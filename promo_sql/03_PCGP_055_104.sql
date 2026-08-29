-- PCG-P プロモーションカード / Supabase SQL Editor用
begin;

-- 055/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='055/PCG-P',
  rarity='プロモ',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-55/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

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
  '055/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-55/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 056/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='056/PCG-P',
  rarity='プロモ',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-56/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

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
  '056/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-56/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 057/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='057/PCG-P',
  rarity='プロモ',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-57/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

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
  '057/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-57/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 058/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='058/PCG-P',
  rarity='プロモ',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-58/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

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
  '058/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-58/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 059/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='059/PCG-P',
  rarity='プロモ',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-59/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

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
  '059/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-59/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 060/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='060/PCG-P',
  rarity='プロモ',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-60/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

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
  '060/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-60/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 061/PCG-P ラティアス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラティアス',
  name_normalized=public.normalize_card_name('ラティアス'),
  card_number='061/PCG-P',
  rarity='プロモ',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-61/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラティアス',
  public.normalize_card_name('ラティアス'),
  '061/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-61/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 062/PCG-P ラティオス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラティオス',
  name_normalized=public.normalize_card_name('ラティオス'),
  card_number='062/PCG-P',
  rarity='プロモ',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-62/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラティオス',
  public.normalize_card_name('ラティオス'),
  '062/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-62/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 063/PCG-P ジュカイン
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ジュカイン',
  name_normalized=public.normalize_card_name('ジュカイン'),
  card_number='063/PCG-P',
  rarity='プロモ',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-63/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

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
  '063/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-63/large',
  'Scrydex public card image (pcgp_ja)',
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

