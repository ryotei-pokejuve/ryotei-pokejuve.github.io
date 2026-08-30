#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BW～SV 全カード画像 Scrydex 全面監査・補完 V1
================================================
目的
- Scrydex APIは使わない
- Scrydex公開Webページだけを使う
- RULE確定セットだけ対象
- DBのBW～SVカードを Scrydex の「実際のページ内画像URL」と照合
- TCGdex由来 / 空欄 / その他の既存画像URLを、Scrydex実画像URLへ統一可能
- DBには直接接続しない
- 安全なSQLチャンク + backup + rollback を生成

入力
- cards.csv
- card_sets.csv
- set_mapping_final.csv
  または bw_to_sv_scrydex_final/set_mapping_final.csv

出力
bw_to_sv_scrydex_image_refresh/
  _summary.txt
  image_matches.csv
  image_updates.csv
  image_unresolved.csv
  set_stats.csv
  APPLY_chunks/
  ROLLBACK_all.sql

実行
  python audit_refresh_bw_to_sv_images_scrydex.py

注意
- mapping_method == RULE のセットだけ使用。
- NAMEマッピングは過去に誤対応があったため完全除外。
- カード番号がScrydex側で一意に照合できない場合は自動更新しない。
- 画像URLは推測生成しない。Scrydex公開ページHTMLから実際に取得したURLだけ採用。
"""

from __future__ import annotations

import csv
import html
import re
import time
import unicodedata
from collections import defaultdict, Counter
from pathlib import Path
from urllib.parse import urljoin, urlparse

import requests
from bs4 import BeautifulSoup

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; RyoteiScrydexImageAudit/1.0)",
    "Accept-Language": "ja,en;q=0.8",
}

TARGET_SERIES = {
    "BWシリーズ",
    "XYシリーズ",
    "SMシリーズ",
    "ソード・シールド",
    "SVシリーズ",
}

CHUNK_SIZE = 300
BACKUP_TABLE = "public.bw_sv_image_backup_scrydex_20260829"

def nt(v):
    return re.sub(r"\s+", " ", unicodedata.normalize("NFKC", str(v or "")).strip())

def numkey(v):
    s = nt(v)
    m = re.match(r"^0*(\d+)(?:\s*/\s*0*\d+)?$", s)
    if m:
        return str(int(m.group(1)))
    m = re.match(r"^0*(\d+)", s)
    if m:
        return str(int(m.group(1)))
    return re.sub(r"\s+", "", s).upper()

def sqlq(v):
    return "'" + str(v).replace("'", "''") + "'"

def locate(*candidates):
    for x in candidates:
        p = Path(x)
        if p.exists():
            return p
    raise FileNotFoundError("見つかりません: " + " / ".join(candidates))

def load_csv(path):
    with path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))

def save_csv(path, rows, fields):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
        w.writeheader()
        w.writerows(rows)

def abs_url(base, u):
    u = html.unescape(nt(u)).replace("\\/", "/")
    if not u:
        return ""
    if u.startswith("//"):
        return "https:" + u
    if u.startswith("/"):
        return urljoin(base, u)
    return u

def is_scrydex_image(u):
    u = nt(u)
    if not u.startswith("http"):
        return False
    host = urlparse(u).netloc.lower()
    lu = u.lower()
    if "scrydex" not in host:
        return False
    if any(x in lu for x in ("logo", "favicon", "avatar", "icon", "sprite")):
        return False
    return True

def image_candidates_from_tag(tag, base):
    vals = []
    if tag is None:
        return vals

    # tag itself + descendants
    tags = [tag]
    try:
        tags += tag.find_all(["img", "source"])
    except Exception:
        pass

    for t in tags:
        for attr in ("src", "data-src", "data-lazy-src", "srcset", "data-srcset"):
            raw = t.get(attr)
            if not raw:
                continue
            if "srcset" in attr:
                for part in str(raw).split(","):
                    url = part.strip().split(" ")[0]
                    if url:
                        vals.append(abs_url(base, url))
            else:
                vals.append(abs_url(base, raw))
    return vals

def card_id_from_href(href, sid):
    href = nt(href)
    # detail URLs normally end in <scrydex_id>-<number>
    m = re.search(r"/([^/?#]+)$", href.split("?")[0])
    if not m:
        return ""
    tail = m.group(1)
    if tail.lower().startswith(sid.lower() + "-"):
        return tail
    return ""

def card_num_from_id(card_id, sid):
    if not card_id.lower().startswith(sid.lower() + "-"):
        return ""
    rest = card_id[len(sid)+1:]
    m = re.match(r"0*(\d+)", rest)
    return str(int(m.group(1))) if m else ""

def choose_image(cands, card_id):
    cands = [u for u in cands if is_scrydex_image(u)]
    if not cands:
        return ""

    cid = card_id.lower()
    exact = [u for u in cands if cid in u.lower()]
    pool = exact or cands

    # Prefer original/large/full, then simpler URLs.
    def score(u):
        lu = u.lower()
        pref = 0
        if "/original" in lu: pref -= 30
        if "/large" in lu: pref -= 20
        if "/full" in lu: pref -= 10
        if "width=" in lu or "w=" in lu: pref += 5
        return (pref, len(u))
    return sorted(set(pool), key=score)[0]

def scrape_expansion(session, expansion_url, sid):
    """
    Return:
      by_num[number_key] = list of {
        card_id, detail_url, image_url, source
      }
    """
    r = session.get(expansion_url, timeout=40)
    r.raise_for_status()
    soup = BeautifulSoup(r.text, "html.parser")
    by_num = defaultdict(list)

    # Primary: anchors pointing to individual card pages.
    anchors = soup.find_all("a", href=True)
    for a in anchors:
        href = abs_url(r.url, a.get("href"))
        card_id = card_id_from_href(href, sid)
        if not card_id:
            continue
        nk = card_num_from_id(card_id, sid)
        if not nk:
            continue

        # Find image near this exact card link.
        candidates = []
        candidates += image_candidates_from_tag(a, r.url)

        parent = a
        for _ in range(6):
            parent = getattr(parent, "parent", None)
            if parent is None:
                break
            candidates += image_candidates_from_tag(parent, r.url)
            # Stop once we found an image tied to exact id.
            if any(card_id.lower() in u.lower() for u in candidates):
                break

        img = choose_image(candidates, card_id)
        rec = {
            "card_id": card_id,
            "detail_url": href,
            "image_url": img,
            "source": "EXPANSION_HTML" if img else "DETAIL_NEEDED",
        }

        # avoid duplicate identical hrefs
        if not any(x["detail_url"] == href for x in by_num[nk]):
            by_num[nk].append(rec)

    # Secondary: direct images in page that contain <sid>-<num>.
    # Useful if card anchors are JS rendered differently.
    all_candidates = image_candidates_from_tag(soup, r.url)
    for u in all_candidates:
        if not is_scrydex_image(u):
            continue
        m = re.search(re.escape(sid) + r"-0*(\d+)", u, re.I)
        if not m:
            continue
        nk = str(int(m.group(1)))
        card_id = f"{sid}-{int(m.group(1))}"
        if not any(x.get("image_url") == u for x in by_num[nk]):
            by_num[nk].append({
                "card_id": card_id,
                "detail_url": "",
                "image_url": u,
                "source": "EXPANSION_DIRECT_IMAGE",
            })

    return by_num, r.url

def scrape_detail_image(session, detail_url, card_id):
    if not detail_url:
        return "", "", "NO_DETAIL_URL"
    try:
        r = session.get(detail_url, timeout=40, allow_redirects=True)
        if r.status_code != 200:
            return "", r.url, f"HTTP_{r.status_code}"
        soup = BeautifulSoup(r.text, "html.parser")
        cands = []

        # canonical social images first
        for attrs in (
            {"property": "og:image"},
            {"name": "twitter:image"},
            {"property": "twitter:image"},
        ):
            t = soup.find("meta", attrs=attrs)
            if t and t.get("content"):
                cands.append(abs_url(r.url, t.get("content")))

        cands += image_candidates_from_tag(soup, r.url)

        # raw HTML fallback for images.scrydex.com URLs
        raw = r.text.replace("\\/", "/")
        cands += re.findall(r'https://[^"\'<>\s]+scrydex[^"\'<>\s]+', raw, re.I)

        img = choose_image(cands, card_id)
        return img, r.url, "" if img else "IMAGE_NOT_FOUND"
    except Exception as e:
        return "", detail_url, repr(e)

def existing_source_kind(url, note):
    u = nt(url).lower()
    n = nt(note).lower()
    if not u:
        return "EMPTY"
    if "tcgdex" in u or "tcgdex" in n:
        return "TCGDEX"
    if "scrydex" in u or "scrydex" in n:
        return "SCRYDEX"
    if "pokemon-card.com" in u:
        return "POKEMON_CARD_COM"
    return "OTHER"

def main():
    cards_path = locate("cards.csv", "supabase_export_db/cards.csv", "supabase_export/cards.csv")
    sets_path = locate("card_sets.csv", "supabase_export_db/card_sets.csv", "supabase_export/card_sets.csv")
    map_path = locate("bw_to_sv_scrydex_final/set_mapping_final.csv", "set_mapping_final.csv")

    cards = load_csv(cards_path)
    sets = load_csv(sets_path)
    mappings = load_csv(map_path)

    set_by_id = {s["id"]: s for s in sets}

    rule = {}
    for m in mappings:
        if nt(m.get("mapping_method")).upper() != "RULE":
            continue
        if nt(m.get("series_name")) not in TARGET_SERIES:
            continue
        if not nt(m.get("scrydex_url")) or not nt(m.get("scrydex_id")):
            continue
        rule[m["set_id"]] = m

    target_cards = [
        c for c in cards
        if c.get("set_id") in rule
        and nt(c.get("is_active")).lower() not in {"false", "0", "no"}
    ]

    print("RULE確定セット:", len(rule))
    print("対象DBカード:", len(target_cards))
    print("Scrydex公開Webから画像を取得します。APIは使いません。")

    db_by_set_num = defaultdict(list)
    for c in target_cards:
        db_by_set_num[(c["set_id"], numkey(c.get("card_number")))].append(c)

    session = requests.Session()
    session.headers.update(HEADERS)

    matches = []
    unresolved = []
    set_stats = []

    for idx, (set_id, m) in enumerate(rule.items(), 1):
        code = nt(m.get("db_code"))
        sid = nt(m.get("scrydex_id"))
        url = nt(m.get("scrydex_url"))
        set_cards = [c for c in target_cards if c["set_id"] == set_id]

        print(f"\n[{idx}/{len(rule)}] {code} -> {sid} / DB {len(set_cards)}枚")

        try:
            web_by_num, final_url = scrape_expansion(session, url, sid)
        except Exception as e:
            print("  SET FETCH ERROR:", repr(e))
            for c in set_cards:
                unresolved.append({
                    "card_id": c["id"],
                    "set_id": set_id,
                    "series_name": m.get("series_name",""),
                    "set_code": code,
                    "set_name": m.get("db_name",""),
                    "card_number": c.get("card_number",""),
                    "number_key": numkey(c.get("card_number")),
                    "card_name": c.get("name",""),
                    "old_image_url": c.get("image_url",""),
                    "reason": "SET_FETCH_ERROR",
                    "detail": repr(e),
                })
            set_stats.append({
                "series_name": m.get("series_name",""),
                "set_code": code,
                "scrydex_id": sid,
                "db_cards": len(set_cards),
                "matched": 0,
                "unresolved": len(set_cards),
                "expansion_numbers_found": 0,
            })
            continue

        matched_count = 0
        unresolved_count = 0

        for c in set_cards:
            nk = numkey(c.get("card_number"))
            candidates = web_by_num.get(nk, [])

            # collapse duplicate occurrences of same card/detail
            unique = {}
            for x in candidates:
                key = (x.get("card_id",""), x.get("detail_url",""))
                # Prefer candidate with image
                if key not in unique or (not unique[key].get("image_url") and x.get("image_url")):
                    unique[key] = x
            candidates = list(unique.values())

            # For number-only mapping, require exactly one distinct Scrydex card id.
            ids = sorted(set(x["card_id"] for x in candidates if x.get("card_id")))
            if len(ids) != 1:
                unresolved_count += 1
                unresolved.append({
                    "card_id": c["id"],
                    "set_id": set_id,
                    "series_name": m.get("series_name",""),
                    "set_code": code,
                    "set_name": m.get("db_name",""),
                    "card_number": c.get("card_number",""),
                    "number_key": nk,
                    "card_name": c.get("name",""),
                    "old_image_url": c.get("image_url",""),
                    "reason": "CARD_NOT_FOUND" if not ids else "AMBIGUOUS_NUMBER",
                    "detail": " | ".join(ids),
                })
                continue

            card_id = ids[0]
            same = [x for x in candidates if x.get("card_id") == card_id]
            image = next((x["image_url"] for x in same if x.get("image_url")), "")
            detail_url = next((x["detail_url"] for x in same if x.get("detail_url")), "")
            source = next((x["source"] for x in same if x.get("image_url")), "DETAIL_NEEDED")

            if not image:
                image, resolved_detail_url, err = scrape_detail_image(session, detail_url, card_id)
                if resolved_detail_url:
                    detail_url = resolved_detail_url
                if image:
                    source = "CARD_DETAIL_HTML"
                else:
                    unresolved_count += 1
                    unresolved.append({
                        "card_id": c["id"],
                        "set_id": set_id,
                        "series_name": m.get("series_name",""),
                        "set_code": code,
                        "set_name": m.get("db_name",""),
                        "card_number": c.get("card_number",""),
                        "number_key": nk,
                        "card_name": c.get("name",""),
                        "old_image_url": c.get("image_url",""),
                        "reason": "SCRYDEX_IMAGE_NOT_FOUND",
                        "detail": err,
                    })
                    time.sleep(0.08)
                    continue
                time.sleep(0.08)

            old = nt(c.get("image_url"))
            note = nt(c.get("image_source_note"))
            matches.append({
                "card_id": c["id"],
                "set_id": set_id,
                "series_name": m.get("series_name",""),
                "set_code": code,
                "set_name": m.get("db_name",""),
                "card_number": c.get("card_number",""),
                "number_key": nk,
                "card_name": c.get("name",""),
                "scrydex_id": sid,
                "scrydex_card_id": card_id,
                "scrydex_detail_url": detail_url,
                "scrydex_image_url": image,
                "image_discovery_source": source,
                "old_image_url": old,
                "old_image_source_note": note,
                "old_source_kind": existing_source_kind(old, note),
                "needs_update": "YES" if old != image else "NO",
            })
            matched_count += 1

        set_stats.append({
            "series_name": m.get("series_name",""),
            "set_code": code,
            "scrydex_id": sid,
            "db_cards": len(set_cards),
            "matched": matched_count,
            "unresolved": unresolved_count,
            "expansion_numbers_found": len(web_by_num),
        })
        print(f"  matched={matched_count} unresolved={unresolved_count} Scrydex番号={len(web_by_num)}")
        time.sleep(0.15)

    updates = [r for r in matches if r["needs_update"] == "YES"]

    outdir = Path("bw_to_sv_scrydex_image_refresh")
    chunks_dir = outdir / "APPLY_chunks"
    chunks_dir.mkdir(parents=True, exist_ok=True)

    match_fields = [
        "card_id","set_id","series_name","set_code","set_name","card_number","number_key",
        "card_name","scrydex_id","scrydex_card_id","scrydex_detail_url","scrydex_image_url",
        "image_discovery_source","old_image_url","old_image_source_note","old_source_kind","needs_update"
    ]
    unresolved_fields = [
        "card_id","set_id","series_name","set_code","set_name","card_number","number_key",
        "card_name","old_image_url","reason","detail"
    ]
    stats_fields = [
        "series_name","set_code","scrydex_id","db_cards","matched","unresolved","expansion_numbers_found"
    ]

    save_csv(outdir/"image_matches.csv", matches, match_fields)
    save_csv(outdir/"image_updates.csv", updates, match_fields)
    save_csv(outdir/"image_unresolved.csv", unresolved, unresolved_fields)
    save_csv(outdir/"set_stats.csv", set_stats, stats_fields)

    # Remove stale chunks from prior runs.
    for p in chunks_dir.glob("*.sql"):
        p.unlink()

    # Each chunk is self-contained; no temp tables.
    for ci, start in enumerate(range(0, len(updates), CHUNK_SIZE), 1):
        chunk = updates[start:start+CHUNK_SIZE]
        values = ",\n  ".join(
            f"({sqlq(r['card_id'])}::uuid,{sqlq(r['scrydex_image_url'])})"
            for r in chunk
        )

        sql = f"""-- BW～SV Scrydex image refresh chunk {ci}
