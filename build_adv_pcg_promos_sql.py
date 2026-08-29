#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Scrydexの公開Webページだけを使って、ADV-P / PCG-P の
Supabase投入用SQLを生成します。有料APIは使用しません。

実行:
  python -m pip install requests beautifulsoup4
  python .\build_adv_pcg_promos_sql.py

出力:
  promo_sql/
    01_ADVP.sql
    02_PCGP_001_054.sql
    03_PCGP_055_104.sql
    04_PCGP_105_154.sql
  scrydex_promo_cache.json

ポイント:
- ADVP = 63 cards
- PCGP = 153 cards。ただしScrydex上の番号範囲は 001～154 で、1番号欠番があるため、
  「153まで」と決め打ちせず公開ページに実在するカードだけを取得します。
- 日本語名は各カード詳細ページの Data Details の name から取得します。
- rarity はすべて「プロモ」。
- 画像は https://images.scrydex.com/pokemon/<card-id>/large
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

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; ryotei-promo-db-import/1.0)"
}
SESSION = requests.Session()
SESSION.headers.update(HEADERS)

CACHE = Path("scrydex_promo_cache.json")
OUTDIR = Path("promo_sql")

EXPANSIONS = [
    {
        "code": "ADVP",
        "sid": "advp_ja",
        "url": "https://scrydex.com/pokemon/expansions/adv-promos/advp_ja",
        "name": "ADV-P プロモーションカード",
        "series_id": "ADV",
        "series_name": "ADV・PCGシリーズ",
        "expected": 63,
    },
    {
        "code": "PCGP",
        "sid": "pcgp_ja",
        "url": "https://scrydex.com/pokemon/expansions/pcg-promos/pcgp_ja",
        "name": "PCG-P プロモーションカード",
        "series_id": "PCG",
        "series_name": "ADV・PCGシリーズ",
        "expected": 153,
    },
]


def sq(v):
    if v is None:
        return "NULL"
    return "'" + str(v).replace("'", "''") + "'"


def get(url, retries=4):
    last = None
    for i in range(retries):
        try:
            r = SESSION.get(url, timeout=30)
            if r.status_code == 404:
                return None
            r.raise_for_status()
            r.encoding = "utf-8"
            return r.text
        except Exception as e:
            last = e
            time.sleep(1.5 * (i + 1))
    raise RuntimeError(f"GET failed: {url}\n{last}")


def load_cache():
    if CACHE.exists():
        try:
            return json.loads(CACHE.read_text(encoding="utf-8"))
        except Exception:
            pass
    return {}


def save_cache(c):
    CACHE.write_text(json.dumps(c, ensure_ascii=False, indent=2), encoding="utf-8")


def expansion_links(exp):
    html = get(exp["url"])
    if not html:
        raise RuntimeError(f"Expansion page 404: {exp['url']}")
    soup = BeautifulSoup(html, "html.parser")

    found = {}
    for a in soup.find_all("a", href=True):
        href = a["href"]
        if f"/{exp['sid']}-" not in href:
            continue
        m = re.search(rf"/({re.escape(exp['sid'])}-(\d+))(?:\?|$)", href)
        if not m:
            continue
        card_id = m.group(1)
        number = int(m.group(2))
        found[card_id] = {
            "id": card_id,
            "number": number,
            "url": urljoin(exp["url"], href),
        }

    cards = sorted(found.values(), key=lambda x: x["number"])
    if len(cards) != exp["expected"]:
        raise RuntimeError(
            f"{exp['code']}: expansion pageから {len(cards)} 件しか取れません "
            f"(expected {exp['expected']})"
        )
    return cards


