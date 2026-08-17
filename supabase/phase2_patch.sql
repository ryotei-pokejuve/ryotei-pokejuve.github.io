-- =====================================================================
-- Phase 2 パッチ（CODEXレビュー対応: パック絞り込みの実装）
-- 前提: phase1_schema.sql / phase1_patch.sql をすでに実行済みであること
-- 既存オブジェクトへの追加のみで、既存データは失われません。
-- 本番プロジェクトのSQL Editorで、この内容を全部貼り付けて実行してください。
-- =====================================================================

-- ---- パック（card_sets）一覧の公開読み取り ----
-- search.htmlの絞り込みUI（パック選択）で使用する。id/nameだけで十分。
create or replace function api.list_card_sets()
returns table (
  id   uuid,
  name text,
  code text
)
language sql
security definer
set search_path = ''
stable
as $$
  select id, name, code
  from public.card_sets
  order by name;
$$;

revoke execute on function api.list_card_sets() from public;
grant  execute on function api.list_card_sets() to anon, authenticated;

-- =====================================================================
-- 実行後、Supabaseダッシュボード → Settings → API → "Exposed functions" で
-- api.list_card_sets が有効になっていることを確認してください
-- （新規関数はデフォルトで無効になっている場合があります）。
-- =====================================================================