-- rows: {len(chunk)}
BEGIN;

CREATE TABLE IF NOT EXISTS {BACKUP_TABLE} (
  card_id uuid PRIMARY KEY,
  old_image_url text,
  old_image_source_note text,
  backed_up_at timestamptz NOT NULL DEFAULT now()
);

WITH incoming(card_id,new_image_url) AS (
  VALUES
  {values}
)
INSERT INTO {BACKUP_TABLE}(card_id,old_image_url,old_image_source_note)
SELECT c.id,c.image_url,c.image_source_note
FROM incoming i
JOIN public.cards c ON c.id=i.card_id
ON CONFLICT (card_id) DO NOTHING;

WITH incoming(card_id,new_image_url) AS (
  VALUES
  {values}
)
UPDATE public.cards c
SET
  image_url=i.new_image_url,
  image_source_note='Scrydex public web image / refreshed 2026-08-29'
FROM incoming i
WHERE c.id=i.card_id
  AND c.image_url IS DISTINCT FROM i.new_image_url;

COMMIT;

SELECT COUNT(*) AS total_backup_rows
FROM {BACKUP_TABLE};
"""
        (chunks_dir/f"{ci:02d}_APPLY_images.sql").write_text(sql, encoding="utf-8")

    rollback = f"""-- BW～SV Scrydex image refresh rollback
