#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
XY6 / XY7 日本語名復元 V2（READ ONLY）

V1で learned pairs = 0 だった原因:
Scrydexの「セット一覧ページ」には既存カードの英語名が十分出ていないため。
V2では、XYシリーズの既存DBカードについて
Scrydexカード詳細ページを開き、英語名を取得して
「英語名 -> DB日本語名」の辞書を作る。

安全:
- Supabase更新なし
- Scrydex API不使用
- RULE mappingのみ
- XYシリーズだけを学習対象
- Scrydex URLはset_mapping_final.csv由来
- 競合は自動採用しない
"""

from __future__ import annotations
import csv, html, re, time, unicodedata
from collections import defaultdict
from pathlib import Path
from urllib.parse import urljoin

import requests
from bs4 import BeautifulSoup

TARGET_CODES = {"XY6","XY7"}
TARGET_SERIES = "XYシリーズ"
OUT = Path("xy6_xy7_japanese_name_restore_v2")
OUT.mkdir(exist_ok=True)

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiNameRestoreV2/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}

BAD_JA = {"", "トレーナー", "エネルギー"}

def nt(v):
    return re.sub(r"\s+"," ",unicodedata.normalize("NFKC",str(v or "")).strip())

def norm_en(v):
    s=nt(v).casefold().replace("’","'").replace("–","-").replace("—","-")
    return re.sub(r"\s+"," ",s).strip()

def numkey(v):
    s=nt(v)
    m=re.match(r"^0*(\d+)(?:\s*/\s*0*\d+)?$",s)
    if m: return str(int(m.group(1)))
    m=re.match(r"^0*(\d+)",s)
    return str(int(m.group(1))) if m else ""

def locate(*cands):
    for c in cands:
        p=Path(c)
        if p.exists(): return p
    raise FileNotFoundError("見つかりません: "+" / ".join(cands))

def load(p):
    with p.open(encoding="utf-8-sig",newline="") as f:
        return list(csv.DictReader(f))

def save(p,rows,fields=None):
    if not rows:
        p.write_text("",encoding="utf-8-sig"); return
    fields=fields or list(rows[0].keys())
    with p.open("w",encoding="utf-8-sig",newline="") as f:
        w=csv.DictWriter(f,fieldnames=fields,extrasaction="ignore")
        w.writeheader(); w.writerows(rows)

def card_links_from_set(sess,set_url,sid):
    r=sess.get(set_url,timeout=40); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")
    out={}
    prefix=sid.lower()+"-"
    for a in soup.find_all("a",href=True):
        href=html.unescape(nt(a.get("href")))
        full=urljoin(r.url,href)
        tail=full.split("?")[0].rstrip("/").split("/")[-1]
        if not tail.lower().startswith(prefix): continue
        rest=tail[len(sid)+1:]
        m=re.match(r"0*(\d+)",rest)
        if m:
            out[str(int(m.group(1)))] = full
    return out

def english_name_from_detail(sess,url):
    r=sess.get(url,timeout=40); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")

    cands=[]
    h1=soup.find("h1")
    if h1:
        cands.append(nt(h1.get_text(" ",strip=True)))
    for sel in ("meta[property='og:title']","meta[name='twitter:title']"):
        x=soup.select_one(sel)
        if x and x.get("content"):
            cands.append(nt(x.get("content")))

    for v in cands:
        v=re.sub(r"\s*[|\-–—]\s*Scrydex.*$","",v,flags=re.I).strip()
        v=re.sub(r"^\s*\d+(?:/\d+)?\s*","",v).strip()
        # Reject obvious UI/site labels.
        if not v: continue
        if v.lower() in {"scrydex","pokemon card","card"}: continue
        if len(v)>120: continue
        return v
    return ""

def main():
    cards=load(locate("cards.csv"))
    sets=load(locate("card_sets.csv"))
    maps=load(locate("set_mapping_final.csv","bw_to_sv_scrydex_final/set_mapping_final.csv"))
    missing=load(locate("missing_cards_detail.csv","xy_3set_missing_audit/missing_cards_detail.csv"))

    set_by_id={s["id"]:s for s in sets}

    xy_maps=[]
    code_to_setid={}
    for m in maps:
        if nt(m.get("mapping_method")).upper()!="RULE": continue
        if nt(m.get("series_name"))!=TARGET_SERIES: continue
        if not nt(m.get("scrydex_url")) or not nt(m.get("scrydex_id")): continue
        xy_maps.append(m)
        s=set_by_id.get(m.get("set_id"),{})
        code=nt(m.get("db_code") or s.get("code"))
        code_to_setid[code]=m.get("set_id")

    targets=[x for x in missing if nt(x.get("set_code")) in TARGET_CODES]

    db_by_set_num=defaultdict(list)
    for c in cards:
        if nt(c.get("is_active")).lower() in {"false","0","no"}: continue
        n=numkey(c.get("card_number"))
        if n: db_by_set_num[(c.get("set_id"),n)].append(c)

    sess=requests.Session(); sess.headers.update(HEADERS)

    global_names=defaultdict(set)
    same_set_names=defaultdict(set)
    learned=[]
    errors=[]

    total_existing=0
    for m in xy_maps:
        sid=m.get("set_id")
        total_existing += sum(1 for (set_id,n),rows in db_by_set_num.items() if set_id==sid and len(rows)==1)

    print(f"XY RULE sets to scan: {len(xy_maps)}")
    print(f"Existing XY DB cards eligible: {total_existing}")
    print(f"XY6/XY7 targets: {len(targets)}")
    print()

    done=0
    for si,m in enumerate(xy_maps,1):
        set_id=m.get("set_id")
        s=set_by_id.get(set_id,{})
        code=nt(m.get("db_code") or s.get("code"))
        scrydex_id=nt(m.get("scrydex_id"))
        url=nt(m.get("scrydex_url"))

        print(f"[{si}/{len(xy_maps)}] {code} -> {scrydex_id}")

        try:
            links=card_links_from_set(sess,url,scrydex_id)
        except Exception as e:
            errors.append({"set_code":code,"stage":"SET","url":url,"error":repr(e)})
            print("  SET ERROR",repr(e))
            continue

        learned_here=0
        existing_nums=sorted(
            {n for (sid,n),rows in db_by_set_num.items() if sid==set_id and len(rows)==1},
            key=int
        )
        for n in existing_nums:
            if n not in links: continue
            dbrow=db_by_set_num[(set_id,n)][0]
            ja=nt(dbrow.get("name"))
            if ja in BAD_JA: continue

            try:
                en=english_name_from_detail(sess,links[n])
            except Exception as e:
                errors.append({"set_code":code,"card_number":n,"stage":"DETAIL","url":links[n],"error":repr(e)})
                continue
            if not en: continue

            key=norm_en(en)
            global_names[key].add(ja)
            same_set_names[(set_id,key)].add(ja)
            learned.append({
                "set_code":code,
                "set_id":set_id,
                "card_number":n,
                "scrydex_english_name":en,
                "db_japanese_name":ja,
                "scrydex_card_url":links[n],
            })
            learned_here+=1
            done+=1
            if done % 50 == 0:
                print(f"  learned total: {done}")
            time.sleep(0.04)

        print(f"  learned pairs: {learned_here}")

    resolved=[]; unresolved=[]; allrows=[]
    methods=defaultdict(int)

    for t in targets:
        code=nt(t.get("set_code"))
        set_id=code_to_setid.get(code,"")
        en=nt(t.get("scrydex_name"))
        key=norm_en(en)

        same=sorted(same_set_names.get((set_id,key),set()))
        glob=sorted(global_names.get(key,set()))

        if len(same)==1:
            ja=same[0]; method="SAME_SET_UNANIMOUS"; status="RESOLVED"; cand=same
        elif len(same)>1:
            ja=""; method="SAME_SET_CONFLICT"; status="UNRESOLVED"; cand=same
        elif len(glob)==1:
            ja=glob[0]; method="GLOBAL_UNANIMOUS"; status="RESOLVED"; cand=glob
        elif len(glob)>1:
            ja=""; method="GLOBAL_CONFLICT"; status="UNRESOLVED"; cand=glob
        else:
            ja=""; method="NO_LEARNED_NAME"; status="UNRESOLVED"; cand=[]

        row=dict(t)
        row.update({
            "resolved_japanese_name":ja,
            "resolution_method":method,
            "resolution_status":status,
            "candidate_japanese_names":" | ".join(cand),
        })
        allrows.append(row); methods[method]+=1
        (resolved if status=="RESOLVED" else unresolved).append(row)

    save(OUT/"resolved.csv",resolved)
    save(OUT/"unresolved.csv",unresolved)
    save(OUT/"targets_all.csv",allrows)
    save(OUT/"learned_name_pairs.csv",learned)
    save(OUT/"fetch_errors.csv",errors)

    byset=defaultdict(lambda:[0,0])
    for x in allrows:
        byset[x["set_code"]][0]+=1
        if x["resolution_status"]=="RESOLVED":
            byset[x["set_code"]][1]+=1

    lines=[
        "XY6 / XY7 JAPANESE NAME RESTORE V2","",
        f"xy_rule_sets_scanned: {len(xy_maps)}",
        f"learned_existing_pairs: {len(learned)}",
        f"target_rows: {len(targets)}",
        f"resolved: {len(resolved)}",
        f"unresolved: {len(unresolved)}",
        f"fetch_errors: {len(errors)}",
        "","[resolution methods]"
    ]
    for k in sorted(methods):
        lines.append(f"{k}: {methods[k]}")
    lines += ["","[by set]"]
    for code in sorted(byset):
        total,res=byset[code]
        lines.append(f"{code}: total={total}, resolved={res}, unresolved={total-res}")
    lines += [
        "","IMPORTANT:",
        "- READ ONLY / no Supabase writes",
        "- Scrydex API is NOT used",
        "- Only XY-series RULE mappings are used for learning",
        "- Conflicts and unknown names are not guessed",
    ]
    (OUT/"_summary.txt").write_text("\n".join(lines),encoding="utf-8")
    print("\n"+"\n".join(lines))

if __name__=="__main__":
    main()
