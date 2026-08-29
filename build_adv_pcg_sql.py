#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ADV4/ADV5 + PCG1-PCG9 + WCP 一括移行SQLジェネレータ（有料API不使用）

Sources:
  - 日本語カード名 / レアリティ: pcg-search.com の公開カードリスト・個別ページ
  - カード画像: Scrydex 公開画像URL（APIは呼ばない）
  - パック画像: Bulbagarden Archives の公開ファイルRedirect

Output:
  adv4_adv5_pcg1_9_wcp_import.sql
  pcg_migration_cache.json  (途中再開用)

PowerShell:
  python .\build_adv_pcg_sql.py
"""

import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import urljoin

try:
    import requests
    from bs4 import BeautifulSoup
except ImportError:
    print("requests / beautifulsoup4 が必要です。")
    print("python -m pip install requests beautifulsoup4")
    sys.exit(1)

LIST_URL = "https://pcg-search.com/card/card_list.php"
CACHE_PATH = Path("pcg_migration_cache.json")
OUTPUT_PATH = Path("adv4_adv5_pcg1_9_wcp_import.sql")

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; ryotei-card-db-migration/1.0)"
}

SETS = [
    {
        "code": "ADV4",
        "marker": "マグマVSアクア ふたつの野望",
        "name": "強化拡張パックex1 マグマVSアクア ふたつの野望",
        "date": "2003-10-24",
        "sid": "adv4_ja",
        "total": 80,
        "series_id": "ADV",
        "series_name": "ADV・PCGシリーズ",
        "pack": "Ex1 Magma VS Aqua Two Ambitions pack.jpg",
    },
    {
        "code": "ADV5",
        "marker": "とかれた封印",
        "name": "第4弾拡張パック とかれた封印",
        "date": "2004-01-16",
        "sid": "adv5_ja",
        "total": 83,
        "series_id": "ADV",
        "series_name": "ADV・PCGシリーズ",
        "pack": "ADV4 Undone Seal pack.jpg",
    },
    {
        "code": "PCG1",
        "marker": "伝説の飛翔",
        "name": "拡張パック 伝説の飛翔",
        "date": "2004-04-09",
        "sid": "pcg1_ja",
        "total": 82,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG1 Flight of Legends pack.jpg",
    },
    {
        "code": "PCG2",
        "marker": "蒼空の激突",
        "name": "拡張パック 蒼空の激突",
        "date": "2004-07-01",
        "sid": "pcg2_ja",
        "total": 82,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG2 Clash of the Blue Sky pack.jpg",
    },
    {
        "code": "PCG3",
        "marker": "ロケット団の逆襲",
        "name": "拡張パック ロケット団の逆襲",
        "date": "2004-10-15",
        "sid": "pcg3_ja",
        "total": 85,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG3 Rocket Gang Strikes Back pack.jpg",
    },
    {
        "code": "PCG4",
        "marker": "金の空、銀の海",
        "name": "拡張パック 金の空、銀の海",
        "date": "2005-04-08",
        "sid": "pcg4_ja",
        "total": 106,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG4 Golden Sky Silvery Ocean pack.jpg",
    },
    {
        "code": "PCG5",
        "marker": "まぼろしの森",
        "name": "拡張パック まぼろしの森",
        "date": "2005-06-30",
        "sid": "pcg5_ja",
        "total": 86,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG5 Mirage Forest pack.jpg",
    },
    {
        "code": "PCG6",
        "marker": "ホロンの研究塔",
        "name": "拡張パック ホロンの研究塔",
        "date": "2005-10-28",
        "sid": "pcg6_ja",
        "total": 86,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG6 Holon Research Tower pack.jpg",
    },
    {
        "code": "PCG7",
        "marker": "ホロンの幻影",
        "name": "拡張パック ホロンの幻影",
        "date": "2006-01-27",
        "sid": "pcg7_ja",
        "total": 52,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG7 Holon Phantom pack.jpg",
    },
    {
        "code": "PCG8",
        "marker": "きせきの結晶",
        "name": "拡張パック きせきの結晶",
        "date": "2006-03-10",
        "sid": "pcg8_ja",
        "total": 75,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG8 Miracle Crystal pack.jpg",
    },
    {
        "code": "PCG9",
        "marker": "さいはての攻防",
        "name": "拡張パック さいはての攻防",
        "date": "2006-06-29",
        "sid": "pcg9_ja",
        "total": 68,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "PCG9 Offense Defense Furthest Ends pack.jpg",
    },
    {
        "code": "WCP",
        "marker": "ワールドチャンピオンズパック",
        "name": "ワールドチャンピオンズパック",
        "date": "2007-07-05",
        "sid": "pcg10_ja",
        "total": 108,
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "pack": "World Champions Pack.jpg",
    },
]

EXPECTED_GRAND_TOTAL = sum(s["total"] for s in SETS)  # 993

session = requests.Session()
session.headers.update(HEADERS)


def sq(v):
    if v is None:
        return "NULL"
    return "'" + str(v).replace("'", "''") + "'"


def load_cache():
    if CACHE_PATH.exists():
        try:
            return json.loads(CACHE_PATH.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {"rarity": {}}


def save_cache(cache):
    CACHE_PATH.write_text(
        json.dumps(cache, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def get(url, attempts=4):
    last = None
    for i in range(attempts):
        try:
            r = session.get(url, timeout=30)
            r.raise_for_status()
            r.encoding = r.apparent_encoding or "utf-8"
            return r.text
        except Exception as e:
            last = e
            time.sleep(1.5 * (i + 1))
    raise RuntimeError(f"GET failed: {url}\n{last}")


def find_set_table(soup, marker):
    # markerを含む文字列の直後のtableを使う。
    nodes = soup.find_all(string=lambda t: t and marker in t)
    for node in nodes:
        table = node.find_next("table")
        if table:
            return table
    raise RuntimeError(f"カードリスト内でセットを見つけられません: {marker}")


def parse_set_rows(table, expected_total):
    rows = []
    seen = set()

    for tr in table.find_all("tr"):
        tds = tr.find_all("td")
        if len(tds) < 3:
            continue

        raw_no = tds[0].get_text(" ", strip=True)
        m = re.search(r"(\d{3})/(\d{3})", raw_no)
        if not m:
            continue

        n = int(m.group(1))
        if n in seen:
            continue

        name_cell = tds[2]
        name = name_cell.get_text(" ", strip=True)
        name = re.sub(r"\s+", " ", name).strip()
        if not name:
            continue

        a = name_cell.find("a", href=True)
        detail_url = urljoin(LIST_URL, a["href"]) if a else None

        rows.append({
            "n": n,
            "printed": raw_no,
            "name": name,
            "detail_url": detail_url,
        })
        seen.add(n)

    rows.sort(key=lambda x: x["n"])

    # pcg-searchの表には、セットによって基本エネルギー等の別番号が続く場合がある。
    # 数字の001/...形式だけを採用し、Scrydexのtotalと一致することを必須にする。
    if len(rows) != expected_total:
        raise RuntimeError(
            f"カード件数不一致: expected={expected_total}, parsed={len(rows)} "
            f"(first={rows[:2]}, last={rows[-2:] if rows else []})"
        )
    return rows


def normalize_rarity(text):
    # pcg-search 個別ページの「レアリティ ●」等をそのまま取得。
    m = re.search(r"レアリティ\s*([●◆★☆◇ー])", text)
    if m:
        return m.group(1)

    # 念のため文字表記にも対応
    for word, sym in [
        ("コモン", "●"),
        ("アンコモン", "◆"),
        ("レア", "★"),
    ]:
        if f"レアリティ{word}" in text.replace(" ", ""):
            return sym
    return None


def get_rarity(card, cache):
    url = card["detail_url"]
    if not url:
        return None
    if url in cache["rarity"]:
        return cache["rarity"][url]

    html = get(url)
    soup = BeautifulSoup(html, "html.parser")
    text = soup.get_text(" ", strip=True)
    rarity = normalize_rarity(text)

    cache["rarity"][url] = rarity
    save_cache(cache)

    # 公開サイトへ過剰な連続アクセスをしない
    time.sleep(0.30)
    return rarity


def pack_redirect(filename):
    from urllib.parse import quote
    return (
        "https://archives.bulbagarden.net/wiki/Special:Redirect/file/"
        + quote(filename, safe="")
    )


def card_match_sql(alias, n):
    # 1 / 001 / 001/082 のどれでも既存行を拾う。
    return (
        f"coalesce(nullif(ltrim(split_part({alias}.card_number,'/',1),'0'),''),'0')"
        f" = {sq(str(n))}"
    )


def build_sql(data):
    lines = [
        "-- ADV4/ADV5 + PCG1-PCG9 + WCP 一括移行",
        "-- Generated from pcg-search public pages; card images use Scrydex public image URLs.",
        "-- Paid Scrydex API is NOT used.",
        "-- Existing unrelated sets are not touched.",
        "",
        "begin;",
        "",
    ]

    for s, cards in data:
        pack = pack_redirect(s["pack"])
        lines += [
            f"-- ============================================================",
            f"-- {s['code']} {s['name']} ({s['total']} cards)",
            f"-- ============================================================",
            "update public.card_sets",
            f"set name={sq(s['name'])},",
            f"    release_date={sq(s['date'])}::date,",
            f"    tcgdex_series_id={sq(s['series_id'])},",
            f"    series_name={sq(s['series_name'])},",
            f"    image_url={sq(pack)}",
            f"where code={sq(s['code'])};",
            "",
            "insert into public.card_sets "
            "(name, code, release_date, tcgdex_series_id, series_name, image_url)",
            f"select {sq(s['name'])}, {sq(s['code'])}, {sq(s['date'])}::date, "
            f"{sq(s['series_id'])}, {sq(s['series_name'])}, {sq(pack)}",
            f"where not exists (select 1 from public.card_sets where code={sq(s['code'])});",
            "",
        ]

        for c in cards:
            n = c["n"]
            name = c["name"]
            rarity = c["rarity"]
            image = f"https://images.scrydex.com/pokemon/{s['sid']}-{n}/large"

            # 既存行を番号でUPDATE。
            lines += [
                f"-- {n:03d}/{s['total']:03d} {name}",
                f"with st as (select id from public.card_sets where code={sq(s['code'])} limit 1)",
                "update public.cards c set",
                f"  name={sq(name)},",
                f"  name_normalized=public.normalize_card_name({sq(name)}),",
                (f"  rarity={sq(rarity)}," if rarity is not None else "  rarity=c.rarity,"),
                f"  set_order={n},",
                f"  image_url={sq(image)},",
                f"  image_source_note={sq('Scrydex public card image (' + s['sid'] + ')')},",
                "  is_active=true,",
                "  updated_at=now()",
                "from st",
                f"where c.set_id=st.id and {card_match_sql('c', n)};",
                "",
                # 存在しなければINSERT。PCG側の欠番もこの処理で補完する。
                f"with st as (select id from public.card_sets where code={sq(s['code'])} limit 1)",
                "insert into public.cards",
                "  (set_id,name,name_normalized,card_number,rarity,variant,image_url,"
                "image_source_note,is_active,set_order,created_at,updated_at)",
                "select st.id,"
                f"{sq(name)},public.normalize_card_name({sq(name)}),{sq(str(n))},{sq(rarity)},"
                f"'normal',{sq(image)},{sq('Scrydex public card image (' + s['sid'] + ')')},"
                f"true,{n},now(),now()",
                "from st",
                "where not exists (",
                "  select 1 from public.cards c",
                f"  where c.set_id=st.id and {card_match_sql('c', n)}",
                ");",
                "",
            ]

    lines += [
        "commit;",
        "",
        "-- ============================================================",
        "-- 一括監査",
        "-- ============================================================",
        "select",
        "  cs.code, cs.name, cs.release_date,",
        "  count(*) as total,",
        "  count(distinct c.set_order) as unique_numbers,",
        "  count(*) filter (where c.image_url like 'https://images.scrydex.com/pokemon/%/large') as scrydex_images,",
        "  cs.image_url as pack_image_url",
        "from public.card_sets cs",
        "join public.cards c on c.set_id=cs.id",
        "where cs.code in ('ADV4','ADV5','PCG1','PCG2','PCG3','PCG4','PCG5','PCG6','PCG7','PCG8','PCG9','WCP')",
        "group by cs.code, cs.name, cs.release_date, cs.image_url",
        "order by",
        "  case cs.code",
        "    when 'ADV4' then 1 when 'ADV5' then 2",
        "    when 'PCG1' then 3 when 'PCG2' then 4 when 'PCG3' then 5",
        "    when 'PCG4' then 6 when 'PCG5' then 7 when 'PCG6' then 8",
        "    when 'PCG7' then 9 when 'PCG8' then 10 when 'PCG9' then 11",
        "    when 'WCP' then 12 else 99 end;",
        "",
        "-- 期待件数との差分（0 rows が正常）",
        "with expected(code,total) as (values",
        "  ('ADV4',80),('ADV5',83),('PCG1',82),('PCG2',82),('PCG3',85),('PCG4',106),",
        "  ('PCG5',86),('PCG6',86),('PCG7',52),('PCG8',75),('PCG9',68),('WCP',108)",
        "), actual as (",
        "  select cs.code, count(distinct c.set_order)::int as total",
        "  from public.card_sets cs join public.cards c on c.set_id=cs.id",
        "  where cs.code in (select code from expected)",
        "  group by cs.code",
        ")",
        "select e.code, e.total as expected, coalesce(a.total,0) as actual",
        "from expected e left join actual a using(code)",
        "where coalesce(a.total,0) <> e.total",
        "order by e.code;",
        "",
        "-- 重複set_order（0 rows が正常）",
        "select cs.code, c.set_order, count(*) as dup_count",
        "from public.card_sets cs join public.cards c on c.set_id=cs.id",
        "where cs.code in ('ADV4','ADV5','PCG1','PCG2','PCG3','PCG4','PCG5','PCG6','PCG7','PCG8','PCG9','WCP')",
        "group by cs.code, c.set_order",
        "having count(*) > 1",
        "order by cs.code, c.set_order;",
    ]
    return "\n".join(lines)


def main():
    print("pcg-search のカードリストを取得中...")
    html = get(LIST_URL)
    soup = BeautifulSoup(html, "html.parser")
    cache = load_cache()

    all_data = []
    total_cards = 0

    for s in SETS:
        print(f"\n[{s['code']}] {s['name']} を解析...")
        table = find_set_table(soup, s["marker"])
        cards = parse_set_rows(table, s["total"])
        print(f"  カードリスト: {len(cards)}/{s['total']}")

        for i, c in enumerate(cards, start=1):
            rarity = get_rarity(c, cache)
            c["rarity"] = rarity
            status = rarity if rarity else "?"
            print(f"  {i:03d}/{len(cards):03d}  {c['n']:03d} {c['name']} [{status}]")

        all_data.append((s, cards))
        total_cards += len(cards)

    if total_cards != EXPECTED_GRAND_TOTAL:
        raise RuntimeError(
            f"全体件数が不一致: expected={EXPECTED_GRAND_TOTAL}, parsed={total_cards}"
        )

    sql = build_sql(all_data)
    OUTPUT_PATH.write_text(sql, encoding="utf-8")

    missing_rarity = [
        (s["code"], c["n"], c["name"])
        for s, cards in all_data
        for c in cards
        if c["rarity"] is None
    ]

    print("\n============================================================")
    print(f"OK: {total_cards} cards parsed")
    print(f"SQL: {OUTPUT_PATH.resolve()}")
    print(f"Cache: {CACHE_PATH.resolve()}")
    if missing_rarity:
        print(f"WARNING: rarity未取得 {len(missing_rarity)}件")
        for row in missing_rarity[:30]:
            print(" ", row)
        print("SQLは生成されていますが、該当行のrarityは既存値維持/新規NULLです。")
    else:
        print("Rarity: 全件取得OK")
    print("============================================================")


if __name__ == "__main__":
    main()
