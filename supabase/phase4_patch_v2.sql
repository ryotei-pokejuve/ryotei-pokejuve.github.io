-- =====================================================================
-- Phase 4 パッチ v2（CODEXレビュー対応: 管理者確認RPC + DB側入力検証）
-- 前提: phase1_schema.sql / phase1_patch.sql / phase2_patch.sql / phase4_patch.sql 実行済み
-- 本番プロジェクトのSQL Editorで、この内容を全部貼り付けて実行してください。
-- =====================================================================

-- ---------------------------------------------------------------------
-- A. 管理者確認用の軽量RPC
--    ログイン直後、実際の書き込みを試す前に「このアカウントは管理者か」を
--    確認するために使う。管理者以外が呼んでもエラーにはせず false を返す
--    （情報漏えいにはならない・UI表示の出し分けにのみ使う）。
-- ---------------------------------------------------------------------
create or replace function api.admin_check_access()
returns boolean
language sql
security definer
set search_path = ''
stable
as $$
  select public.is_admin();
$$;

revoke execute on function api.admin_check_access() from public;
grant  execute on function api.admin_check_access() to authenticated;

-- ---------------------------------------------------------------------
-- B. api.admin_upsert_card にDB側の入力検証を追加
--    - 名前・番号は前後空白除去のうえ必須＋文字数上限
--    - レアリティ・バリアント・出典メモも文字数上限
--    - 画像URLは https:// 始まりのみ許可（空文字は null 扱い）
--    - 更新対象のidが存在しない場合はNULLを返さずエラーにする
--      （フロントが「保存しました」と誤表示しないようにするため）
-- ---------------------------------------------------------------------
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
  v_id        uuid;
  v_name      text := btrim(coalesce(p_name, ''));
  v_number    text := btrim(coalesce(p_card_number, ''));
  v_rarity    text := nullif(btrim(coalesce(p_rarity, '')), '');
  v_variant   text := btrim(coalesce(p_variant, ''));
  v_image_url text := nullif(btrim(coalesce(p_image_url, '')), '');
  v_note      text := nullif(btrim(coalesce(p_image_source_note, '')), '');
begin
  if not public.is_admin() then
    raise exception 'not authorized';
  end if;

  if p_set_id is null then
    raise exception 'set_id is required';
  end if;
  if v_name = '' or length(v_name) > 200 then
    raise exception 'name is required and must be 200 characters or fewer';
  end if;
  if v_number = '' or length(v_number) > 50 then
    raise exception 'card_number is required and must be 50 characters or fewer';
  end if;
  if v_rarity is not null and length(v_rarity) > 50 then
    raise exception 'rarity must be 50 characters or fewer';
  end if;
  if length(v_variant) > 50 then
    raise exception 'variant must be 50 characters or fewer';
  end if;
  if v_image_url is not null then
    if length(v_image_url) > 2048 then
      raise exception 'image_url is too long';
    end if;
    if v_image_url !~ '^https://' then
      raise exception 'image_url must start with https://';
    end if;
  end if;
  if v_note is not null and length(v_note) > 500 then
    raise exception 'image_source_note must be 500 characters or fewer';
  end if;

  if p_id is null then
    insert into public.cards (set_id, name, card_number, rarity, variant, image_url, image_source_note)
    values (p_set_id, v_name, v_number, v_rarity, v_variant, v_image_url, v_note)
    returning id into v_id;
  else
    update public.cards
       set set_id = p_set_id, name = v_name, card_number = v_number,
           rarity = v_rarity, variant = v_variant,
           image_url = v_image_url, image_source_note = v_note,
           updated_at = now()
     where id = p_id
    returning id into v_id;

    if v_id is null then
      raise exception 'card not found for update';
    end if;
  end if;

  return v_id;
end;
$$;

revoke execute on function api.admin_upsert_card from public;
grant  execute on function api.admin_upsert_card to authenticated;

-- ---------------------------------------------------------------------
-- C. api.admin_record_price に condition / price_type の検証を追加
-- ---------------------------------------------------------------------
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
  v_condition text := nullif(btrim(coalesce(p_condition, '')), '');
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
  if p_price_type is null or p_price_type not in ('sell', 'buy') then
    raise exception 'price_type must be sell or buy';
  end if;
  if v_condition is null or length(v_condition) > 50 then
    raise exception 'condition is required and must be 50 characters or fewer';
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
    (p_card_id, v_source_id, p_price, p_price_type, v_condition,
     p_observed_at, p_import_batch_id)
  on conflict (card_id, source_id, price_type, condition, observed_at) do nothing
  returning id into v_id;

  return v_id;
end;
$$;

revoke execute on function api.admin_record_price from public;
grant  execute on function api.admin_record_price to authenticated;

-- =====================================================================
-- 実行後、Settings → Data API → Exposed functions で
-- api.admin_check_access が公開対象になっているか確認してください。
-- =====================================================================
