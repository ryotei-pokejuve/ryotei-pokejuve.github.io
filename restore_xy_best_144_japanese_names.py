#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
XY (THE BEST OF XY) 欠損144枚 日本語名救済監査（READ ONLY）

目的:
- missing_cards_detail.csv の set_code=XY の欠損144枚について、
  Scrydex public card detail page から日本語名を直接取得する。
- レアリティ・画像URLは missing_cards_detail.csv の取得済み値を保持。
- Supabaseは更新しない。
- Scrydex APIは使わない。
- 推測しない。日本語名がページ上で確認できないものは unresolved。

入力:
  missing_cards_detail.csv
    または xy_3set_missing_audit/missing_cards_detail.csv

出力:
  xy_best_missing_144_restore/
    _summary.txt
    resolved_xy.csv
    unresolved_xy.csv
    fetch_errors.csv
"""

from __future__ import annotations

import csv
import html
import json
import re
import time
import unicodedata
from pathlib import Path

import requests
from bs4 import BeautifulSoup

OUT = Path("xy_best_missing_144_restore")
OUT.mkdir(exist_ok=True)

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiXYBestRestore/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}

GENERIC = {
    "", "ポケモン", "トレーナー", "エネルギー", "たね", "進化",
    "グッズ", "サポート", "スタジアム", "特殊エネルギー",
    "基本エネルギー", "ダブルレア", "レア", "アンコモン", "コモン"
}

def nt(v):
    return re.sub(r"\s+", " ", unicodedata.normalize("NFKC", str(v or "")).strip())

def has_japanese(s):
    return bool(re.search(r"[\u3040-\u30ff\u3400-\u9fff]", s or ""))

def looks_like_card_name(s):
    s = nt(s)
    if not s or len(s) > 100:
        return False
    if not has_japanese(s):
        return False
    if s in GENERIC:
        return False
    if re.fullmatch(r"(HP\s*)?\d+", s, re.I):
        return False
    bad_fragments = [
        "カード検索", "データソース", "最近の販売", "ディスカッション",
        "カード詳細", "収録カード", "ポケモンカード"
    ]
    if any(x in s for x in bad_fragments):
        return False
    return True

def locate(*cands):
    for c in cands:
        p = Path(c)
        if p.exists():
            return p
    raise FileNotFoundError("見つかりません: " + " / ".join(cands))

def load_csv(p):
    with p.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))

def save_csv(p, rows, fallback_fields=None):
    fields = list(rows[0].keys()) if rows else (fallback_fields or [])
    with p.open("w", encoding="utf-8-sig", newline="") as f:
        if fields:
            w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
            w.writeheader()
            w.writerows(rows)

def extract_json_names(obj, out):
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k == "name" and isinstance(v, str) and looks_like_card_name(v):
                out.append(("JSON_NAME", nt(v)))
            extract_json_names(v, out)
    elif isinstance(obj, list):
        for x in obj:
            extract_json_names(x, out)

def extract_name(sess, url):
    r = sess.get(url, timeout=40)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")

    candidates = []

    # Strongest source: first plausible Japanese heading after H1.
    h1 = soup.find("h1")
    if h1:
        for el in h1.find_all_next(["h2", "h3"], limit=16):
            s = nt(el.get_text(" ", strip=True))
            if looks_like_card_name(s):
                candidates.append(("HEADING_AFTER_H1", s))
                break

    # Heading fallback.
    for el in soup.find_all(["h2", "h3"]):
        s = nt(el.get_text(" ", strip=True))
        if looks_like_card_name(s):
            candidates.append(("HEADING", s))

    # Embedded JSON / Next.js fallback.
    for sc in soup.find_all("script"):
        txt = sc.string or sc.get_text("", strip=False) or ""
        if not txt:
            continue

        if sc.get("type") == "application/json":
            try:
                extract_json_names(json.loads(txt), candidates)
            except Exception:
                pass

        for m in re.finditer(r'"name"\s*:\s*"([^"]{1,120})"', txt):
            raw = html.unescape(m.group(1))
            try:
                raw = bytes(raw, "utf-8").decode("unicode_escape")
            except Exception:
                pass
            s = nt(raw)
            if looks_like_card_name(s):
                candidates.append(("SCRIPT_NAME", s))

    # Deduplicate preserving order.
    dedup = []
    seen = set()
    for method, name in candidates:
        if name not in seen:
            dedup.append((method, name))
            seen.add(name)

    strong = [x for x in dedup if x[0] == "HEADING_AFTER_H1"]
    if strong:
        return strong[0][1], strong[0][0], dedup, r.url

    uniq = sorted({name for _, name in dedup})
    if len(uniq) == 1:
        return uniq[0], "UNANIMOUS_PAGE", dedup, r.url
    if len(uniq) > 1:
        return "", "PAGE_CONFLICT", dedup, r.url
    return "", "NO_JAPANESE_NAME", dedup, r.url

def main():
    src = locate(
        "missing_cards_detail.csv",
        "xy_3set_missing_audit/missing_cards_detail.csv"
    )
    all_rows = load_csv(src)
    rows = [r for r in all_rows if nt(r.get("set_code")) == "XY"]

    print(f"XY target rows: {len(rows)}")
    if len(rows) != 144:
        print("WARNING: expected 144 rows from the previous audit.")

    sess = requests.Session()
    sess.headers.update(HEADERS)

    resolved = []
    unresolved = []
    errors = []

    for i, r in enumerate(rows, 1):
        num = nt(r.get("card_number"))
        url = nt(r.get("scrydex_card_url"))
        print(f"[{i}/{len(rows)}] XY #{num}", end=" ")

        if not url:
            row = dict(r)
            row.update({
                "resolved_japanese_name": "",
                "resolution_method": "NO_CARD_URL",
                "resolution_status": "UNRESOLVED",
                "page_candidates": "",
            })
            unresolved.append(row)
            print("NO URL")
            continue

        try:
            name, method, candidates, final_url = extract_name(sess, url)
        except Exception as e:
            row = dict(r)
            row.update({
                "resolved_japanese_name": "",
                "resolution_method": "FETCH_ERROR",
                "resolution_status": "UNRESOLVED",
                "page_candidates": "",
            })
            unresolved.append(row)
            errors.append({
                "set_code": "XY",
                "card_number": num,
                "scrydex_card_url": url,
                "error": repr(e),
            })
            print("FETCH ERROR")
            continue

        row = dict(r)
        row.update({
            "resolved_japanese_name": name,
            "resolution_method": "SCRYDEX_DETAIL_" + method if name else method,
            "resolution_status": "RESOLVED" if name else "UNRESOLVED",
            "page_candidates": " | ".join(f"{m}:{n}" for m, n in candidates),
            "final_scrydex_card_url": final_url,
        })

        if name:
            resolved.append(row)
            print("=>", name)
        else:
            unresolved.append(row)
            print("=> unresolved", method)

        time.sleep(0.08)

    fields = list(rows[0].keys()) + [
        "resolved_japanese_name", "resolution_method", "resolution_status",
        "page_candidates", "final_scrydex_card_url"
    ] if rows else []

    save_csv(OUT / "resolved_xy.csv", resolved, fields)
    save_csv(OUT / "unresolved_xy.csv", unresolved, fields)
    save_csv(OUT / "fetch_errors.csv", errors,
             ["set_code", "card_number", "scrydex_card_url", "error"])

    methods = {}
    for x in resolved + unresolved:
        m = x.get("resolution_method", "")
        methods[m] = methods.get(m, 0) + 1

    blank_rarity = sum(not nt(x.get("scrydex_rarity")) for x in resolved)
    blank_image = sum(not nt(x.get("scrydex_image_url")) for x in resolved)

    lines = [
        "XY (THE BEST OF XY) JAPANESE NAME RESCUE AUDIT",
        "",
        f"target_rows: {len(rows)}",
        f"resolved: {len(resolved)}",
        f"unresolved: {len(unresolved)}",
        f"fetch_errors: {len(errors)}",
        f"resolved_rows_blank_rarity: {blank_rarity}",
        f"resolved_rows_blank_image: {blank_image}",
        "",
        "[methods]",
    ]
    for k in sorted(methods):
        lines.append(f"{k}: {methods[k]}")

    lines += [
        "",
        "READ ONLY / no Supabase writes / no Scrydex API",
        "Japanese names are taken only from Scrydex public card detail pages.",
        "No unresolved row is guessed or auto-filled.",
    ]

    (OUT / "_summary.txt").write_text("\n".join(lines), encoding="utf-8")
    print("\n" + "\n".join(lines))

if __name__ == "__main__":
    main()
