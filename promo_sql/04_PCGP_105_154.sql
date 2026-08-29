-- PCG-P プロモーションカード / Supabase SQL Editor用
begin;

-- 105/PCG-P ヘイガニ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ヘイガニ',
  name_normalized=public.normalize_card_name('ヘイガニ'),
  card_number='105/PCG-P',
  rarity='プロモ',
  set_order=105,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-105/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '105';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ヘイガニ',
  public.normalize_card_name('ヘイガニ'),
  '105/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-105/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  105,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '105'
);

-- 106/PCG-P サンダース
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='サンダース',
  name_normalized=public.normalize_card_name('サンダース'),
  card_number='106/PCG-P',
  rarity='プロモ',
  set_order=106,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-106/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '106';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'サンダース',
  public.normalize_card_name('サンダース'),
  '106/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-106/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  106,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '106'
);

-- 107/PCG-P ミュウツーδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ミュウツーδ-デルタ種',
  name_normalized=public.normalize_card_name('ミュウツーδ-デルタ種'),
  card_number='107/PCG-P',
  rarity='プロモ',
  set_order=107,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-107/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '107';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ミュウツーδ-デルタ種',
  public.normalize_card_name('ミュウツーδ-デルタ種'),
  '107/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-107/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  107,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '107'
);

-- 108/PCG-P メタモン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  card_number='108/PCG-P',
  rarity='プロモ',
  set_order=108,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-108/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '108';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'メタモン',
  public.normalize_card_name('メタモン'),
  '108/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-108/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  108,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '108'
);

-- 109/PCG-P ドンファン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ドンファン',
  name_normalized=public.normalize_card_name('ドンファン'),
  card_number='109/PCG-P',
  rarity='プロモ',
  set_order=109,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-109/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '109';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ドンファン',
  public.normalize_card_name('ドンファン'),
  '109/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-109/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  109,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '109'
);

-- 110/PCG-P ヌマクロー
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ヌマクロー',
  name_normalized=public.normalize_card_name('ヌマクロー'),
  card_number='110/PCG-P',
  rarity='プロモ',
  set_order=110,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-110/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '110';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ヌマクロー',
  public.normalize_card_name('ヌマクロー'),
  '110/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-110/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  110,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '110'
);

-- 111/PCG-P イーブイ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='イーブイ',
  name_normalized=public.normalize_card_name('イーブイ'),
  card_number='111/PCG-P',
  rarity='プロモ',
  set_order=111,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-111/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '111';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'イーブイ',
  public.normalize_card_name('イーブイ'),
  '111/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-111/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  111,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '111'
);

-- 112/PCG-P ピカチュウδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピカチュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ピカチュウδ-デルタ種'),
  card_number='112/PCG-P',
  rarity='プロモ',
  set_order=112,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-112/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '112';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピカチュウδ-デルタ種',
  public.normalize_card_name('ピカチュウδ-デルタ種'),
  '112/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-112/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  112,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '112'
);

-- 113/PCG-P ピカチュウδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピカチュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ピカチュウδ-デルタ種'),
  card_number='113/PCG-P',
  rarity='プロモ',
  set_order=113,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-113/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '113';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピカチュウδ-デルタ種',
  public.normalize_card_name('ピカチュウδ-デルタ種'),
  '113/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-113/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  113,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '113'
);

-- 114/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='114/PCG-P',
  rarity='プロモ',
  set_order=114,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-114/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '114';

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
  '114/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-114/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  114,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '114'
);

-- 115/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='115/PCG-P',
  rarity='プロモ',
  set_order=115,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-115/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '115';

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
  '115/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-115/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  115,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '115'
);

-- 116/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='116/PCG-P',
  rarity='プロモ',
  set_order=116,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-116/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '116';

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
  '116/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-116/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  116,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '116'
);

-- 118/PCG-P ピカチュウδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピカチュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ピカチュウδ-デルタ種'),
  card_number='118/PCG-P',
  rarity='プロモ',
  set_order=118,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-118/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '118';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピカチュウδ-デルタ種',
  public.normalize_card_name('ピカチュウδ-デルタ種'),
  '118/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-118/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  118,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '118'
);

-- 119/PCG-P ジュカイン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ジュカイン',
  name_normalized=public.normalize_card_name('ジュカイン'),
  card_number='119/PCG-P',
  rarity='プロモ',
  set_order=119,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-119/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '119';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ジュカイン',
  public.normalize_card_name('ジュカイン'),
  '119/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-119/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  119,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '119'
);

