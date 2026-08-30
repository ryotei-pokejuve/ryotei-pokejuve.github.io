#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
XY / XY6 / XY7 欠損カード専用監査 V1（READ ONLY）

目的:
- DBにある番号 / Scrydexにある番号を比較
- 欠損303件をカード単位で整理
- Scrydexカード詳細ページから、取得できる範囲で
  名前 / レアリティ / 画像URL / カードURL を確認
- DB側の既存カードが「一部だけ入っている」のかを把握する

入力:
  cards.csv
  card_sets.csv
  set_mapping_final.csv
    または bw_to_sv_scrydex_final/set_mapping_final.csv

出力:
  xy_3set_missing_audit/
    _summary.txt
    set_summary.csv
    missing_cards_detail.csv
    db_existing_cards.csv
    db_not_found_in_scrydex.csv
    fetch_errors.csv

安全:
- Supabaseへ書き込まない
- Scrydex APIは使わない
- RULE mappingだけ
- ScrydexセットURLは mapping CSV の scrydex_url をそのまま使用
- 画像URLはHTML内で実際に確認できたものだけ
"""

from __future__ import annotations
import csv, html, re, time, unicodedata
from collections import defaultdict
from pathlib import Path
from urllib.parse import urljoin

import requests
from bs4 import BeautifulSoup

TARGET_CODES = {"XY", "XY6", "XY7"}
OUT = Path("xy_3set_missing_audit")
OUT.mkdir(exist_ok=True)

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiXYAudit/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}

def nt(v):
    return re.sub(r"\s+", " ", unicodedata.normalize("NFKC", str(v or "")).strip())

def numkey(v):
    s = nt(v)
    m = re.match(r"^0*(\d+)(?:\s*/\s*0*\d+)?$", s)
    if m:
        return str(int(m.group(1)))
    m = re.match(r"^0*(\d+)", s)
    return str(int(m.group(1))) if m else ""

def locate(*candidates):
    for c in candidates:
        p = Path(c)
        if p.exists():
            return p
    raise FileNotFoundError("見つかりません: " + " / ".join(candidates))

def load_csv(path):
    with path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))

def save_csv(path, rows, fields=None):
    if not rows:
        path.write_text("", encoding="utf-8-sig")
        return
    fields = fields or list(rows[0].keys())
    with path.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)

def rarity_token(raw):
    s = nt(raw).upper()
    known = ["PROMO","SAR","MUR","CSR","CHR","SSR","RRR","SR","HR","UR","AR","RR","PR","R","U","C","S","A","K"]
    for x in known:
        if s == x:
            return x
    for x in sorted(known, key=len, reverse=True):
        if re.search(rf"(?<![A-Z0-9]){re.escape(x)}(?![A-Z0-9])", s):
            return x
    return ""

def extract_image(node, base_url):
    vals = []
    nodes = [node] + list(node.find_all(True))
    for tag in nodes:
        for attr in ("src", "data-src", "data-lazy-src", "data-original"):
            v = tag.get(attr)
            if v:
                vals.append(v)
        ss = tag.get("srcset")
        if ss:
            for part in ss.split(","):
                vals.append(part.strip().split(" ")[0])

    for v in vals:
        u = urljoin(base_url, html.unescape(nt(v)))
        low = u.lower()
        if "scrydex" in low and ("/pokemon/" in low or "image" in low):
            return u
    return ""

def parse_set_page(sess, url, sid):
    r = sess.get(url, timeout=40)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")

    cards = {}

    # Exact card links: strongest source for identity/number.
    for a in soup.find_all("a", href=True):
        href = html.unescape(nt(a.get("href")))
        full = urljoin(r.url, href)
        tail = full.split("?")[0].rstrip("/").split("/")[-1]
        prefix = sid.lower() + "-"
        if not tail.lower().startswith(prefix):
            continue

        rest = tail[len(sid) + 1:]
        m = re.match(r"0*(\d+)", rest)
        if not m:
            continue

        n = str(int(m.group(1)))
        rec = cards.setdefault(n, {
            "number": n,
            "name": "",
            "rarity": "",
            "image_url": "",
            "card_url": full,
        })
        rec["card_url"] = full

        # Link metadata only; no guessing.
        for source in (a, a.find("img")):
            if not source:
                continue
            for attr in ("aria-label", "title", "alt"):
                v = nt(source.get(attr))
                if not v:
                    continue
                if re.fullmatch(r"\d+(?:/\d+)?", v):
                    continue
                if v.lower() == sid.lower():
                    continue
                rec["name"] = rec["name"] or v

        rec["image_url"] = rec["image_url"] or extract_image(a, r.url)

    # Table metadata if explicitly present.
    for table in soup.find_all("table"):
        trs = table.find_all("tr")
        if not trs:
            continue
        heads = [nt(x.get_text(" ", strip=True)).lower() for x in trs[0].find_all(["th","td"])]
        ni = namei = ri = None
        for i, h in enumerate(heads):
            if "number" in h or h in {"#", "no", "no."}:
                ni = i
            if "name" in h:
                namei = i
            if "rarity" in h:
                ri = i
        if ni is None:
            continue

        for tr in trs[1:]:
            td = tr.find_all("td")
            if ni >= len(td):
                continue
            n = numkey(td[ni].get_text(" ", strip=True))
            if not n:
                continue
            rec = cards.setdefault(n, {
                "number": n,
                "name": "",
                "rarity": "",
                "image_url": "",
                "card_url": "",
            })
            if namei is not None and namei < len(td):
                rec["name"] = nt(td[namei].get_text(" ", strip=True)) or rec["name"]
            if ri is not None and ri < len(td):
                rec["rarity"] = rarity_token(td[ri].get_text(" ", strip=True)) or rec["rarity"]
            rec["image_url"] = rec["image_url"] or extract_image(tr, r.url)

    return cards, r.url

def fetch_card_detail(sess, rec):
    url = rec.get("card_url")
    if not url:
        return rec, ""

    try:
        r = sess.get(url, timeout=40)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, "html.parser")
    except Exception as e:
        return rec, repr(e)

    # Image: actual page HTML only.
    rec["image_url"] = rec.get("image_url") or extract_image(soup, r.url)

    # JSON-LD / meta / h1 candidates for name. Keep conservative.
    name_candidates = []
    for sel in ("h1", "meta[property='og:title']", "meta[name='twitter:title']"):
        for x in soup.select(sel):
            if x.name == "meta":
                v = nt(x.get("content"))
            else:
                v = nt(x.get_text(" ", strip=True))
            if v:
                name_candidates.append(v)

    # Strip obvious site suffixes only.
    for v in name_candidates:
        cleaned = re.sub(r"\s*[|\-–—]\s*Scrydex.*$", "", v, flags=re.I).strip()
        cleaned = re.sub(r"^\s*\d+(?:/\d+)?\s*", "", cleaned).strip()
        if cleaned and cleaned.lower() not in {"scrydex", rec.get("number","")}:
            if len(cleaned) <= 120:
                rec["name"] = rec.get("name") or cleaned
                break

    text = "\n".join(nt(x.get_text(" ", strip=True)) for x in soup.find_all(["tr","li","div","p"]))
    # Explicit rarity labels only.
    m = re.search(r"(?:Rarity|レアリティ)\s*[:：]?\s*([A-Za-z0-9]+)", text, re.I)
    if m:
        rec["rarity"] = rec.get("rarity") or rarity_token(m.group(1))

    return rec, ""

def main():
    cards = load_csv(locate("cards.csv"))
    sets = load_csv(locate("card_sets.csv"))
    maps = load_csv(locate("set_mapping_final.csv", "bw_to_sv_scrydex_final/set_mapping_final.csv"))

    set_by_id = {s["id"]: s for s in sets}

    selected = {}
    for m in maps:
        set_id = m.get("set_id")
        s = set_by_id.get(set_id, {})
        code = nt(m.get("db_code") or s.get("code"))
        if code in TARGET_CODES and nt(m.get("mapping_method")).upper() == "RULE":
            selected[set_id] = m

    db_by_set = defaultdict(list)
    for c in cards:
        if c.get("set_id") in selected and nt(c.get("is_active")).lower() not in {"false","0","no"}:
            db_by_set[c["set_id"]].append(c)

    sess = requests.Session()
    sess.headers.update(HEADERS)

    set_summary = []
    missing = []
    existing = []
    notfound = []
    errors = []

    for set_id, m in selected.items():
        s = set_by_id.get(set_id, {})
        code = nt(m.get("db_code") or s.get("code"))
        set_name = nt(s.get("name"))
        sid = nt(m.get("scrydex_id"))
        set_url = nt(m.get("scrydex_url"))

        rows = db_by_set[set_id]
        dbnum = defaultdict(list)
        for c in rows:
            n = numkey(c.get("card_number"))
            if n:
                dbnum[n].append(c)

        print(f"\n{code}: DB {len(rows)} / {sid}")

        try:
            scards, final_set_url = parse_set_page(sess, set_url, sid)
        except Exception as e:
            errors.append({
                "set_code": code,
                "set_name": set_name,
                "scrydex_id": sid,
                "scrydex_url": set_url,
                "stage": "SET_PAGE",
                "error": repr(e),
            })
            continue

        dbnums = set(dbnum)
        snums = set(scards)

        print(f"  Scrydex {len(snums)} / missing {len(snums-dbnums)}")

        # Existing DB cards for pattern inspection.
        for n in sorted(dbnums, key=int):
            for c in dbnum[n]:
                existing.append({
                    "set_code": code,
                    "set_name": set_name,
                    "card_number_numeric": n,
                    "db_card_number": c.get("card_number",""),
                    "db_name": c.get("name",""),
                    "db_rarity": c.get("rarity",""),
                    "db_variant": c.get("variant",""),
                    "db_image_url": c.get("image_url",""),
                    "found_in_scrydex": "YES" if n in snums else "NO",
                    "scrydex_card_url": scards.get(n,{}).get("card_url",""),
                })

        missing_nums = sorted(snums - dbnums, key=int)
        for idx, n in enumerate(missing_nums, 1):
            rec = dict(scards[n])
            rec, detail_err = fetch_card_detail(sess, rec)

            if detail_err:
                errors.append({
                    "set_code": code,
                    "set_name": set_name,
                    "scrydex_id": sid,
                    "scrydex_url": rec.get("card_url",""),
                    "stage": "CARD_DETAIL",
                    "card_number": n,
                    "error": detail_err,
                })

            missing.append({
                "set_code": code,
                "set_name": set_name,
                "scrydex_id": sid,
                "card_number": n,
                "scrydex_name": rec.get("name",""),
                "scrydex_rarity": rec.get("rarity",""),
                "scrydex_image_url": rec.get("image_url",""),
                "scrydex_card_url": rec.get("card_url",""),
                "scrydex_set_url": final_set_url,
            })

            if idx % 25 == 0:
                print(f"  details {idx}/{len(missing_nums)}")
            time.sleep(0.06)

        for n in sorted(dbnums - snums, key=int):
            for c in dbnum[n]:
                notfound.append({
                    "set_code": code,
                    "set_name": set_name,
                    "db_card_number": c.get("card_number",""),
                    "db_name": c.get("name",""),
                    "db_rarity": c.get("rarity",""),
                    "db_image_url": c.get("image_url",""),
                    "scrydex_id": sid,
                    "scrydex_set_url": final_set_url,
                })

        set_summary.append({
            "set_code": code,
            "set_name": set_name,
            "scrydex_id": sid,
            "db_rows": len(rows),
            "db_numeric_numbers": len(dbnums),
            "scrydex_numbers": len(snums),
            "missing_count": len(snums-dbnums),
            "db_not_found_count": len(dbnums-snums),
            "missing_with_name": sum(1 for n in snums-dbnums if nt(scards[n].get("name"))),
            "missing_with_rarity": sum(1 for n in snums-dbnums if nt(scards[n].get("rarity"))),
            "missing_with_image": sum(1 for n in snums-dbnums if nt(scards[n].get("image_url"))),
        })

    save_csv(OUT/"set_summary.csv", set_summary)
    save_csv(OUT/"missing_cards_detail.csv", missing)
    save_csv(OUT/"db_existing_cards.csv", existing)
    save_csv(OUT/"db_not_found_in_scrydex.csv", notfound)
    save_csv(OUT/"fetch_errors.csv", errors)

    lines = ["XY / XY6 / XY7 MISSING CARD AUDIT", ""]
    total = 0
    for x in set_summary:
        total += x["missing_count"]
        lines.append(
            f'{x["set_code"]}: DB={x["db_rows"]}, Scrydex={x["scrydex_numbers"]}, '
            f'MISSING={x["missing_count"]}, DB_NOT_FOUND={x["db_not_found_count"]}'
        )
    lines += [
        "",
        f"total_missing: {total}",
        f"fetch_errors: {len(errors)}",
        "",
        "READ ONLY / no Supabase writes / no Scrydex API",
    ]
    (OUT/"_summary.txt").write_text("\n".join(lines), encoding="utf-8")
    print("\n" + "\n".join(lines))

if __name__ == "__main__":
    main()
