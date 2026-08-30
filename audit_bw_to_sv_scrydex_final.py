#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV Scrydex全面準拠 V3
- Scrydex APIは使わず公開Webページのみ
- Scrydexの明示レアリティを正として採用
- 未対応セットはScrydex日本語Expansion一覧から自動探索を強化
- DBは直接変更しない
- 最終候補CSV + 安全なUPDATE SQL + rollback SQLを生成
"""

from __future__ import annotations
import csv, re, time, unicodedata
from pathlib import Path
from urllib.parse import urljoin, urlparse
from collections import defaultdict, Counter
import requests
from bs4 import BeautifulSoup

BASE = "https://scrydex.com"
INDEX_URL = BASE + "/pokemon/jp/expansions"
TARGET_SERIES = {"BWシリーズ","XYシリーズ","SMシリーズ","ソード・シールド","SVシリーズ"}
HEADERS = {"User-Agent":"Mozilla/5.0 (compatible; RyoteiPokemonAuditV3/1.0)"}

# Confirmed/special mappings. Generic mappings below cover most SM/SWSH/SV.
OVERRIDES = {
    "BW1-Bb":"bw1b_ja","BW1-Bw":"bw1w_ja","BW2-B":"bw2_ja",
    "BW3-Bh":"bw3h_ja","BW3-Bp":"bw3p_ja","BW4-B":"bw4_ja",
    "BW5-Brn":"bw5d_ja","BW5-Brz":"bw5s_ja","BW6-Bc":"bw6c_ja",
    "BW6-Bf":"bw6f_ja","BW7-B":"bw7_ja","BW8-Brn":"bw8t_ja",
    "BW8-Brf":"bw8s_ja","BW9-B":"bw9_ja","BW10-B":"ebb1_ja","DS":"ds1_ja",
    "XY":"xy_ja","XY1-Bx":"xy1x_ja","XY1-By":"xy1y_ja",
    "XY5-Bg":"xy5g_ja","XY5-Bt":"xy5t_ja","XY8-Bb":"xy8b_ja",
    "XY8-Br":"xy8r_ja","XY9-B":"xy9_ja","XY10-B":"xy10_ja",
    "XY11-Bb":"xy11b_ja","XY11-Br":"xy11r_ja",
    **{f"CP{i}":f"cp{i}_ja" for i in range(1,7)},
}

VALID = {
    "C","U","R","RR","RRR","AR","SR","SAR","UR","HR","MUR",
    "CHR","CSR","S","SSR","A","K","TR","PR","PROMO","ACE","ACE SPEC"
}
LABELS = {
    "COMMON":"C","UNCOMMON":"U","RARE":"R","DOUBLE RARE":"RR",
    "TRIPLE RARE":"RRR","ART RARE":"AR","SUPER RARE":"SR",
    "SPECIAL ART RARE":"SAR","ULTRA RARE":"UR","HYPER RARE":"HR",
    "MEGA ULTRA RARE":"MUR","CHARACTER RARE":"CHR",
    "CHARACTER SUPER RARE":"CSR","SHINY":"S","SHINY RARE":"S",
    "SHINY SUPER RARE":"SSR","AMAZING RARE":"A","RADIANT":"K",
    "TRAINER RARE":"TR","PRISM RARE":"PR","PROMO":"PROMO",
    "ACE":"ACE","ACE SPEC":"ACE SPEC"
}
BLANK = {"","-","—","–","N/A","NA","NONE","NULL"}

def nt(s):
    return re.sub(r"\s+"," ",unicodedata.normalize("NFKC",str(s or "")).strip())

def keynum(s):
    s=nt(s)
    m=re.match(r"^0*(\d+)(?:\s*/\s*\d+)?$",s)
    return str(int(m.group(1))) if m else re.sub(r"\s+","",s).upper()

def nr(s):
    u=nt(s).upper()
    if u in BLANK: return ""
    if u in VALID: return u
    u=re.sub(r"\s*\([^)]*\)\s*","",u).strip()
    return LABELS.get(u,"")

def compact(s):
    return re.sub(r"[^a-z0-9]","",nt(s).lower())

def locate(name):
    for p in [Path(name),Path("supabase_export_db")/name,Path("supabase_export")/name]:
        if p.exists(): return p
    raise FileNotFoundError(name)

def load(path):
    with path.open(encoding="utf-8-sig",newline="") as f: return list(csv.DictReader(f))

def save(path,rows,fields):
    path.parent.mkdir(parents=True,exist_ok=True)
    with path.open("w",encoding="utf-8-sig",newline="") as f:
        w=csv.DictWriter(f,fieldnames=fields,extrasaction="ignore"); w.writeheader(); w.writerows(rows)

def q(s): return "'" + str(s).replace("'","''") + "'"

def discover(sess):
    r=sess.get(INDEX_URL,timeout=30); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")
    out={}
    for a in soup.find_all("a",href=True):
        href=a["href"]
        if "/pokemon/expansions/" not in href: continue
        full=urljoin(BASE,href)
        parts=[x for x in urlparse(full).path.split("/") if x]
        if not parts: continue
        sid=parts[-1]
        if not sid.endswith("_ja"): continue
        out[sid]={"id":sid,"url":full,"text":nt(a.get_text(" ",strip=True))}
    for m in re.finditer(r'href=["\']([^"\']*/pokemon/expansions/[^"\']+/([A-Za-z0-9_-]+_ja))["\']',r.text):
        href,sid=m.groups()
        out.setdefault(sid,{"id":sid,"url":urljoin(BASE,href),"text":""})
    return out

def candidates(code,series):
    out=[]
    if code in OVERRIDES: out.append(OVERRIDES[code])
    c=compact(code)
    if series=="BWシリーズ":
        m=re.match(r"bw(\d+)([a-z]?)",c)
        if m:
            n,s=m.groups(); out += [f"bw{n}{s}_ja",f"bw{n}_ja"]
        out += [f"{c}_ja"]
    elif series=="XYシリーズ":
        out += [f"{c}_ja"]
    elif series=="SMシリーズ":
        out += [f"{c}_ja"]
    elif series=="ソード・シールド":
        if re.match(r"^s\d",c): out += [f"swsh{c[1:]}_ja",f"{c}_ja"]
        else: out += [f"{c}_ja"]
    elif series=="SVシリーズ":
        out += [f"{c}_ja"]
    return list(dict.fromkeys(out))

def token_score(db_code,db_name,info):
    # Conservative fallback matching by names/link text/id.
    a=compact(db_name); b=compact(info["text"]); sid=compact(info["id"].replace("_ja",""))
    score=0
    if a and b and (a in b or b in a): score+=100
    cc=compact(db_code)
    if cc and cc==sid: score+=90
    if cc and (cc in sid or sid in cc): score+=35
    # shared alnum tokens from name
    toks=[compact(x) for x in re.findall(r"[A-Za-z0-9]+",nt(db_name)) if len(compact(x))>=2]
    score += sum(8 for t in toks if t in b)
    return score

def map_set(s,exp):
    code=nt(s.get("code")); series=nt(s.get("series_name"))
    for cid in candidates(code,series):
        if cid in exp: return cid,"RULE"
    scored=sorted(((token_score(code,s.get("name",""),v),sid) for sid,v in exp.items()),reverse=True)
    if scored and scored[0][0] >= 90:
        # Only accept strong fallback; avoid guessing.
        if len(scored)==1 or scored[0][0] > scored[1][0]:
            return scored[0][1],"NAME"
    return None,"UNRESOLVED"

def parse_page(sess,url):
    r=sess.get(url,timeout=30); r.raise_for_status()
    soup=BeautifulSoup(r.text,"html.parser")
    rows=[]
    for table in soup.find_all("table"):
        trs=table.find_all("tr")
        if not trs: continue
        heads=[nt(x.get_text(" ",strip=True)).lower() for x in trs[0].find_all(["th","td"])]
        ni=ri=None
        for i,h in enumerate(heads):
            if "number" in h or h in {"no","no."}: ni=i
            if "rarity" in h: ri=i
        if ni is None or ri is None: continue
        for tr in trs[1:]:
            td=tr.find_all("td")
            if max(ni,ri)>=len(td): continue
            num=nt(td[ni].get_text(" ",strip=True))
            if not num: continue
            raw=nt(td[ri].get_text(" ",strip=True))
            rows.append({"num":keynum(num),"raw":raw,"rarity":nr(raw)})
    return rows

def main():
    cards=load(locate("cards.csv")); sets=load(locate("card_sets.csv"))
    tsets=[s for s in sets if nt(s.get("series_name")) in TARGET_SERIES]
    tids={s["id"] for s in tsets}
    tcards=[c for c in cards if c.get("set_id") in tids]
    sbid={s["id"]:s for s in tsets}
    out=Path("bw_to_sv_scrydex_final")
    sess=requests.Session(); sess.headers.update(HEADERS)

    print("Scrydex expansion一覧取得...")
    exp=discover(sess)
    mapping={}; maprows=[]
    for s in tsets:
        sid,method=map_set(s,exp)
        if sid: mapping[s["id"]]=sid
        maprows.append({
            "set_id":s["id"],"series_name":s.get("series_name",""),"db_code":s.get("code",""),
            "db_name":s.get("name",""),"scrydex_id":sid or "",
            "scrydex_url":exp.get(sid,{}).get("url","") if sid else "",
            "mapping_method":method
        })
    save(out/"set_mapping_final.csv",maprows,
         ["set_id","series_name","db_code","db_name","scrydex_id","scrydex_url","mapping_method"])

    parsed={}; fetch=[]
    mids=sorted(set(mapping.values()))
    for i,sid in enumerate(mids,1):
        print(f"[{i}/{len(mids)}] {sid}")
        try:
            rr=parse_page(sess,exp[sid]["url"]); parsed[sid]=rr
            fetch.append({"scrydex_id":sid,"rows_found":len(rr),"status":"OK","url":exp[sid]["url"],"error":""})
        except Exception as e:
            fetch.append({"scrydex_id":sid,"rows_found":0,"status":"ERROR","url":exp[sid]["url"],"error":repr(e)})
        time.sleep(.12)
    save(out/"set_fetch_stats_final.csv",fetch,["scrydex_id","rows_found","status","url","error"])

    index={}
    for sid,rr in parsed.items():
        d=defaultdict(list)
        for x in rr:d[x["num"]].append(x)
        index.update({(sid,k):v for k,v in d.items()})

    accepted=[]; unresolved=[]; missing=[]
    for c in tcards:
        s=sbid[c["set_id"]]; sid=mapping.get(c["set_id"])
        base={
            "card_id":c["id"],"series_name":s.get("series_name",""),"set_code":s.get("code",""),
            "set_name":s.get("name",""),"scrydex_id":sid or "","card_number":c.get("card_number",""),
            "card_name":c.get("name",""),"current_rarity":nt(c.get("rarity")).upper()
        }
        if not sid:
            unresolved.append({**base,"scrydex_rarity":"","scrydex_rarity_raw":"","reason":"UNRESOLVED_SET"}); continue
        vals=index.get((sid,keynum(c.get("card_number",""))),[])
        if not vals:
            unresolved.append({**base,"scrydex_rarity":"","scrydex_rarity_raw":"","reason":"CARD_NOT_FOUND"}); continue
        rs={x["rarity"] for x in vals if x["rarity"]}
        raws="|".join(sorted({x["raw"] for x in vals}))
        if len(rs)!=1:
            unresolved.append({**base,"scrydex_rarity":"","scrydex_rarity_raw":raws,
                               "reason":"SCRYDEX_BLANK" if not rs else "AMBIGUOUS"}); continue
        expected=next(iter(rs))
        if base["current_rarity"] != expected:
            accepted.append({**base,"scrydex_rarity":expected,"scrydex_rarity_raw":raws})
        if not nt(c.get("image_url")):
            nk=keynum(c.get("card_number",""))
            url=f"https://images.scrydex.com/pokemon/{sid}-{int(nk)}/large" if nk.isdigit() else ""
            missing.append({**base,"expected_image_url":url})

    af=["card_id","series_name","set_code","set_name","scrydex_id","card_number","card_name",
        "current_rarity","scrydex_rarity","scrydex_rarity_raw"]
    save(out/"rarity_updates_final.csv",accepted,af)
    save(out/"unresolved_final.csv",unresolved,af+["reason"])
    save(out/"missing_images_final.csv",missing,
         ["card_id","series_name","set_code","set_name","scrydex_id","card_number","card_name","current_rarity","expected_image_url"])

    # Safe SQL: backup every touched card, and update only if current rarity still matches export.
    sql=[
        "-- BW-SV Scrydex全面準拠: explicit Scrydex rarity only",
        "BEGIN;",
        "CREATE TABLE IF NOT EXISTS public.bw_sv_rarity_backup_scrydex_final (",
        " card_id uuid PRIMARY KEY, old_rarity text, new_rarity text, backed_up_at timestamptz NOT NULL DEFAULT now());",""
    ]
    for r in accepted:
        cid,old,new=r["card_id"],r["current_rarity"],r["scrydex_rarity"]
        sql += [
            f"-- {r['set_code']} {r['card_number']} {r['card_name']}: {old or '(blank)'} -> {new}",
            "INSERT INTO public.bw_sv_rarity_backup_scrydex_final(card_id,old_rarity,new_rarity)",
            f"SELECT id, rarity, {q(new)} FROM public.cards WHERE id={q(cid)}::uuid",
            "ON CONFLICT (card_id) DO NOTHING;",
            f"UPDATE public.cards SET rarity={q(new)}, updated_at=now()",
            f"WHERE id={q(cid)}::uuid AND COALESCE(rarity,'')={q(old)};",""
        ]
    sql += ["COMMIT;",
            "SELECT COUNT(*) AS backed_up_rows FROM public.bw_sv_rarity_backup_scrydex_final;"]
    (out/"APPLY_rarity_scrydex_final.sql").write_text("\n".join(sql),encoding="utf-8")

    rb="""BEGIN;