-- 120/PCG-P ラティアスδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラティアスδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティアスδ-デルタ種'),
  card_number='120/PCG-P',
  rarity='プロモ',
  set_order=120,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-120/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '120';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラティアスδ-デルタ種',
  public.normalize_card_name('ラティアスδ-デルタ種'),
  '120/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-120/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  120,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '120'
);

-- 121/PCG-P ゼニガメ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ゼニガメ',
  name_normalized=public.normalize_card_name('ゼニガメ'),
  card_number='121/PCG-P',
  rarity='プロモ',
  set_order=121,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-121/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '121';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ゼニガメ',
  public.normalize_card_name('ゼニガメ'),
  '121/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-121/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  121,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '121'
);

-- 122/PCG-P ラティオスδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラティオスδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティオスδ-デルタ種'),
  card_number='122/PCG-P',
  rarity='プロモ',
  set_order=122,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-122/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '122';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラティオスδ-デルタ種',
  public.normalize_card_name('ラティオスδ-デルタ種'),
  '122/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-122/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  122,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '122'
);

-- 123/PCG-P ピカチュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピカチュウ',
  name_normalized=public.normalize_card_name('ピカチュウ'),
  card_number='123/PCG-P',
  rarity='プロモ',
  set_order=123,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-123/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '123';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピカチュウ',
  public.normalize_card_name('ピカチュウ'),
  '123/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-123/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  123,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '123'
);

-- 124/PCG-P ソーナンス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ソーナンス',
  name_normalized=public.normalize_card_name('ソーナンス'),
  card_number='124/PCG-P',
  rarity='プロモ',
  set_order=124,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-124/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '124';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ソーナンス',
  public.normalize_card_name('ソーナンス'),
  '124/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-124/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  124,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '124'
);

-- 125/PCG-P フライゴン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='フライゴン',
  name_normalized=public.normalize_card_name('フライゴン'),
  card_number='125/PCG-P',
  rarity='プロモ',
  set_order=125,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-125/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '125';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'フライゴン',
  public.normalize_card_name('フライゴン'),
  '125/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-125/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  125,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '125'
);

-- 126/PCG-P ポッポ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ポッポ',
  name_normalized=public.normalize_card_name('ポッポ'),
  card_number='126/PCG-P',
  rarity='プロモ',
  set_order=126,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-126/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '126';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ポッポ',
  public.normalize_card_name('ポッポ'),
  '126/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-126/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  126,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '126'
);

-- 127/PCG-P ニャースδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ニャースδ-デルタ種',
  name_normalized=public.normalize_card_name('ニャースδ-デルタ種'),
  card_number='127/PCG-P',
  rarity='プロモ',
  set_order=127,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-127/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '127';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ニャースδ-デルタ種',
  public.normalize_card_name('ニャースδ-デルタ種'),
  '127/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-127/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  127,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '127'
);

-- 128/PCG-P チリーンδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='チリーンδ-デルタ種',
  name_normalized=public.normalize_card_name('チリーンδ-デルタ種'),
  card_number='128/PCG-P',
  rarity='プロモ',
  set_order=128,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-128/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '128';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'チリーンδ-デルタ種',
  public.normalize_card_name('チリーンδ-デルタ種'),
  '128/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-128/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  128,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '128'
);

-- 129/PCG-P デオキシスδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='デオキシスδ-デルタ種',
  name_normalized=public.normalize_card_name('デオキシスδ-デルタ種'),
  card_number='129/PCG-P',
  rarity='プロモ',
  set_order=129,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-129/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '129';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'デオキシスδ-デルタ種',
  public.normalize_card_name('デオキシスδ-デルタ種'),
  '129/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-129/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  129,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '129'
);

-- 130/PCG-P Subtypes Trainer トレーナー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Trainer トレーナー supertype',
  name_normalized=public.normalize_card_name('Subtypes Trainer トレーナー supertype'),
  card_number='130/PCG-P',
  rarity='プロモ',
  set_order=130,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-130/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '130';

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
  '130/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-130/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  130,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '130'
);

-- 131/PCG-P キモリδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='キモリδ-デルタ種',
  name_normalized=public.normalize_card_name('キモリδ-デルタ種'),
  card_number='131/PCG-P',
  rarity='プロモ',
  set_order=131,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-131/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '131';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'キモリδ-デルタ種',
  public.normalize_card_name('キモリδ-デルタ種'),
  '131/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-131/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  131,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '131'
);

-- 132/PCG-P ヒトカゲδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ヒトカゲδ-デルタ種',
  name_normalized=public.normalize_card_name('ヒトカゲδ-デルタ種'),
  card_number='132/PCG-P',
  rarity='プロモ',
  set_order=132,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-132/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '132';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ヒトカゲδ-デルタ種',
  public.normalize_card_name('ヒトカゲδ-デルタ種'),
  '132/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-132/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  132,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '132'
);

