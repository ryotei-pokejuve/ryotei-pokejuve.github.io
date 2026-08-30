import csv
import getpass
import json
import re
from pathlib import Path
from urllib.parse import quote

import psycopg

TABLES = [
    "card_sets",
    "cards",
    "current_prices",
    "price_sources",
    "short_features",
    "site_settings",
]

OUTPUT_DIR = Path(__file__).resolve().parent / "supabase_export_db"
FETCH_SIZE = 2000


def normalize_value(value):
    if value is None:
        return ""
    if isinstance(value, (dict, list)):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))
    return value


def build_conninfo():
    print("Supabase Dashboard → Connect → Connection string → Session pooler")
    print("に表示される postgresql://... を貼ってください。")
    print("※ [YOUR-PASSWORD] のままでOKです。パスワードは次に非表示入力します。\n")

    uri = input("Connection string: ").strip()
    if not uri.startswith(("postgresql://", "postgres://")):
        raise ValueError("postgresql:// から始まるConnection stringを貼ってください。")

    password = getpass.getpass("Database password（画面には表示されません）: ")

    placeholders = [
        "[YOUR-PASSWORD]",
        "[YOUR_PASSWORD]",
        "<YOUR-PASSWORD>",
        "<YOUR_PASSWORD>",
        "YOUR-PASSWORD",
        "YOUR_PASSWORD",
    ]

    replaced = False
    for p in placeholders:
        if p in uri:
            uri = uri.replace(p, quote(password, safe=""))
            replaced = True
            break

    if not replaced:
        # URIに既にパスワードがある/ないケースに対応。
        # postgres://user@host... のようにパスワード無しなら user:password@ にする。
        m = re.match(r"^(postgres(?:ql)?://)([^/@:]+)@(.+)$", uri)
        if m:
            uri = f"{m.group(1)}{m.group(2)}:{quote(password, safe='')}@{m.group(3)}"
        else:
            # 既に user:password@ 形式なら、そのまま使用する。
            # ユーザーが貼ったURIにパスワードが含まれる場合は、非表示入力値は使わない。
            pass

    return uri


def get_columns(conn, table):
    with conn.cursor() as cur:
        cur.execute(
            """
            select column_name
            from information_schema.columns
            where table_schema = 'public'
              and table_name = %s
            order by ordinal_position
            """,
            (table,),
        )
        return [r[0] for r in cur.fetchall()]


def get_count(conn, table):
    with conn.cursor() as cur:
        cur.execute(f'SELECT count(*) FROM public."{table}"')
        return cur.fetchone()[0]


def export_table(conn, table):
    columns = get_columns(conn, table)
    if not columns:
        print(f"[{table}] テーブルが見つからないためスキップ")
        return "NOT FOUND"

    total = get_count(conn, table)
    out = OUTPUT_DIR / f"{table}.csv"

    quoted_cols = ", ".join(f'"{c}"' for c in columns)
    sql = f'SELECT {quoted_cols} FROM public."{table}"'

    print(f"\n[{table}] {total:,}件を取得します")

    with conn.cursor(name=f"export_{table}") as cur, out.open(
        "w", newline="", encoding="utf-8-sig"
    ) as f:
        cur.itersize = FETCH_SIZE
        cur.execute(sql)

        writer = csv.writer(f)
        writer.writerow(columns)

        written = 0
        while True:
            rows = cur.fetchmany(FETCH_SIZE)
            if not rows:
                break
            writer.writerows(
                [[normalize_value(v) for v in row] for row in rows]
            )
            written += len(rows)
            print(f"  {written:,} / {total:,}")

    print(f"  保存完了: {out}")
    return written


def main():
    OUTPUT_DIR.mkdir(exist_ok=True)

    try:
        conninfo = build_conninfo()
        print("\nDBへ接続中...")
        with psycopg.connect(conninfo, connect_timeout=15) as conn:
            print("接続成功。全件CSV化を開始します。")

            results = {}
            for table in TABLES:
                try:
                    results[table] = export_table(conn, table)
                except Exception as e:
                    conn.rollback()
                    print(f"[{table}] ERROR: {e}")
                    results[table] = f"ERROR: {e}"

        summary = OUTPUT_DIR / "_export_summary.txt"
        with summary.open("w", encoding="utf-8") as f:
            for table, result in results.items():
                f.write(f"{table}: {result}\n")

        print("\n=== 完了 ===")
        for table, result in results.items():
            print(f"{table}: {result}")
        print(f"\nCSV保存先:\n{OUTPUT_DIR}")
        print("\nこのフォルダ内のCSVをChatGPTにアップロードしてください。")

    except Exception as e:
        print("\n接続または処理に失敗しました。")
        print(type(e).__name__ + ":", e)
        print("\nConnection string は Supabase の Connect → Session pooler を推奨します。")

    input("\nEnterで終了...")


if __name__ == "__main__":
    main()
