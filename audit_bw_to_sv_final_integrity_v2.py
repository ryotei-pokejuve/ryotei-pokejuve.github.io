#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV 最終整合性監査 V2（READ ONLY）

V1の修正点:
- ScrydexセットURLを推測しない
- set_mapping_final.csv の scrydex_url をそのまま使用
- 過去に131セット取得成功した画像監査と同じ方式
- RULEマッピングのみ
- DBは一切更新しない
- Scrydex APIは使わない

必要:
  cards.csv
  card_sets.csv
  set_mapping_final.csv
    または bw_to_sv_scrydex_final/set_mapping_final.csv
"""

from __future__ import annotations
import csv, html, re, sys, time, unicodedata
from collections import Counter, defaultdict
from pathlib import Path
from urllib.parse import urljoin
import requests
from bs4 import BeautifulSoup

TARGET_SERIES = {
    "BWシリーズ","XYシリーズ","SMシリーズ","ソード・シールド","SVシリーズ"
}
HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiFinalAuditV2/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}

ROOT = Path(".")
OUT = ROOT / "bw_to_sv_final_audit_v2"
OUT.mkdir(exist_ok=True)

def nt(v):
    return re.sub(r"\s+"," ",unicodedata.normalize("NFKC",str(v or "")).strip())

def numkey(v):
    s=nt(v)
    m=re.match(r"^0*(\d+)(?:\s*/\s*0*\d+)?$",s)
    if m: return str(int(m.group(1)))
    m=re.match(r"^0*(\d+)",s)
    if m: return str(int(m.group(1)))
    return re.sub(r"\s+","",s).upper()

def locate(*candidates):
    for c in candidates:
        p=Path(c)
        if p.exists(): return p
    raise FileNotFoundError("見つかりません: "+" / ".join(candidates))

def load(path):
    with path.open(encoding="utf-8-sig",newline="") as f:
        return list(csv.DictReader(f))

def save(path,rows,fields=None):
    if not rows:
        path.write_text("",encoding="utf-8-sig")
        return
    if fields is None: fields=list(rows[0].keys())
    with path.open("w",encoding="utf-8-sig",newline="") as f:
        w=csv.DictWriter(f,fieldnames=fields,extrasaction="ignore")
        w.writeheader(); w.writerows(rows)

def classify_image(url):
    u=nt(url).lower()
    if not u: return "EMPTY"
    if "scrydex" in u: return "SCRYDEX"
    if "pokemon-card.com" in u: return "POKEMON_CARD_COM"
    if "tcgdex" in u: return "TCGDEX"
    return "OTHER"

def nr(raw):
    """Normalize explicit rarity text only; do not guess."""
    s=nt(raw).upper()
    known=["PROMO","SAR","MUR","CSR","CHR","SSR","RRR","SR","HR","UR","AR","RR","PR","R","U","C","S","A","K"]
    for x in known:
        if s == x: return x
    # tolerate labels like "Rarity: SR", but still require explicit standalone token
    for x in sorted(known,key=len,reverse=True):
        if re.search(rf'(?<![A-Z0-9]){re.escape(x)}(?![A-Z0-9])',s):
            return x
    return ""

def parse_expansion_page(sess,url,scrydex_id):
    """
    Returns:
      nums: set of Scrydex numeric card numbers found from exact card hrefs
      rarity_by_num: explicit table rarity only
      final_url
    """
    r=sess.get(url,timeout=40)
    r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")

    nums=set()

    # Same reliable card-link strategy as image audit.
    for a in soup.find_all("a",href=True):
        href=html.unescape(nt(a.get("href")))
        full=urljoin(r.url,href)
        tail=full.split("?")[0].rstrip("/").split("/")[-1]
        prefix=scrydex_id.lower()+"-"
        if not tail.lower().startswith(prefix):
            continue
        rest=tail[len(scrydex_id)+1:]
        m=re.match(r"0*(\d+)",rest)
        if m:
            nums.add(str(int(m.group(1))))

    # Secondary: direct image URLs can prove card numbers too.
    raw=r.text
    for m in re.finditer(re.escape(scrydex_id)+r"-0*(\d+)",raw,re.I):
        nums.add(str(int(m.group(1))))

    # Explicit rarity table only.
    rarity_by_num=defaultdict(list)
    for table in soup.find_all("table"):
        trs=table.find_all("tr")
        if not trs: continue
        heads=[nt(x.get_text(" ",strip=True)).lower() for x in trs[0].find_all(["th","td"])]
        ni=ri=None
        for i,h in enumerate(heads):
            if "number" in h or h in {"no","no.","#"}: ni=i
            if "rarity" in h: ri=i
        if ni is None or ri is None: continue
        for tr in trs[1:]:
            td=tr.find_all("td")
            if max(ni,ri)>=len(td): continue
            nk=numkey(td[ni].get_text(" ",strip=True))
            if not nk or not nk.isdigit(): continue
            rawrar=nt(td[ri].get_text(" ",strip=True))
            rarity=nr(rawrar)
            if rarity:
                rarity_by_num[nk].append((rarity,rawrar))

    return nums,rarity_by_num,r.url

def main():
    cards_path=locate("cards.csv")
    sets_path=locate("card_sets.csv")
    map_path=locate("bw_to_sv_scrydex_final/set_mapping_final.csv","set_mapping_final.csv")

    cards=load(cards_path)
    sets=load(sets_path)
    mappings=load(map_path)
    set_by_id={s["id"]:s for s in sets}

    rule={}
    for m in mappings:
        if nt(m.get("mapping_method")).upper()!="RULE": continue
        if nt(m.get("series_name")) not in TARGET_SERIES: continue
        if not nt(m.get("scrydex_id")) or not nt(m.get("scrydex_url")): continue
        rule[m["set_id"]]=m

    target_cards=[
        c for c in cards
        if c.get("set_id") in rule
        and nt(c.get("is_active")).lower() not in {"false","0","no"}
    ]
    by_set=defaultdict(list)
    for c in target_cards: by_set[c["set_id"]].append(c)

    image_sources=Counter(classify_image(c.get("image_url")) for c in target_cards)

    suspicious_names=[]
    non_numeric=[]
    duplicate_rows=[]
    for set_id,rows in by_set.items():
        seen=defaultdict(list)
        for c in rows:
            name=nt(c.get("name"))
            if not name or name in {"トレーナー","エネルギー"}:
                suspicious_names.append(c)
            nk=numkey(c.get("card_number"))
            if not nk.isdigit():
                non_numeric.append(c)
            else:
                seen[nk].append(c)
        for nk,xs in seen.items():
            if len(xs)>1:
                s=set_by_id.get(set_id,{})
                for c in xs:
                    duplicate_rows.append({
                        "series_name":s.get("series_name",""),
                        "set_code":s.get("code",""),
                        "set_name":s.get("name",""),
                        "number_key":nk,
                        "card_id":c.get("id",""),
                        "card_number":c.get("card_number",""),
                        "name":c.get("name",""),
                        "rarity":c.get("rarity",""),
                    })

    sess=requests.Session(); sess.headers.update(HEADERS)
    set_errors=[]
    missing_in_db=[]
    db_not_found=[]
    rarity_mismatches=[]
    rarity_checked=0
    set_stats=[]

    for i,(set_id,m) in enumerate(rule.items(),1):
        s=set_by_id.get(set_id,{})
        code=nt(m.get("db_code") or s.get("code"))
        sname=nt(m.get("db_name") or s.get("name"))
        sid=nt(m.get("scrydex_id"))
        url=nt(m.get("scrydex_url"))
        rows=by_set.get(set_id,[])
        db_by_num=defaultdict(list)
        for c in rows:
            nk=numkey(c.get("card_number"))
            if nk.isdigit(): db_by_num[nk].append(c)

        print(f"[{i}/{len(rule)}] {code} -> {sid} / DB {len(rows)}枚")

        try:
            scr_nums,rarity_by_num,final_url=parse_expansion_page(sess,url,sid)
        except Exception as e:
            print("  SET FETCH ERROR:",repr(e))
            set_errors.append({
                "set_id":set_id,"set_code":code,"set_name":sname,
                "scrydex_id":sid,"scrydex_url":url,"error":repr(e)
            })
            continue

        db_nums=set(db_by_num)
        for n in sorted(scr_nums-db_nums,key=int):
            missing_in_db.append({
                "series_name":m.get("series_name",""),
                "set_code":code,"set_name":sname,
                "scrydex_id":sid,"scrydex_url":final_url,
                "card_number":n,
            })

        for n in sorted(db_nums-scr_nums,key=int):
            for c in db_by_num[n]:
                db_not_found.append({
                    "card_id":c.get("id",""),
                    "series_name":m.get("series_name",""),
                    "set_code":code,"set_name":sname,
                    "card_number":c.get("card_number",""),
                    "name":c.get("name",""),
                    "rarity":c.get("rarity",""),
                    "image_url":c.get("image_url",""),
                    "scrydex_id":sid,
                    "scrydex_url":final_url,
                })

        for n,vals in rarity_by_num.items():
            if n not in db_by_num: continue
            explicit={x[0] for x in vals if x[0]}
            if len(explicit)!=1: continue
            expected=next(iter(explicit))
            for c in db_by_num[n]:
                current=nt(c.get("rarity")).upper()
                if not current: continue
                rarity_checked+=1
                if current!=expected:
                    rarity_mismatches.append({
                        "card_id":c.get("id",""),
                        "series_name":m.get("series_name",""),
                        "set_code":code,"set_name":sname,
                        "card_number":c.get("card_number",""),
                        "name":c.get("name",""),
                        "db_rarity":current,
                        "scrydex_rarity":expected,
                        "scrydex_rarity_raw":" | ".join(sorted({x[1] for x in vals})),
                        "scrydex_url":final_url,
                    })

        set_stats.append({
            "series_name":m.get("series_name",""),
            "set_code":code,"set_name":sname,
            "scrydex_id":sid,
            "db_cards":len(rows),
            "scrydex_numbers_found":len(scr_nums),
            "missing_in_db":len(scr_nums-db_nums),
            "db_not_found_in_scrydex":len(db_nums-scr_nums),
            "explicit_rarity_numbers":len(rarity_by_num),
        })
        time.sleep(0.10)

    save(OUT/"set_stats.csv",set_stats)
    save(OUT/"missing_cards_in_db.csv",missing_in_db)
    save(OUT/"db_cards_not_found_in_scrydex.csv",db_not_found)
    save(OUT/"rarity_mismatches.csv",rarity_mismatches)
    save(OUT/"suspicious_names.csv",suspicious_names)
    save(OUT/"non_numeric_card_numbers.csv",non_numeric)
    save(OUT/"duplicate_numeric_numbers.csv",duplicate_rows)
    save(OUT/"scrydex_set_errors.csv",set_errors)

    summary=[
        "BW-SV FINAL AUDIT V2","",
        f"rule_mapped_sets: {len(rule)}",
        f"target_db_cards: {len(target_cards)}",
        f"scrydex_sets_fetched: {len(rule)-len(set_errors)}",
        f"scrydex_set_errors: {len(set_errors)}",
        f"missing_cards_in_db: {len(missing_in_db)}",
        f"db_cards_not_found_in_scrydex: {len(db_not_found)}",
        f"explicit_rarity_rows_checked: {rarity_checked}",
        f"rarity_mismatches: {len(rarity_mismatches)}",
        f"suspicious_names: {len(suspicious_names)}",
        f"non_numeric_card_numbers: {len(non_numeric)}",
        f"duplicate_numeric_number_rows: {len(duplicate_rows)}",
        "","[image sources]",
    ]
    for k,v in sorted(image_sources.items()):
        summary.append(f"{k}: {v}")
    summary += ["","[missing cards by series]"]
    for k,v in sorted(Counter(x["series_name"] for x in missing_in_db).items()):
        summary.append(f"{k}: {v}")
    summary += ["","[DB cards not found in Scrydex by series]"]
    for k,v in sorted(Counter(x["series_name"] for x in db_not_found).items()):
        summary.append(f"{k}: {v}")
    summary += ["","[rarity mismatches by series]"]
    for k,v in sorted(Counter(x["series_name"] for x in rarity_mismatches).items()):
        summary.append(f"{k}: {v}")
    summary += [
        "","IMPORTANT:",
        "- Python does not update Supabase.",
        "- Uses scrydex_url from RULE mapping; no expansion URL guessing.",
        "- Scrydex API is not used.",
        "- If scrydex_set_errors is not 0, do not interpret zero counts as clean.",
        "- Review CSVs before any DB correction.",
    ]
    (OUT/"_summary.txt").write_text("\n".join(summary),encoding="utf-8")
    print()
    print("\n".join(summary))

if __name__=="__main__":
    main()
