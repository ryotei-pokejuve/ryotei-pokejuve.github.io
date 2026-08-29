-- PCG-P プロモーションカード / Supabase SQL Editor用
begin;

update public.card_sets
set
  name='PCG-P プロモーションカード',
  tcgdex_series_id='PCG',
  series_name='ADV・PCGシリーズ'
where code='PCGP';

insert into public.card_sets
  (name, code, tcgdex_series_id, series_name)
select
  'PCG-P プロモーションカード', 'PCGP', 'PCG', 'ADV・PCGシリーズ'
where not exists (
  select 1 from public.card_sets where code='PCGP'
);

-- 001/PCG-P カメックス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='カメックス',
  name_normalized=public.normalize_card_name('カメックス'),
  card_number='001/PCG-P',
  rarity='プロモ',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-1/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'カメックス',
  public.normalize_card_name('カメックス'),
  '001/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-1/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  1,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/PCG-P リザードン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='リザードン',
  name_normalized=public.normalize_card_name('リザードン'),
  card_number='002/PCG-P',
  rarity='プロモ',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-2/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'リザードン',
  public.normalize_card_name('リザードン'),
  '002/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-2/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  2,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/PCG-P フシギバナ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='フシギバナ',
  name_normalized=public.normalize_card_name('フシギバナ'),
  card_number='003/PCG-P',
  rarity='プロモ',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-3/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'フシギバナ',
  public.normalize_card_name('フシギバナ'),
  '003/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-3/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  3,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/PCG-P フシギソウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='フシギソウ',
  name_normalized=public.normalize_card_name('フシギソウ'),
  card_number='004/PCG-P',
  rarity='プロモ',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-4/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'フシギソウ',
  public.normalize_card_name('フシギソウ'),
  '004/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-4/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  4,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/PCG-P アゲハント
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アゲハント',
  name_normalized=public.normalize_card_name('アゲハント'),
  card_number='005/PCG-P',
  rarity='プロモ',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-5/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アゲハント',
  public.normalize_card_name('アゲハント'),
  '005/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-5/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  5,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/PCG-P アメモース
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アメモース',
  name_normalized=public.normalize_card_name('アメモース'),
  card_number='006/PCG-P',
  rarity='プロモ',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-6/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アメモース',
  public.normalize_card_name('アメモース'),
  '006/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-6/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  6,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/PCG-P バシャーモ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='バシャーモ',
  name_normalized=public.normalize_card_name('バシャーモ'),
  card_number='007/PCG-P',
  rarity='プロモ',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-7/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'バシャーモ',
  public.normalize_card_name('バシャーモ'),
  '007/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-7/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  7,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/PCG-P アメタマ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アメタマ',
  name_normalized=public.normalize_card_name('アメタマ'),
  card_number='008/PCG-P',
  rarity='プロモ',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-8/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アメタマ',
  public.normalize_card_name('アメタマ'),
  '008/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-8/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  8,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/PCG-P プラスル
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='プラスル',
  name_normalized=public.normalize_card_name('プラスル'),
  card_number='009/PCG-P',
  rarity='プロモ',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-9/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'プラスル',
  public.normalize_card_name('プラスル'),
  '009/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-9/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  9,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/PCG-P マイナン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='マイナン',
  name_normalized=public.normalize_card_name('マイナン'),
  card_number='010/PCG-P',
  rarity='プロモ',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-10/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'マイナン',
  public.normalize_card_name('マイナン'),
  '010/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-10/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  10,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/PCG-P デオキシス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='デオキシス',
  name_normalized=public.normalize_card_name('デオキシス'),
  card_number='011/PCG-P',
  rarity='プロモ',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-11/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'デオキシス',
  public.normalize_card_name('デオキシス'),
  '011/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-11/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  11,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/PCG-P コータス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='コータス',
  name_normalized=public.normalize_card_name('コータス'),
  card_number='012/PCG-P',
  rarity='プロモ',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-12/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'コータス',
  public.normalize_card_name('コータス'),
  '012/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-12/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  12,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/PCG-P オオスバメ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='オオスバメ',
  name_normalized=public.normalize_card_name('オオスバメ'),
  card_number='013/PCG-P',
  rarity='プロモ',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-13/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'オオスバメ',
  public.normalize_card_name('オオスバメ'),
  '013/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-13/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  13,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/PCG-P レックウザ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レックウザ',
  name_normalized=public.normalize_card_name('レックウザ'),
  card_number='014/PCG-P',
  rarity='プロモ',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-14/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レックウザ',
  public.normalize_card_name('レックウザ'),
  '014/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-14/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  14,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/PCG-P ヤミカラス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ヤミカラス',
  name_normalized=public.normalize_card_name('ヤミカラス'),
  card_number='015/PCG-P',
  rarity='プロモ',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-15/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ヤミカラス',
  public.normalize_card_name('ヤミカラス'),
  '015/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-15/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  15,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/PCG-P メタグロス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='メタグロス',
  name_normalized=public.normalize_card_name('メタグロス'),
  card_number='016/PCG-P',
  rarity='プロモ',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-16/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'メタグロス',
  public.normalize_card_name('メタグロス'),
  '016/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-16/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  16,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/PCG-P デオキシス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='デオキシス',
  name_normalized=public.normalize_card_name('デオキシス'),
  card_number='017/PCG-P',
  rarity='プロモ',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-17/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'デオキシス',
  public.normalize_card_name('デオキシス'),
  '017/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-17/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  17,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/PCG-P 裂空のデオキシス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='裂空のデオキシス',
  name_normalized=public.normalize_card_name('裂空のデオキシス'),
  card_number='018/PCG-P',
  rarity='プロモ',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-18/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '裂空のデオキシス',
  public.normalize_card_name('裂空のデオキシス'),
  '018/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-18/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  18,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/PCG-P デオキシス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='デオキシス',
  name_normalized=public.normalize_card_name('デオキシス'),
  card_number='019/PCG-P',
  rarity='プロモ',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-19/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'デオキシス',
  public.normalize_card_name('デオキシス'),
  '019/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-19/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  19,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/PCG-P ラルースのゴンベ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラルースのゴンベ',
  name_normalized=public.normalize_card_name('ラルースのゴンベ'),
  card_number='020/PCG-P',
  rarity='プロモ',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-20/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラルースのゴンベ',
  public.normalize_card_name('ラルースのゴンベ'),
  '020/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-20/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  20,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='021/PCG-P',
  rarity='プロモ',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-21/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Subtypes Energy エネルギー supertype',
  public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  '021/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-21/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  21,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='022/PCG-P',
  rarity='プロモ',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-22/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Subtypes Energy エネルギー supertype',
  public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  '022/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-22/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  22,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/PCG-P ラブカス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラブカス',
  name_normalized=public.normalize_card_name('ラブカス'),
  card_number='023/PCG-P',
  rarity='プロモ',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-23/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラブカス',
  public.normalize_card_name('ラブカス'),
  '023/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-23/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  23,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/PCG-P Subtypes Trainer トレーナー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Trainer トレーナー supertype',
  name_normalized=public.normalize_card_name('Subtypes Trainer トレーナー supertype'),
  card_number='024/PCG-P',
  rarity='プロモ',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-24/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Subtypes Trainer トレーナー supertype',
  public.normalize_card_name('Subtypes Trainer トレーナー supertype'),
  '024/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-24/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  24,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/PCG-P ラルースのゴンベ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラルースのゴンベ',
  name_normalized=public.normalize_card_name('ラルースのゴンベ'),
  card_number='025/PCG-P',
  rarity='プロモ',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-25/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラルースのゴンベ',
  public.normalize_card_name('ラルースのゴンベ'),
  '025/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-25/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  25,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/PCG-P R団のライコウex
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='R団のライコウex',
  name_normalized=public.normalize_card_name('R団のライコウex'),
  card_number='026/PCG-P',
  rarity='プロモ',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-26/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'R団のライコウex',
  public.normalize_card_name('R団のライコウex'),
  '026/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-26/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  26,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/PCG-P デオキシスex
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='デオキシスex',
  name_normalized=public.normalize_card_name('デオキシスex'),
  card_number='027/PCG-P',
  rarity='プロモ',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-27/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'デオキシスex',
  public.normalize_card_name('デオキシスex'),
  '027/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-27/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  27,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/PCG-P チコリータ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='チコリータ',
  name_normalized=public.normalize_card_name('チコリータ'),
  card_number='028/PCG-P',
  rarity='プロモ',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-28/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'チコリータ',
  public.normalize_card_name('チコリータ'),
  '028/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-28/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  28,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/PCG-P ヒノアラシ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ヒノアラシ',
  name_normalized=public.normalize_card_name('ヒノアラシ'),
  card_number='029/PCG-P',
  rarity='プロモ',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-29/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ヒノアラシ',
  public.normalize_card_name('ヒノアラシ'),
  '029/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-29/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  29,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/PCG-P ワニノコ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ワニノコ',
  name_normalized=public.normalize_card_name('ワニノコ'),
  card_number='030/PCG-P',
  rarity='プロモ',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-30/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ワニノコ',
  public.normalize_card_name('ワニノコ'),
  '030/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-30/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  30,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/PCG-P ピチュー
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピチュー',
  name_normalized=public.normalize_card_name('ピチュー'),
  card_number='031/PCG-P',
  rarity='プロモ',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-31/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピチュー',
  public.normalize_card_name('ピチュー'),
  '031/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-31/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  31,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/PCG-P デオキシス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='デオキシス',
  name_normalized=public.normalize_card_name('デオキシス'),
  card_number='032/PCG-P',
  rarity='プロモ',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-32/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'デオキシス',
  public.normalize_card_name('デオキシス'),
  '032/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-32/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  32,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/PCG-P ヨーギラス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ヨーギラス',
  name_normalized=public.normalize_card_name('ヨーギラス'),
  card_number='033/PCG-P',
  rarity='プロモ',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-33/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ヨーギラス',
  public.normalize_card_name('ヨーギラス'),
  '033/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-33/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  33,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/PCG-P トゲピー
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='トゲピー',
  name_normalized=public.normalize_card_name('トゲピー'),
  card_number='034/PCG-P',
  rarity='プロモ',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-34/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'トゲピー',
  public.normalize_card_name('トゲピー'),
  '034/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-34/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  34,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/PCG-P R団のライコウex
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='R団のライコウex',
  name_normalized=public.normalize_card_name('R団のライコウex'),
  card_number='035/PCG-P',
  rarity='プロモ',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-35/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'R団のライコウex',
  public.normalize_card_name('R団のライコウex'),
  '035/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-35/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  35,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/PCG-P R団のペルシアンex
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='R団のペルシアンex',
  name_normalized=public.normalize_card_name('R団のペルシアンex'),
  card_number='036/PCG-P',
  rarity='プロモ',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-36/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'R団のペルシアンex',
  public.normalize_card_name('R団のペルシアンex'),
  '036/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-36/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  36,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/PCG-P キモリ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='キモリ',
  name_normalized=public.normalize_card_name('キモリ'),
  card_number='037/PCG-P',
  rarity='プロモ',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-37/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'キモリ',
  public.normalize_card_name('キモリ'),
  '037/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-37/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  37,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/PCG-P ルギア
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ルギア',
  name_normalized=public.normalize_card_name('ルギア'),
  card_number='038/PCG-P',
  rarity='プロモ',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-38/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ルギア',
  public.normalize_card_name('ルギア'),
  '038/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-38/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  38,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/PCG-P スイクン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='スイクン',
  name_normalized=public.normalize_card_name('スイクン'),
  card_number='039/PCG-P',
  rarity='プロモ',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-39/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'スイクン',
  public.normalize_card_name('スイクン'),
  '039/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-39/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  39,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/PCG-P ポケパークのゴンベ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのゴンベ',
  name_normalized=public.normalize_card_name('ポケパークのゴンベ'),
  card_number='040/PCG-P',
  rarity='プロモ',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-40/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのゴンベ',
  public.normalize_card_name('ポケパークのゴンベ'),
  '040/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-40/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  40,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/PCG-P レックウザ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レックウザ',
  name_normalized=public.normalize_card_name('レックウザ'),
  card_number='041/PCG-P',
  rarity='プロモ',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-41/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レックウザ',
  public.normalize_card_name('レックウザ'),
  '041/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-41/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  41,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/PCG-P グラードン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='グラードン',
  name_normalized=public.normalize_card_name('グラードン'),
  card_number='042/PCG-P',
  rarity='プロモ',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-42/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'グラードン',
  public.normalize_card_name('グラードン'),
  '042/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-42/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  42,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/PCG-P ポケパークのピカチュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのピカチュウ',
  name_normalized=public.normalize_card_name('ポケパークのピカチュウ'),
  card_number='043/PCG-P',
  rarity='プロモ',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-43/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのピカチュウ',
  public.normalize_card_name('ポケパークのピカチュウ'),
  '043/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-43/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  43,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/PCG-P ポケパークのセレビィ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのセレビィ',
  name_normalized=public.normalize_card_name('ポケパークのセレビィ'),
  card_number='044/PCG-P',
  rarity='プロモ',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-44/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのセレビィ',
  public.normalize_card_name('ポケパークのセレビィ'),
  '044/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-44/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  44,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/PCG-P ポケパークのラティオス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのラティオス',
  name_normalized=public.normalize_card_name('ポケパークのラティオス'),
  card_number='045/PCG-P',
  rarity='プロモ',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-45/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのラティオス',
  public.normalize_card_name('ポケパークのラティオス'),
  '045/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-45/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  45,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/PCG-P ポケパークのゴニョニョ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのゴニョニョ',
  name_normalized=public.normalize_card_name('ポケパークのゴニョニョ'),
  card_number='046/PCG-P',
  rarity='プロモ',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-46/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのゴニョニョ',
  public.normalize_card_name('ポケパークのゴニョニョ'),
  '046/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-46/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  46,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/PCG-P ポケパークのアチャモ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのアチャモ',
  name_normalized=public.normalize_card_name('ポケパークのアチャモ'),
  card_number='047/PCG-P',
  rarity='プロモ',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-47/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのアチャモ',
  public.normalize_card_name('ポケパークのアチャモ'),
  '047/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-47/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  47,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/PCG-P ポケパークのミズゴロウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのミズゴロウ',
  name_normalized=public.normalize_card_name('ポケパークのミズゴロウ'),
  card_number='048/PCG-P',
  rarity='プロモ',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-48/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのミズゴロウ',
  public.normalize_card_name('ポケパークのミズゴロウ'),
  '048/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-48/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  48,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/PCG-P ケンタロス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ケンタロス',
  name_normalized=public.normalize_card_name('ケンタロス'),
  card_number='049/PCG-P',
  rarity='プロモ',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-49/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ケンタロス',
  public.normalize_card_name('ケンタロス'),
  '049/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-49/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  49,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/PCG-P ポケパークのジラーチ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポケパークのジラーチ',
  name_normalized=public.normalize_card_name('ポケパークのジラーチ'),
  card_number='050/PCG-P',
  rarity='プロモ',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-50/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポケパークのジラーチ',
  public.normalize_card_name('ポケパークのジラーチ'),
  '050/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-50/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  50,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/PCG-P バクフーン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='バクフーン',
  name_normalized=public.normalize_card_name('バクフーン'),
  card_number='051/PCG-P',
  rarity='プロモ',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-51/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'バクフーン',
  public.normalize_card_name('バクフーン'),
  '051/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-51/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  51,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/PCG-P セレビィex
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='セレビィex',
  name_normalized=public.normalize_card_name('セレビィex'),
  card_number='052/PCG-P',
  rarity='プロモ',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-52/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'セレビィex',
  public.normalize_card_name('セレビィex'),
  '052/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-52/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  52,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/PCG-P R団のペルシアンex
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='R団のペルシアンex',
  name_normalized=public.normalize_card_name('R団のペルシアンex'),
  card_number='053/PCG-P',
  rarity='プロモ',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-53/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'R団のペルシアンex',
  public.normalize_card_name('R団のペルシアンex'),
  '053/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-53/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  53,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='054/PCG-P',
  rarity='プロモ',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-54/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Subtypes Energy エネルギー supertype',
  public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  '054/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-54/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  54,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

commit;
