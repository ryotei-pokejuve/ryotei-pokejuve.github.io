-- ADV-P プロモーションカード / Supabase SQL Editor用
begin;

update public.card_sets
set
  name='ADV-P プロモーションカード',
  tcgdex_series_id='ADV',
  series_name='ADV・PCGシリーズ'
where code='ADVP';

insert into public.card_sets
  (name, code, tcgdex_series_id, series_name)
select
  'ADV-P プロモーションカード', 'ADVP', 'ADV', 'ADV・PCGシリーズ'
where not exists (
  select 1 from public.card_sets where code='ADVP'
);

-- 001/ADV-P Kyogre EX
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='Kyogre EX',
  name_normalized=public.normalize_card_name('Kyogre EX'),
  card_number='001/ADV-P',
  rarity='プロモ',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/advp_ja-1/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Kyogre EX',
  public.normalize_card_name('Kyogre EX'),
  '001/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-1/large',
  'Scrydex public card image (advp_ja)',
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

-- 002/ADV-P Groudon EX
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='Groudon EX',
  name_normalized=public.normalize_card_name('Groudon EX'),
  card_number='002/ADV-P',
  rarity='プロモ',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/advp_ja-2/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Groudon EX',
  public.normalize_card_name('Groudon EX'),
  '002/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-2/large',
  'Scrydex public card image (advp_ja)',
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

-- 003/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='003/ADV-P',
  rarity='プロモ',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/advp_ja-3/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '003/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-3/large',
  'Scrydex public card image (advp_ja)',
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

-- 004/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='004/ADV-P',
  rarity='プロモ',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/advp_ja-4/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '004/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-4/large',
  'Scrydex public card image (advp_ja)',
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

-- 005/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='005/ADV-P',
  rarity='プロモ',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/advp_ja-5/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '005/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-5/large',
  'Scrydex public card image (advp_ja)',
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

-- 006/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='006/ADV-P',
  rarity='プロモ',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/advp_ja-6/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '006/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-6/large',
  'Scrydex public card image (advp_ja)',
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

-- 007/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='007/ADV-P',
  rarity='プロモ',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/advp_ja-7/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '007/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-7/large',
  'Scrydex public card image (advp_ja)',
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

-- 008/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='008/ADV-P',
  rarity='プロモ',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/advp_ja-8/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '008/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-8/large',
  'Scrydex public card image (advp_ja)',
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

-- 009/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='009/ADV-P',
  rarity='プロモ',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/advp_ja-9/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '009/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-9/large',
  'Scrydex public card image (advp_ja)',
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

-- 010/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='010/ADV-P',
  rarity='プロモ',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/advp_ja-10/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '010/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-10/large',
  'Scrydex public card image (advp_ja)',
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

-- 011/ADV-P Kyogre EX
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='Kyogre EX',
  name_normalized=public.normalize_card_name('Kyogre EX'),
  card_number='011/ADV-P',
  rarity='プロモ',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/advp_ja-11/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Kyogre EX',
  public.normalize_card_name('Kyogre EX'),
  '011/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-11/large',
  'Scrydex public card image (advp_ja)',
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

-- 012/ADV-P Groudon EX
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='Groudon EX',
  name_normalized=public.normalize_card_name('Groudon EX'),
  card_number='012/ADV-P',
  rarity='プロモ',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/advp_ja-12/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Groudon EX',
  public.normalize_card_name('Groudon EX'),
  '012/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-12/large',
  'Scrydex public card image (advp_ja)',
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

-- 013/ADV-P Armaldo EX
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='Armaldo EX',
  name_normalized=public.normalize_card_name('Armaldo EX'),
  card_number='013/ADV-P',
  rarity='プロモ',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/advp_ja-13/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Armaldo EX',
  public.normalize_card_name('Armaldo EX'),
  '013/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-13/large',
  'Scrydex public card image (advp_ja)',
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

-- 014/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='014/ADV-P',
  rarity='プロモ',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/advp_ja-14/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '014/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-14/large',
  'Scrydex public card image (advp_ja)',
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

-- 015/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='015/ADV-P',
  rarity='プロモ',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/advp_ja-15/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '015/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-15/large',
  'Scrydex public card image (advp_ja)',
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

-- 016/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='016/ADV-P',
  rarity='プロモ',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/advp_ja-16/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '016/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-16/large',
  'Scrydex public card image (advp_ja)',
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

-- 017/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='017/ADV-P',
  rarity='プロモ',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/advp_ja-17/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '017/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-17/large',
  'Scrydex public card image (advp_ja)',
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

-- 018/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='018/ADV-P',
  rarity='プロモ',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/advp_ja-18/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '018/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-18/large',
  'Scrydex public card image (advp_ja)',
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