def extract_data_detail_name(soup):
    # Scrydex detail pageにはData Detailsで
    # id / name / supertype ... の順にラベルと値が表示される。
    # まず "name" という独立テキストを探し、その後ろの日本語値を拾う。
    for node in soup.find_all(string=lambda s: s and s.strip() == "name"):
        parent = node.parent
        # 近傍の兄弟/次要素から値を探す
        cur = parent
        for _ in range(12):
            cur = cur.find_next()
            if cur is None:
                break
            txt = cur.get_text(" ", strip=True)
            if not txt or txt in {"string", "name"}:
                continue
            # 説明文 "The name of the card" は飛ばす
            if "The name of the card" in txt:
                continue
            # 日本語を含むか、ex/δ/☆等を含む短いカード名なら採用
            if len(txt) <= 80 and (
                re.search(r"[\u3040-\u30ff\u3400-\u9fff]", txt)
                or re.search(r"(ex|δ|☆|★)", txt, re.I)
            ):
                return txt.strip()

    # フォールバック: Details周辺に日本語見出しが出る場合
    h2s = soup.find_all(["h1", "h2"])
    for h in h2s:
        txt = h.get_text(" ", strip=True)
        if re.search(r"[\u3040-\u30ff\u3400-\u9fff]", txt):
            if txt not in {"ポケモン", "トレーナー", "エネルギー"}:
                return txt
    return None


def parse_detail(card, cache):
    cid = card["id"]
    if cid in cache:
        return cache[cid]

    html = get(card["url"])
    if html is None:
        raise RuntimeError(f"404: {card['url']}")
    soup = BeautifulSoup(html, "html.parser")
    text = soup.get_text("\n", strip=True)

    name = extract_data_detail_name(soup)

    # printed_number
    pm = re.search(r"(\d{3})/(ADV-P|PCG-P)", text)
    printed = pm.group(0) if pm else None

    # Data Detailsのname抽出が失敗した場合、
    # "Rarity Promo プロモ Language Japanese Number" の前に出る日本語副題を探す。
    if not name:
        # title/h1は英語名なので最終手段として使わず停止する。
        raise RuntimeError(
            f"{cid}: 日本語名を公開ページから抽出できませんでした。\n{card['url']}"
        )

    data = {
        "id": cid,
        "number": card["number"],
        "printed_number": printed,
        "name": name,
        "url": card["url"],
    }
    cache[cid] = data
    save_cache(cache)
    time.sleep(0.25)
    return data


def normalize_number_match(alias, n):
    # 既存DBが "1", "001", "001/ADV-P" いずれでも拾う
    return (
        f"coalesce(nullif(ltrim(split_part({alias}.card_number,'/',1),'0'),''),'0')"
        f" = {sq(str(n))}"
    )


def set_sql(exp):
    return f"""
update public.card_sets
set
  name={sq(exp['name'])},
  tcgdex_series_id={sq(exp['series_id'])},
  series_name={sq(exp['series_name'])}
where code={sq(exp['code'])};

insert into public.card_sets
  (name, code, tcgdex_series_id, series_name)
select
  {sq(exp['name'])}, {sq(exp['code'])}, {sq(exp['series_id'])}, {sq(exp['series_name'])}
where not exists (
  select 1 from public.card_sets where code={sq(exp['code'])}
);
""".strip()


def card_sql(exp, c):
    n = c["number"]
    cid = c["id"]
    name = c["name"]
    printed = c["printed_number"] or str(n)
    image = f"https://images.scrydex.com/pokemon/{cid}/large"
    return f"""
-- {printed} {name}
with st as (
  select id from public.card_sets where code={sq(exp['code'])} limit 1
)
update public.cards c
set
  name={sq(name)},
  name_normalized=public.normalize_card_name({sq(name)}),
  card_number={sq(printed)},
  rarity='プロモ',
  set_order={n},
  image_url={sq(image)},
  image_source_note={sq('Scrydex public card image (' + exp['sid'] + ')')},
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and {normalize_number_match('c', n)};

with st as (
  select id from public.card_sets where code={sq(exp['code'])} limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  {sq(name)},
  public.normalize_card_name({sq(name)}),
  {sq(printed)},
  'プロモ',
  'normal',
  {sq(image)},
  {sq('Scrydex public card image (' + exp['sid'] + ')')},
  true,
  {n},
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and {normalize_number_match('c', n)}
);
""".strip()


