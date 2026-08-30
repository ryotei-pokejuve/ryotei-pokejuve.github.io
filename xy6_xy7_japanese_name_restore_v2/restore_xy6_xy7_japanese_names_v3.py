#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
XY6 / XY7 未解決75枚 日本語名救済 V3（READ ONLY）

V2で未解決だったカードについて、Scrydexの「カード詳細ページ」そのものから
日本語名を取得する。

重要:
- Supabase更新なし
- Scrydex API不使用
- public Webページのみ
- XY6 / XY7のみ
- 日本語名を確認できない行は推測しない
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

OUT = Path("xy6_xy7_japanese_name_restore_v3")
OUT.mkdir(exist_ok=True)

TARGET_CODES = {"XY6", "XY7"}

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiNameRestoreV3/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}

GENERIC = {
    "ポケモン", "トレーナー", "エネルギー", "たね", "進化",
    "グッズ", "サポート", "スタジアム", "特殊エネルギー",
    "基本エネルギー", "ダブルレア", "レア", "アンコモン", "コモン"
}

def nt(v):
    return re.sub(r"\s+", " ", unicodedata.normalize("NFKC", str(v or "")).strip())

def has_japanese(s):
    return bool(re.search(r"[\u3040-\u30ff\u3400-\u9fff]", s or ""))

def looks_like_card_name(s):
    s = nt(s)
    if not s or len(s) > 80:
        return False
    if not has_japanese(s):
        return False
    if s in GENERIC:
        return False
    if re.fullmatch(r"(HP\s*)?\d+", s, re.I):
        return False
    if any(x in s for x in ["カード検索", "データソース", "最近の販売", "詳細", "ディスカッション"]):
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

def save_csv(p, rows):
    if not rows:
        p.write_text("", encoding="utf-8-sig")
        return
    with p.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()), extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)

def extract_from_json_objects(obj, out):
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k == "name" and isinstance(v, str) and looks_like_card_name(v):
                out.append(("JSON_NAME", nt(v)))
            extract_from_json_objects(v, out)
    elif isinstance(obj, list):
        for x in obj:
            extract_from_json_objects(x, out)

def extract_name(sess, url):
    r = sess.get(url, timeout=40)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")
    candidates = []

    # 1. Scrydex card page currently places localized Japanese card name
    #    in a heading below the English H1.
    h1 = soup.find("h1")
    if h1:
        for el in h1.find_all_next(["h2", "h3"], limit=12):
            s = nt(el.get_text(" ", strip=True))
            if looks_like_card_name(s):
                candidates.append(("HEADING_AFTER_H1", s))
                break

    # 2. All headings as fallback.
    for el in soup.find_all(["h2", "h3"]):
        s = nt(el.get_text(" ", strip=True))
        if looks_like_card_name(s):
            candidates.append(("HEADING", s))

    # 3. Embedded JSON / Next.js data fallback.
    for sc in soup.find_all("script"):
        txt = sc.string or sc.get_text("", strip=False) or ""
        if not txt:
            continue

        # Strict JSON if possible.
        if sc.get("type") == "application/json":
            try:
                obj = json.loads(txt)
                extract_from_json_objects(obj, candidates)
            except Exception:
                pass

        # Conservative regex for JSON-style name fields.
        for m in re.finditer(r'"name"\s*:\s*"([^"]{1,100})"', txt):
            try:
                s = bytes(m.group(1), "utf-8").decode("unicode_escape")
            except Exception:
                s = m.group(1)
            s = nt(html.unescape(s))
            if looks_like_card_name(s):
                candidates.append(("SCRIPT_NAME", s))

    # Deduplicate preserving priority/order.
    seen = []
    for method, name in candidates:
        if name not in [x[1] for x in seen]:
            seen.append((method, name))

    if not seen:
        return "", "NO_JAPANESE_NAME", [], r.url

    # First heading-after-H1 is strongest. Otherwise only resolve if all
    # surviving candidates agree on one Japanese name.
    strong = [x for x in seen if x[0] == "HEADING_AFTER_H1"]
    if strong:
        return strong[0][1], strong[0][0], seen, r.url

    uniq = sorted(set(name for _, name in seen))
    if len(uniq) == 1:
        return uniq[0], "UNANIMOUS_PAGE", seen, r.url

    return "", "PAGE_CONFLICT", seen, r.url

