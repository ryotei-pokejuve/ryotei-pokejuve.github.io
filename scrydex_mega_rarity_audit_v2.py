import csv
import html
import json
import re
import sys
import time
from pathlib import Path

try:
    import requests
    from bs4 import BeautifulSoup
except ImportError:
    print("requests / beautifulsoup4 が必要です。")
    print("PowerShell: pip install requests beautifulsoup4")
    input("\nEnterで終了...")
    raise

# Scrydex APIは使いません。公開されている expansion ページの表だけ読みます。
EXPANSIONS = {
    "M1L": ("m1l_ja", "https://scrydex.com/pokemon/expansions/mega-brave/m1l_ja"),
    "M1S": ("m1s_ja", "https://scrydex.com/pokemon/expansions/mega-symphonia/m1s_ja"),
    "MA":  ("ma_ja",  "https://scrydex.com/pokemon/expansions/mega-premium-trainer-box/ma_ja"),
    "MBD": ("mbd_ja", "https://scrydex.com/pokemon/expansions/mega-diancie-ex-starter-set-mega/mbd_ja"),
    "MBG": ("mbg_ja", "https://scrydex.com/pokemon/expansions/mega-gengar-ex-starter-set-mega/mbg_ja"),
    "M-P": ("mp_ja",  "https://scrydex.com/pokemon/expansions/mega-evolution-promos/mp_ja"),
    "M2":  ("m2_ja",  "https://scrydex.com/pokemon/expansions/inferno-x/m2_ja"),
    "M2a": ("m2a_ja", "https://scrydex.com/pokemon/expansions/mega-dream-ex/m2a_ja"),
    "MC":  ("mc_ja",  "https://scrydex.com/pokemon/expansions/start-deck-100-battle-collection/mc_ja"),
    "MP1": ("mp1_ja", "https://scrydex.com/pokemon/expansions/start-deck-100-battle-collection-corociao-version/mp1_ja"),
    "M3":  ("m3_ja",  "https://scrydex.com/pokemon/expansions/nihil-zero/m3_ja"),
    "M4":  ("m4_ja",  "https://scrydex.com/pokemon/expansions/ninja-spinner/m4_ja"),
    "M5":  ("m5_ja",  "https://scrydex.com/pokemon/expansions/abyss-eye/m5_ja"),
    "M6":  ("m6_ja",  "https://scrydex.com/pokemon/expansions/storm-emeralda/m6_ja"),
}

# Scrydex表に出る正式なレアリティだけ採用。
# "—" は「Scrydex側にレアリティ記載なし」として更新しません。
VALID_RARITIES = {
    "C", "U", "R", "RR", "AR", "SR", "SAR", "MUR",
    "PROMO", "ACE", "ACE SPEC"
}

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/152 Safari/537.36"
session = requests.Session()
session.headers.update({
    "User-Agent": UA,
    "Accept-Language": "ja,en;q=0.8",
})


def find_export_files():
    here = Path(__file__).resolve().parent
    candidates = [
        here,
        here / "supabase_export_db",
        here / "supabase_export",
        here.parent / "supabase_export_db",
        here.parent / "supabase_export",
    ]
    for folder in candidates:
        cards = folder / "cards.csv"
        sets = folder / "card_sets.csv"
        if cards.exists() and sets.exists():
            return cards, sets

    print("cards.csv / card_sets.csv の場所を自動検出できませんでした。")
    folder = Path(input("CSVがあるフォルダを貼ってください: ").strip().strip('"'))
    cards = folder / "cards.csv"
    sets = folder / "card_sets.csv"
    if cards.exists() and sets.exists():
        return cards, sets
    raise FileNotFoundError("cards.csv または card_sets.csv が見つかりません。")


def norm_num(v):
    if v is None:
        return ""
    s = html.unescape(str(v)).strip()
    s = s.replace("#", "")
    if "/" in s:
        s = s.split("/", 1)[0].strip()
    if re.fullmatch(r"\d+", s):
        return str(int(s))
    return s.upper()


def norm_rarity(v):
    if v is None:
        return ""
    s = html.unescape(str(v)).strip().upper()
    s = re.sub(r"\s+", " ", s)
    if s in {"", "-", "—", "–", "―", "N/A", "NONE", "NULL"}:
        return ""
    if s == "ACE SPEC":
        return "ACE SPEC"
    return s if s in VALID_RARITIES else ""


def get(url, tries=4):
    last = None
    for i in range(tries):
        try:
            r = session.get(url, timeout=60)
            if r.status_code == 200:
                return r.text
            last = RuntimeError(f"HTTP {r.status_code}")
        except Exception as e:
            last = e
        time.sleep(1.5 + i * 2)
    raise RuntimeError(f"{url}: {last}")