def audit_sql(exp, expected):
    return f"""
-- 監査
select
  cs.code,
  cs.name,
  count(*) as total,
  count(distinct c.set_order) as unique_numbers,
  min(c.set_order) as min_number,
  max(c.set_order) as max_number,
  count(*) filter (where c.rarity='プロモ') as promo_rarity,
  count(*) filter (
    where c.image_url like 'https://images.scrydex.com/pokemon/{exp['sid']}-%/large'
  ) as scrydex_images
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code={sq(exp['code'])}
group by cs.code, cs.name;

-- 件数が違えば1行返る。0 rows が正常。
select
  {sq(exp['code'])} as code,
  {expected} as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code={sq(exp['code'])}
having count(distinct c.set_order) <> {expected};

-- set_order重複。0 rows が正常。
select c.set_order, count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code={sq(exp['code'])}
group by c.set_order
having count(*) > 1
order by c.set_order;
""".strip()


def write_chunk(filename, exp, cards, include_set=False, expected_for_audit=None):
    parts = [
        f"-- {exp['name']} / Supabase SQL Editor用",
        "begin;",
        "",
    ]
    if include_set:
        parts += [set_sql(exp), ""]
    for c in cards:
        parts += [card_sql(exp, c), ""]
    parts += ["commit;", ""]
    if expected_for_audit is not None:
        parts += [audit_sql(exp, expected_for_audit), ""]
    (OUTDIR / filename).write_text("\n".join(parts), encoding="utf-8")


def main():
    OUTDIR.mkdir(exist_ok=True)
    cache = load_cache()

    parsed = {}
    for exp in EXPANSIONS:
        print(f"[{exp['code']}] expansion pageを取得...")
        links = expansion_links(exp)
        print(f"  links: {len(links)}/{exp['expected']}")
        rows = []
        for i, card in enumerate(links, 1):
            d = parse_detail(card, cache)
            rows.append(d)
            print(f"  {i:03d}/{len(links):03d} {d['id']} {d['name']}")
        parsed[exp["code"]] = rows

    adv = next(e for e in EXPANSIONS if e["code"] == "ADVP")
    pcg = next(e for e in EXPANSIONS if e["code"] == "PCGP")

    advcards = parsed["ADVP"]
    pcgcards = parsed["PCGP"]

    if len(advcards) != 63:
        raise RuntimeError(f"ADVP count mismatch: {len(advcards)}")
    if len(pcgcards) != 153:
        raise RuntimeError(f"PCGP count mismatch: {len(pcgcards)}")

    # ADVPは1本
    write_chunk(
        "01_ADVP.sql", adv, advcards,
        include_set=True, expected_for_audit=63
    )

    # PCGPは番号範囲で3分割。最後のファイルに監査を付ける。
    c1 = [c for c in pcgcards if 1 <= c["number"] <= 54]
    c2 = [c for c in pcgcards if 55 <= c["number"] <= 104]
    c3 = [c for c in pcgcards if 105 <= c["number"] <= 154]

    write_chunk("02_PCGP_001_054.sql", pcg, c1, include_set=True)
    write_chunk("03_PCGP_055_104.sql", pcg, c2)
    write_chunk(
        "04_PCGP_105_154.sql", pcg, c3,
        expected_for_audit=153
    )

    nums = {c["number"] for c in pcgcards}
    missing = [n for n in range(1, 155) if n not in nums]

    print("")
    print("============================================================")
    print("OK")
    print("ADVP:", len(advcards), "cards")
    print("PCGP:", len(pcgcards), "cards")
    print("PCGP 001-154 missing number(s):", missing)
    print("出力:")
    for p in sorted(OUTDIR.glob("*.sql")):
        print(" ", p)
    print("============================================================")


if __name__ == "__main__":
    main()
