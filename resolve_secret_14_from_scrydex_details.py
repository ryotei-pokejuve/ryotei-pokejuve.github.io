#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV シークレット欠損 14件 Scrydex詳細ページ日本語名復元 V2
- Scrydex API不使用
- 公開カード詳細ページのみ
- DB更新なし
- 推測翻訳なし

入力:
  secret_264_resolved.csv
  secret_264_unresolved.csv

出力:
  bw_to_sv_secret_detail_resolve/
    _summary.txt
    secret_264_resolved_all.csv
    detail_resolved_14.csv
    detail_still_unresolved.csv
    detail_fetch_log.csv
"""

from __future__ import annotations
import csv, json, re, time, unicodedata
from pathlib import Path
from urllib.parse import quote
import requests
from bs4 import BeautifulSoup

HEADERS = {"User-Agent":"Mozilla/5.0 (compatible; RyoteiSecretDetailResolver/1.0)"}

def nt(v):
    return re.sub(r"\s+"," ",unicodedata.normalize("NFKC",str(v or "")).strip())

def locate(*paths):
    for x in paths:
        p=Path(x)
        if p.exists():
            return p
    raise FileNotFoundError("見つかりません: " + " / ".join(paths))

def load(p):
    with p.open(encoding="utf-8-sig",newline="") as f:
        return list(csv.DictReader(f))

def save(p,rows,fields):
    p.parent.mkdir(parents=True,exist_ok=True)
    with p.open("w",encoding="utf-8-sig",newline="") as f:
        w=csv.DictWriter(f,fieldnames=fields,extrasaction="ignore")
        w.writeheader(); w.writerows(rows)

def slugify(name):
    s=unicodedata.normalize("NFKD",nt(name)).encode("ascii","ignore").decode("ascii")
    s=s.lower().replace("pokemon","pokemon")
    s=re.sub(r"['’`]", "", s)
    s=re.sub(r"[^a-z0-9]+","-",s).strip("-")
    return s

def walk(obj):
    if isinstance(obj,dict):
        yield obj
        for v in obj.values():
            yield from walk(v)
    elif isinstance(obj,list):
        for v in obj:
            yield from walk(v)

def jp_chars(s):
    return bool(re.search(r"[ぁ-んァ-ヶ一-龯々ー]",str(s or "")))

def extract_from_json(soup, wanted_id):
    # Next/React embedded JSON can contain the card object.
    for sc in soup.find_all("script"):
        txt=sc.string or sc.get_text("",strip=False)
        if not txt or wanted_id not in txt:
            continue
        # Normal JSON script tags first.
        if sc.get("type") in {"application/json","application/ld+json"} or txt.lstrip().startswith(("{","[")):
            try:
                obj=json.loads(txt)
                for d in walk(obj):
                    if str(d.get("id","")) == wanted_id:
                        n=d.get("name")
                        if jp_chars(n):
                            return nt(n), "EMBEDDED_JSON"
            except Exception:
                pass

        # Fallback: card id and Japanese name may be serialized near each other.
        # Find a bounded window around the exact id and inspect name fields.
        pos=txt.find(wanted_id)
        if pos >= 0:
            window=txt[max(0,pos-2000):pos+5000]
            for pat in [
                r'"name"\s*:\s*"([^"]+)"',
                r'\\"name\\"\s*:\s*\\"([^"]+)\\"',
            ]:
                vals=re.findall(pat,window)
                for n in vals:
                    try:
                        n=bytes(n,"utf-8").decode("unicode_escape") if "\\u" in n else n
                    except Exception:
                        pass
                    if jp_chars(n):
                        return nt(n), "SERIALIZED_JSON_WINDOW"
    return "", ""

def extract_from_visible_text(soup, english_name):
    text=soup.get_text("\n",strip=True)
    lines=[nt(x) for x in text.splitlines() if nt(x)]

    # Scrydex Japanese detail pages expose Japanese name in Data Details.
    # Search near "name / string / The name of the card".
    for i,line in enumerate(lines):
        if line.lower()=="name":
            window=lines[i:i+8]
            for x in window:
                if jp_chars(x) and x != english_name:
                    return x, "VISIBLE_DATA_DETAILS"

    # Expansion/card pages can also show Japanese name near the main title/details.
    for marker in ["Language","Japanese","Expansion","Rarity"]:
        for i,line in enumerate(lines):
            if line==marker:
                for x in lines[max(0,i-10):i+10]:
                    if jp_chars(x) and len(x)<=60:
                        # exclude common metadata labels
                        if x not in {"日本語","ポケモン","トレーナー","エネルギー","スーパーレア","ウルトラレア"}:
                            return x, "VISIBLE_NEAR_DETAILS"
    return "", ""

def fetch_jp_name(session,row):
    sid=nt(row["scrydex_id"])
    num=nt(row["number_key"])
    en=nt(row["scrydex_name"])
    wanted_id=f"{sid}-{int(num) if num.isdigit() else num}"
    slug=slugify(en)
    urls=[
        f"https://scrydex.com/pokemon/cards/{slug}/{wanted_id}",
    ]
    last_err=""
    for url in urls:
        try:
            r=session.get(url,timeout=35,allow_redirects=True)
            if r.status_code != 200:
                last_err=f"HTTP {r.status_code}"
                continue
            soup=BeautifulSoup(r.text,"html.parser")
            name,method=extract_from_json(soup,wanted_id)
            if not name:
                name,method=extract_from_visible_text(soup,en)
            if name:
                return name,method,r.url,""
            last_err="JP_NAME_NOT_FOUND"
        except Exception as e:
            last_err=repr(e)
    return "","","",last_err

def main():
    resolved=load(locate(
        "secret_264_resolved.csv",
        "bw_to_sv_secret_name_restore/secret_264_resolved.csv"
    ))
    unresolved=load(locate(
        "secret_264_unresolved.csv",
        "bw_to_sv_secret_name_restore/secret_264_unresolved.csv"
    ))

    sess=requests.Session()
    sess.headers.update(HEADERS)

    fixed=[]
    still=[]
    logs=[]

    print(f"Scrydex詳細ページで未解決 {len(unresolved)} 件を確認...")
    for i,row in enumerate(unresolved,1):
        print(f"[{i}/{len(unresolved)}] {row.get('set_code')} #{row.get('number_key')} {row.get('scrydex_name')}")
        jp,method,url,err=fetch_jp_name(sess,row)
        rr=dict(row)
        if jp:
            rr["jp_name"]=jp
            rr["name_resolution_method"]="SCRYDEX_DETAIL_"+method
            rr["name_confidence"]="HIGH"
            rr["unresolved_reason"]=""
            fixed.append(rr)
            status="RESOLVED"
            print("  ->",jp)
        else:
            still.append(rr)
            status="UNRESOLVED"
            print("  -> unresolved:",err)
        logs.append({
            "set_code":row.get("set_code",""),
            "number_key":row.get("number_key",""),
            "scrydex_name":row.get("scrydex_name",""),
            "jp_name":jp,
            "status":status,
            "method":method,
            "final_url":url,
            "error":err,
        })
        time.sleep(.15)

    all_rows=resolved+fixed
    fields=list((all_rows or unresolved)[0].keys()) if (all_rows or unresolved) else []

    out=Path("bw_to_sv_secret_detail_resolve")
    save(out/"detail_resolved_14.csv",fixed,fields)
    save(out/"detail_still_unresolved.csv",still,fields)
    save(out/"secret_264_resolved_all.csv",all_rows,fields)
    save(out/"detail_fetch_log.csv",logs,
         ["set_code","number_key","scrydex_name","jp_name","status","method","final_url","error"])

    summary=[
        f"previously_resolved: {len(resolved)}",
        f"detail_target: {len(unresolved)}",
        f"detail_resolved: {len(fixed)}",
        f"still_unresolved: {len(still)}",
        f"total_resolved: {len(all_rows)}",
        "",
        "NOTE: DB更新なし。",
        "NOTE: Scrydex公開カード詳細ページに掲載された日本語名のみ採用。",
        "NOTE: total_resolved=264 なら次にINSERT SQL生成へ進める。",
    ]
    (out/"_summary.txt").write_text("\n".join(summary),encoding="utf-8")
    print("\n完了:",out.resolve())
    print("\n"+"\n".join(summary))

if __name__=="__main__":
    main()