-- 019/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='019/ADV-P',
  rarity='プロモ',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/advp_ja-19/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '019/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-19/large',
  'Scrydex public card image (advp_ja)',
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

-- 020/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='020/ADV-P',
  rarity='プロモ',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/advp_ja-20/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '020/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-20/large',
  'Scrydex public card image (advp_ja)',
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

-- 021/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='021/ADV-P',
  rarity='プロモ',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/advp_ja-21/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '021/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-21/large',
  'Scrydex public card image (advp_ja)',
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

-- 022/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='022/ADV-P',
  rarity='プロモ',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/advp_ja-22/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '022/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-22/large',
  'Scrydex public card image (advp_ja)',
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

-- 023/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='023/ADV-P',
  rarity='プロモ',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/advp_ja-23/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '023/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-23/large',
  'Scrydex public card image (advp_ja)',
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

-- 024/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='024/ADV-P',
  rarity='プロモ',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/advp_ja-24/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '024/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-24/large',
  'Scrydex public card image (advp_ja)',
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

-- 025/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='025/ADV-P',
  rarity='プロモ',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/advp_ja-25/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '025/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-25/large',
  'Scrydex public card image (advp_ja)',
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

-- 026/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='026/ADV-P',
  rarity='プロモ',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/advp_ja-26/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '026/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-26/large',
  'Scrydex public card image (advp_ja)',
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

-- 027/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='027/ADV-P',
  rarity='プロモ',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/advp_ja-27/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '027/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-27/large',
  'Scrydex public card image (advp_ja)',
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

-- 028/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='028/ADV-P',
  rarity='プロモ',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/advp_ja-28/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '028/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-28/large',
  'Scrydex public card image (advp_ja)',
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

-- 029/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='029/ADV-P',
  rarity='プロモ',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/advp_ja-29/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '029/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-29/large',
  'Scrydex public card image (advp_ja)',
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

-- 030/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='030/ADV-P',
  rarity='プロモ',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/advp_ja-30/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '030/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-30/large',
  'Scrydex public card image (advp_ja)',
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

-- 031/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='031/ADV-P',
  rarity='プロモ',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/advp_ja-31/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '031/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-31/large',
  'Scrydex public card image (advp_ja)',
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

-- 032/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='032/ADV-P',
  rarity='プロモ',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/advp_ja-32/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '032/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-32/large',
  'Scrydex public card image (advp_ja)',
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

-- 033/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='033/ADV-P',
  rarity='プロモ',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/advp_ja-33/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '033/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-33/large',
  'Scrydex public card image (advp_ja)',
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

-- 034/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='034/ADV-P',
  rarity='プロモ',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/advp_ja-34/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '034/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-34/large',
  'Scrydex public card image (advp_ja)',
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

-- 035/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='035/ADV-P',
  rarity='プロモ',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/advp_ja-35/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '035/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-35/large',
  'Scrydex public card image (advp_ja)',
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

-- 036/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='036/ADV-P',
  rarity='プロモ',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/advp_ja-36/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '036/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-36/large',
  'Scrydex public card image (advp_ja)',
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

-- 037/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='037/ADV-P',
  rarity='プロモ',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/advp_ja-37/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '037/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-37/large',
  'Scrydex public card image (advp_ja)',
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

-- 038/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='038/ADV-P',
  rarity='プロモ',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/advp_ja-38/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '038/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-38/large',
  'Scrydex public card image (advp_ja)',
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

-- 039/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='039/ADV-P',
  rarity='プロモ',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/advp_ja-39/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '039/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-39/large',
  'Scrydex public card image (advp_ja)',
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

-- 040/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='040/ADV-P',
  rarity='プロモ',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/advp_ja-40/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '040/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-40/large',
  'Scrydex public card image (advp_ja)',
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

-- 041/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='041/ADV-P',
  rarity='プロモ',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/advp_ja-41/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '041/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-41/large',
  'Scrydex public card image (advp_ja)',
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

-- 042/ADV-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='042/ADV-P',
  rarity='プロモ',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/advp_ja-42/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Subtypes Energy エネルギー supertype',
  public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  '042/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-42/large',
  'Scrydex public card image (advp_ja)',
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

-- 043/ADV-P Subtypes Trainer トレーナー supertype
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='Subtypes Trainer トレーナー supertype',
  name_normalized=public.normalize_card_name('Subtypes Trainer トレーナー supertype'),
  card_number='043/ADV-P',
  rarity='プロモ',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/advp_ja-43/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Subtypes Trainer トレーナー supertype',
  public.normalize_card_name('Subtypes Trainer トレーナー supertype'),
  '043/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-43/large',
  'Scrydex public card image (advp_ja)',
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

