#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
XY6 / XY7 欠損159枚 日本語名復元監査（READ ONLY）

目的:
- missing_cards_detail.csv の XY6 / XY7 欠損カード（合計159枚）について、
  Scrydex英語名 -> 既存DB日本語名 の対応を既存カードから学習し、
  日本語名を「推測せず」高信頼で復元する。
- Supabaseは更新しない。
- Scrydex APIは使わない。
- RULE mappingのみ使用。

入力:
  cards.csv
  card_sets.csv
  set_mapping_final.csv
    または bw_to_sv_scrydex_final/set_mapping_final.csv
  missing_cards_detail.csv
    または xy_3set_missing_audit/missing_cards_detail.csv

出力:
  xy6_xy7_japanese_name_restore/
    _summary.txt
    resolved.csv
    unresolved.csv
    targets_all.csv
    learned_name_pairs.csv
    fetch_errors.csv

判定:
- SAME_SET_UNANIMOUS:
    同じセット内で同じScrydex英語名 -> 日本語名が一意
- GLOBAL_UNANIMOUS:
    RULE mapped全セットで同じScrydex英語名 -> 日本語名が一意
- CONFLICT:
    複数の日本語名候補があり自動採用しない
- NO_LEARNED_NAME:
    既存DBから対応を学習できない

