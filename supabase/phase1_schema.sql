-- =====================================================================
-- ポケカ相場表示機能 Phase 1 スキーマ一式
-- 設計ドキュメント v4（card-market-design-v4.md）に基づく実装
-- Supabaseダッシュボード → SQL Editor に貼り付けて実行してください。
-- 上から順に実行される前提で書かれています（依存関係に注意）。
-- =====================================================================

-- ---------------------------------------------------------------------
-- 0. 拡張機能（Supabaseプロジェクトには通常デフォルトで有効ですが念のため）
-- ---------------------------------------------------------------------
create extension if not exists pgcrypto with schema extensions;

-- ---------------------------------------------------------------------
-- 1. テーブル本体（public スキーマ）
-- ---------------------------------------------------------------------

create table public.card_sets (
  id           uuid primary key default gen_random_uuid(),
  name         text not null,
  code         text unique,
  release_date date,
  created_at   timestamptz not null default now()
);

create table public.price_sources (
  id         uuid primary key default gen_random_uuid(),
  name       text not null,
  type       text not null default 'manual' check (type in ('manual', 'csv', 'scraper', 'api')),
  url        text,
  created_at timestamptz not null default now()
);

create table public.import_batches (
  id            uuid primary key default gen_random_uuid(),
  source_id     uuid references public.price_sources(id),
  status        text not null default 'validating'
                 check (status in ('validating', 'previewed', 'committed', 'failed')),
  total_rows    integer not null default 0,
  success_rows  integer not null default 0,
  error_rows    integer not null default 0,
  error_report  jsonb,
  created_by    uuid references auth.users(id),
  created_at    timestamptz not null default now(),
  committed_at  timestamptz
);

create table public.cards (
  id                 uuid primary key default gen_random_uuid(),
  set_id             uuid not null references public.card_sets(id),
  name               text not null,
  name_normalized    text, -- トリガーで自動生成。手で入れなくてよい
  card_number        text not null,
  rarity             text,
  variant            text not null default '', -- ホロ/ミラー/SAR等の識別用の逃げ道
  image_url          text,
  image_source_note  text,
  is_active          boolean not null default true,
  created_at         timestamptz not null default now(),
  updated_at         timestamptz not null default now(),
  unique (set_id, card_number, variant)
);

create table public.price_observations (
  id               bigint generated always as identity primary key,
  card_id          uuid not null references public.cards(id),
  source_id        uuid not null references public.price_sources(id),
  price_type       text not null default 'sell' check (price_type in ('sell', 'buy')),
  condition        text not null default 'default',
  price            integer not null check (price > 0),
  currency         text not null default 'JPY',
  observed_at      timestamptz not null,
  import_batch_id  uuid references public.import_batches(id),
  external_ref_id  text,
  created_at       timestamptz not null default now(),
  unique (card_id, source_id, price_type, condition, observed_at)
);

create table public.current_prices (
  card_id      uuid not null references public.cards(id),
  price_type   text not null default 'sell',
  condition    text not null default 'default',
  source_id    uuid references public.price_sources(id),
  price        integer not null,
  observed_at  timestamptz not null,
  updated_at   timestamptz not null default now(),
  primary key (card_id, price_type, condition)
);

create table public.admin_users (
  user_id    uuid primary key references auth.users(id),
  role       text not null default 'admin',
  created_at timestamptz not null default now()
);

-- 検索・履歴の問い合わせパターンに直結する索引
create index idx_cards_set_rarity on public.cards (set_id, rarity);
create index idx_cards_card_number on public.cards (card_number);
create index idx_price_observations_lookup
  on public.price_observations (card_id, source_id, condition, observed_at desc);

-- ---------------------------------------------------------------------
-- 2. 日本語名の正規化（DB側の1箇所のみに実装。フロントでは重複実装しない）
-- ---------------------------------------------------------------------

create or replace function public.normalize_card_name(p_text text)
returns text
language sql
immutable
set search_path = ''
as $$
  select lower(
    translate(
      regexp_replace(normalize(coalesce(p_text, ''), nfkc), '\s+', '', 'g'),
      'ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをん',
      'ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲン'
    )
  );
