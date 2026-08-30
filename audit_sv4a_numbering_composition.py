#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SV4a missing 40: official Pokémon Card + Scrydex verification
READ ONLY. No Supabase writes. No Scrydex API.

Input:
  scrydex_missing_in_db.csv   (the 40 rows from the SV4a audit)

Output:
  sv4a_missing40_official_verify/
    _summary.txt
    verified.csv
    unresolved.csv

Verification rule:
- Scrydex row supplies candidate number/name/image.
- Official pokemon-card.com search is queried for "SV4a <number>/190".
- A row is VERIFIED only when an official card detail result explicitly exposes
  the same SV4a printed number and a usable Japanese card name.
- This script does NOT generate INSERT SQL. We inspect verified.csv first.
"""

from pathlib import Path
import csv, re, time, urllib.parse
import requests
from bs4 import BeautifulSoup

IN = Path("scrydex_missing_in_db.csv")
OUT = Path("sv4a_missing40_official_verify")
OUT.mkdir(exist_ok=True)

S = requests.Session()
S.headers.update({
    "User-Agent":"Mozilla/5.0 (compatible; RyoteiSV4aOfficialVerify/1.0)",
    "Accept-Language":"ja,en;q=0.8",
})

def norm(s):
    return re.sub(r"\s+"," ",str(s or "")).strip()

def load(p):
    with p.open(encoding="utf-8-sig",newline="") as f:
        return list(csv.DictReader(f))

def save(p, rows, fields):
    with p.open("w",encoding="utf-8-sig",newline="") as f:
        w=csv.DictWriter(f,fieldnames=fields,extrasaction="ignore")
        w.writeheader(); w.writerows(rows)

def official_search(num):
    # Public web search endpoint; no API.
    q = f'SV4a {int(num):03d}/190'
    url = "https://www.google.com/search?q=" + urllib.parse.quote(
        'site:pokemon-card.com/card-search/details.php ' + q
    )
    r=S.get(url,timeout=30); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")
    candidates=[]
    for a in soup.find_all("a",href=True):
        href=a["href"]
        m=re.search(r'https://www\.pokemon-card\.com/card-search/details\.php/card/\d+(?:/regu/all)?',href)
        if m:
            u=m.group(0)
            if u not in candidates: candidates.append(u)
    return candidates[:5]

def official_detail(url, num):
    r=S.get(url,timeout=30); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")
    text=norm(soup.get_text(" ",strip=True))
    h1=soup.find("h1")
    name=norm(h1.get_text(" ",strip=True)) if h1 else ""
    # Must explicitly contain correct set + printed number.
    ok = re.search(rf'\bSV4a\s+0*{int(num)}\s*/\s*190\b', text, re.I) is not None
    return ok,name,r.url

rows=load(IN)
verified=[]; unresolved=[]

for i,row in enumerate(rows,1):
    num=row.get("card_number","")
    print(f"[{i}/{len(rows)}] SV4a #{num}", end=" ")
    try:
        urls=official_search(num)
        hit=None
        for u in urls:
            try:
                ok,name,final=official_detail(u,num)
                if ok and name:
                    hit=(name,final); break
            except Exception:
                pass
            time.sleep(.15)
        if hit:
            x=dict(row)
            x["official_name"]=hit[0]
            x["official_url"]=hit[1]
            x["verification"]="OFFICIAL_NUMBER_MATCH"
            verified.append(x)
            print("=>",hit[0])
        else:
            x=dict(row); x["reason"]="NO_OFFICIAL_EXACT_NUMBER_MATCH"
            unresolved.append(x); print("UNRESOLVED")
    except Exception as e:
        x=dict(row); x["reason"]=repr(e)
        unresolved.append(x); print("ERROR")
    time.sleep(.3)

base_fields=list(rows[0].keys()) if rows else []
save(OUT/"verified.csv",verified,base_fields+["official_name","official_url","verification"])
save(OUT/"unresolved.csv",unresolved,base_fields+["reason"])

summary=[
    "SV4a MISSING 40 OFFICIAL VERIFY",
    "",
    f"input_rows: {len(rows)}",
    f"verified_official_number_match: {len(verified)}",
    f"unresolved: {len(unresolved)}",
    "",
    "READ ONLY / no Supabase writes / no Scrydex API",
    "No INSERT SQL generated yet.",
]
(OUT/"_summary.txt").write_text("\n".join(summary),encoding="utf-8")
print("\n"+"\n".join(summary))