def load_db(cards_path, sets_path):
    with open(sets_path, newline="", encoding="utf-8-sig") as f:
        sets = list(csv.DictReader(f))
    id_to_code = {r["id"]: (r.get("code") or "").strip() for r in sets}

    rows = []
    with open(cards_path, newline="", encoding="utf-8-sig") as f:
        for r in csv.DictReader(f):
            code = id_to_code.get(r.get("set_id", ""), "")
            if code in EXPANSIONS:
                r["_set_code"] = code
                r["_num"] = norm_num(r.get("card_number"))
                rows.append(r)
    return rows


def parse_table_rows(page_html):
    """
    Scrydex公開 expansion ページの
      Card Details | Number | Rarity | Price/Trend
    表から number + rarity を直接取得。
    個別カードページにはアクセスしない。
    """
    soup = BeautifulSoup(page_html, "html.parser")
    out = {}

    # まず通常のHTML table/tr を解析。
    for tr in soup.find_all("tr"):
        cells = [c.get_text(" ", strip=True) for c in tr.find_all(["th", "td"])]
        if len(cells) < 3:
            continue

        # ヘッダ除外
        joined = " | ".join(cells).lower()
        if "number" in joined and "rarity" in joined:
            continue

        # Scrydexは基本 [Card Details, Number, Rarity, Price/Trend]
        # ただし装飾セルが混ざっても、番号と rarity の位置を柔軟に探す。
        rarity_idx = None
        rarity = ""
        for i, c in enumerate(cells):
            nr = norm_rarity(c)
            if nr:
                rarity_idx = i
                rarity = nr
                break
            if c.strip() in {"—", "-", "–", "―"}:
                # rarity列がダッシュの場合も候補として保持
                rarity_idx = i
                rarity = ""

        # 番号候補: 数字、英字エネルギーコード等
        number = ""
        for i, c in enumerate(cells):
            s = c.strip()
            if re.fullmatch(r"#?\d+(?:/\d+)?", s):
                number = norm_num(s)
                # rarity より前にある番号を優先
                if rarity_idx is None or i < rarity_idx:
                    break
            elif re.fullmatch(r"(?:DAR|FIG|FIR|GRA|LIG|MET|PSY|WAT)", s, re.I):
                number = norm_num(s)
                break

        if number:
            # 同一番号が複数回見つかった場合、rarity記載ありを優先。
            prev = out.get(number)
            if prev is None or (not prev["rarity"] and rarity):
                out[number] = {
                    "rarity": rarity,
                    "cells": cells,
                }

    # Next/Reactの埋め込みデータがあり、table解析数が極端に少ない場合の補助。
    # JSON断片の number / rarity ペアを近接検索。
    if len(out) < 5:
        raw = html.unescape(page_html)
        pattern = re.compile(
            r'"number"\s*:\s*"?(?P<num>[A-Za-z0-9]+)"?.{0,500}?'
            r'"rarity"\s*:\s*"(?P<rar>[^"]*)"',
            re.I | re.S,
        )
        for m in pattern.finditer(raw):
            number = norm_num(m.group("num"))
            rarity = norm_rarity(m.group("rar"))
            if number:
                out[number] = {"rarity": rarity, "cells": ["embedded-json"]}

    return out


def qlit(s):
    if s is None:
        return "NULL"
    return "'" + str(s).replace("'", "''") + "'"


