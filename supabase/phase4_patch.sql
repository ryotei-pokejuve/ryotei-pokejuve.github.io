-- =====================================================================
-- Phase 4 パッチ（管理画面用: 編集対象カードの詳細取得）
-- 前提: phase1_schema.sql / phase1_patch.sql / phase2_patch.sql 実行済み
-- 本番プロジェクトのSQL Editorで、この内容を全部貼り付けて実行してください。
-- =====================================================================

-- ---------------------------------------------------------------------
-- 管理者専用: カード編集フォームの初期値取得
-- 公開のapi.get_card/api.search_cardsはset_id（パックのUUID）や
-- image_source_noteを返さない（編集フォームには必要）ため、
-- 管理者だけが呼べる別関数として用意する。is_admin()でない場合は拒否。
-- ---------------------------------------------------------------------
create or replace function api.admin_get_card(p_card_id uuid)
returns table (
  id                 uuid,
  set_id             uuid,
  name               text,
  card_number        text,
  rarity             text,
  variant            text,
  image_url          text,
  image_source_note  text
)
language plpgsql
security definer
set search_path = ''
stable
as $$
begin
  if not public.is_admin() then
    raise exception 'not authorized';
  end if;

  return query
  select c.id, c.set_id, c.name, c.card_number, c.rarity, c.variant, c.image_url, c.image_source_note
  from public.cards c
  where c.id = p_card_id;
end;
$$;

revoke execute on function api.admin_get_card(uuid) from public;
grant  execute on function api.admin_get_card(uuid) to authenticated;

-- =====================================================================
-- 実行後、Supabaseダッシュボード → Settings → Data API → Exposed functions で
-- api.admin_get_card が公開対象になっているか確認してください。
-- =====================================================================