-- 064/PCG-P サボネア
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='サボネア',
  name_normalized=public.normalize_card_name('サボネア'),
  card_number='064/PCG-P',
  rarity='プロモ',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-64/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'サボネア',
  public.normalize_card_name('サボネア'),
  '064/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-64/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  64,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/PCG-P ワカシャモ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ワカシャモ',
  name_normalized=public.normalize_card_name('ワカシャモ'),
  card_number='065/PCG-P',
  rarity='プロモ',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-65/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

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
  '065/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-65/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  65,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/PCG-P ラグラージ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ラグラージ',
  name_normalized=public.normalize_card_name('ラグラージ'),
  card_number='066/PCG-P',
  rarity='プロモ',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-66/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ラグラージ',
  public.normalize_card_name('ラグラージ'),
  '066/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-66/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  66,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/PCG-P レジアイス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レジアイス',
  name_normalized=public.normalize_card_name('レジアイス'),
  card_number='067/PCG-P',
  rarity='プロモ',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-67/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レジアイス',
  public.normalize_card_name('レジアイス'),
  '067/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-67/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  67,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/PCG-P ピカチュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピカチュウ',
  name_normalized=public.normalize_card_name('ピカチュウ'),
  card_number='068/PCG-P',
  rarity='プロモ',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-68/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

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
  '068/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-68/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  68,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/PCG-P ミュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ミュウ',
  name_normalized=public.normalize_card_name('ミュウ'),
  card_number='069/PCG-P',
  rarity='プロモ',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-69/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ミュウ',
  public.normalize_card_name('ミュウ'),
  '069/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-69/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  69,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/PCG-P サーナイト
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='サーナイト',
  name_normalized=public.normalize_card_name('サーナイト'),
  card_number='070/PCG-P',
  rarity='プロモ',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-70/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'サーナイト',
  public.normalize_card_name('サーナイト'),
  '070/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-70/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  70,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/PCG-P ゴマゾウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ゴマゾウ',
  name_normalized=public.normalize_card_name('ゴマゾウ'),
  card_number='071/PCG-P',
  rarity='プロモ',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-71/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ゴマゾウ',
  public.normalize_card_name('ゴマゾウ'),
  '071/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-71/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  71,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/PCG-P レジロック
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レジロック',
  name_normalized=public.normalize_card_name('レジロック'),
  card_number='072/PCG-P',
  rarity='プロモ',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-72/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レジロック',
  public.normalize_card_name('レジロック'),
  '072/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-72/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  72,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/PCG-P ピジョット
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピジョット',
  name_normalized=public.normalize_card_name('ピジョット'),
  card_number='073/PCG-P',
  rarity='プロモ',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-73/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピジョット',
  public.normalize_card_name('ピジョット'),
  '073/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-73/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  73,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/PCG-P レジスチル
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レジスチル',
  name_normalized=public.normalize_card_name('レジスチル'),
  card_number='074/PCG-P',
  rarity='プロモ',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-74/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レジスチル',
  public.normalize_card_name('レジスチル'),
  '074/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-74/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  74,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/PCG-P 波導のルカリオ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='波導のルカリオ',
  name_normalized=public.normalize_card_name('波導のルカリオ'),
  card_number='075/PCG-P',
  rarity='プロモ',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-75/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '波導のルカリオ',
  public.normalize_card_name('波導のルカリオ'),
  '075/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-75/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  75,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/PCG-P ホウオウex
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ホウオウex',
  name_normalized=public.normalize_card_name('ホウオウex'),
  card_number='076/PCG-P',
  rarity='プロモ',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-76/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ホウオウex',
  public.normalize_card_name('ホウオウex'),
  '076/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-76/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  76,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/PCG-P マリルリ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='マリルリ',
  name_normalized=public.normalize_card_name('マリルリ'),
  card_number='077/PCG-P',
  rarity='プロモ',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-77/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'マリルリ',
  public.normalize_card_name('マリルリ'),
  '077/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-77/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  77,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/PCG-P ピチュー兄弟
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピチュー兄弟',
  name_normalized=public.normalize_card_name('ピチュー兄弟'),
  card_number='078/PCG-P',
  rarity='プロモ',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-78/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ピチュー兄弟',
  public.normalize_card_name('ピチュー兄弟'),
  '078/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-78/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  78,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/PCG-P 波導のルカリオ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='波導のルカリオ',
  name_normalized=public.normalize_card_name('波導のルカリオ'),
  card_number='079/PCG-P',
  rarity='プロモ',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-79/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '波導のルカリオ',
  public.normalize_card_name('波導のルカリオ'),
  '079/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-79/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  79,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/PCG-P ミュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ミュウ',
  name_normalized=public.normalize_card_name('ミュウ'),
  card_number='080/PCG-P',
  rarity='プロモ',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-80/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ミュウ',
  public.normalize_card_name('ミュウ'),
  '080/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-80/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  80,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/PCG-P ジュプトル
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ジュプトル',
  name_normalized=public.normalize_card_name('ジュプトル'),
  card_number='081/PCG-P',
  rarity='プロモ',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-81/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ジュプトル',
  public.normalize_card_name('ジュプトル'),
  '081/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-81/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  81,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/PCG-P ワカシャモ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ワカシャモ',
  name_normalized=public.normalize_card_name('ワカシャモ'),
  card_number='082/PCG-P',
  rarity='プロモ',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-82/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

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
  '082/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-82/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  82,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

-- 083/PCG-P ミズゴロウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ミズゴロウ',
  name_normalized=public.normalize_card_name('ミズゴロウ'),
  card_number='083/PCG-P',
  rarity='プロモ',
  set_order=83,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-83/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ミズゴロウ',
  public.normalize_card_name('ミズゴロウ'),
  '083/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-83/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  83,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83'
);

-- 084/PCG-P ピカチュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ピカチュウ',
  name_normalized=public.normalize_card_name('ピカチュウ'),
  card_number='084/PCG-P',
  rarity='プロモ',
  set_order=84,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-84/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84';

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
  '084/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-84/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  84,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84'
);

