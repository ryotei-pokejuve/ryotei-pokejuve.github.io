#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW-SV 7セット専用・欠損カード詳細監査（READ ONLY）

対象:
  XY / XY6 / XY7 / SV4a / SM1p / S8a / WCS23

入力:
  cards.csv
  card_sets.csv
  set_mapping_final.csv
    または bw_to_sv_scrydex_final/set_mapping_final.csv

出力:
  bw_to_sv_7set_detail_audit/
    _summary.txt
    set_summary.csv
    missing_detail.csv
    db_existing_numbers.csv
    db_not_found_detail.csv
    fetch_errors.csv

安全方針:
- Supabaseを更新しない
- Scrydex APIを使わない
- RULE mappingのみ
- Scrydex URLはset_mapping_final.csvのscrydex_urlを使用
- 画像URLはScrydex HTML内で実際に確認できたURLのみ
"""

from __future__ import annotations
import csv, html, re, time, unicodedata
from collections import defaultdict
from pathlib import Path
from urllib.parse import urljoin
import requests
from bs4 import BeautifulSoup

TARGET_CODES = {"XY","XY6","XY7","SV4a","SM1p","S8a","WCS23"}
HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; Ryotei7SetAudit/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}
OUT = Path("bw_to_sv_7set_detail_audit")
OUT.mkdir(exist_ok=True)

def nt(v):
    return re.sub(r"\s+"," ",unicodedata.normalize("NFKC",str(v or "")).strip())

def numkey(v):
    s=nt(v)
    m=re.match(r"^0*(\d+)(?:\s*/\s*0*\d+)?$",s)
    if m: return str(int(m.group(1)))
    m=re.match(r"^0*(\d+)",s)
    return str(int(m.group(1))) if m else ""

def locate(*xs):
    for x in xs:
        p=Path(x)
        if p.exists(): return p
    raise FileNotFoundError(" / ".join(xs))

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

def rarity_token(s):
    s=nt(s).upper()
    vals=["PROMO","SAR","MUR","CSR","CHR","SSR","RRR","SR","HR","UR","AR","RR","PR","R","U","C","S","A","K"]
    for x in vals:
        if s==x: return x
    for x in sorted(vals,key=len,reverse=True):
        if re.search(rf"(?<![A-Z0-9]){re.escape(x)}(?![A-Z0-9])",s):
            return x
    return ""

def actual_image_from_node(node, base):
    candidates=[]
    for tag in [node] + list(node.find_all(True)):
        for attr in ("src","data-src","data-lazy-src","data-original"):
            v=tag.get(attr)
            if v: candidates.append(v)
        srcset=tag.get("srcset")
        if srcset:
            for part in srcset.split(","):
                candidates.append(part.strip().split(" ")[0])
    for v in candidates:
        u=urljoin(base,html.unescape(nt(v)))
        if "scrydex" in u.lower() and ("image" in u.lower() or "/pokemon/" in u.lower()):
            return u
    return ""

def parse_page(sess,url,sid):
    r=sess.get(url,timeout=40); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")
    cards={}

    # Card links are the strongest identity source.
    for a in soup.find_all("a",href=True):
        href=html.unescape(nt(a.get("href")))
        full=urljoin(r.url,href)
        tail=full.split("?")[0].rstrip("/").split("/")[-1]
        prefix=sid.lower()+"-"
        if not tail.lower().startswith(prefix): continue
        rest=tail[len(sid)+1:]
        m=re.match(r"0*(\d+)",rest)
        if not m: continue
        n=str(int(m.group(1)))
        rec=cards.setdefault(n,{"number":n,"name":"","rarity":"","image_url":"","card_url":full})
        rec["card_url"]=full

        # Extract visible title/name close to the card link, without guessing.
        texts=[]
        for attr in ("title","aria-label"):
            if a.get(attr): texts.append(nt(a.get(attr)))
        img=a.find("img")
        if img:
            for attr in ("alt","title"):
                if img.get(attr): texts.append(nt(img.get(attr)))
        for t in texts:
            if t and t.lower()!=sid.lower() and not re.fullmatch(r"\d+(?:/\d+)?",t):
                rec["name"]=t
                break

        rec["image_url"] = rec["image_url"] or actual_image_from_node(a,r.url)

    # Explicit table metadata where available.
    for table in soup.find_all("table"):
        trs=table.find_all("tr")
        if not trs: continue
        heads=[nt(x.get_text(" ",strip=True)).lower() for x in trs[0].find_all(["th","td"])]
        ni=namei=ri=None
        for i,h in enumerate(heads):
            if "number" in h or h in {"no","no.","#"}: ni=i
            if "name" in h: namei=i
            if "rarity" in h: ri=i
        if ni is None: continue
        for tr in trs[1:]:
            td=tr.find_all("td")
            if ni>=len(td): continue
            n=numkey(td[ni].get_text(" ",strip=True))
            if not n: continue
            rec=cards.setdefault(n,{"number":n,"name":"","rarity":"","image_url":"","card_url":""})
            if namei is not None and namei<len(td):
                rec["name"]=nt(td[namei].get_text(" ",strip=True)) or rec["name"]
            if ri is not None and ri<len(td):
                rec["rarity"]=rarity_token(td[ri].get_text(" ",strip=True))
            rec["image_url"]=rec["image_url"] or actual_image_from_node(tr,r.url)

    return cards,r.url

def main():
    cards=load(locate("cards.csv"))
    sets=load(locate("card_sets.csv"))
    maps=load(locate("set_mapping_final.csv","bw_to_sv_scrydex_final/set_mapping_final.csv"))

    set_by_id={s["id"]:s for s in sets}
    selected={}
    for m in maps:
        code=nt(m.get("db_code") or set_by_id.get(m.get("set_id"),{}).get("code"))
        if code in TARGET_CODES and nt(m.get("mapping_method")).upper()=="RULE":
            selected[m["set_id"]]=m

    db=defaultdict(list)
    for c in cards:
        if c.get("set_id") in selected and nt(c.get("is_active")).lower() not in {"false","0","no"}:
            db[c["set_id"]].append(c)

    sess=requests.Session(); sess.headers.update(HEADERS)
    summary=[]; missing=[]; existing=[]; notfound=[]; errors=[]

    for set_id,m in selected.items():
        s=set_by_id.get(set_id,{})
        code=nt(m.get("db_code") or s.get("code"))
        name=nt(s.get("name"))
        sid=nt(m.get("scrydex_id"))
        url=nt(m.get("scrydex_url"))
        rows=db[set_id]
        bynum=defaultdict(list)
        for c in rows:
            n=numkey(c.get("card_number"))
            if n: bynum[n].append(c)
        dbnums=set(bynum)
        dbmax=max(map(int,dbnums)) if dbnums else None

        print(f"{code}: DB {len(rows)} / {sid}")
        try:
            scards,final_url=parse_page(sess,url,sid)
        except Exception as e:
            errors.append({"set_code":code,"set_name":name,"scrydex_id":sid,"url":url,"error":repr(e)})
            continue

        snums=set(scards)
        for n in sorted(dbnums,key=int):
            for c in bynum[n]:
                existing.append({
                    "set_code":code,"set_name":name,"number":n,
                    "db_card_number":c.get("card_number",""),"db_name":c.get("name",""),
                    "db_rarity":c.get("rarity",""),"db_image_url":c.get("image_url",""),
                    "found_in_scrydex":"YES" if n in snums else "NO",
                })

        for n in sorted(snums-dbnums,key=int):
            x=scards[n]
            missing.append({
                "set_code":code,"set_name":name,"scrydex_id":sid,
                "card_number":n,
                "position_vs_db_max":"BEYOND_DB_MAX" if dbmax is not None and int(n)>dbmax else "INSIDE_DB_RANGE",
                "db_max_number":dbmax if dbmax is not None else "",
                "scrydex_name":x["name"],
                "scrydex_rarity":x["rarity"],
                "scrydex_image_url":x["image_url"],
                "scrydex_card_url":x["card_url"],
                "scrydex_set_url":final_url,
            })

        for n in sorted(dbnums-snums,key=int):
            for c in bynum[n]:
                notfound.append({
                    "set_code":code,"set_name":name,"card_number":c.get("card_number",""),
                    "db_name":c.get("name",""),"db_rarity":c.get("rarity",""),
                    "db_image_url":c.get("image_url",""),"scrydex_id":sid,"scrydex_set_url":final_url,
                })

        inside=sum(1 for n in snums-dbnums if dbmax is not None and int(n)<=dbmax)
        beyond=sum(1 for n in snums-dbnums if dbmax is not None and int(n)>dbmax)
        summary.append({
            "set_code":code,"set_name":name,"scrydex_id":sid,
            "db_rows":len(rows),"db_numeric_numbers":len(dbnums),"db_max_number":dbmax or "",
            "scrydex_numbers":len(snums),"missing_total":len(snums-dbnums),
            "missing_inside_db_range":inside,"missing_beyond_db_max":beyond,
            "db_not_found_in_scrydex":len(dbnums-snums),
        })
        time.sleep(.1)

    save(OUT/"set_summary.csv",summary)
    save(OUT/"missing_detail.csv",missing)
    save(OUT/"db_existing_numbers.csv",existing)
    save(OUT/"db_not_found_detail.csv",notfound)
    save(OUT/"fetch_errors.csv",errors)

    lines=["BW-SV 7-SET DETAIL AUDIT",""]
    for x in summary:
        lines.append(
            f'{x["set_code"]}: DB={x["db_rows"]}, Scrydex={x["scrydex_numbers"]}, '
            f'MISSING={x["missing_total"]} (inside={x["missing_inside_db_range"]}, beyond={x["missing_beyond_db_max"]}), '
            f'DB_NOT_FOUND={x["db_not_found_in_scrydex"]}'
        )
    lines += ["",f"total_missing: {len(missing)}",f"fetch_errors: {len(errors)}",
              "","READ ONLY / no Supabase writes / no Scrydex API"]
    (OUT/"_summary.txt").write_text("\n".join(lines),encoding="utf-8")
    print("\n"+"\n".join(lines))

if __name__=="__main__":
    main()
