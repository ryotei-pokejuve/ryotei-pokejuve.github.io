#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV DB欠損カード監査
Scrydex public Web only / API不使用 / DB更新なし

目的:
  RULEで確定したScrydexセットについて
  「Scrydexには存在するがDBに存在しないカード番号」を全件抽出する。

入力:
  cards.csv
  card_sets.csv
  bw_to_sv_scrydex_final/set_mapping_final.csv
    ※ set_mapping_final.csv がカレント直下でも可

出力:
  bw_to_sv_missing_cards_audit/
    _summary.txt
    set_stats.csv
    missing_cards.csv
    missing_beyond_db_max.csv
    parse_warnings.csv

重要:
  このスクリプトはDBを書き換えません。
  INSERT SQLもまだ生成しません。
"""

from __future__ import annotations
import csv
import re
import time
import unicodedata
from collections import defaultdict, Counter
from pathlib import Path
from urllib.parse import urljoin
import requests
from bs4 import BeautifulSoup

BASE = "https://scrydex.com"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiMissingCardAudit/1.0)"
}

VALID_RARITIES = {
    "C","U","R","RR","RRR","AR","SR","SAR","UR","HR","MUR",
    "CHR","CSR","S","SSR","A","K","TR","PR","PROMO","ACE","ACE SPEC"
}
RARITY_LABELS = {
    "COMMON":"C",
    "UNCOMMON":"U",
    "RARE":"R",
    "DOUBLE RARE":"RR",
    "TRIPLE RARE":"RRR",
    "ART RARE":"AR",
    "SUPER RARE":"SR",
    "SPECIAL ART RARE":"SAR",
    "ULTRA RARE":"UR",
    "HYPER RARE":"HR",
    "MEGA ULTRA RARE":"MUR",
    "CHARACTER RARE":"CHR",
    "CHARACTER SUPER RARE":"CSR",
    "SHINY":"S",
    "SHINY RARE":"S",
    "SHINY SUPER RARE":"SSR",
    "AMAZING RARE":"A",
    "RADIANT":"K",
    "TRAINER RARE":"TR",
    "PRISM RARE":"PR",
    "PROMO":"PROMO",
    "ACE":"ACE",
    "ACE SPEC":"ACE SPEC",
}
BLANKS = {"", "-", "—", "–", "N/A", "NA", "NONE", "NULL"}

def nt(v):
    return re.sub(r"\s+", " ", unicodedata.normalize("NFKC", str(v or "")).strip())

def norm_number(v):
    s = nt(v)
    # 095, 095/093, 95/93 -> 95
    m = re.match(r"^0*(\d+)(?:\s*/\s*0*\d+)?$", s)
    if m:
        return str(int(m.group(1)))
    # fallback for special card numbers
    return re.sub(r"\s+", "", s).upper()

def numeric_number(v):
    k = norm_number(v)
    return int(k) if k.isdigit() else None

def norm_rarity(v):
    u = nt(v).upper()
    if u in BLANKS:
        return ""
    if u in VALID_RARITIES:
        return u
    u = re.sub(r"\s*\([^)]*\)\s*", "", u).strip()
    return RARITY_LABELS.get(u, "")

def locate(*candidates):
    for c in candidates:
        p = Path(c)
        if p.exists():
            return p
    raise FileNotFoundError("見つかりません: " + " / ".join(candidates))

def read_csv(path):
    with path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))

def write_csv(path, rows, fields):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)

def choose_idx(headers, words):
    for i, h in enumerate(headers):
        hh = nt(h).lower()
        if any(w in hh for w in words):
            return i
    return None

def parse_expansion_page(session, url, sid):
    r = session.get(url, timeout=35)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")

    found = []
    warnings = []

    for table_no, table in enumerate(soup.find_all("table"), 1):
        trs = table.find_all("tr")
        if not trs:
            continue

        header_cells = trs[0].find_all(["th", "td"])
        headers = [nt(x.get_text(" ", strip=True)) for x in header_cells]
        lower = [h.lower() for h in headers]

        number_i = choose_idx(headers, ["number", "card number", "no.", "no"])
        rarity_i = choose_idx(headers, ["rarity"])
        name_i = choose_idx(headers, ["name", "card"])
        if name_i == number_i:
            name_i = None

        if number_i is None:
            continue

        for row_no, tr in enumerate(trs[1:], 2):
            cells = tr.find_all(["td", "th"])
            if number_i >= len(cells):
                continue

            raw_number = nt(cells[number_i].get_text(" ", strip=True))
            if not raw_number:
                continue

            # Ignore obvious non-card rows.
            nk = norm_number(raw_number)
            if not nk:
                continue

            raw_rarity = ""
            rarity = ""
            if rarity_i is not None and rarity_i < len(cells):
                raw_rarity = nt(cells[rarity_i].get_text(" ", strip=True))
                rarity = norm_rarity(raw_rarity)

            name = ""
            if name_i is not None and name_i < len(cells):
                name = nt(cells[name_i].get_text(" ", strip=True))

            card_url = ""
            # Prefer a card-specific link in the row.
            for a in tr.find_all("a", href=True):
                href = a.get("href", "")
                txt = nt(a.get_text(" ", strip=True))
                if "/pokemon/" in href and "/expansions/" not in href:
                    card_url = urljoin(BASE, href)
                    if not name and txt and txt != raw_number:
                        name = txt
                    break

            # If header detection misses the name, use the first useful text cell.
            if not name:
                for i, c in enumerate(cells):
                    if i in {number_i, rarity_i}:
                        continue
                    txt = nt(c.get_text(" ", strip=True))
                    if txt and txt != raw_number and txt != raw_rarity:
                        name = txt
                        break

            image_url = ""
            n = numeric_number(raw_number)
            if n is not None:
                image_url = f"https://images.scrydex.com/pokemon/{sid}-{n}/large"

            found.append({
                "scrydex_id": sid,
                "scrydex_number_raw": raw_number,
                "number_key": nk,
                "scrydex_name": name,
                "scrydex_rarity": rarity,
                "scrydex_rarity_raw": raw_rarity,
                "scrydex_card_url": card_url,
                "expected_image_url": image_url,
                "table_no": table_no,
                "row_no": row_no,
            })

    if not found:
        warnings.append({
            "scrydex_id": sid,
            "url": url,
            "warning": "NO_CARD_ROWS_PARSED"
        })

    return found, warnings

def main():
    cards_path = locate(
        "cards.csv",
        "supabase_export_db/cards.csv",
        "supabase_export/cards.csv",
    )
    sets_path = locate(
        "card_sets.csv",
        "supabase_export_db/card_sets.csv",
        "supabase_export/card_sets.csv",
    )
    mapping_path = locate(
        "bw_to_sv_scrydex_final/set_mapping_final.csv",
        "set_mapping_final.csv",
    )

    cards = read_csv(cards_path)
    sets = read_csv(sets_path)
    mappings = read_csv(mapping_path)

    sets_by_id = {s["id"]: s for s in sets}
    rule_maps = [
        m for m in mappings
        if nt(m.get("mapping_method")).upper() == "RULE"
        and nt(m.get("scrydex_id"))
        and nt(m.get("scrydex_url"))
    ]

    # Avoid duplicate mappings.
    map_by_set = {}
    for m in rule_maps:
        map_by_set[m["set_id"]] = m

    db_by_set = defaultdict(list)
    for c in cards:
        if c.get("set_id") in map_by_set:
            db_by_set[c["set_id"]].append(c)

    session = requests.Session()
    session.headers.update(HEADERS)

    outdir = Path("bw_to_sv_missing_cards_audit")
    all_missing = []
    warnings = []
    stats = []

    print(f"RULE確定セット: {len(map_by_set)}")
    print("Scrydex全カードとDBカード番号を比較します...")

    for i, (set_id, m) in enumerate(map_by_set.items(), 1):
        sid = m["scrydex_id"]
        url = m["scrydex_url"]
        s = sets_by_id.get(set_id, {})
        dbrows = db_by_set.get(set_id, [])

        print(f"[{i}/{len(map_by_set)}] {m.get('db_code','')} -> {sid}")

        try:
            srows, ws = parse_expansion_page(session, url, sid)
            warnings.extend(ws)
        except Exception as e:
            warnings.append({
                "scrydex_id": sid,
                "url": url,
                "warning": "FETCH_OR_PARSE_ERROR: " + repr(e),
            })
            stats.append({
                "series_name": s.get("series_name", ""),
                "set_code": m.get("db_code", ""),
                "set_name": s.get("name", m.get("db_name", "")),
                "scrydex_id": sid,
                "db_card_rows": len(dbrows),
                "db_unique_numbers": len({norm_number(x.get("card_number")) for x in dbrows}),
                "scrydex_rows": 0,
                "scrydex_unique_numbers": 0,
                "missing_unique_numbers": "",
                "missing_rows": "",
                "db_numeric_max": "",
                "status": "ERROR",
            })
            continue

        db_keys = {norm_number(x.get("card_number")) for x in dbrows}
        db_numeric = [numeric_number(x.get("card_number")) for x in dbrows]
        db_numeric = [n for n in db_numeric if n is not None]
        db_max = max(db_numeric) if db_numeric else None

        scrydex_keys = {x["number_key"] for x in srows}
        missing_rows = [x for x in srows if x["number_key"] not in db_keys]
        missing_keys = {x["number_key"] for x in missing_rows}

        for x in missing_rows:
            n = numeric_number(x["scrydex_number_raw"])
            beyond = bool(n is not None and db_max is not None and n > db_max)
            all_missing.append({
                "series_name": s.get("series_name", ""),
                "set_id": set_id,
                "set_code": m.get("db_code", ""),
                "set_name": s.get("name", m.get("db_name", "")),
                "scrydex_id": sid,
                "scrydex_url": url,
                "scrydex_number_raw": x["scrydex_number_raw"],
                "number_key": x["number_key"],
                "scrydex_name": x["scrydex_name"],
                "scrydex_rarity": x["scrydex_rarity"],
                "scrydex_rarity_raw": x["scrydex_rarity_raw"],
                "scrydex_card_url": x["scrydex_card_url"],
                "expected_image_url": x["expected_image_url"],
                "db_numeric_max": db_max if db_max is not None else "",
                "beyond_db_max": "YES" if beyond else "NO",
            })

        stats.append({
            "series_name": s.get("series_name", ""),
            "set_code": m.get("db_code", ""),
            "set_name": s.get("name", m.get("db_name", "")),
            "scrydex_id": sid,
            "db_card_rows": len(dbrows),
            "db_unique_numbers": len(db_keys),
            "scrydex_rows": len(srows),
            "scrydex_unique_numbers": len(scrydex_keys),
            "missing_unique_numbers": len(missing_keys),
            "missing_rows": len(missing_rows),
            "db_numeric_max": db_max if db_max is not None else "",
            "status": "OK",
        })
        time.sleep(0.12)

    fields = [
        "series_name","set_id","set_code","set_name","scrydex_id","scrydex_url",
        "scrydex_number_raw","number_key","scrydex_name",
        "scrydex_rarity","scrydex_rarity_raw",
        "scrydex_card_url","expected_image_url",
        "db_numeric_max","beyond_db_max",
    ]
    write_csv(outdir / "missing_cards.csv", all_missing, fields)
    write_csv(
        outdir / "missing_beyond_db_max.csv",
        [r for r in all_missing if r["beyond_db_max"] == "YES"],
        fields
    )
    write_csv(
        outdir / "set_stats.csv",
        stats,
        [
            "series_name","set_code","set_name","scrydex_id",
            "db_card_rows","db_unique_numbers",
            "scrydex_rows","scrydex_unique_numbers",
            "missing_unique_numbers","missing_rows",
            "db_numeric_max","status",
        ]
    )
    write_csv(outdir / "parse_warnings.csv", warnings,
              ["scrydex_id","url","warning"])

    by_series = Counter(r["series_name"] for r in all_missing)
    beyond = [r for r in all_missing if r["beyond_db_max"] == "YES"]
    by_series_beyond = Counter(r["series_name"] for r in beyond)
    sets_with_missing = {r["set_id"] for r in all_missing}

    summary = [
        f"rule_mapped_sets: {len(map_by_set)}",
        f"sets_with_missing_cards: {len(sets_with_missing)}",
        f"missing_scrydex_rows: {len(all_missing)}",
        f"missing_beyond_db_max_rows: {len(beyond)}",
        f"parse_warnings: {len(warnings)}",
        "",
        "[missing by series]",
    ]
    for k in sorted(by_series):
        summary.append(f"{k}: {by_series[k]}")
    summary += ["", "[beyond DB max by series]"]
    for k in sorted(by_series_beyond):
        summary.append(f"{k}: {by_series_beyond[k]}")
    summary += [
        "",
        "NOTE: DB更新はしていません。",
        "NOTE: missing_cards.csv はScrydexに存在し、DBに同じカード番号が無い行です。",
        "NOTE: missing_beyond_db_max.csv は特にシークレット枠欠損の可能性が高い行です。",
        "NOTE: INSERT SQLはまだ生成していません。結果確認後に作成します。",
    ]

    (outdir / "_summary.txt").write_text("\n".join(summary), encoding="utf-8")
    print("\n完了:", outdir.resolve())
    print("\n" + "\n".join(summary))

if __name__ == "__main__":
    main()
