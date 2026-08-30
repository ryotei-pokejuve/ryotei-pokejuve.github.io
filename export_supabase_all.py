import csv
import json
import sys
import urllib.parse
import urllib.request
import urllib.error
from pathlib import Path

# ↓ Supabase Dashboard の「API URL」をそのまま貼ってください。
# 末尾が /rest/v1 でも、なくても動くようにしてあります。
SUPABASE_API_URL = "https://idnhamxtwxfcxflenxko.supabase.co"

# ↓ Supabase Dashboard の Publishable key (sb_publishable_...) を貼ってください。
SUPABASE_KEY = "sb_publishable_lZoCHYEsf4LscKv2TVphBg_0JAAy4wO"

TABLES = [
    "card_sets",
    "cards",
    "current_prices",
    "price_sources",
    "short_features",
    "site_settings",
]

PAGE_SIZE = 1000
OUTPUT_DIR = Path(__file__).resolve().parent / "supabase_export"


def normalize_rest_url(value: str) -> str:
    value = value.strip().rstrip("/")
    if not value.startswith(("http://", "https://")):
        raise ValueError("API URL は https:// から始まるURLを貼ってください。")
    if value.endswith("/rest/v1"):
        return value
    return value + "/rest/v1"


REST_URL = None


def request_page(table, offset):
    url = f"{REST_URL}/{urllib.parse.quote(table)}?select=*"
    req = urllib.request.Request(
        url,
        headers={
            # 新しい sb_publishable_* キーは apikey ヘッダーだけで利用。
            # Authorization: Bearer に publishable key を入れない。
            "apikey": SUPABASE_KEY.strip(),
            "Accept": "application/json",
            "Range": f"{offset}-{offset + PAGE_SIZE - 1}",
            "Range-Unit": "items",
            "Prefer": "count=exact",
        },
    )
    with urllib.request.urlopen(req, timeout=60) as response:
        data = json.loads(response.read().decode("utf-8"))
        return data, response.headers.get("Content-Range", "")


def csv_value(value):
    if value is None:
        return ""
    if isinstance(value, (dict, list)):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))
    return value


def export_table(table):
    print(f"\n[{table}] 取得開始")
    rows = []
    offset = 0
    total_hint = None

    while True:
        page, content_range = request_page(table, offset)

        if total_hint is None and "/" in content_range:
            total_text = content_range.rsplit("/", 1)[-1]
            if total_text.isdigit():
                total_hint = int(total_text)

        rows.extend(page)
        if total_hint is not None:
            print(f"  {len(rows):,} / {total_hint:,} 件")
        else:
            print(f"  {len(rows):,} 件")

        if len(page) < PAGE_SIZE:
            break
        offset += PAGE_SIZE

    output = OUTPUT_DIR / f"{table}.csv"

    if not rows:
        output.write_text("", encoding="utf-8-sig")
        print(f"  0件: {output}")
        return 0

    fields, seen = [], set()
    for row in rows:
        for key in row.keys():
            if key not in seen:
                seen.add(key)
                fields.append(key)

    with output.open("w", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        for row in rows:
            writer.writerow({k: csv_value(row.get(k)) for k in fields})

    print(f"  保存完了: {output}")
    return len(rows)


def main():
    global REST_URL

    if SUPABASE_API_URL.startswith("ここに") or SUPABASE_KEY.startswith("ここに"):
        print("ERROR: ファイル上部の SUPABASE_API_URL と SUPABASE_KEY を設定してください。")
        input("\nEnterで終了...")
        return

    REST_URL = normalize_rest_url(SUPABASE_API_URL)
    OUTPUT_DIR.mkdir(exist_ok=True)

    print("Supabase 全件CSVエクスポート")
    print(f"REST URL: {REST_URL}")
    print(f"保存先: {OUTPUT_DIR}")
    print("※ 読み取り権限のあるテーブルだけ取得します。")

    results = {}
    for table in TABLES:
        try:
            results[table] = export_table(table)
        except urllib.error.HTTPError as e:
            body = e.read().decode("utf-8", errors="replace")
            print(f"\n[{table}] HTTP {e.code}")
            print("アクセス先:", getattr(e, "url", ""))
            print("レスポンス本文:", body[:2000])
            results[table] = f"ERROR HTTP {e.code}: {body[:300]}"
        except Exception as e:
            print(f"\n[{table}] エラー: {e}")
            results[table] = f"ERROR {e}"

    summary = OUTPUT_DIR / "_export_summary.txt"
    with summary.open("w", encoding="utf-8") as f:
        f.write(f"REST_URL: {REST_URL}\n")
        for table, result in results.items():
            f.write(f"{table}: {result}\n")

    print("\n=== 完了 ===")
    for table, result in results.items():
        print(f"{table}: {result}")
    print(f"\n結果: {OUTPUT_DIR}")
    input("\nEnterで終了...")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n中断しました。")
        sys.exit(1)