$$;

create or replace function public.set_card_name_normalized()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.name_normalized := public.normalize_card_name(new.name);
  new.updated_at := now();
  return new;
end;
$$;

create trigger trg_set_card_name_normalized
  before insert or update on public.cards
  for each row execute function public.set_card_name_normalized();

-- ---------------------------------------------------------------------
-- 3. 管理者判定（admin_usersに登録されたユーザーのみ true）
-- ---------------------------------------------------------------------

create or replace function public.is_admin()
returns boolean
language sql
security definer
set search_path = ''
stable
as $$
  select exists (
    select 1 from public.admin_users where user_id = auth.uid()
  );
$$;

revoke execute on function public.is_admin() from public;
grant execute on function public.is_admin() to authenticated;

-- ---------------------------------------------------------------------
-- 4. 現在価格の同期（price_observationsへのINSERTをトリガーで検知）
--    どの経路（RPC / SQL直接実行 / 将来のバッチ）から挿入されても、
--    実際にINSERTが成功した行についてのみ発火するため不整合が起きない
-- ---------------------------------------------------------------------

create or replace function public.sync_current_price()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.current_prices
    (card_id, price_type, condition, source_id, price, observed_at, updated_at)
  values
    (new.card_id, new.price_type, new.condition, new.source_id, new.price, new.observed_at, now())
  on conflict (card_id, price_type, condition) do update
    set source_id   = excluded.source_id,
        price       = excluded.price,
        observed_at = excluded.observed_at,
        updated_at  = now()
  where excluded.observed_at >= public.current_prices.observed_at;
  return new;
end;
$$;

create trigger trg_sync_current_price
  after insert on public.price_observations
  for each row execute function public.sync_current_price();

-- ---------------------------------------------------------------------
-- 5. RLSを有効化 + ポリシーは作らない（デフォルト拒否）
--    アクセスはすべて api スキーマの関数経由に統一するため
-- ---------------------------------------------------------------------

alter table public.card_sets          enable row level security;
alter table public.cards              enable row level security;
alter table public.price_sources      enable row level security;
alter table public.price_observations enable row level security;
alter table public.current_prices     enable row level security;
alter table public.import_batches     enable row level security;
alter table public.admin_users        enable row level security;

-- anon / authenticated には実テーブルへの権限を一切与えない（念のため明示的に剥奪）
revoke all on public.card_sets, public.cards, public.price_sources,
  public.price_observations, public.current_prices, public.import_batches,
  public.admin_users
from anon, authenticated;

-- ---------------------------------------------------------------------
-- 6. api スキーマ（外部公開する関数だけを置く）
--    ★重要★ このSQL実行後、Supabaseダッシュボードで
--    Settings → API → "Exposed schemas" に api を追加してください。
--    追加しないと、ここで作った関数はREST APIから一切呼び出せません。
-- ---------------------------------------------------------------------

create schema if not exists api;
grant usage on schema api to anon, authenticated;

-- ---- 6-1. 公開読み取り: カード検索 ----
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
begin
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
      p_query is null or p_query = ''
      or c.card_number = p_query
      or c.name_normalized ilike public.normalize_card_name(p_query) || '%'
      or c.name_normalized ilike '%' || public.normalize_card_name(p_query) || '%'
    )
  order by c.updated_at desc, c.id
  limit least(coalesce(p_limit, 20), 100) offset greatest(coalesce(p_offset, 0), 0);
end;
$$;

revoke execute on function api.search_cards from public;
grant execute on function api.search_cards to anon, authenticated;