BEGIN;

UPDATE public.cards c
SET
  image_url=b.old_image_url,
  image_source_note=b.old_image_source_note
FROM {BACKUP_TABLE} b
WHERE c.id=b.card_id;

COMMIT;

SELECT COUNT(*) AS restored_rows
FROM {BACKUP_TABLE};
"""
    (outdir/"ROLLBACK_all.sql").write_text(rollback, encoding="utf-8")

    source_counts = Counter(r["old_source_kind"] for r in updates)
    series_updates = Counter(r["series_name"] for r in updates)
    unresolved_reasons = Counter(r["reason"] for r in unresolved)

    summary = [
        f"rule_mapped_sets: {len(rule)}",
        f"target_db_cards: {len(target_cards)}",
        f"scrydex_image_matches: {len(matches)}",
        f"image_updates_needed: {len(updates)}",
        f"already_same_scrydex_url: {len(matches)-len(updates)}",
        f"unresolved_cards: {len(unresolved)}",
        f"sql_chunks: {(len(updates)+CHUNK_SIZE-1)//CHUNK_SIZE}",
        "",
        "[updates by previous source]",
    ]
    for k,v in sorted(source_counts.items()):
        summary.append(f"{k}: {v}")
    summary += ["", "[updates by series]"]
    for k,v in sorted(series_updates.items()):
        summary.append(f"{k}: {v}")
    summary += ["", "[unresolved reasons]"]
    for k,v in sorted(unresolved_reasons.items()):
        summary.append(f"{k}: {v}")
    summary += [
        "",
        "IMPORTANT:",
        "- Python does not update Supabase.",
        "- Only RULE mappings are used.",
        "- NAME mappings are excluded.",
        "- No guessed Scrydex CDN URL is generated.",
        "- Only an image URL actually found in Scrydex public Web HTML is used.",
        "- Review _summary.txt and image_unresolved.csv before executing SQL.",
        f"- APPLY SQL is split into {CHUNK_SIZE}-row chunks for Supabase SQL Editor.",
        f"- Backup table: {BACKUP_TABLE}",
    ]

    (outdir/"_summary.txt").write_text("\n".join(summary), encoding="utf-8")

    print("\n完了:", outdir.resolve())
    print("\n" + "\n".join(summary))

if __name__ == "__main__":
    main()