-- 133/PCG-P リザードδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='リザードδ-デルタ種',
  name_normalized=public.normalize_card_name('リザードδ-デルタ種'),
  card_number='133/PCG-P',
  rarity='プロモ',
  set_order=133,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-133/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '133';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'リザードδ-デルタ種',
  public.normalize_card_name('リザードδ-デルタ種'),
  '133/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-133/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  133,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '133'
);

-- 134/PCG-P ハブネーク
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ハブネーク',
  name_normalized=public.normalize_card_name('ハブネーク'),
  card_number='134/PCG-P',
  rarity='プロモ',
  set_order=134,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-134/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '134';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ハブネーク',
  public.normalize_card_name('ハブネーク'),
  '134/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-134/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  134,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '134'
);

-- 135/PCG-P ホウオウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ホウオウ',
  name_normalized=public.normalize_card_name('ホウオウ'),
  card_number='135/PCG-P',
  rarity='プロモ',
  set_order=135,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-135/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '135';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ホウオウ',
  public.normalize_card_name('ホウオウ'),
  '135/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-135/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  135,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '135'
);

-- 136/PCG-P ワカシャモ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ワカシャモ',
  name_normalized=public.normalize_card_name('ワカシャモ'),
  card_number='136/PCG-P',
  rarity='プロモ',
  set_order=136,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-136/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '136';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ワカシャモ',
  public.normalize_card_name('ワカシャモ'),
  '136/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-136/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  136,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '136'
);

-- 137/PCG-P アクーシャのタマンタ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アクーシャのタマンタ',
  name_normalized=public.normalize_card_name('アクーシャのタマンタ'),
  card_number='137/PCG-P',
  rarity='プロモ',
  set_order=137,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-137/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '137';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アクーシャのタマンタ',
  public.normalize_card_name('アクーシャのタマンタ'),
  '137/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-137/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  137,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '137'
);

-- 138/PCG-P アクーシャのブイゼル
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アクーシャのブイゼル',
  name_normalized=public.normalize_card_name('アクーシャのブイゼル'),
  card_number='138/PCG-P',
  rarity='プロモ',
  set_order=138,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-138/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '138';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アクーシャのブイゼル',
  public.normalize_card_name('アクーシャのブイゼル'),
  '138/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-138/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  138,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '138'
);

-- 139/PCG-P 蒼海のマナフィ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='蒼海のマナフィ',
  name_normalized=public.normalize_card_name('蒼海のマナフィ'),
  card_number='139/PCG-P',
  rarity='プロモ',
  set_order=139,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-139/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '139';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '蒼海のマナフィ',
  public.normalize_card_name('蒼海のマナフィ'),
  '139/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-139/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  139,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '139'
);

-- 140/PCG-P ペリッパーδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ペリッパーδ-デルタ種',
  name_normalized=public.normalize_card_name('ペリッパーδ-デルタ種'),
  card_number='140/PCG-P',
  rarity='プロモ',
  set_order=140,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-140/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '140';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ペリッパーδ-デルタ種',
  public.normalize_card_name('ペリッパーδ-デルタ種'),
  '140/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-140/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  140,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '140'
);

-- 141/PCG-P ルギア
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ルギア',
  name_normalized=public.normalize_card_name('ルギア'),
  card_number='141/PCG-P',
  rarity='プロモ',
  set_order=141,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-141/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '141';

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
  '141/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-141/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  141,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '141'
);

-- 142/PCG-P アサナン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アサナン',
  name_normalized=public.normalize_card_name('アサナン'),
  card_number='142/PCG-P',
  rarity='プロモ',
  set_order=142,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-142/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '142';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アサナン',
  public.normalize_card_name('アサナン'),
  '142/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-142/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  142,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '142'
);

-- 143/PCG-P アクーシャのペラップ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アクーシャのペラップ',
  name_normalized=public.normalize_card_name('アクーシャのペラップ'),
  card_number='143/PCG-P',
  rarity='プロモ',
  set_order=143,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-143/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '143';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アクーシャのペラップ',
  public.normalize_card_name('アクーシャのペラップ'),
  '143/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-143/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  143,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '143'
);

-- 144/PCG-P サメハダー
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='サメハダー',
  name_normalized=public.normalize_card_name('サメハダー'),
  card_number='144/PCG-P',
  rarity='プロモ',
  set_order=144,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-144/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '144';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'サメハダー',
  public.normalize_card_name('サメハダー'),
  '144/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-144/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  144,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '144'
);

