#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV 最終整合性監査（READ ONLY）

目的:
- RULE確定セットだけを対象に、現在のDBエクスポートを最終監査する
- DBは一切更新しない
- Scrydex APIは使わない
- Scrydex公開Web HTMLだけを参照
- 画像 / レアリティ / カード欠損 / 基本的な名前異常をまとめて確認する

必要ファイル:
  cards.csv
  card_sets.csv
  set_mapping_final.csv
    または bw_to_sv_scrydex_final/set_mapping_final.csv

重要:
- cards.csv / card_sets.csv は「最新DBを再エクスポートしたもの」を使ってください。
- 以前の古いCSVを使うと、直した14件や追加264件が反映されません。
"""

import csv
import html
import re
import sys
import time
from collections import Counter, defaultdict
from pathlib import Path
from urllib.parse import urljoin

import requests

TARGET_SERIES = {
    "BWシリーズ",
    "XYシリーズ",
    "SMシリーズ",
    "ソード・シールド",
    "SVシリーズ",
}

ROOT = Path(".")
OUT = ROOT / "bw_to_sv_final_audit"
OUT.mkdir(exist_ok=True)

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/152 Safari/537.36"
S = requests.Session()
S.headers.update({"User-Agent": UA, "Accept-Language": "ja,en;q=0.8"})

def pick_file(*candidates):
    for p in candidates:
        p = Path(p)
        if p.exists():
            return p
    return None

CARDS = pick_file("cards.csv")
SETS = pick_file("card_sets.csv")
MAPPING = pick_file(
    "bw_to_sv_scrydex_final/set_mapping_final.csv",
    "set_mapping_final.csv",
)

if not CARDS or not SETS or not MAPPING:
    print("ERROR: 必要ファイルが見つかりません。")
    print("必要: cards.csv / card_sets.csv / set_mapping_final.csv")
    sys.exit(1)

def read_csv(path):
    with open(path, encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))

def numkey(v):
    s = str(v or "").strip()
    m = re.search(r"\d+", s)
    return str(int(m.group())) if m else ""

def clean(s):
    return re.sub(r"\s+", " ", html.unescape(str(s or ""))).strip()

def fetch(url):
    r = S.get(url, timeout=30)
    r.raise_for_status()
    return r.text

def expansion_url(scrydex_id):
    # public Web only
    return f"https://scrydex.com/pokemon/cards/{scrydex_id}"

def extract_cards_from_expansion(txt, sid):
    """
    Scrydex expansion HTMLから
    setid-number を含むリンクを拾ってカード番号集合を作る。
    rarityはHTML近傍から安全に拾える場合のみ取る。
    """
    found = {}
    pat = re.compile(
        rf'href=["\']([^"\']*{re.escape(sid)}-(\d+)[^"\']*)["\']',
        re.I
    )
    for m in pat.finditer(txt):
        href, n = m.group(1), str(int(m.group(2)))
        start = max(0, m.start() - 900)
        end = min(len(txt), m.end() + 1800)
        ctx = clean(re.sub(r"<[^>]+>", " ", txt[start:end]))
        found.setdefault(n, {
            "detail_url": urljoin("https://scrydex.com", html.unescape(href)),
            "context": ctx,
        })
    return found

def detect_rarity(context):
    # Scrydex上で明示されている一般的なレアリティだけを拾う。
    # 見つからない時は空欄にして推測しない。
    rarities = [
        "SAR","MUR","UR","SR","AR","CHR","CSR","HR",
        "RRR","RR","R","U","C","S","SSR","A","K","PR","PROMO"
    ]
    # 長いものから
    for r in sorted(rarities, key=len, reverse=True):
        if re.search(rf'(?<![A-Za-z0-9]){re.escape(r)}(?![A-Za-z0-9])', context):
            return r
    return ""

def classify_image(url):
    u = (url or "").lower()
    if not u:
        return "EMPTY"
    if "scrydex" in u:
        return "SCRYDEX"
    if "pokemon-card.com" in u:
        return "POKEMON_CARD_COM"
    if "tcgdex" in u:
        return "TCGDEX"
    return "OTHER"

cards = read_csv(CARDS)
sets = read_csv(SETS)
mapping = read_csv(MAPPING)

set_by_id = {r["id"]: r for r in sets}
map_by_set_id = {}
for r in mapping:
    if (r.get("mapping_method") or "").strip().upper() != "RULE":
        continue
    set_id = (r.get("set_id") or "").strip()
    sid = (
        r.get("scrydex_set_id")
        or r.get("scrydex_id")
        or r.get("mapped_scrydex_id")
        or ""
    ).strip()
    if set_id and sid:
        map_by_set_id[set_id] = sid

target_sets = {
    sid: set_by_id[sid]
    for sid in map_by_set_id
    if sid in set_by_id
    and set_by_id[sid].get("series_name") in TARGET_SERIES
}

target_cards = [
    c for c in cards
    if c.get("set_id") in target_sets
    and str(c.get("is_active","")).strip().lower() not in {"false","0","no"}
]

cards_by_set = defaultdict(list)
for c in target_cards:
    cards_by_set[c["set_id"]].append(c)

# Local DB checks first
bad_names = []
bad_numbers = []
image_source_counts = Counter()
duplicate_numbers = []
for set_id, rows in cards_by_set.items():
    seen = defaultdict(list)
    for c in rows:
        name = (c.get("name") or "").strip()
        if not name or name in {"トレーナー", "エネルギー"}:
            bad_names.append(c)
        nk = numkey(c.get("card_number"))
        if not nk:
            bad_numbers.append(c)
        else:
            seen[nk].append(c)
        image_source_counts[classify_image(c.get("image_url"))] += 1
    for nk, xs in seen.items():
        if len(xs) > 1:
            duplicate_numbers.append((set_id, nk, xs))

scrydex_set_errors = []
missing_cards = []
rarity_mismatches = []
scrydex_card_not_found = []
set_stats = []

for idx, (set_id, srow) in enumerate(sorted(target_sets.items(), key=lambda x: x[1].get("code","")), 1):
    sid = map_by_set_id[set_id]
    code = srow.get("code","")
    rows = cards_by_set.get(set_id, [])
    db_by_num = {}
    for c in rows:
        nk = numkey(c.get("card_number"))
        if nk:
            db_by_num[nk] = c

    try:
        txt = fetch(expansion_url(sid))
        scards = extract_cards_from_expansion(txt, sid)
    except Exception as e:
        scrydex_set_errors.append({
            "set_id": set_id, "set_code": code, "set_name": srow.get("name",""),
            "scrydex_set_id": sid, "error": repr(e)
        })
        continue

    db_nums = set(db_by_num)
    scr_nums = set(scards)
    for n in sorted(scr_nums - db_nums, key=int):
        missing_cards.append({
            "series_name": srow.get("series_name",""),
            "set_code": code,
            "set_name": srow.get("name",""),
            "scrydex_set_id": sid,
            "card_number": n,
            "detail_url": scards[n]["detail_url"],
        })

    for n, c in db_by_num.items():
        if n not in scards:
            scrydex_card_not_found.append({
                "card_id": c.get("id",""),
                "series_name": srow.get("series_name",""),
                "set_code": code,
                "set_name": srow.get("name",""),
                "card_number": c.get("card_number",""),
                "name": c.get("name",""),
                "rarity": c.get("rarity",""),
                "image_url": c.get("image_url",""),
                "scrydex_set_id": sid,
            })
            continue
        sr = detect_rarity(scards[n]["context"])
        dr = (c.get("rarity") or "").strip()
        if sr and dr and sr != dr:
            rarity_mismatches.append({
                "card_id": c.get("id",""),
                "series_name": srow.get("series_name",""),
                "set_code": code,
                "set_name": srow.get("name",""),
                "card_number": c.get("card_number",""),
                "name": c.get("name",""),
                "db_rarity": dr,
                "scrydex_rarity": sr,
                "detail_url": scards[n]["detail_url"],
            })

    set_stats.append({
        "series_name": srow.get("series_name",""),
        "set_code": code,
        "set_name": srow.get("name",""),
        "scrydex_set_id": sid,
        "db_cards": len(rows),
        "scrydex_numbers_found": len(scards),
        "missing_in_db": len(scr_nums - db_nums),
        "db_not_found_in_scrydex": len(db_nums - scr_nums),
    })
    print(f"{idx}/{len(target_sets)} {code} DB={len(rows)} Scrydex={len(scards)}")
    time.sleep(0.10)

def write_csv(name, rows, fields=None):
    path = OUT / name
    if not rows:
        path.write_text("", encoding="utf-8-sig")
        return
    if fields is None:
        fields = list(rows[0].keys())
    with open(path, "w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)

write_csv("set_stats.csv", set_stats)
write_csv("missing_cards.csv", missing_cards)
write_csv("scrydex_card_not_found.csv", scrydex_card_not_found)
write_csv("rarity_mismatches.csv", rarity_mismatches)
write_csv("bad_names.csv", bad_names)
write_csv("bad_card_numbers.csv", bad_numbers)
write_csv("scrydex_set_errors.csv", scrydex_set_errors)

dup_rows = []
for set_id, nk, xs in duplicate_numbers:
    s = target_sets[set_id]
    for c in xs:
        dup_rows.append({
            "series_name": s.get("series_name",""),
            "set_code": s.get("code",""),
            "set_name": s.get("name",""),
            "number_key": nk,
            "card_id": c.get("id",""),
            "card_number": c.get("card_number",""),
            "name": c.get("name",""),
            "rarity": c.get("rarity",""),
        })
write_csv("duplicate_numbers.csv", dup_rows)

summary = []
summary.append("BW-SV FINAL AUDIT")
summary.append("")
summary.append(f"rule_mapped_sets: {len(target_sets)}")
summary.append(f"target_db_cards: {len(target_cards)}")
summary.append(f"scrydex_set_errors: {len(scrydex_set_errors)}")
summary.append(f"missing_cards_in_db: {len(missing_cards)}")
summary.append(f"db_cards_not_found_in_scrydex: {len(scrydex_card_not_found)}")
summary.append(f"rarity_mismatches_with_explicit_scrydex_rarity: {len(rarity_mismatches)}")
summary.append(f"suspicious_names: {len(bad_names)}")
summary.append(f"non_numeric_card_numbers: {len(bad_numbers)}")
summary.append(f"duplicate_numeric_number_rows: {len(dup_rows)}")
summary.append("")
summary.append("[image sources]")
for k,v in sorted(image_source_counts.items()):
    summary.append(f"{k}: {v}")
summary.append("")
summary.append("[missing cards by series]")
mc = Counter(r["series_name"] for r in missing_cards)
for k,v in sorted(mc.items()):
    summary.append(f"{k}: {v}")
summary.append("")
summary.append("[DB cards not found in Scrydex by series]")
nf = Counter(r["series_name"] for r in scrydex_card_not_found)
for k,v in sorted(nf.items()):
    summary.append(f"{k}: {v}")
summary.append("")
summary.append("IMPORTANT:")
summary.append("- This script does NOT update Supabase.")
summary.append("- Only RULE mappings are used.")
summary.append("- Scrydex API is NOT used.")
summary.append("- Review CSVs before making any corrections.")
summary.append("- Use a fresh DB export before running this final audit.")

(OUT / "_summary.txt").write_text("\n".join(summary), encoding="utf-8")
print()
print("\n".join(summary))
