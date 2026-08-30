#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV 全件監査（Scrydex 公開Webページのみ / API不使用）

対象:
  BWシリーズ / XYシリーズ / SMシリーズ / ソード・シールド / SVシリーズ

監査内容:
  1) DBセットコード -> Scrydex公開Expansionページの対応確認
  2) カード番号で照合
  3) レアリティ差分
  4) image_url が空のカード
  5) Scrydex側で空欄・見つからないカード・セット未対応を別CSVへ

重要:
  - このスクリプトはDBを更新しません。
  - SQLも生成しません。
  - まず監査結果だけを出します。
"""

from __future__ import annotations

import csv
import re
import sys
import time
import unicodedata
from collections import Counter, defaultdict
from pathlib import Path
from urllib.parse import urljoin, urlparse

import requests
from bs4 import BeautifulSoup

BASE = "https://scrydex.com"
INDEX_URL = "https://scrydex.com/pokemon/jp/expansions"

TARGET_SERIES = {
    "BWシリーズ",
    "XYシリーズ",
    "SMシリーズ",
    "ソード・シールド",
    "SVシリーズ",
}

# DBコードからScrydex IDへ、規則だけでは出せない主要セット。
OVERRIDES = {
    # BW
    "BW1-Bb": "bw1b_ja",
    "BW1-Bw": "bw1w_ja",
    "BW2-B": "bw2_ja",
    "BW3-Bh": "bw3h_ja",
    "BW3-Bp": "bw3p_ja",
    "BW4-B": "bw4_ja",
    "BW5-Brn": "bw5d_ja",   # リューノブレード / Dragon Blade
    "BW5-Brz": "bw5s_ja",   # リューズブラスト / Dragon Blast
    "BW6-Bc": "bw6c_ja",
    "BW6-Bf": "bw6f_ja",
    "BW7-B": "bw7_ja",
    "BW8-Brn": "bw8t_ja",   # ライデンナックル / Thunder Knuckle
    "BW8-Brf": "bw8s_ja",   # ラセンフォース / Spiral Force
    "BW9-B": "bw9_ja",
    "BW10-B": "ebb1_ja",    # EX Battle Boost
    "DS": "ds1_ja",

    # XY
    "XY": "xy_ja",
    "XY1-Bx": "xy1x_ja",
    "XY1-By": "xy1y_ja",
    "XY5-Bg": "xy5g_ja",
    "XY5-Bt": "xy5t_ja",
    "XY8-Bb": "xy8b_ja",
    "XY8-Br": "xy8r_ja",
    "XY9-B": "xy9_ja",
    "XY10-B": "xy10_ja",
    "XY11-Bb": "xy11b_ja",
    "XY11-Br": "xy11r_ja",
    "CP1": "cp1_ja",
    "CP2": "cp2_ja",
    "CP3": "cp3_ja",
    "CP4": "cp4_ja",
    "CP5": "cp5_ja",
    "CP6": "cp6_ja",
}

RARITY_MAP = {
    "COMMON": "C",
    "UNCOMMON": "U",
    "RARE": "R",
    "DOUBLE RARE": "RR",
    "ART RARE": "AR",
    "SUPER RARE": "SR",
    "SPECIAL ART RARE": "SAR",
    "ULTRA RARE": "UR",
    "HYPER RARE": "HR",
    "MEGA ULTRA RARE": "MUR",
    "CHARACTER RARE": "CHR",
    "CHARACTER SUPER RARE": "CSR",
    "SHINY": "S",
    "SHINY RARE": "S",
    "SHINY SUPER RARE": "SSR",
    "AMAZING RARE": "A",
    "RADIANT": "K",
    "TRAINER RARE": "TR",
    "PRISM RARE": "PR",
    "PROMO": "PROMO",
    "ACE": "ACE",
    "ACE SPEC": "ACE SPEC",
}

VALID_CODES = {
    "C","U","R","RR","AR","SR","SAR","UR","HR","MUR",
    "CHR","CSR","S","SSR","A","K","TR","PR","PROMO","ACE","ACE SPEC"
}

BLANK_RARITY = {"", "-", "—", "–", "N/A", "NA", "NONE", "NULL"}

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiPokemonAudit/1.0; +public-web-audit)"
}

def norm_text(s: str) -> str:
    s = unicodedata.normalize("NFKC", str(s or "")).strip()
    return re.sub(r"\s+", " ", s)

def norm_num(s: str) -> str:
    s = norm_text(s)
    # 001 -> 1, 001/100 -> 1, otherwise uppercase compact text.
    m = re.match(r"^0*(\d+)(?:\s*/\s*\d+)?$", s)
    if m:
        return str(int(m.group(1)))
    return re.sub(r"\s+", "", s).upper()

def is_blank(s) -> bool:
    return norm_text(s).upper() in BLANK_RARITY

def norm_rarity(raw: str) -> str:
    s = norm_text(raw)
    u = s.upper()
    if u in BLANK_RARITY:
        return ""
    if u in VALID_CODES:
        return u
    # remove parenthetical notes etc.
    u2 = re.sub(r"\s*\([^)]*\)\s*", "", u).strip()
    if u2 in RARITY_MAP:
        return RARITY_MAP[u2]
    for label, code in sorted(RARITY_MAP.items(), key=lambda x: -len(x[0])):
        if u2 == label:
            return code
    return ""

def locate_csv(name: str) -> Path:
    candidates = [
        Path(name),
        Path("supabase_export_db") / name,
        Path("supabase_export") / name,
    ]
    for p in candidates:
        if p.exists():
            return p
    raise FileNotFoundError(f"{name} が見つかりません。ryotei_site 直下などに置いてください。")

def read_csv_dict(path: Path):
    with path.open("r", encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))

def write_csv(path: Path, rows, fieldnames):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)

def candidate_ids(code: str, series: str):
    code = norm_text(code)
    if not code:
        return []
    out = []
    if code in OVERRIDES:
        out.append(OVERRIDES[code])

    c = re.sub(r"[^A-Za-z0-9]", "", code).lower()

    if series == "BWシリーズ":
        # basic BWn forms
        m = re.match(r"bw(\d+)([a-z]?)", c)
        if m:
            n, suf = m.groups()
            out += [f"bw{n}{suf}_ja", f"bw{n}_ja"]
        if c == "ds":
            out.append("ds1_ja")
    elif series == "XYシリーズ":
        if c.startswith("xy"):
            out.append(f"{c}_ja")
        elif re.match(r"cp\d+$", c):
            out.append(f"{c}_ja")
    elif series == "SMシリーズ":
        if c.startswith("sm"):
            out.append(f"{c}_ja")
    elif series == "ソード・シールド":
        # DB: S12a / S10D / S1W -> Scrydex: swsh12a_ja / swsh10d_ja / swsh1w_ja
        if re.match(r"^s\d", c):
            out.append(f"swsh{c[1:]}_ja")
    elif series == "SVシリーズ":
        if c.startswith("sv") or c == "wcs23":
            out.append(f"{c}_ja")

    # de-dupe
    return list(dict.fromkeys(out))

def discover_scrydex_expansions(session: requests.Session):
    r = session.get(INDEX_URL, timeout=30)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")

    found = {}
    for a in soup.find_all("a", href=True):
        href = a["href"]
        if "/pokemon/expansions/" not in href:
            continue
        full = urljoin(BASE, href)
        parts = [x for x in urlparse(full).path.split("/") if x]
        if not parts:
            continue
        scrydex_id = parts[-1]
        if not scrydex_id.endswith("_ja"):
            continue
        found[scrydex_id] = {
            "scrydex_id": scrydex_id,
            "url": full,
            "link_text": norm_text(a.get_text(" ", strip=True)),
        }

    # Some pages render links oddly; supplement by regex over raw HTML.
    for m in re.finditer(r'href=["\']([^"\']*/pokemon/expansions/[^"\']+/([A-Za-z0-9_-]+_ja))["\']', r.text):
        href, sid = m.groups()
        found.setdefault(sid, {
            "scrydex_id": sid,
            "url": urljoin(BASE, href),
            "link_text": "",
        })
    return found

def parse_expansion_page(session: requests.Session, url: str):
    r = session.get(url, timeout=30)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")

    cards = []
    for table in soup.find_all("table"):
        header_cells = table.find_all("th")
        headers = [norm_text(x.get_text(" ", strip=True)).lower() for x in header_cells]
        if not headers:
            first = table.find("tr")
            if first:
                headers = [norm_text(x.get_text(" ", strip=True)).lower() for x in first.find_all(["th","td"])]

        num_idx = rarity_idx = None
        for i, h in enumerate(headers):
            if h in {"number", "no.", "no", "card number"} or "number" in h:
                num_idx = i
            if "rarity" in h:
                rarity_idx = i

        if num_idx is None or rarity_idx is None:
            continue

        for tr in table.find_all("tr"):
            tds = tr.find_all("td")
            if not tds or max(num_idx, rarity_idx) >= len(tds):
                continue
            raw_num = norm_text(tds[num_idx].get_text(" ", strip=True))
            raw_rarity = norm_text(tds[rarity_idx].get_text(" ", strip=True))
            if not raw_num:
                continue

            # Card name usually first column.
            card_name = norm_text(tds[0].get_text(" ", strip=True))
            cards.append({
                "scrydex_number_raw": raw_num,
                "num_key": norm_num(raw_num),
                "scrydex_rarity_raw": raw_rarity,
                "scrydex_rarity": norm_rarity(raw_rarity),
                "scrydex_card_name": card_name,
            })

    # de-dupe exact page rows
    uniq = {}
    for row in cards:
        key = (row["num_key"], row["scrydex_card_name"], row["scrydex_rarity_raw"])
        uniq[key] = row
    return list(uniq.values())

def main():
    cards_path = locate_csv("cards.csv")
    sets_path = locate_csv("card_sets.csv")
    cards = read_csv_dict(cards_path)
    sets = read_csv_dict(sets_path)

    target_sets = [s for s in sets if norm_text(s.get("series_name")) in TARGET_SERIES]
    target_set_ids = {s["id"] for s in target_sets}
    target_cards = [c for c in cards if c.get("set_id") in target_set_ids]

    outdir = Path("bw_to_sv_audit")
    outdir.mkdir(exist_ok=True)

    session = requests.Session()
    session.headers.update(HEADERS)

    print("Scrydex 日本語Expansion一覧を取得中...")
    expansions = discover_scrydex_expansions(session)
    print(f"Scrydex expansion IDs discovered: {len(expansions)}")

    mapping_rows = []
    mapping = {}
    for s in target_sets:
        code = norm_text(s.get("code"))
        series = norm_text(s.get("series_name"))
        candidates = candidate_ids(code, series)
        matched = next((x for x in candidates if x in expansions), None)

        status = "MAPPED" if matched else "UNRESOLVED_SET"
        mapping_rows.append({
            "set_id": s.get("id",""),
            "series_name": series,
            "db_code": code,
            "db_name": s.get("name",""),
            "scrydex_id": matched or "",
            "scrydex_url": expansions.get(matched, {}).get("url","") if matched else "",
            "candidate_ids": "|".join(candidates),
            "status": status,
        })
        if matched:
            mapping[s["id"]] = matched

    write_csv(
        outdir / "set_mapping.csv",
        mapping_rows,
        ["set_id","series_name","db_code","db_name","scrydex_id","scrydex_url","candidate_ids","status"]
    )

    parsed_by_set = {}
    stats = []
    mapped_ids = sorted(set(mapping.values()))
    for i, sid in enumerate(mapped_ids, 1):
        info = expansions[sid]
        print(f"[{i}/{len(mapped_ids)}] {sid}")
        try:
            rows = parse_expansion_page(session, info["url"])
            parsed_by_set[sid] = rows
            stats.append({
                "scrydex_id": sid,
                "url": info["url"],
                "rows_found": len(rows),
                "fetch_status": "OK",
                "error": "",
            })
        except Exception as e:
            stats.append({
                "scrydex_id": sid,
                "url": info["url"],
                "rows_found": 0,
                "fetch_status": "ERROR",
                "error": repr(e),
            })
        time.sleep(0.15)

    write_csv(
        outdir / "set_fetch_stats.csv",
        stats,
        ["scrydex_id","url","rows_found","fetch_status","error"]
    )

    # Index Scrydex rows by expansion + card number
    idx = {}
    duplicate_keys = set()
    for sid, rows in parsed_by_set.items():
        by_num = defaultdict(list)
        for r in rows:
            by_num[r["num_key"]].append(r)
        for num_key, vals in by_num.items():
            idx[(sid, num_key)] = vals
            if len(vals) > 1:
                duplicate_keys.add((sid, num_key))

    set_by_id = {s["id"]: s for s in target_sets}
    audit = []
    changes = []
    missing_images = []
    unresolved = []

    for c in target_cards:
        s = set_by_id[c["set_id"]]
        code = norm_text(s.get("code"))
        series = norm_text(s.get("series_name"))
        sid = mapping.get(c["set_id"])
        num_raw = norm_text(c.get("card_number"))
        num_key = norm_num(num_raw)
        current_rarity = norm_text(c.get("rarity")).upper()
        image_url = norm_text(c.get("image_url"))

        base = {
            "card_id": c.get("id",""),
            "series_name": series,
            "set_code": code,
            "set_name": s.get("name",""),
            "scrydex_id": sid or "",
            "card_number": num_raw,
            "card_name": c.get("name",""),
            "current_rarity": current_rarity,
            "image_url": image_url,
        }

        if not sid:
            row = {**base, "scrydex_rarity":"", "scrydex_rarity_raw":"", "status":"UNRESOLVED_SET"}
            audit.append(row); unresolved.append(row)
            continue

        vals = idx.get((sid, num_key), [])
        if not vals:
            row = {**base, "scrydex_rarity":"", "scrydex_rarity_raw":"", "status":"CARD_NOT_FOUND"}
            audit.append(row); unresolved.append(row)
            continue

        # If duplicate same-number rows exist, only trust rarity if all explicit rarities agree.
        rarities = {v["scrydex_rarity"] for v in vals if v["scrydex_rarity"]}
        raw_rarities = "|".join(sorted({v["scrydex_rarity_raw"] for v in vals}))
        if len(rarities) > 1:
            row = {
                **base,
                "scrydex_rarity":"",
                "scrydex_rarity_raw":raw_rarities,
                "status":"AMBIGUOUS_SCRYDEX_NUMBER",
            }
            audit.append(row); unresolved.append(row)
            continue

        scr_rarity = next(iter(rarities), "")
        if not scr_rarity:
            status = "SCRYDEX_BLANK"
        elif current_rarity != scr_rarity:
            status = "RARITY_CHANGE"
        else:
            status = "RARITY_OK"

        row = {
            **base,
            "scrydex_rarity":scr_rarity,
            "scrydex_rarity_raw":raw_rarities,
            "status":status,
        }
        audit.append(row)

        if status == "RARITY_CHANGE":
            changes.append(row)
        elif status == "SCRYDEX_BLANK":
            unresolved.append(row)

        # Missing image report only. Existing image URLs are NEVER considered wrong/overwritten here.
        if not image_url:
            expected = ""
            if re.fullmatch(r"\d+", num_key):
                expected = f"https://images.scrydex.com/pokemon/{sid}-{int(num_key)}/large"
            missing_images.append({
                **base,
                "expected_scrydex_image_url": expected,
                "status": "MISSING_IMAGE_NUMERIC" if expected else "MISSING_IMAGE_NONNUMERIC",
            })

    audit_fields = [
        "card_id","series_name","set_code","set_name","scrydex_id",
        "card_number","card_name","current_rarity","scrydex_rarity",
        "scrydex_rarity_raw","image_url","status"
    ]
    write_csv(outdir / "audit_all.csv", audit, audit_fields)
    write_csv(outdir / "rarity_changes_only.csv", changes, audit_fields)
    write_csv(outdir / "unresolved_cards.csv", unresolved, audit_fields)

    write_csv(
        outdir / "missing_images.csv",
        missing_images,
        [
            "card_id","series_name","set_code","set_name","scrydex_id",
            "card_number","card_name","current_rarity","image_url",
            "expected_scrydex_image_url","status"
        ]
    )

    counts = Counter(x["status"] for x in audit)
    set_counts = Counter(x["status"] for x in mapping_rows)

    summary_lines = [
        f"target_series: {', '.join(sorted(TARGET_SERIES))}",
        f"db_target_sets: {len(target_sets)}",
        f"db_target_cards: {len(target_cards)}",
        f"scrydex_expansions_discovered: {len(expansions)}",
        f"mapped_sets: {set_counts.get('MAPPED',0)}",
        f"unresolved_sets: {set_counts.get('UNRESOLVED_SET',0)}",
        f"rarity_ok: {counts.get('RARITY_OK',0)}",
        f"rarity_changes: {counts.get('RARITY_CHANGE',0)}",
        f"scrydex_blank: {counts.get('SCRYDEX_BLANK',0)}",
        f"card_not_found: {counts.get('CARD_NOT_FOUND',0)}",
        f"ambiguous_scrydex_number: {counts.get('AMBIGUOUS_SCRYDEX_NUMBER',0)}",
        f"cards_in_unresolved_sets: {counts.get('UNRESOLVED_SET',0)}",
        f"missing_images: {len(missing_images)}",
        "",
        "NOTE: この監査はDBを更新していません。差分SQLはまだ作っていません。",
    ]
    (outdir / "_summary.txt").write_text("\n".join(summary_lines), encoding="utf-8")

    print("\n完了:")
    print(outdir.resolve())
    print("\n" + "\n".join(summary_lines))

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n中断しました。", file=sys.stderr)
        raise