重要:
- 日本語名が「トレーナー」「エネルギー」のような汎用ラベルの場合は学習対象外。
- 自動INSERTはしない。
"""

from __future__ import annotations

import csv
import html
import re
import time
import unicodedata
from collections import defaultdict
from pathlib import Path
from urllib.parse import urljoin

import requests
from bs4 import BeautifulSoup

TARGET_CODES = {"XY6", "XY7"}
OUT = Path("xy6_xy7_japanese_name_restore")
OUT.mkdir(exist_ok=True)

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiNameRestore/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}

BAD_JA_NAMES = {"", "トレーナー", "エネルギー"}

def nt(v):
    return re.sub(r"\s+", " ", unicodedata.normalize("NFKC", str(v or "")).strip())

def norm_en(v):
    s = nt(v).casefold()
    # Normalize punctuation differences without collapsing meaningful words.
    s = s.replace("’", "'").replace("–", "-").replace("—", "-")
    s = re.sub(r"\s+", " ", s).strip()
    return s

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

def extract_scrydex_cards(sess, set_url, sid):
    """
    Scrydex set pageから numeric card number -> English display name を取得。
    URL推測はせず、mapping CSVのscrydex_urlを使う。
    """
    r = sess.get(set_url, timeout=40)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")
    out = {}

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

        candidates = []
        for node in (a, a.find("img")):
            if not node:
                continue
            for attr in ("aria-label", "title", "alt"):
                v = nt(node.get(attr))
                if v:
                    candidates.append(v)

        name = ""
        for v in candidates:
            if re.fullmatch(r"\d+(?:/\d+)?", v):
                continue
            if v.lower() == sid.lower():
                continue
            # Avoid obvious generic UI labels.
            if v.lower() in {"card", "view card", "pokemon card"}:
                continue
            name = v
            break

        if name:
            out[n] = name

    # Table fallback for explicit Name column.
    for table in soup.find_all("table"):
        trs = table.find_all("tr")
        if not trs:
            continue
        heads = [nt(x.get_text(" ", strip=True)).lower()
                 for x in trs[0].find_all(["th", "td"])]
        ni = namei = None
        for i, h in enumerate(heads):
            if "number" in h or h in {"#", "no", "no."}:
                ni = i
            if "name" in h:
                namei = i
        if ni is None or namei is None:
            continue

        for tr in trs[1:]:
            td = tr.find_all("td")
            if max(ni, namei) >= len(td):
                continue
            n = numkey(td[ni].get_text(" ", strip=True))
            name = nt(td[namei].get_text(" ", strip=True))
            if n and name:
                out[n] = name

    return out, r.url

def main():
    cards = load_csv(locate("cards.csv"))
    sets = load_csv(locate("card_sets.csv"))
    maps = load_csv(locate(
        "set_mapping_final.csv",
        "bw_to_sv_scrydex_final/set_mapping_final.csv"
    ))
    missing = load_csv(locate(
        "missing_cards_detail.csv",
        "xy_3set_missing_audit/missing_cards_detail.csv"
    ))

    set_by_id = {s["id"]: s for s in sets}
    rule_maps = []
    for m in maps:
        if nt(m.get("mapping_method")).upper() != "RULE":
            continue
        if not nt(m.get("scrydex_id")) or not nt(m.get("scrydex_url")):
            continue
        rule_maps.append(m)

    targets = [
        x for x in missing
        if nt(x.get("set_code")) in TARGET_CODES
    ]

    # DB existing cards by set + numeric number.
    db_by_set_num = defaultdict(list)
    for c in cards:
        if nt(c.get("is_active")).lower() in {"false", "0", "no"}:
            continue
        n = numkey(c.get("card_number"))
        if not n:
            continue
        db_by_set_num[(c.get("set_id"), n)].append(c)

    sess = requests.Session()
    sess.headers.update(HEADERS)

    # Learned mapping:
    # English normalized -> Japanese names
    global_names = defaultdict(set)
    same_set_names = defaultdict(set)
    learned_rows = []
    fetch_errors = []

    print(f"RULE mapped sets to scan: {len(rule_maps)}")
    print(f"XY6/XY7 targets: {len(targets)}")
    print()

    for idx, m in enumerate(rule_maps, 1):
        set_id = m.get("set_id")
        s = set_by_id.get(set_id, {})
        code = nt(m.get("db_code") or s.get("code"))
        sid = nt(m.get("scrydex_id"))
        url = nt(m.get("scrydex_url"))

        print(f"[{idx}/{len(rule_maps)}] {code} -> {sid}")

        try:
            scards, final_url = extract_scrydex_cards(sess, url, sid)
        except Exception as e:
            fetch_errors.append({
                "set_code": code,
                "set_id": set_id,
                "scrydex_id": sid,
                "scrydex_url": url,
                "error": repr(e),
            })
            print("  FETCH ERROR:", repr(e))
            continue

        learned_here = 0
        for n, en_name in scards.items():
            db_rows = db_by_set_num.get((set_id, n), [])
            if len(db_rows) != 1:
                continue

            ja_name = nt(db_rows[0].get("name"))
            if ja_name in BAD_JA_NAMES:
                continue

            en_key = norm_en(en_name)
            if not en_key:
                continue

            global_names[en_key].add(ja_name)
            same_set_names[(set_id, en_key)].add(ja_name)
            learned_rows.append({
                "set_code": code,
                "set_id": set_id,
                "scrydex_id": sid,
                "card_number": n,
                "scrydex_name": en_name,
                "db_japanese_name": ja_name,
                "scrydex_url": final_url,
            })
            learned_here += 1

        print(f"  learned pairs: {learned_here}")
        time.sleep(0.08)

    # Identify XY6/XY7 set IDs.
    code_to_set_id = {}
    for m in rule_maps:
        s = set_by_id.get(m.get("set_id"), {})
        code = nt(m.get("db_code") or s.get("code"))
        if code in TARGET_CODES:
            code_to_set_id[code] = m.get("set_id")

    resolved = []
    unresolved = []
    all_targets = []

    for t in targets:
        code = nt(t.get("set_code"))
        en_name = nt(t.get("scrydex_name"))
        en_key = norm_en(en_name)
        set_id = code_to_set_id.get(code, "")

        same = sorted(same_set_names.get((set_id, en_key), set()))
        glob = sorted(global_names.get(en_key, set()))

        method = ""
        ja_name = ""
        status = ""
        candidates = []

        if len(same) == 1:
            ja_name = same[0]
            method = "SAME_SET_UNANIMOUS"
            status = "RESOLVED"
            candidates = same
        elif len(same) > 1:
            method = "SAME_SET_CONFLICT"
            status = "UNRESOLVED"
            candidates = same
        elif len(glob) == 1:
            ja_name = glob[0]
            method = "GLOBAL_UNANIMOUS"
            status = "RESOLVED"
            candidates = glob
        elif len(glob) > 1:
            method = "GLOBAL_CONFLICT"
            status = "UNRESOLVED"
            candidates = glob
        else:
            method = "NO_LEARNED_NAME"
            status = "UNRESOLVED"
            candidates = []

        row = dict(t)
        row.update({
            "resolved_japanese_name": ja_name,
            "resolution_method": method,
            "resolution_status": status,
            "candidate_japanese_names": " | ".join(candidates),
        })
        all_targets.append(row)
        if status == "RESOLVED":
            resolved.append(row)
        else:
            unresolved.append(row)

    save_csv(OUT / "resolved.csv", resolved)
    save_csv(OUT / "unresolved.csv", unresolved)
    save_csv(OUT / "targets_all.csv", all_targets)
    save_csv(OUT / "learned_name_pairs.csv", learned_rows)
    save_csv(OUT / "fetch_errors.csv", fetch_errors)

    by_method = defaultdict(int)
    by_set_resolved = defaultdict(int)
    by_set_unresolved = defaultdict(int)

    for x in all_targets:
        by_method[x["resolution_method"]] += 1
        if x["resolution_status"] == "RESOLVED":
            by_set_resolved[x["set_code"]] += 1
        else:
            by_set_unresolved[x["set_code"]] += 1

    lines = [
        "XY6 / XY7 JAPANESE NAME RESTORE AUDIT",
        "",
        f"target_rows: {len(targets)}",
        f"resolved: {len(resolved)}",
        f"unresolved: {len(unresolved)}",
        f"learned_existing_pairs: {len(learned_rows)}",
        f"scrydex_set_fetch_errors: {len(fetch_errors)}",
        "",
        "[resolution methods]",
    ]
    for k in sorted(by_method):
        lines.append(f"{k}: {by_method[k]}")

    lines += ["", "[by set]"]
    for code in sorted(TARGET_CODES):
        total = sum(1 for x in targets if nt(x.get("set_code")) == code)
        lines.append(
            f"{code}: total={total}, resolved={by_set_resolved[code]}, "
            f"unresolved={by_set_unresolved[code]}"
        )

    lines += [
        "",
        "IMPORTANT:",
        "- READ ONLY. No Supabase writes.",
        "- Scrydex API is NOT used.",
        "- Only RULE mappings are scanned.",
        "- Conflicting or unknown names are NOT guessed.",
        "- Review unresolved.csv before creating INSERT SQL.",
    ]

    (OUT / "_summary.txt").write_text("\n".join(lines), encoding="utf-8")
    print()
    print("\n".join(lines))

if __name__ == "__main__":
    main()