-- ---- 6-2. 公開読み取り: カード詳細 ----
create or replace function api.get_card(p_card_id uuid)
returns table (
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
    on cp.card_id = c.id and cp.price_type = 'sell' and cp.condition = 'default'
  where c.id = p_card_id and c.is_active = true;
$$;

revoke execute on function api.get_card from public;
grant execute on function api.get_card to anon, authenticated;

-- ---- 6-3. 公開読み取り: 価格履歴（直近N件） ----
create or replace function api.get_price_history(
  p_card_id uuid,
  p_limit   int default 30
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
  order by po.observed_at desc
  limit least(coalesce(p_limit, 30), 200);
$$;

revoke execute on function api.get_price_history from public;
grant execute on function api.get_price_history to anon, authenticated;

-- ---- 6-4. 管理操作: カード追加・編集（is_admin()必須） ----
create or replace function api.admin_upsert_card(
  p_id                uuid default null,
  p_set_id            uuid default null,
  p_name              text default null,
  p_card_number       text default null,
  p_rarity            text default null,
  p_variant           text default '',
  p_image_url         text default null,
  p_image_source_note text default null
) returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_id uuid;
begin
  if not public.is_admin() then
    raise exception 'not authorized';
  end if;
  if p_set_id is null or p_name is null or p_card_number is null then
    raise exception 'set_id, name, card_number are required';
  end if;

  if p_id is null then
    insert into public.cards (set_id, name, card_number, rarity, variant, image_url, image_source_note)
    values (p_set_id, p_name, p_card_number, p_rarity, coalesce(p_variant, ''), p_image_url, p_image_source_note)
    returning id into v_id;
  else
    update public.cards
       set set_id = p_set_id, name = p_name, card_number = p_card_number,
           rarity = p_rarity, variant = coalesce(p_variant, ''),
           image_url = p_image_url, image_source_note = p_image_source_note
     where id = p_id
    returning id into v_id;
  end if;

  return v_id;
end;
$$;

revoke execute on function api.admin_upsert_card from public;
grant execute on function api.admin_upsert_card to authenticated;

-- ---- 6-5. 管理操作: 価格登録（is_admin()必須。現在価格の同期はトリガー任せ） ----
create or replace function api.admin_record_price(
  p_card_id         uuid,
  p_price           int,
  p_observed_at     timestamptz default now(),
  p_source_id       uuid default null,
  p_price_type      text default 'sell',
  p_condition       text default 'default',
  p_import_batch_id uuid default null
) returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_id        bigint;
  v_source_id uuid;
begin
  if not public.is_admin() then
    raise exception 'not authorized';
  end if;
  if p_price is null or p_price <= 0 then
    raise exception 'price must be positive';
  end if;
  if p_observed_at is null or p_observed_at > now() + interval '1 hour' then
    raise exception 'observed_at is invalid or in the future';
  end if;
  if not exists (select 1 from public.cards where id = p_card_id and is_active = true) then
    raise exception 'card not found';
  end if;

  v_source_id := coalesce(
    p_source_id,
    (select id from public.price_sources where type = 'manual' order by created_at limit 1)
  );
  if v_source_id is null then
    raise exception 'no default price source configured (insert into price_sources first)';
  end if;

  insert into public.price_observations
    (card_id, source_id, price, price_type, condition, observed_at, import_batch_id)
  values
    (p_card_id, v_source_id, p_price, coalesce(p_price_type, 'sell'), coalesce(p_condition, 'default'),
     p_observed_at, p_import_batch_id)
  on conflict (card_id, source_id, price_type, condition, observed_at) do nothing
  returning id into v_id;

  return v_id; -- 重複でINSERTされなかった場合はnullが返る。current_pricesはトリガー任せなので不整合は起きない
end;
$$;

revoke execute on function api.admin_record_price from public;
grant execute on function api.admin_record_price to authenticated;

-- =====================================================================
-- 7. 初期データ（手動入力用のprice_sourceを1件だけ作成）
-- =====================================================================

insert into public.price_sources (name, type)
values ('手動入力', 'manual')
on conflict do nothing;

-- =====================================================================
-- ここまででテーブル・トリガー・関数・権限の作成は完了です。
-- 次にやること（SQL以外の手動作業）:
--   1. Supabaseダッシュボード → Settings → API → Exposed schemas に "api" を追加
--   2. Authentication → Users で自分用の管理者アカウントを作成
--   3. 作成したユーザーのUUIDを確認し、以下を実行して管理者登録する
--      insert into public.admin_users (user_id) values ('取得したUUID');
--   4. phase1_setup_and_tests.md の受け入れテストを実施
-- =====================================================================