-- 085/PCG-P ミュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ミュウ',
  name_normalized=public.normalize_card_name('ミュウ'),
  card_number='085/PCG-P',
  rarity='プロモ',
  set_order=85,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-85/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ミュウ',
  public.normalize_card_name('ミュウ'),
  '085/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-85/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  85,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85'
);

-- 086/PCG-P ロータのマネネ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ロータのマネネ',
  name_normalized=public.normalize_card_name('ロータのマネネ'),
  card_number='086/PCG-P',
  rarity='プロモ',
  set_order=86,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-86/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ロータのマネネ',
  public.normalize_card_name('ロータのマネネ'),
  '086/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-86/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  86,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86'
);

-- 087/PCG-P ロータのウソハチ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ロータのウソハチ',
  name_normalized=public.normalize_card_name('ロータのウソハチ'),
  card_number='087/PCG-P',
  rarity='プロモ',
  set_order=87,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-87/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '87';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ロータのウソハチ',
  public.normalize_card_name('ロータのウソハチ'),
  '087/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-87/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  87,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '87'
);

-- 088/PCG-P ロータのゴンベ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ロータのゴンベ',
  name_normalized=public.normalize_card_name('ロータのゴンベ'),
  card_number='088/PCG-P',
  rarity='プロモ',
  set_order=88,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-88/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '88';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ロータのゴンベ',
  public.normalize_card_name('ロータのゴンベ'),
  '088/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-88/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  88,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '88'
);

-- 089/PCG-P ロータのマニューラ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ロータのマニューラ',
  name_normalized=public.normalize_card_name('ロータのマニューラ'),
  card_number='089/PCG-P',
  rarity='プロモ',
  set_order=89,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-89/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '89';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ロータのマニューラ',
  public.normalize_card_name('ロータのマニューラ'),
  '089/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-89/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  89,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '89'
);

-- 090/PCG-P 波導のルカリオ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='波導のルカリオ',
  name_normalized=public.normalize_card_name('波導のルカリオ'),
  card_number='090/PCG-P',
  rarity='プロモ',
  set_order=90,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-90/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '90';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '波導のルカリオ',
  public.normalize_card_name('波導のルカリオ'),
  '090/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-90/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  90,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '90'
);

-- 091/PCG-P ミュウ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ミュウ',
  name_normalized=public.normalize_card_name('ミュウ'),
  card_number='091/PCG-P',
  rarity='プロモ',
  set_order=91,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-91/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '91';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ミュウ',
  public.normalize_card_name('ミュウ'),
  '091/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-91/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  91,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '91'
);

-- 092/PCG-P 波導のルカリオ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='波導のルカリオ',
  name_normalized=public.normalize_card_name('波導のルカリオ'),
  card_number='092/PCG-P',
  rarity='プロモ',
  set_order=92,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-92/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '92';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '波導のルカリオ',
  public.normalize_card_name('波導のルカリオ'),
  '092/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-92/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  92,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '92'
);

-- 093/PCG-P 波導のルカリオ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='波導のルカリオ',
  name_normalized=public.normalize_card_name('波導のルカリオ'),
  card_number='093/PCG-P',
  rarity='プロモ',
  set_order=93,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-93/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '93';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  '波導のルカリオ',
  public.normalize_card_name('波導のルカリオ'),
  '093/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-93/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  93,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '93'
);

-- 094/PCG-P レックウザ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レックウザ',
  name_normalized=public.normalize_card_name('レックウザ'),
  card_number='094/PCG-P',
  rarity='プロモ',
  set_order=94,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-94/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '94';

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
  '094/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-94/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  94,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '94'
);

-- 095/PCG-P Subtypes Energy エネルギー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Energy エネルギー supertype',
  name_normalized=public.normalize_card_name('Subtypes Energy エネルギー supertype'),
  card_number='095/PCG-P',
  rarity='プロモ',
  set_order=95,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-95/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '95';

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
  '095/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-95/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  95,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '95'
);

