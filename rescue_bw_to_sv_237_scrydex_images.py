#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW-SV Scrydex image rescue for the 237 CARD_NOT_FOUND rows.
READ-ONLY: does not update Supabase.
Input: image_unresolved.csv
Output: bw_to_sv_scrydex_image_rescue/
Strategy:
- only the 6 sets present in image_unresolved.csv
- search Scrydex public HTML / search-engine-visible card pages
- require exact Scrydex set id + numeric card number before accepting
- extract only image URLs actually present in returned Scrydex HTML
- generate SQL only for confirmed matches
"""
import csv, re, time, html, sys
from pathlib import Path
from urllib.parse import quote, urljoin
import requests

INFILE = Path("image_unresolved.csv")
OUT = Path("bw_to_sv_scrydex_image_rescue")
OUT.mkdir(exist_ok=True)
APPLY = OUT / "APPLY_chunks"
APPLY.mkdir(exist_ok=True)

# Confirmed/previous RULE mappings. Edit only if your set_mapping_final.csv says otherwise.
SET_IDS = {
    "SV4a": "sv4a_ja",
    "S4a": "s4a_ja",
    "S8b": "s8b_ja",
    "S12a": "s12a_ja",
    "SM2L": "sm2l_ja",
    "SGG": "sgg_ja",
}

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/152 Safari/537.36"
S = requests.Session()
S.headers.update({"User-Agent": UA, "Accept-Language": "ja,en;q=0.8"})

IMG_RE = re.compile(r'https?://[^"\'<>\\\s]+', re.I)
CARD_HREF_RE = re.compile(r'href=["\']([^"\']+)["\']', re.I)

def numkey(v):
    m = re.search(r'\d+', str(v or ""))
    return str(int(m.group())) if m else ""

def fetch(url):
    r=S.get(url, timeout=25)
    r.raise_for_status()
    return r.text

def image_from_html(txt):
    candidates=[]
    # meta image first
    for pat in [
        r'<meta[^>]+property=["\']og:image["\'][^>]+content=["\']([^"\']+)',
        r'<meta[^>]+content=["\']([^"\']+)["\'][^>]+property=["\']og:image["\']',
        r'<meta[^>]+name=["\']twitter:image["\'][^>]+content=["\']([^"\']+)',
        r'<meta[^>]+content=["\']([^"\']+)["\'][^>]+name=["\']twitter:image["\']',
    ]:
        candidates += re.findall(pat, txt, re.I)
    candidates += IMG_RE.findall(txt)
    for u in candidates:
        u=html.unescape(u).replace("\\u0026","&").replace("\\/","/")
        if "scrydex" in u.lower() and re.search(r'\.(?:png|jpe?g|webp)(?:\?|$)|images\.scrydex\.com',u,re.I):
            return u
    return ""

def discover_detail(exp_id, number, card_name):
    # First try Scrydex search page; do not invent a card slug.
    queries=[
        f"{exp_id}-{number}",
        f"{card_name} {exp_id}-{number}",
    ]
    for q in queries:
        for base in [
            "https://scrydex.com/search?q=" + quote(q),
            "https://scrydex.com/pokemon/cards?search=" + quote(q),
        ]:
            try:
                txt=fetch(base)
            except Exception:
                continue
            for href in CARD_HREF_RE.findall(txt):
                h=html.unescape(href)
                if f"{exp_id}-{number}" in h.lower():
                    return urljoin("https://scrydex.com", h)
    return ""

def main():
    if not INFILE.exists():
        print("ERROR: image_unresolved.csv をこのPythonと同じフォルダに置いてください。")
        sys.exit(1)
    rows=list(csv.DictReader(INFILE.open(encoding="utf-8-sig")))
    confirmed=[]; unresolved=[]
    cache={}
    for i,row in enumerate(rows,1):
        code=row["set_code"].strip()
        exp=SET_IDS.get(code)
        n=numkey(row["card_number"])
        if not exp or not n:
            row["rescue_reason"]="NO_MAPPING_OR_NUMBER"; unresolved.append(row); continue

        key=(exp,n)
        detail=cache.get(key)
        if detail is None:
            detail=discover_detail(exp,n,row.get("card_name",""))
            cache[key]=detail
            time.sleep(0.15)

        if not detail:
            row["rescue_reason"]="DETAIL_NOT_FOUND"; unresolved.append(row); continue

        # Critical safety check: exact expansion id-number must be in detail URL.
        if f"{exp}-{n}" not in detail.lower():
            row["rescue_reason"]="DETAIL_ID_MISMATCH"; row["scrydex_detail_url"]=detail
            unresolved.append(row); continue
        try:
            txt=fetch(detail)
            img=image_from_html(txt)
        except Exception as e:
            row["rescue_reason"]="DETAIL_FETCH_ERROR"; row["detail_error"]=str(e)
            unresolved.append(row); continue
        if not img:
            row["rescue_reason"]="IMAGE_NOT_FOUND_IN_HTML"; row["scrydex_detail_url"]=detail
            unresolved.append(row); continue
        x=dict(row)
        x["scrydex_detail_url"]=detail
        x["new_image_url"]=img
        confirmed.append(x)
        if i % 20 == 0: print(f"{i}/{len(rows)} confirmed={len(confirmed)} unresolved={len(unresolved)}")

    fields=list(rows[0].keys()) if rows else []
    def writecsv(path,data,extra):
        fs=fields+[x for x in extra if x not in fields]
        with path.open("w",encoding="utf-8-sig",newline="") as f:
            w=csv.DictWriter(f,fieldnames=fs,extrasaction="ignore"); w.writeheader(); w.writerows(data)
    writecsv(OUT/"rescue_confirmed.csv",confirmed,["scrydex_detail_url","new_image_url"])
    writecsv(OUT/"rescue_unresolved.csv",unresolved,["rescue_reason","scrydex_detail_url","detail_error"])

    # SQL chunks; backup first, then exact UUID update.
    table="public.bw_sv_image_rescue_backup_20260829"
    for chunk_i,start in enumerate(range(0,len(confirmed),300),1):
        chunk=confirmed[start:start+300]
        vals=[]
        for r in chunk:
            def q(s): return "'" + str(s).replace("'","''") + "'"
            vals.append(f"({q(r['card_id'])}::uuid,{q(r['new_image_url'])})")
        sql=f"""BEGIN;
