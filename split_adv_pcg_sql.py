#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
adv4_adv5_pcg1_9_wcp_import.sql を Supabase SQL Editor 用に12分割します。

使い方:
  python split_adv_pcg_sql.py

前提:
  このスクリプトと
  adv4_adv5_pcg1_9_wcp_import.sql
  を同じフォルダに置く。

出力:
  split_sql/
    01_ADV4.sql
    02_ADV5.sql
    03_PCG1.sql
    ...
    12_WCP.sql
"""

from pathlib import Path
import re
import sys

SRC = Path("adv4_adv5_pcg1_9_wcp_import.sql")
OUT_DIR = Path("split_sql")

SETS = [
    ("ADV4", 80),
    ("ADV5", 83),
    ("PCG1", 82),
    ("PCG2", 82),
    ("PCG3", 85),
    ("PCG4", 106),
    ("PCG5", 86),
    ("PCG6", 86),
    ("PCG7", 52),
    ("PCG8", 75),
    ("PCG9", 68),
    ("WCP", 108),
]

def find_section(text: str, code: str, next_code: str | None) -> str:
    # build_adv_pcg_sql.py が出力した各セット見出しを起点にする
    start_pat = re.compile(
        rf"(?m)^-- {re.escape(code)}\s+.+?\(\d+ cards\)\s*$"
    )
    m = start_pat.search(text)
    if not m:
        raise RuntimeError(f"{code} の開始位置が見つかりません。")

    start = m.start()

    if next_code:
        next_pat = re.compile(
            rf"(?m)^-- {re.escape(next_code)}\s+.+?\(\d+ cards\)\s*$"
        )
        n = next_pat.search(text, m.end())
        if not n:
            raise RuntimeError(f"{next_code} の開始位置が見つかりません。")
        # 次セット直前の区切りコメントは除外してよい
        end = n.start()
    else:
        # 最終セットは全体commitより前まで
        commit_marker = text.find("\ncommit;", m.end())
        if commit_marker == -1:
            raise RuntimeError("全体 commit; が見つかりません。")
        end = commit_marker

    section = text[start:end].strip()

    # セクション末尾に次セット用の区切り線だけ残っていたら削除
    section = re.sub(
        r"\n-- =+\s*$",
        "",
        section,
        flags=re.MULTILINE,
    ).strip()

    return section

def audit_sql(code: str, expected: int) -> str:
    return f"""
-- ============================================================
-- {code} 監査
-- ============================================================
select
  cs.code,
  cs.name,
  cs.release_date,
  cs.image_url as pack_image_url,
  count(*) as total,
  count(distinct c.set_order) as unique_numbers,
  count(*) filter (
    where c.image_url like 'https://images.scrydex.com/pokemon/%/large'
  ) as scrydex_images
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = '{code}'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  '{code}' as code,
  {expected} as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = '{code}'
having count(distinct c.set_order) <> {expected};

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = '{code}'
group by c.set_order
having count(*) > 1
order by c.set_order;
""".strip()

def main():
    if not SRC.exists():
        print(f"ERROR: {SRC} が見つかりません。")
        print("このスクリプトを元SQLと同じフォルダに置いて実行してください。")
        sys.exit(1)

    text = SRC.read_text(encoding="utf-8")
    OUT_DIR.mkdir(exist_ok=True)

    written = []

    for i, (code, expected) in enumerate(SETS):
        next_code = SETS[i + 1][0] if i + 1 < len(SETS) else None
        section = find_section(text, code, next_code)

        content = "\n".join([
            f"-- {code} 単体実行用 / Supabase SQL Editor向け",
            "-- 元の一括SQLから自動分割",
            "",
            "begin;",
            "",
            section,
            "",
            "commit;",
            "",
            audit_sql(code, expected),
            "",
        ])

        out = OUT_DIR / f"{i+1:02d}_{code}.sql"
        out.write_text(content, encoding="utf-8")
        written.append(out)

    print("OK: 12ファイルに分割しました。")
    for p in written:
        print(f"  {p}")
    print("")
    print("Supabaseでは 01_ADV4.sql → 12_WCP.sql の順に実行してください。")

if __name__ == "__main__":
    main()