-- 044/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='044/ADV-P',
  rarity='プロモ',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/advp_ja-44/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '044/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-44/large',
  'Scrydex public card image (advp_ja)',
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

-- 045/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='045/ADV-P',
  rarity='プロモ',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/advp_ja-45/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '045/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-45/large',
  'Scrydex public card image (advp_ja)',
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

-- 046/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='046/ADV-P',
  rarity='プロモ',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/advp_ja-46/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '046/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-46/large',
  'Scrydex public card image (advp_ja)',
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

-- 047/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='047/ADV-P',
  rarity='プロモ',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/advp_ja-47/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '047/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-47/large',
  'Scrydex public card image (advp_ja)',
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

-- 048/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='048/ADV-P',
  rarity='プロモ',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/advp_ja-48/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '048/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-48/large',
  'Scrydex public card image (advp_ja)',
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

-- 049/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='049/ADV-P',
  rarity='プロモ',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/advp_ja-49/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '049/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-49/large',
  'Scrydex public card image (advp_ja)',
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

-- 050/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='050/ADV-P',
  rarity='プロモ',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/advp_ja-50/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '050/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-50/large',
  'Scrydex public card image (advp_ja)',
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

-- 051/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='051/ADV-P',
  rarity='プロモ',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/advp_ja-51/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '051/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-51/large',
  'Scrydex public card image (advp_ja)',
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

-- 052/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='052/ADV-P',
  rarity='プロモ',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/advp_ja-52/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '052/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-52/large',
  'Scrydex public card image (advp_ja)',
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

-- 053/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='053/ADV-P',
  rarity='プロモ',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/advp_ja-53/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '053/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-53/large',
  'Scrydex public card image (advp_ja)',
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

-- 054/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='054/ADV-P',
  rarity='プロモ',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/advp_ja-54/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '054/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-54/large',
  'Scrydex public card image (advp_ja)',
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

-- 055/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='055/ADV-P',
  rarity='プロモ',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/advp_ja-55/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '055/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-55/large',
  'Scrydex public card image (advp_ja)',
  true,
  55,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='056/ADV-P',
  rarity='プロモ',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/advp_ja-56/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '056/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-56/large',
  'Scrydex public card image (advp_ja)',
  true,
  56,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='057/ADV-P',
  rarity='プロモ',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/advp_ja-57/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '057/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-57/large',
  'Scrydex public card image (advp_ja)',
  true,
  57,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='058/ADV-P',
  rarity='プロモ',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/advp_ja-58/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '058/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-58/large',
  'Scrydex public card image (advp_ja)',
  true,
  58,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='059/ADV-P',
  rarity='プロモ',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/advp_ja-59/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '059/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-59/large',
  'Scrydex public card image (advp_ja)',
  true,
  59,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='060/ADV-P',
  rarity='プロモ',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/advp_ja-60/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '060/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-60/large',
  'Scrydex public card image (advp_ja)',
  true,
  60,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='061/ADV-P',
  rarity='プロモ',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/advp_ja-61/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '061/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-61/large',
  'Scrydex public card image (advp_ja)',
  true,
  61,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='062/ADV-P',
  rarity='プロモ',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/advp_ja-62/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '062/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-62/large',
  'Scrydex public card image (advp_ja)',
  true,
  62,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/ADV-P supertype string The supertype such as Pokemon or Trainer ポケモン
with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
update public.cards c
set
  name='supertype string The supertype such as Pokemon or Trainer ポケモン',
  name_normalized=public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  card_number='063/ADV-P',
  rarity='プロモ',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/advp_ja-63/large',
  image_source_note='Scrydex public card image (advp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (
  select id from public.card_sets where code='ADVP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'supertype string The supertype such as Pokemon or Trainer ポケモン',
  public.normalize_card_name('supertype string The supertype such as Pokemon or Trainer ポケモン'),
  '063/ADV-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/advp_ja-63/large',
  'Scrydex public card image (advp_ja)',
  true,
  63,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

commit;

-- 監査
select
  cs.code,
  cs.name,
  count(*) as total,
  count(distinct c.set_order) as unique_numbers,
  min(c.set_order) as min_number,
  max(c.set_order) as max_number,
  count(*) filter (where c.rarity='プロモ') as promo_rarity,
  count(*) filter (
    where c.image_url like 'https://images.scrydex.com/pokemon/advp_ja-%/large'
  ) as scrydex_images
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code='ADVP'
group by cs.code, cs.name;

-- 件数が違えば1行返る。0 rows が正常。
select
  'ADVP' as code,
  63 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code='ADVP'
having count(distinct c.set_order) <> 63;

-- set_order重複。0 rows が正常。
select c.set_order, count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code='ADVP'
group by c.set_order
having count(*) > 1
order by c.set_order;