CREATE TABLE IF NOT EXISTS {table} (
 card_id uuid PRIMARY KEY,
 old_image_url text,
 old_image_source_note text,
 backed_up_at timestamptz NOT NULL DEFAULT now()
);
WITH changes(card_id,new_image_url) AS (VALUES
{','.join(vals)}
)
INSERT INTO {table}(card_id,old_image_url,old_image_source_note)
SELECT c.id,c.image_url,c.image_source_note
FROM public.cards c JOIN changes x ON x.card_id=c.id
ON CONFLICT (card_id) DO NOTHING;

WITH changes(card_id,new_image_url) AS (VALUES
{','.join(vals)}
)
UPDATE public.cards c
SET image_url=x.new_image_url,
    image_source_note='Scrydex public web image / rescue 2026-08-29'
FROM changes x WHERE c.id=x.card_id;
COMMIT;
SELECT COUNT(*) AS total_backup_rows FROM {table};
"""
        (APPLY/f"{chunk_i:02d}_APPLY_rescue.sql").write_text(sql,encoding="utf-8")

    rb=f"""BEGIN;
UPDATE public.cards c
SET image_url=b.old_image_url,
    image_source_note=b.old_image_source_note
FROM {table} b
WHERE c.id=b.card_id;
COMMIT;
"""
    (OUT/"ROLLBACK_all.sql").write_text(rb,encoding="utf-8")

    byset={}
    for r in confirmed: byset[r["set_code"]]=byset.get(r["set_code"],0)+1
    reasons={}
    for r in unresolved:
        z=r.get("rescue_reason","UNKNOWN"); reasons[z]=reasons.get(z,0)+1
    summary=[
        f"input_unresolved: {len(rows)}",
        f"rescue_confirmed: {len(confirmed)}",
        f"still_unresolved: {len(unresolved)}",
        f"sql_chunks: {(len(confirmed)+299)//300}",
        "",
        "[confirmed by set]",
    ]+[f"{k}: {v}" for k,v in sorted(byset.items())]+["","[unresolved reasons]"]+[f"{k}: {v}" for k,v in sorted(reasons.items())]+[
        "","IMPORTANT: Python does not update Supabase. Review CSVs before SQL."
    ]
    (OUT/"_summary.txt").write_text("\n".join(summary),encoding="utf-8")
    print("\n".join(summary))

if __name__=="__main__":
    main()