-- 096/PCG-P Subtypes Trainer トレーナー supertype
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='Subtypes Trainer トレーナー supertype',
  name_normalized=public.normalize_card_name('Subtypes Trainer トレーナー supertype'),
  card_number='096/PCG-P',
  rarity='プロモ',
  set_order=96,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-96/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '96';

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
  '096/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-96/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  96,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '96'
);

-- 097/PCG-P ロータのマネネ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ロータのマネネ',
  name_normalized=public.normalize_card_name('ロータのマネネ'),
  card_number='097/PCG-P',
  rarity='プロモ',
  set_order=97,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-97/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '97';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ロータのマネネ',
  public.normalize_card_name('ロータのマネネ'),
  '097/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-97/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  97,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '97'
);

-- 098/PCG-P レジアイス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レジアイス',
  name_normalized=public.normalize_card_name('レジアイス'),
  card_number='098/PCG-P',
  rarity='プロモ',
  set_order=98,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-98/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '98';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レジアイス',
  public.normalize_card_name('レジアイス'),
  '098/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-98/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  98,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '98'
);

-- 099/PCG-P レジロック
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レジロック',
  name_normalized=public.normalize_card_name('レジロック'),
  card_number='099/PCG-P',
  rarity='プロモ',
  set_order=99,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-99/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '99';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レジロック',
  public.normalize_card_name('レジロック'),
  '099/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-99/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  99,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '99'
);

-- 100/PCG-P レジスチル
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レジスチル',
  name_normalized=public.normalize_card_name('レジスチル'),
  card_number='100/PCG-P',
  rarity='プロモ',
  set_order=100,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-100/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '100';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レジスチル',
  public.normalize_card_name('レジスチル'),
  '100/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-100/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  100,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '100'
);

-- 101/PCG-P フォレトス
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='フォレトス',
  name_normalized=public.normalize_card_name('フォレトス'),
  card_number='101/PCG-P',
  rarity='プロモ',
  set_order=101,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-101/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '101';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'フォレトス',
  public.normalize_card_name('フォレトス'),
  '101/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-101/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  101,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '101'
);

-- 102/PCG-P ブースター
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='ブースター',
  name_normalized=public.normalize_card_name('ブースター'),
  card_number='102/PCG-P',
  rarity='プロモ',
  set_order=102,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-102/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '102';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'ブースター',
  public.normalize_card_name('ブースター'),
  '102/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-102/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  102,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '102'
);

-- 103/PCG-P レックウザδ-デルタ種
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='レックウザδ-デルタ種',
  name_normalized=public.normalize_card_name('レックウザδ-デルタ種'),
  card_number='103/PCG-P',
  rarity='プロモ',
  set_order=103,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-103/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '103';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'レックウザδ-デルタ種',
  public.normalize_card_name('レックウザδ-デルタ種'),
  '103/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-103/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  103,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '103'
);

-- 104/PCG-P シャワーズ
with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
update public.cards c
set
  name='シャワーズ',
  name_normalized=public.normalize_card_name('シャワーズ'),
  card_number='104/PCG-P',
  rarity='プロモ',
  set_order=104,
  image_url='https://images.scrydex.com/pokemon/pcgp_ja-104/large',
  image_source_note='Scrydex public card image (pcgp_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id
  and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '104';

with st as (
  select id from public.card_sets where code='PCGP' limit 1
)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,
   image_url,image_source_note,is_active,set_order,created_at,updated_at)
select
  st.id,
  'シャワーズ',
  public.normalize_card_name('シャワーズ'),
  '104/PCG-P',
  'プロモ',
  'normal',
  'https://images.scrydex.com/pokemon/pcgp_ja-104/large',
  'Scrydex public card image (pcgp_ja)',
  true,
  104,
  now(),
  now()
from st
where not exists (
  select 1
  from public.cards c
  where c.set_id=st.id
    and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '104'
);

commit;