-- 145/PCG-P ザングースδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ザングースδ-デルタ種',
  name_normalized=public.normalize_card_name('ザングースδ-デルタ種'),
  card_number='145/PCG-P',
  rarity='プロモ',
  set_order=145,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-145/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '145';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ザングースδ-デルタ種',
  public.normalize_card_name('ザングースδ-デルタ種'),
  '145/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-145/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  145,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '145'
);

-- 146/PCG-P 蒼海のマナフィ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='蒼海のマナフィ',
  name_normalized=public.normalize_card_name('蒼海のマナフィ'),
  card_number='146/PCG-P',
  rarity='プロモ',
  set_order=146,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-146/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '146';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '蒼海のマナフィ',
  public.normalize_card_name('蒼海のマナフィ'),
  '146/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-146/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  146,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '146'
);

-- 147/PCG-P 蒼海のマナフィ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='蒼海のマナフィ',
  name_normalized=public.normalize_card_name('蒼海のマナフィ'),
  card_number='147/PCG-P',
  rarity='プロモ',
  set_order=147,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-147/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '147';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '蒼海のマナフィ',
  public.normalize_card_name('蒼海のマナフィ'),
  '147/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-147/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  147,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '147'
);

-- 148/PCG-P ミュウδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ミュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ミュウδ-デルタ種'),
  card_number='148/PCG-P',
  rarity='プロモ',
  set_order=148,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-148/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '148';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ミュウδ-デルタ種',
  public.normalize_card_name('ミュウδ-デルタ種'),
  '148/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-148/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  148,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '148'
);

-- 149/PCG-P Subtypes Energy エネルギー supertype Delta Species Delta Species subtypes
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype Delta Species Delta Species subtypes',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype Delta Species Delta Species subtypes'),
  card_number='149/PCG-P',
  rarity='プロモ',
  set_order=149,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-149/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '149';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'Subtypes Energy エネルギー supertype Delta Species Delta Species subtypes',
  public.normalize_card_name('Subtypes Energy エネルギー supertype Delta Species Delta Species subtypes'),
  '149/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-149/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  149,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '149'
);

-- 150/PCG-P 蒼海のマナフィ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='蒼海のマナフィ',
  name_normalized=public.normalize_card_name('蒼海のマナフィ'),
  card_number='150/PCG-P',
  rarity='プロモ',
  set_order=150,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-150/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '150';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '蒼海のマナフィ',
  public.normalize_card_name('蒼海のマナフィ'),
  '150/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-150/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  150,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '150'
);

-- 151/PCG-P アクーシャのブイゼル
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アクーシャのブイゼル',
  name_normalized=public.normalize_card_name('アクーシャのブイゼル'),
  card_number='151/PCG-P',
  rarity='プロモ',
  set_order=151,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-151/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '151';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アクーシャのブイゼル',
  public.normalize_card_name('アクーシャのブイゼル'),
  '151/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-151/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  151,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '151'
);

-- 152/PCG-P アクーシャのペラップ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='アクーシャのペラップ',
  name_normalized=public.normalize_card_name('アクーシャのペラップ'),
  card_number='152/PCG-P',
  rarity='プロモ',
  set_order=152,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-152/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '152';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'アクーシャのペラップ',
  public.normalize_card_name('アクーシャのペラップ'),
  '152/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-152/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  152,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '152'
);

-- 153/PCG-P ピカチュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピカチュウ',
  name_normalized=public.normalize_card_name('ピカチュウ'),
  card_number='153/PCG-P',
  rarity='プロモ',
  set_order=153,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-153/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '153';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピカチュウ',
  public.normalize_card_name('ピカチュウ'),
  '153/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-153/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  153,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '153'
);

-- 154/PCG-P 蒼海のマナフィ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='蒼海のマナフィ',
  name_normalized=public.normalize_card_name('蒼海のマナフィ'),
  card_number='154/PCG-P',
  rarity='プロモ',
  set_order=154,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-154/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '154';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '蒼海のマナフィ',
  public.normalize_card_name('蒼海のマナフィ'),
  '154/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-154/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  154,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '154'
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
    where c.image_url like 'https://images.scrydex.com/pokemon/pcgp_ja-%/large'
  ) as scrydex_images
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code='PCGP'
group by cs.code, cs.name;

-- 件数が違えば1行返る。0 rows が正常。
select
  'PCGP' as code,
  153 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code='PCGP'
having count(distinct c.set_order) <> 153;

-- set_order重複。0 rows が正常。
select c.set_order, count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id=cs.id
where cs.code='PCGP'
group by c.set_order
having count(*) > 1
order by c.set_order;