UPDATE public.cards c
SET rarity=b.old_rarity, updated_at=now()
FROM public.bw_sv_rarity_backup_scrydex_final b
WHERE c.id=b.card_id;
COMMIT;
SELECT COUNT(*) AS restored_rows FROM public.bw_sv_rarity_backup_scrydex_final;
"""
    (out/"ROLLBACK_rarity_scrydex_final.sql").write_text(rb,encoding="utf-8")

    mc=Counter(x["mapping_method"] for x in maprows)
    rc=Counter(x["reason"] for x in unresolved)
    summary=[
        f"db_target_sets: {len(tsets)}",f"db_target_cards: {len(tcards)}",
        f"scrydex_expansions_discovered: {len(exp)}",f"mapped_sets: {len(mapping)}",
        f"mapped_by_rule: {mc['RULE']}",f"mapped_by_name: {mc['NAME']}",
        f"unresolved_sets: {mc['UNRESOLVED']}",f"rarity_updates: {len(accepted)}",
        f"unresolved_cards: {len(unresolved)}",f"scrydex_blank: {rc['SCRYDEX_BLANK']}",
        f"card_not_found: {rc['CARD_NOT_FOUND']}",f"cards_in_unresolved_sets: {rc['UNRESOLVED_SET']}",
        f"ambiguous: {rc['AMBIGUOUS']}",f"missing_images: {len(missing)}",
        "NOTE: SQLは生成しましたが、まだ実行しないでください。"
    ]
    (out/"_summary_final.txt").write_text("\n".join(summary),encoding="utf-8")
    print("\n完了:",out.resolve()); print("\n"+"\n".join(summary))

if __name__=="__main__":
    main()
