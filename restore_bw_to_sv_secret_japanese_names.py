#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV シークレット欠損264件 日本語名自動復元
- Scrydex API不使用
- Scrydex公開Expansionページのみ
- DB更新なし / INSERT SQLまだ生成しない

仕組み:
1) RULE確定セットのScrydex表を読み、英語名 ↔ カード番号を取得
2) DBに既に存在する番号と突き合わせ、
   Scrydex英語名 ↔ DB日本語名 の辞書を自動生成
3) 欠損カードについて、
   A. 同一セット内に同じScrydex英語名の既存カードがあれば、その日本語名を採用
   B. なければ全RULEセット横断で、英語名→日本語名が一意なら採用
4) 推測が割れるものは unresolved に残す

入力:
  cards.csv
  card_sets.csv
  missing_beyond_db_max.csv
  bw_to_sv_scrydex_final/set_mapping_final.csv

出力:
  bw_to_sv_secret_name_restore/
    _summary.txt
    secret_264_enriched.csv
    secret_264_resolved.csv
    secret_264_unresolved.csv
    learned_name_dictionary.csv
    conflicts.csv
"""

from __future__ import annotations
import csv, re, time, unicodedata
from collections import defaultdict, Counter
from pathlib import Path
import requests
from bs4 import BeautifulSoup

HEADERS = {"User-Agent":"Mozilla/5.0 (compatible; RyoteiSecretNameRestore/1.0)"}

def nt(v):
    return re.sub(r"\s+"," ",unicodedata.normalize("NFKC",str(v or "")).strip())

def numkey(v):
    s=nt(v)
    m=re.match(r"^0*(\d+)(?:\s*/\s*0*\d+)?$",s)
    return str(int(m.group(1))) if m else re.sub(r"\s+","",s).upper()

def namekey(v):
    s=nt(v).casefold()
    s=s.replace("pokémon","pokemon").replace("’","'").replace("–","-").replace("—","-")
    return re.sub(r"\s+"," ",s)

def locate(*paths):
    for x in paths:
        p=Path(x)
        if p.exists(): return p
    raise FileNotFoundError("見つかりません: "+" / ".join(paths))

def load(p):
    with p.open(encoding="utf-8-sig",newline="") as f:
        return list(csv.DictReader(f))

def save(p,rows,fields):
    p.parent.mkdir(parents=True,exist_ok=True)
    with p.open("w",encoding="utf-8-sig",newline="") as f:
        w=csv.DictWriter(f,fieldnames=fields,extrasaction="ignore")
        w.writeheader(); w.writerows(rows)

def find_col(headers, needles):
    for i,h in enumerate(headers):
        z=nt(h).lower()
        if any(n in z for n in needles): return i
    return None

def parse_scrydex(session,url):
    r=session.get(url,timeout=35); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")
    out=[]
    for table in soup.find_all("table"):
        trs=table.find_all("tr")
        if not trs: continue
        heads=[nt(x.get_text(" ",strip=True)) for x in trs[0].find_all(["th","td"])]
        ni=find_col(heads,["number","no.","no"])
        ri=find_col(heads,["rarity"])
        # Name is usually first column; detect "name/card" but avoid number.
        name_i=None
        for i,h in enumerate(heads):
            z=h.lower()
            if ("name" in z or "card" in z or "details" in z) and i != ni:
                name_i=i; break
        if ni is None: continue

        for tr in trs[1:]:
            cells=tr.find_all(["td","th"])
            if ni>=len(cells): continue
            rawnum=nt(cells[ni].get_text(" ",strip=True))
            if not rawnum: continue

            en=""
            if name_i is not None and name_i<len(cells):
                en=nt(cells[name_i].get_text(" ",strip=True))
            if not en:
                # Find first sensible text cell excluding number/rarity.
                for i,c in enumerate(cells):
                    if i==ni or i==ri: continue
                    txt=nt(c.get_text(" ",strip=True))
                    if txt and txt!=rawnum:
                        en=txt; break
            if not en: continue
            rarity=""
            if ri is not None and ri<len(cells):
                rarity=nt(cells[ri].get_text(" ",strip=True))
            out.append({"number_key":numkey(rawnum),"en_name":en,"rarity_raw":rarity})
    # Deduplicate exact number/name pairs.
    uniq={}
    for x in out:
        uniq[(x["number_key"],namekey(x["en_name"]))]=x
    return list(uniq.values())

def main():
    cards=load(locate("cards.csv","supabase_export_db/cards.csv","supabase_export/cards.csv"))
    sets=load(locate("card_sets.csv","supabase_export_db/card_sets.csv","supabase_export/card_sets.csv"))
    missing=load(locate(
        "missing_beyond_db_max.csv",
        "bw_to_sv_missing_cards_audit/missing_beyond_db_max.csv"
    ))
    mappings=load(locate(
        "bw_to_sv_scrydex_final/set_mapping_final.csv",
        "set_mapping_final.csv"
    ))

    rule={m["set_id"]:m for m in mappings
          if nt(m.get("mapping_method")).upper()=="RULE"
          and nt(m.get("scrydex_url"))}
    db_by_set_num=defaultdict(list)
    for c in cards:
        if c.get("set_id") in rule:
            db_by_set_num[(c["set_id"],numkey(c.get("card_number")))].append(c)

    sess=requests.Session(); sess.headers.update(HEADERS)
    scrydex_by_set={}
    print(f"RULEセットを辞書学習: {len(rule)}")
    for i,(set_id,m) in enumerate(rule.items(),1):
        print(f"[{i}/{len(rule)}] {m.get('db_code','')} -> {m.get('scrydex_id','')}")
        try:
            scrydex_by_set[set_id]=parse_scrydex(sess,m["scrydex_url"])
        except Exception as e:
            print("  ERROR:",repr(e))
            scrydex_by_set[set_id]=[]
        time.sleep(.1)

    # Learn en -> jp from rows where Scrydex number exists in DB.
    same_set_map=defaultdict(lambda: defaultdict(set)) # set_id -> enkey -> jp names
    global_map=defaultdict(set)                        # enkey -> jp names
    samples=defaultdict(list)

    for set_id,srows in scrydex_by_set.items():
        for sr in srows:
            dbrows=db_by_set_num.get((set_id,sr["number_key"]),[])
            if not dbrows: continue
            ek=namekey(sr["en_name"])
            for d in dbrows:
                jp=nt(d.get("name"))
                if not jp: continue
                same_set_map[set_id][ek].add(jp)
                global_map[ek].add(jp)
                if len(samples[ek])<5:
                    samples[ek].append((sr["en_name"],jp,set_id,sr["number_key"]))

    # Existing DB template lookup by Japanese name, prefer same set then global.
    db_by_set_jp=defaultdict(list)
    db_by_jp=defaultdict(list)
    for c in cards:
        jp=nt(c.get("name"))
        if jp:
            db_by_set_jp[(c.get("set_id"),jp)].append(c)
            db_by_jp[jp].append(c)

    enriched=[]
    conflicts=[]
    for r in missing:
        set_id=r["set_id"]
        en=nt(r.get("scrydex_name"))
        ek=namekey(en)

        ss=sorted(same_set_map[set_id].get(ek,set()))
        gl=sorted(global_map.get(ek,set()))

        jp=""
        method=""
        confidence=""
        reason=""

        if len(ss)==1:
            jp=ss[0]; method="SAME_SET"; confidence="HIGH"
        elif len(ss)>1:
            reason="SAME_SET_CONFLICT"
        elif len(gl)==1:
            jp=gl[0]; method="GLOBAL_UNANIMOUS"; confidence="HIGH"
        elif len(gl)>1:
            reason="GLOBAL_CONFLICT"
        else:
            reason="NO_LEARNED_NAME"

        template=None
        if jp:
            cand=db_by_set_jp.get((set_id,jp),[])
            if cand:
                template=cand[0]
                template_method="SAME_SET_TEMPLATE"
            elif db_by_jp.get(jp):
                template=db_by_jp[jp][0]
                template_method="GLOBAL_TEMPLATE"
            else:
                template_method=""
        else:
            template_method=""

        out=dict(r)
        out.update({
            "jp_name":jp,
            "name_resolution_method":method,
            "name_confidence":confidence,
            "unresolved_reason":reason,
            "template_method":template_method,
            "template_card_id":template.get("id","") if template else "",
            "template_category":template.get("category","") if template else "",
            "template_hp":template.get("hp","") if template else "",
            "template_types":template.get("types","") if template else "",
            "template_stage":template.get("stage","") if template else "",
            "template_regulation_mark":template.get("regulation_mark","") if template else "",
        })
        enriched.append(out)

        if reason and (ss or gl):
            conflicts.append({
                "set_code":r.get("set_code",""),
                "number_key":r.get("number_key",""),
                "scrydex_name":en,
                "same_set_jp_candidates":" | ".join(ss),
                "global_jp_candidates":" | ".join(gl),
                "reason":reason
            })

    fields=list(enriched[0].keys()) if enriched else []
    outdir=Path("bw_to_sv_secret_name_restore")
    save(outdir/"secret_264_enriched.csv",enriched,fields)
    save(outdir/"secret_264_resolved.csv",[x for x in enriched if x["jp_name"]],fields)
    save(outdir/"secret_264_unresolved.csv",[x for x in enriched if not x["jp_name"]],fields)
    save(outdir/"conflicts.csv",conflicts,
         ["set_code","number_key","scrydex_name","same_set_jp_candidates","global_jp_candidates","reason"])

    dictrows=[]
    for ek,jps in sorted(global_map.items()):
        ex=samples[ek][0] if samples[ek] else ("","","","")
        dictrows.append({
            "english_name":ex[0],
            "japanese_names":" | ".join(sorted(jps)),
            "jp_candidate_count":len(jps),
            "example_set_id":ex[2],
            "example_number":ex[3],
        })
    save(outdir/"learned_name_dictionary.csv",dictrows,
         ["english_name","japanese_names","jp_candidate_count","example_set_id","example_number"])

    methods=Counter(x["name_resolution_method"] or "UNRESOLVED" for x in enriched)
    by_series=Counter(x["series_name"] for x in enriched if x["jp_name"])
    unresolved_reasons=Counter(x["unresolved_reason"] for x in enriched if not x["jp_name"])

    summary=[
        f"target_missing_secret_rows: {len(missing)}",
        f"resolved_japanese_names: {sum(1 for x in enriched if x['jp_name'])}",
        f"unresolved_japanese_names: {sum(1 for x in enriched if not x['jp_name'])}",
        f"same_set_resolved: {methods['SAME_SET']}",
        f"global_unanimous_resolved: {methods['GLOBAL_UNANIMOUS']}",
        "",
        "[resolved by series]",
    ]
    for k,v in sorted(by_series.items()): summary.append(f"{k}: {v}")
    summary += ["","[unresolved reasons]"]
    for k,v in sorted(unresolved_reasons.items()): summary.append(f"{k}: {v}")
    summary += [
        "",
        "NOTE: DB更新なし。",
        "NOTE: HIGHのみ自動復元。英語名→日本語名が一意でないものは未解決。",
        "NOTE: 次段階で resolved CSV を確認してから INSERT SQL を生成する。",
    ]
    (outdir/"_summary.txt").write_text("\n".join(summary),encoding="utf-8")
    print("\n完了:",outdir.resolve())
    print("\n"+"\n".join(summary))

if __name__=="__main__":
    main()