def main():
    cards_path, sets_path = find_export_files()
    print("DB CSV:")
    print(" ", cards_path)
    print(" ", sets_path)

    db_rows = load_db(cards_path, sets_path)
    print(f"MEGA期 DB行数: {len(db_rows):,}")

    scraped = {}
    fetch_errors = []
    set_stats = []

    for code, (sid, url) in EXPANSIONS.items():
        print(f"\n[{code}] {url}")
        try:
            page = get(url)
            table = parse_table_rows(page)
            valid = sum(1 for x in table.values() if x["rarity"])
            blank = sum(1 for x in table.values() if not x["rarity"])
            print(f"  表から取得: {len(table)}件 / rarity記載あり {valid} / 記載なし {blank}")
            set_stats.append((code, len(table), valid, blank, "OK"))
            for num, data in table.items():
                scraped[(code, num)] = data
        except Exception as e:
            print("  ERROR:", e)
            fetch_errors.append((code, url, str(e)))
            set_stats.append((code, 0, 0, 0, f"ERROR: {e}"))

    audit = []
    for r in db_rows:
        code = r["_set_code"]
        num = r["_num"]
        current = (r.get("rarity") or "").strip()
        src = scraped.get((code, num))

        if src is None:
            status = "NOT_FOUND"
            expected = ""
        elif not src["rarity"]:
            status = "SCRYDEX_BLANK"
            expected = ""
        else:
            expected = src["rarity"]
            status = "MATCH" if current.upper() == expected.upper() else "CHANGE"

        audit.append({
            "card_id": r.get("id", ""),
            "set_code": code,
            "card_number": r.get("card_number", ""),
            "card_name": r.get("name", ""),
            "current_rarity": current,
            "scrydex_rarity": expected,
            "status": status,
        })

    outdir = Path(__file__).resolve().parent / "mega_rarity_audit_v2"
    outdir.mkdir(exist_ok=True)

    fields = [
        "card_id", "set_code", "card_number", "card_name",
        "current_rarity", "scrydex_rarity", "status"
    ]

    with open(outdir / "mega_rarity_audit_v2.csv", "w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(audit)

    changes = [r for r in audit if r["status"] == "CHANGE"]
    with open(outdir / "mega_rarity_changes_only_v2.csv", "w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(changes)

    unresolved = [r for r in audit if r["status"] in {"NOT_FOUND", "SCRYDEX_BLANK"}]
    with open(outdir / "mega_rarity_unresolved_v2.csv", "w", newline="", encoding="utf-8-sig") as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(unresolved)

    # SQLは差分だけ。ただしCSV取得時と現在DB rarity が同じ場合だけ更新。
    sql = [
        "-- MEGA rarity update v2",
        "-- Source: Scrydex PUBLIC expansion pages only. API is NOT used.",
        "-- IMPORTANT: Review mega_rarity_changes_only_v2.csv before running.",
        "",
        "BEGIN;",
        "",
        "CREATE TABLE IF NOT EXISTS public.mega_rarity_backup_20260829_v2 (",
        "    card_id uuid PRIMARY KEY,",
        "    old_rarity text,",
        "    backed_up_at timestamptz NOT NULL DEFAULT now()",
        ");",
        "",
    ]
    for r in changes:
        cid = r["card_id"]
        old = r["current_rarity"]
        new = r["scrydex_rarity"]
        sql += [
            f'-- {r["set_code"]} {r["card_number"]} {r["card_name"]}: {old or "(blank)"} -> {new}',
            "INSERT INTO public.mega_rarity_backup_20260829_v2(card_id, old_rarity)",
            f"SELECT id, rarity FROM public.cards WHERE id = {qlit(cid)}",
            "ON CONFLICT (card_id) DO NOTHING;",
            "UPDATE public.cards",
            f"SET rarity = {qlit(new)}, updated_at = now()",
            f"WHERE id = {qlit(cid)}",
            f"  AND COALESCE(rarity, '') = {qlit(old)};",
            "",
        ]
    sql += ["COMMIT;", ""]
    (outdir / "mega_rarity_update_v2.sql").write_text("\n".join(sql), encoding="utf-8")

    (outdir / "mega_rarity_rollback_v2.sql").write_text(
        """BEGIN;
UPDATE public.cards c
SET rarity = b.old_rarity,
    updated_at = now()
FROM public.mega_rarity_backup_20260829_v2 b
WHERE c.id = b.card_id;
COMMIT;
""",
        encoding="utf-8",
    )

    with open(outdir / "set_fetch_stats.csv", "w", newline="", encoding="utf-8-sig") as f:
        w = csv.writer(f)
        w.writerow(["set_code", "rows_found", "rarity_present", "rarity_blank", "status"])
        w.writerows(set_stats)

    summary = {
        "db_mega_rows": len(audit),
        "scrydex_table_rows_found": len(scraped),
        "matches": sum(r["status"] == "MATCH" for r in audit),
        "changes": len(changes),
        "scrydex_blank": sum(r["status"] == "SCRYDEX_BLANK" for r in audit),
        "not_found": sum(r["status"] == "NOT_FOUND" for r in audit),
        "set_fetch_errors": len(fetch_errors),
    }
    (outdir / "_summary_v2.txt").write_text(
        "\n".join(f"{k}: {v}" for k, v in summary.items()) + "\n",
        encoding="utf-8",
    )

    print("\n=== 完了 ===")
    for k, v in summary.items():
        print(f"{k}: {v}")
    print("\n出力先:", outdir)
    print("\nまず以下3つをChatGPTにアップロードしてください:")
    print("  _summary_v2.txt")
    print("  mega_rarity_changes_only_v2.csv")
    print("  mega_rarity_unresolved_v2.csv")
    print("\nまだ mega_rarity_update_v2.sql は実行しないでください。")
    input("\nEnterで終了...")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n中断しました。")
        sys.exit(1)
    except Exception as e:
        print("\nERROR:", type(e).__name__, e)
        input("\nEnterで終了...")
        raise
