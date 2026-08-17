-- =====================================================================
-- Phase 1 パッチ（Codex 2回目レビュー対応）
-- 前提: phase1_schema.sql をすでに実行済みであること
-- 既存オブジェクトの調整・追加のみで、既存データは失われません。
-- SQL Editorで新しいクエリとして、この内容を全部貼り付けて実行してください。
-- =====================================================================

-- ---------------------------------------------------------------------
-- A. 内部関数からPUBLICのEXECUTE権限を明示的に剥奪
--    （新規関数はデフォルトでPUBLICにEXECUTEが付くPostgreSQLの仕様に対応）
-- ---------------------------------------------------------------------
revoke execute on function public.normalize_card_name(text) from public;
revoke execute on function public.set_card_name_normalized() from public;
revoke execute on function public.sync_current_price() from public;
revoke execute on function public.is_admin() from public;
grant  execute on function public.is_admin() to authenticated;

-- ---------------------------------------------------------------------
-- B. api.get_card を修正（price_type / condition を引数化）
--    旧シグネチャ get_card(uuid) は削除し、新シグネチャに統一
-- ---------------------------------------------------------------------
drop function if exists api.get_card(uuid);

create or replace function api.get_card(
  p_card_id    uuid,
  p_price_type text default 'sell',
  p_condition  text default 'default'
) returns table (
  id                uuid,
  name              text,
  card_number       text,
  rarity            text,
  variant           text,
  set_name          text,
  image_url         text,
  current_price     int,
  price_type        text,
  condition         text,
  price_updated_at  timestamptz
)
language sql
security definer
set search_path = ''
stable
as $$
  select
    c.id, c.name, c.card_number, c.rarity, c.variant, cs.name, c.image_url,
    cp.price, cp.price_type, cp.condition, cp.observed_at
  from public.cards c
  join public.card_sets cs on cs.id = c.set_id
  left join public.current_prices cp
    on cp.card_id = c.id
   and cp.price_type = coalesce(p_price_type, 'sell')
   and cp.condition  = coalesce(p_condition, 'default')
  where c.id = p_card_id and c.is_active = true;
$$;

revoke execute on function api.get_card(uuid, text, text) from public;
grant  execute on function api.get_card(uuid, text, text) to anon, authenticated;

-- ---------------------------------------------------------------------
-- C. api.get_price_history を修正
--    - price_type / condition で絞り込むよう変更（sell/buy等が混在しないように）
--    - limitの下限を保証（0以下・NULLでもエラーにならず1〜200に収まる）
-- ---------------------------------------------------------------------
drop function if exists api.get_price_history(uuid, int);

create or replace function api.get_price_history(
  p_card_id    uuid,
  p_price_type text default 'sell',
  p_condition  text default 'default',
  p_limit      int  default 30
) returns table (
  price       int,
  observed_at timestamptz,
  source_name text
)
language sql
security definer
set search_path = ''
stable
as $$
  select po.price, po.observed_at, ps.name
  from public.price_observations po
  join public.price_sources ps on ps.id = po.source_id
  where po.card_id = p_card_id
    and po.price_type = coalesce(p_price_type, 'sell')
    and po.condition  = coalesce(p_condition, 'default')
  order by po.observed_at desc
  limit greatest(1, least(coalesce(p_limit, 30), 200));
$$;

revoke execute on function api.get_price_history(uuid, text, text, int) from public;
grant  execute on function api.get_price_history(uuid, text, text, int) to anon, authenticated;

-- 履歴APIの問い合わせパターン（card_id, price_type, condition, observed_at desc）に合わせて索引を張り替え
drop index if exists idx_price_observations_lookup;
create index idx_price_observations_by_type
  on public.price_observations (card_id, price_type, condition, observed_at desc);

-- ---------------------------------------------------------------------
-- D. api.search_cards を修正
--    - limitの下限を保証（負数・0でもエラーにならず1〜100に収まる）
--    - offsetに上限を設定（極端に大きい値を拒否）
--    - 検索語を最大100文字に切り詰め
--    - ユーザー入力中の % _ \ をLIKEのワイルドカードとして解釈しないようエスケープ
--    - 空白だけの検索語も「絞り込みなし」として扱う（正規化後の空文字で判定）
-- ---------------------------------------------------------------------
create or replace function api.search_cards(
  p_query   text default null,
  p_set_id  uuid default null,
  p_rarity  text default null,
  p_limit   int  default 20,
  p_offset  int  default 0
) returns table (
  id               uuid,
  name             text,
  card_number      text,
  rarity           text,
  set_name         text,
  image_url        text,
  current_price    int,
  price_updated_at timestamptz,
  total_count      bigint
)
language plpgsql
security definer
set search_path = ''
stable
as $$
declare
  v_query_raw  text := left(coalesce(p_query, ''), 100);
  v_query_norm text := public.normalize_card_name(v_query_raw);
  v_query_esc  text;
  v_limit      int := greatest(1, least(coalesce(p_limit, 20), 100));
  v_offset     int := greatest(0, least(coalesce(p_offset, 0), 100000));
begin
  v_query_esc := replace(replace(replace(v_query_norm, '\', '\\'), '%', '\%'), '_', '\_');

  return query
  select
    c.id, c.name, c.card_number, c.rarity, cs.name, c.image_url,
    cp.price, cp.observed_at,
    count(*) over() as total_count
  from public.cards c
  join public.card_sets cs on cs.id = c.set_id
  left join public.current_prices cp
    on cp.card_id = c.id and cp.price_type = 'sell' and cp.condition = 'default'
  where c.is_active = true
    and (p_set_id is null or c.set_id = p_set_id)
    and (p_rarity is null or c.rarity = p_rarity)
    and (
      v_query_norm = ''
      or c.card_number = v_query_raw
      or c.name_normalized ilike v_query_esc || '%' escape '\'
      or c.name_normalized ilike '%' || v_query_esc || '%' escape '\'
    )
  order by c.updated_at desc, c.id
  limit v_limit offset v_offset;
end;
$$;

revoke execute on function api.search_cards(text, uuid, text, int, int) from public;
grant  execute on function api.search_cards(text, uuid, text, int, int) to anon, authenticated;

-- ---------------------------------------------------------------------
-- E. 今後作成するテーブル・関数に、デフォルトで公開権限が付かないようにする
--    Supabase SQL Editorは postgres ロールでSQLを実行するため、
--    postgres ロールが所有者になるオブジェクトを対象に設定する
-- ---------------------------------------------------------------------
alter default privileges for role postgres in schema public
  revoke execute on functions from public;
alter default privileges for role postgres in schema api
  revoke execute on functions from public;
alter default privileges for role postgres in schema public
  revoke all on tables from anon, authenticated;
alter default privileges for role postgres in schema api
  revoke all on tables from anon, authenticated;

-- publicスキーマへの不要なCREATE権限も念のため剥奪（自分＝postgresロールの権限には影響しません）
revoke create on schema public from public;

-- =====================================================================
-- ここまで実行したら、test-phase1.htmlの追加テスト（9〜13）を実施してください。
-- =====================================================================