def main():
    src = locate(
        "unresolved.csv",
        "xy6_xy7_japanese_name_restore_v2/unresolved.csv",
    )
    rows = load_csv(src)
    rows = [r for r in rows if nt(r.get("set_code")) in TARGET_CODES]

    print(f"target unresolved rows: {len(rows)}")

    sess = requests.Session()
    sess.headers.update(HEADERS)

    resolved = []
    unresolved = []
    errors = []

    for i, r in enumerate(rows, 1):
        code = nt(r.get("set_code"))
        num = nt(r.get("card_number"))
        url = nt(r.get("scrydex_card_url"))

        print(f"[{i}/{len(rows)}] {code} #{num}", end=" ")

        if not url:
            row = dict(r)
            row.update({
                "v3_japanese_name": "",
                "v3_method": "NO_CARD_URL",
                "v3_candidates": "",
            })
            unresolved.append(row)
            print("NO URL")
            continue

        try:
            name, method, candidates, final_url = extract_name(sess, url)
        except Exception as e:
            row = dict(r)
            row.update({
                "v3_japanese_name": "",
                "v3_method": "FETCH_ERROR",
                "v3_candidates": "",
            })
            unresolved.append(row)
            errors.append({
                "set_code": code,
                "card_number": num,
                "scrydex_card_url": url,
                "error": repr(e),
            })
            print("FETCH ERROR")
            continue

        row = dict(r)
        row.update({
            "v3_japanese_name": name,
            "v3_method": method,
            "v3_candidates": " | ".join(f"{m}:{n}" for m, n in candidates),
            "v3_final_url": final_url,
        })

        if name:
            # Preserve one canonical field for the next INSERT stage.
            row["resolved_japanese_name"] = name
            row["resolution_method"] = "SCRYDEX_DETAIL_" + method
            row["resolution_status"] = "RESOLVED"
            resolved.append(row)
            print("=>", name)
        else:
            unresolved.append(row)
            print("=> unresolved", method)

        time.sleep(0.08)

    save_csv(OUT / "resolved_v3.csv", resolved)
    save_csv(OUT / "still_unresolved_v3.csv", unresolved)
    save_csv(OUT / "fetch_errors.csv", errors)

    by_set = {}
    for code in sorted(TARGET_CODES):
        total = sum(1 for x in rows if nt(x.get("set_code")) == code)
        ok = sum(1 for x in resolved if nt(x.get("set_code")) == code)
        by_set[code] = (total, ok)

    methods = {}
    for x in resolved + unresolved:
        m = x.get("v3_method", "")
        methods[m] = methods.get(m, 0) + 1

    lines = [
        "XY6 / XY7 JAPANESE NAME RESCUE V3",
        "",
        f"target_rows: {len(rows)}",
        f"resolved_v3: {len(resolved)}",
        f"still_unresolved_v3: {len(unresolved)}",
        f"fetch_errors: {len(errors)}",
        "",
        "[methods]",
    ]
    for k in sorted(methods):
        lines.append(f"{k}: {methods[k]}")

    lines += ["", "[by set]"]
    for code, (total, ok) in by_set.items():
        lines.append(f"{code}: total={total}, resolved={ok}, unresolved={total-ok}")

    lines += [
        "",
        "READ ONLY / no Supabase writes / no Scrydex API",
        "Japanese names are taken from Scrydex public card detail pages.",
    ]

    (OUT / "_summary.txt").write_text("\n".join(lines), encoding="utf-8")
    print("\n" + "\n".join(lines))

if __name__ == "__main__":
    main()
