#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SV4a missing 40 - Official direct search verifier V2
READ ONLY / no Supabase writes / no Scrydex API

Input:
  scrydex_missing_in_db.csv

Strategy:
1. Use Japanese name already obtained from Scrydex.
2. Search pokemon-card.com's own public card-search page directly.
3. Follow official detail links returned by the official site.
4. VERIFIED only when the detail page explicitly contains:
       SV4a <candidate-number> / 190
   and the official card name is obtainable.
5. No INSERT SQL is generated yet.

Outputs:
  sv4a_missing40_official_verify_v2/
    _summary.txt
    verified.csv
    unresolved.csv
    search_debug.csv
"""

from __future__ import annotations

import csv
import re
import time
from pathlib import Path
from urllib.parse import urljoin

import requests
from bs4 import BeautifulSoup

INPUT = Path("scrydex_missing_in_db.csv")
OUT = Path("sv4a_missing40_official_verify_v2")
OUT.mkdir(exist_ok=True)

BASE = "https://www.pokemon-card.com"
SEARCH = BASE + "/card-search/index.php"

SESSION = requests.Session()
SESSION.headers.update({
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                  "AppleWebKit/537.36 (KHTML, like Gecko) "
                  "Chrome/131.0 Safari/537.36",
    "Accept-Language": "ja,en;q=0.8",
    "Referer": BASE + "/card-search/",
})

def nt(x):
    return re.sub(r"\s+", " ", str(x or "")).strip()

def load_csv(path):
    with path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))

def save_csv(path, rows, fields):
    with path.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)

def official_search(name):
    params = {
        "keyword": name,
        "regulation_sidebar_form": "all",
        "sm_and_keyword": "true",
        "se_ta": "",
        "illust": "",
    }
    r = SESSION.get(SEARCH, params=params, timeout=40)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")

    urls = []
    for a in soup.find_all("a", href=True):
        href = a["href"]
        if "/card-search/details.php/card/" not in href:
            continue
        u = urljoin(BASE, href)
        # Normalize away irrelevant fragments/query where possible.
        u = u.split("#", 1)[0]
        if u not in urls:
            urls.append(u)
    return r.url, urls, nt(soup.get_text(" ", strip=True))

def detail_check(url, wanted_num):
    r = SESSION.get(url, timeout=40)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")
    text = nt(soup.get_text(" ", strip=True))

    h1 = soup.find("h1")
    official_name = nt(h1.get_text(" ", strip=True)) if h1 else ""

    # Flexible spaces/NBSP around printed number.
    patt = re.compile(
        rf"SV4a\s*0*{int(wanted_num)}\s*/\s*190",
        re.I
    )
    exact = bool(patt.search(text))

    official_number_text = ""
    m = re.search(r"SV4a\s*\d+\s*/\s*190", text, re.I)
    if m:
        official_number_text = nt(m.group(0))

    return {
        "exact": exact,
        "official_name": official_name,
        "official_number_text": official_number_text,
        "official_url": r.url,
    }

def main():
    if not INPUT.exists():
        raise FileNotFoundError(
            "scrydex_missing_in_db.csv が見つかりません。"
            "このスクリプトと同じフォルダに置いてください。"
        )

    rows = load_csv(INPUT)
    verified = []
    unresolved = []
    debug = []

    for i, row in enumerate(rows, 1):
        num = nt(row.get("card_number"))
        ja = nt(row.get("scrydex_japanese_name"))
        en = nt(row.get("scrydex_name"))

        print(f"[{i}/{len(rows)}] #{num} {ja or en}", end=" ")

        if not num.isdigit() or not ja:
            x = dict(row)
            x["reason"] = "MISSING_NUMBER_OR_JAPANESE_NAME"
            unresolved.append(x)
            print("UNRESOLVED")
            continue

        try:
            search_url, urls, search_text = official_search(ja)
            debug.append({
                "card_number": num,
                "scrydex_japanese_name": ja,
                "official_search_url": search_url,
                "official_detail_links_found": len(urls),
                "search_page_contains_name": str(ja in search_text),
            })

            hit = None
            checked = 0
            for u in urls:
                checked += 1
                try:
                    d = detail_check(u, num)
                except Exception:
                    continue
                if d["exact"]:
                    hit = d
                    break
                time.sleep(0.08)

            if hit:
                x = dict(row)
                x.update({
                    "official_name": hit["official_name"],
                    "official_number_text": hit["official_number_text"],
                    "official_url": hit["official_url"],
                    "verification": "OFFICIAL_DIRECT_SEARCH_EXACT_NUMBER_MATCH",
                    "official_links_checked": str(checked),
                })
                verified.append(x)
                print(f"=> VERIFIED {hit['official_name']}")
            else:
                x = dict(row)
                x.update({
                    "reason": "NO_EXACT_SV4A_NUMBER_MATCH_IN_OFFICIAL_RESULTS",
                    "official_search_url": search_url,
                    "official_detail_links_found": str(len(urls)),
                    "official_links_checked": str(checked),
                })
                unresolved.append(x)
                print(f"=> UNRESOLVED ({len(urls)} links)")

        except Exception as e:
            x = dict(row)
            x["reason"] = "SEARCH_ERROR: " + repr(e)
            unresolved.append(x)
            print("=> ERROR")

        time.sleep(0.20)

    base = list(rows[0].keys()) if rows else []

    save_csv(
        OUT / "verified.csv",
        verified,
        base + [
            "official_name",
            "official_number_text",
            "official_url",
            "verification",
            "official_links_checked",
        ],
    )
    save_csv(
        OUT / "unresolved.csv",
        unresolved,
        base + [
            "reason",
            "official_search_url",
            "official_detail_links_found",
            "official_links_checked",
        ],
    )
    save_csv(
        OUT / "search_debug.csv",
        debug,
        [
            "card_number",
            "scrydex_japanese_name",
            "official_search_url",
            "official_detail_links_found",
            "search_page_contains_name",
        ],
    )

    summary = [
        "SV4a MISSING 40 OFFICIAL DIRECT VERIFY V2",
        "",
        f"input_rows: {len(rows)}",
        f"verified: {len(verified)}",
        f"unresolved: {len(unresolved)}",
        "",
        "Method:",
        "- pokemon-card.com public card-search directly",
        "- Japanese candidate name from Scrydex",
        "- official detail page must explicitly match SV4a <number>/190",
        "",
        "READ ONLY / no Supabase writes / no Scrydex API",
        "No INSERT SQL generated yet.",
    ]
    (OUT / "_summary.txt").write_text("\n".join(summary), encoding="utf-8")
    print("\n" + "\n".join(summary))

if __name__ == "__main__":
    main()
