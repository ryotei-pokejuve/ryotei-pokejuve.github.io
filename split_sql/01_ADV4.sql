-- ADV4 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- ADV4 強化拡張パックex1 マグマVSアクア ふたつの野望 (80 cards)
update public.card_sets
set name='強化拡張パックex1 マグマVSアクア ふたつの野望',
    release_date='2003-10-24'::date,
    tcgdex_series_id='ADV',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/Ex1%20Magma%20VS%20Aqua%20Two%20Ambitions%20pack.jpg'
where code='ADV4';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '強化拡張パックex1 マグマVSアクア ふたつの野望', 'ADV4', '2003-10-24'::date, 'ADV', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/Ex1%20Magma%20VS%20Aqua%20Two%20Ambitions%20pack.jpg'
where not exists (select 1 from public.card_sets where code='ADV4');

-- 001/080 アーボ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アーボ',
  name_normalized=public.normalize_card_name('アーボ'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-1/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーボ',public.normalize_card_name('アーボ'),'1','●','normal','https://images.scrydex.com/pokemon/adv4_ja-1/large','Scrydex public card image (adv4_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/080 アーボック
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アーボック',
  name_normalized=public.normalize_card_name('アーボック'),
  rarity='★',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-2/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーボック',public.normalize_card_name('アーボック'),'2','★','normal','https://images.scrydex.com/pokemon/adv4_ja-2/large','Scrydex public card image (adv4_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/080 クヌギダマ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='クヌギダマ',
  name_normalized=public.normalize_card_name('クヌギダマ'),
  rarity='●',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-3/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クヌギダマ',public.normalize_card_name('クヌギダマ'),'3','●','normal','https://images.scrydex.com/pokemon/adv4_ja-3/large','Scrydex public card image (adv4_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/080 キモリ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='キモリ',
  name_normalized=public.normalize_card_name('キモリ'),
  rarity='●',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-4/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キモリ',public.normalize_card_name('キモリ'),'4','●','normal','https://images.scrydex.com/pokemon/adv4_ja-4/large','Scrydex public card image (adv4_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/080 ジュプトル
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ジュプトル',
  name_normalized=public.normalize_card_name('ジュプトル'),
  rarity='★',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-5/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュプトル',public.normalize_card_name('ジュプトル'),'5','★','normal','https://images.scrydex.com/pokemon/adv4_ja-5/large','Scrydex public card image (adv4_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/080 ジュカインex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ジュカインex',
  name_normalized=public.normalize_card_name('ジュカインex'),
  rarity='☆',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-6/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュカインex',public.normalize_card_name('ジュカインex'),'6','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-6/large','Scrydex public card image (adv4_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/080 サボネア
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='サボネア',
  name_normalized=public.normalize_card_name('サボネア'),
  rarity='●',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-7/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サボネア',public.normalize_card_name('サボネア'),'7','●','normal','https://images.scrydex.com/pokemon/adv4_ja-7/large','Scrydex public card image (adv4_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/080 リリーラ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='リリーラ',
  name_normalized=public.normalize_card_name('リリーラ'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-8/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リリーラ',public.normalize_card_name('リリーラ'),'8','★','normal','https://images.scrydex.com/pokemon/adv4_ja-8/large','Scrydex public card image (adv4_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/080 ユレイドルex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ユレイドルex',
  name_normalized=public.normalize_card_name('ユレイドルex'),
  rarity='☆',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-9/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ユレイドルex',public.normalize_card_name('ユレイドルex'),'9','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-9/large','Scrydex public card image (adv4_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/080 アクア団のハブネーク
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のハブネーク',
  name_normalized=public.normalize_card_name('アクア団のハブネーク'),
  rarity='★',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-10/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のハブネーク',public.normalize_card_name('アクア団のハブネーク'),'10','★','normal','https://images.scrydex.com/pokemon/adv4_ja-10/large','Scrydex public card image (adv4_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/080 アクア団のサボネア
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のサボネア',
  name_normalized=public.normalize_card_name('アクア団のサボネア'),
  rarity='◆',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-11/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のサボネア',public.normalize_card_name('アクア団のサボネア'),'11','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-11/large','Scrydex public card image (adv4_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/080 アクア団のノクタス
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のノクタス',
  name_normalized=public.normalize_card_name('アクア団のノクタス'),
  rarity='★',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-12/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のノクタス',public.normalize_card_name('アクア団のノクタス'),'12','★','normal','https://images.scrydex.com/pokemon/adv4_ja-12/large','Scrydex public card image (adv4_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/080 ガーディ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ガーディ',
  name_normalized=public.normalize_card_name('ガーディ'),
  rarity='●',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-13/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ガーディ',public.normalize_card_name('ガーディ'),'13','●','normal','https://images.scrydex.com/pokemon/adv4_ja-13/large','Scrydex public card image (adv4_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/080 ウインディ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ウインディ',
  name_normalized=public.normalize_card_name('ウインディ'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-14/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウインディ',public.normalize_card_name('ウインディ'),'14','★','normal','https://images.scrydex.com/pokemon/adv4_ja-14/large','Scrydex public card image (adv4_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/080 ブースター
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ブースター',
  name_normalized=public.normalize_card_name('ブースター'),
  rarity='★',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-15/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブースター',public.normalize_card_name('ブースター'),'15','★','normal','https://images.scrydex.com/pokemon/adv4_ja-15/large','Scrydex public card image (adv4_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/080 アチャモ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アチャモ',
  name_normalized=public.normalize_card_name('アチャモ'),
  rarity='●',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-16/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アチャモ',public.normalize_card_name('アチャモ'),'16','●','normal','https://images.scrydex.com/pokemon/adv4_ja-16/large','Scrydex public card image (adv4_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/080 ワカシャモ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ワカシャモ',
  name_normalized=public.normalize_card_name('ワカシャモ'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-17/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワカシャモ',public.normalize_card_name('ワカシャモ'),'17','★','normal','https://images.scrydex.com/pokemon/adv4_ja-17/large','Scrydex public card image (adv4_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/080 バシャーモex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='バシャーモex',
  name_normalized=public.normalize_card_name('バシャーモex'),
  rarity='☆',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-18/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バシャーモex',public.normalize_card_name('バシャーモex'),'18','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-18/large','Scrydex public card image (adv4_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/080 マグマ団のデルビル
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のデルビル',
  name_normalized=public.normalize_card_name('マグマ団のデルビル'),
  rarity='◆',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-19/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のデルビル',public.normalize_card_name('マグマ団のデルビル'),'19','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-19/large','Scrydex public card image (adv4_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/080 マグマ団のヘルガー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のヘルガー',
  name_normalized=public.normalize_card_name('マグマ団のヘルガー'),
  rarity='★',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-20/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のヘルガー',public.normalize_card_name('マグマ団のヘルガー'),'20','★','normal','https://images.scrydex.com/pokemon/adv4_ja-20/large','Scrydex public card image (adv4_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/080 マグマ団のコータス
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のコータス',
  name_normalized=public.normalize_card_name('マグマ団のコータス'),
  rarity='★',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-21/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のコータス',public.normalize_card_name('マグマ団のコータス'),'21','★','normal','https://images.scrydex.com/pokemon/adv4_ja-21/large','Scrydex public card image (adv4_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/080 シャワーズ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='シャワーズ',
  name_normalized=public.normalize_card_name('シャワーズ'),
  rarity='★',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-22/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シャワーズ',public.normalize_card_name('シャワーズ'),'22','★','normal','https://images.scrydex.com/pokemon/adv4_ja-22/large','Scrydex public card image (adv4_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/080 オムナイト
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='オムナイト',
  name_normalized=public.normalize_card_name('オムナイト'),
  rarity='◆',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-23/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムナイト',public.normalize_card_name('オムナイト'),'23','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-23/large','Scrydex public card image (adv4_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/080 オムスター
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='オムスター',
  name_normalized=public.normalize_card_name('オムスター'),
  rarity='★',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-24/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムスター',public.normalize_card_name('オムスター'),'24','★','normal','https://images.scrydex.com/pokemon/adv4_ja-24/large','Scrydex public card image (adv4_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/080 カブト
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='カブト',
  name_normalized=public.normalize_card_name('カブト'),
  rarity='◆',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-25/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブト',public.normalize_card_name('カブト'),'25','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-25/large','Scrydex public card image (adv4_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/080 カブトプスex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='カブトプスex',
  name_normalized=public.normalize_card_name('カブトプスex'),
  rarity='☆',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-26/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブトプスex',public.normalize_card_name('カブトプスex'),'26','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-26/large','Scrydex public card image (adv4_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/080 スイクンex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='スイクンex',
  name_normalized=public.normalize_card_name('スイクンex'),
  rarity='☆',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-27/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スイクンex',public.normalize_card_name('スイクンex'),'27','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-27/large','Scrydex public card image (adv4_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/080 ミズゴロウ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ミズゴロウ',
  name_normalized=public.normalize_card_name('ミズゴロウ'),
  rarity='●',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-28/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミズゴロウ',public.normalize_card_name('ミズゴロウ'),'28','●','normal','https://images.scrydex.com/pokemon/adv4_ja-28/large','Scrydex public card image (adv4_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/080 ヌマクロー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ヌマクロー',
  name_normalized=public.normalize_card_name('ヌマクロー'),
  rarity='★',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-29/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヌマクロー',public.normalize_card_name('ヌマクロー'),'29','★','normal','https://images.scrydex.com/pokemon/adv4_ja-29/large','Scrydex public card image (adv4_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/080 キャモメ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='キャモメ',
  name_normalized=public.normalize_card_name('キャモメ'),
  rarity='●',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-30/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キャモメ',public.normalize_card_name('キャモメ'),'30','●','normal','https://images.scrydex.com/pokemon/adv4_ja-30/large','Scrydex public card image (adv4_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/080 ペリッパー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ペリッパー',
  name_normalized=public.normalize_card_name('ペリッパー'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-31/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ペリッパー',public.normalize_card_name('ペリッパー'),'31','★','normal','https://images.scrydex.com/pokemon/adv4_ja-31/large','Scrydex public card image (adv4_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/080 ホエルコ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ホエルコ',
  name_normalized=public.normalize_card_name('ホエルコ'),
  rarity='◆',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-32/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホエルコ',public.normalize_card_name('ホエルコ'),'32','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-32/large','Scrydex public card image (adv4_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/080 アクア団のキバニア
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のキバニア',
  name_normalized=public.normalize_card_name('アクア団のキバニア'),
  rarity='◆',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-33/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のキバニア',public.normalize_card_name('アクア団のキバニア'),'33','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-33/large','Scrydex public card image (adv4_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/080 アクア団のヘイガニ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のヘイガニ',
  name_normalized=public.normalize_card_name('アクア団のヘイガニ'),
  rarity='◆',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-34/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のヘイガニ',public.normalize_card_name('アクア団のヘイガニ'),'34','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-34/large','Scrydex public card image (adv4_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/080 アクア団のサメハダー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のサメハダー',
  name_normalized=public.normalize_card_name('アクア団のサメハダー'),
  rarity='★',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-35/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のサメハダー',public.normalize_card_name('アクア団のサメハダー'),'35','★','normal','https://images.scrydex.com/pokemon/adv4_ja-35/large','Scrydex public card image (adv4_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/080 アクア団のシザリガー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のシザリガー',
  name_normalized=public.normalize_card_name('アクア団のシザリガー'),
  rarity='★',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-36/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のシザリガー',public.normalize_card_name('アクア団のシザリガー'),'36','★','normal','https://images.scrydex.com/pokemon/adv4_ja-36/large','Scrydex public card image (adv4_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/080 サンダース
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='サンダース',
  name_normalized=public.normalize_card_name('サンダース'),
  rarity='★',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-37/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンダース',public.normalize_card_name('サンダース'),'37','★','normal','https://images.scrydex.com/pokemon/adv4_ja-37/large','Scrydex public card image (adv4_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/080 アクア団のラクライ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のラクライ',
  name_normalized=public.normalize_card_name('アクア団のラクライ'),
  rarity='◆',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-38/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のラクライ',public.normalize_card_name('アクア団のラクライ'),'38','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-38/large','Scrydex public card image (adv4_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/080 アクア団のライボルト
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のライボルト',
  name_normalized=public.normalize_card_name('アクア団のライボルト'),
  rarity='★',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-39/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のライボルト',public.normalize_card_name('アクア団のライボルト'),'39','★','normal','https://images.scrydex.com/pokemon/adv4_ja-39/large','Scrydex public card image (adv4_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/080 エーフィ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='エーフィ',
  name_normalized=public.normalize_card_name('エーフィ'),
  rarity='★',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-40/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エーフィ',public.normalize_card_name('エーフィ'),'40','★','normal','https://images.scrydex.com/pokemon/adv4_ja-40/large','Scrydex public card image (adv4_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/080 ラルトス
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ラルトス',
  name_normalized=public.normalize_card_name('ラルトス'),
  rarity='●',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-41/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラルトス',public.normalize_card_name('ラルトス'),'41','●','normal','https://images.scrydex.com/pokemon/adv4_ja-41/large','Scrydex public card image (adv4_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/080 キルリア
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='キルリア',
  name_normalized=public.normalize_card_name('キルリア'),
  rarity='★',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-42/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キルリア',public.normalize_card_name('キルリア'),'42','★','normal','https://images.scrydex.com/pokemon/adv4_ja-42/large','Scrydex public card image (adv4_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/080 ヨマワル
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ヨマワル',
  name_normalized=public.normalize_card_name('ヨマワル'),
  rarity='●',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-43/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヨマワル',public.normalize_card_name('ヨマワル'),'43','●','normal','https://images.scrydex.com/pokemon/adv4_ja-43/large','Scrydex public card image (adv4_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/080 マグマ団のヤジロン
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のヤジロン',
  name_normalized=public.normalize_card_name('マグマ団のヤジロン'),
  rarity='◆',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-44/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のヤジロン',public.normalize_card_name('マグマ団のヤジロン'),'44','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-44/large','Scrydex public card image (adv4_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/080 マグマ団のネンドール
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のネンドール',
  name_normalized=public.normalize_card_name('マグマ団のネンドール'),
  rarity='★',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-45/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のネンドール',public.normalize_card_name('マグマ団のネンドール'),'45','★','normal','https://images.scrydex.com/pokemon/adv4_ja-45/large','Scrydex public card image (adv4_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/080 イシツブテ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='イシツブテ',
  name_normalized=public.normalize_card_name('イシツブテ'),
  rarity='●',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-46/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イシツブテ',public.normalize_card_name('イシツブテ'),'46','●','normal','https://images.scrydex.com/pokemon/adv4_ja-46/large','Scrydex public card image (adv4_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/080 ゴローン
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ゴローン',
  name_normalized=public.normalize_card_name('ゴローン'),
  rarity='★',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-47/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴローン',public.normalize_card_name('ゴローン'),'47','★','normal','https://images.scrydex.com/pokemon/adv4_ja-47/large','Scrydex public card image (adv4_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/080 ゴローニャex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ゴローニャex',
  name_normalized=public.normalize_card_name('ゴローニャex'),
  rarity='☆',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-48/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴローニャex',public.normalize_card_name('ゴローニャex'),'48','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-48/large','Scrydex public card image (adv4_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/080 イワーク
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='イワーク',
  name_normalized=public.normalize_card_name('イワーク'),
  rarity='●',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-49/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イワーク',public.normalize_card_name('イワーク'),'49','●','normal','https://images.scrydex.com/pokemon/adv4_ja-49/large','Scrydex public card image (adv4_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/080 ラグラージex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ラグラージex',
  name_normalized=public.normalize_card_name('ラグラージex'),
  rarity='☆',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-50/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラグラージex',public.normalize_card_name('ラグラージex'),'50','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-50/large','Scrydex public card image (adv4_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/080 アノプス
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アノプス',
  name_normalized=public.normalize_card_name('アノプス'),
  rarity='★',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-51/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アノプス',public.normalize_card_name('アノプス'),'51','★','normal','https://images.scrydex.com/pokemon/adv4_ja-51/large','Scrydex public card image (adv4_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/080 マグマ団のサイホーン
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のサイホーン',
  name_normalized=public.normalize_card_name('マグマ団のサイホーン'),
  rarity='◆',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-52/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のサイホーン',public.normalize_card_name('マグマ団のサイホーン'),'52','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-52/large','Scrydex public card image (adv4_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/080 マグマ団のサイドン
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のサイドン',
  name_normalized=public.normalize_card_name('マグマ団のサイドン'),
  rarity='★',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-53/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のサイドン',public.normalize_card_name('マグマ団のサイドン'),'53','★','normal','https://images.scrydex.com/pokemon/adv4_ja-53/large','Scrydex public card image (adv4_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/080 イーブイ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='イーブイ',
  name_normalized=public.normalize_card_name('イーブイ'),
  rarity='●',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-54/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イーブイ',public.normalize_card_name('イーブイ'),'54','●','normal','https://images.scrydex.com/pokemon/adv4_ja-54/large','Scrydex public card image (adv4_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/080 プテラex
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='プテラex',
  name_normalized=public.normalize_card_name('プテラex'),
  rarity='☆',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-55/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プテラex',public.normalize_card_name('プテラex'),'55','☆','normal','https://images.scrydex.com/pokemon/adv4_ja-55/large','Scrydex public card image (adv4_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/080 ノコッチ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ノコッチ',
  name_normalized=public.normalize_card_name('ノコッチ'),
  rarity='●',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-56/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ノコッチ',public.normalize_card_name('ノコッチ'),'56','●','normal','https://images.scrydex.com/pokemon/adv4_ja-56/large','Scrydex public card image (adv4_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/080 マッスグマ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マッスグマ',
  name_normalized=public.normalize_card_name('マッスグマ'),
  rarity='◆',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-57/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マッスグマ',public.normalize_card_name('マッスグマ'),'57','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-57/large','Scrydex public card image (adv4_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/080 オオスバメ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='オオスバメ',
  name_normalized=public.normalize_card_name('オオスバメ'),
  rarity='★',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-58/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オオスバメ',public.normalize_card_name('オオスバメ'),'58','★','normal','https://images.scrydex.com/pokemon/adv4_ja-58/large','Scrydex public card image (adv4_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/080 エネコ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='エネコ',
  name_normalized=public.normalize_card_name('エネコ'),
  rarity='●',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-59/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコ',public.normalize_card_name('エネコ'),'59','●','normal','https://images.scrydex.com/pokemon/adv4_ja-59/large','Scrydex public card image (adv4_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/080 エネコロロ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='エネコロロ',
  name_normalized=public.normalize_card_name('エネコロロ'),
  rarity='◆',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-60/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコロロ',public.normalize_card_name('エネコロロ'),'60','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-60/large','Scrydex public card image (adv4_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/080 マグマ団のザングース
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のザングース',
  name_normalized=public.normalize_card_name('マグマ団のザングース'),
  rarity='★',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-61/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のザングース',public.normalize_card_name('マグマ団のザングース'),'61','★','normal','https://images.scrydex.com/pokemon/adv4_ja-61/large','Scrydex public card image (adv4_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/080 ブラッキー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ブラッキー',
  name_normalized=public.normalize_card_name('ブラッキー'),
  rarity='★',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-62/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブラッキー',public.normalize_card_name('ブラッキー'),'62','★','normal','https://images.scrydex.com/pokemon/adv4_ja-62/large','Scrydex public card image (adv4_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/080 ヤミカラス
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ヤミカラス',
  name_normalized=public.normalize_card_name('ヤミカラス'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-63/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤミカラス',public.normalize_card_name('ヤミカラス'),'63','★','normal','https://images.scrydex.com/pokemon/adv4_ja-63/large','Scrydex public card image (adv4_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/080 フォレトス
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='フォレトス',
  name_normalized=public.normalize_card_name('フォレトス'),
  rarity='★',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-64/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フォレトス',public.normalize_card_name('フォレトス'),'64','★','normal','https://images.scrydex.com/pokemon/adv4_ja-64/large','Scrydex public card image (adv4_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/080 ハガネール
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ハガネール',
  name_normalized=public.normalize_card_name('ハガネール'),
  rarity='★',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-65/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハガネール',public.normalize_card_name('ハガネール'),'65','★','normal','https://images.scrydex.com/pokemon/adv4_ja-65/large','Scrydex public card image (adv4_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/080 デュアルボール
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='デュアルボール',
  name_normalized=public.normalize_card_name('デュアルボール'),
  rarity='◆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-66/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デュアルボール',public.normalize_card_name('デュアルボール'),'66','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-66/large','Scrydex public card image (adv4_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/080 なにかの化石
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='なにかの化石',
  name_normalized=public.normalize_card_name('なにかの化石'),
  rarity='●',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-67/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'なにかの化石',public.normalize_card_name('なにかの化石'),'67','●','normal','https://images.scrydex.com/pokemon/adv4_ja-67/large','Scrydex public card image (adv4_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/080 ワープポイント
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ワープポイント',
  name_normalized=public.normalize_card_name('ワープポイント'),
  rarity='◆',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-68/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワープポイント',public.normalize_card_name('ワープポイント'),'68','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-68/large','Scrydex public card image (adv4_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/080 ちからのかけら
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='ちからのかけら',
  name_normalized=public.normalize_card_name('ちからのかけら'),
  rarity='◆',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-69/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ちからのかけら',public.normalize_card_name('ちからのかけら'),'69','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-69/large','Scrydex public card image (adv4_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/080 マグマ団のパルサー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のパルサー',
  name_normalized=public.normalize_card_name('マグマ団のパルサー'),
  rarity='◆',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-70/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のパルサー',public.normalize_card_name('マグマ団のパルサー'),'70','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-70/large','Scrydex public card image (adv4_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/080 アクア団のパルサー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のパルサー',
  name_normalized=public.normalize_card_name('アクア団のパルサー'),
  rarity='◆',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-71/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のパルサー',public.normalize_card_name('アクア団のパルサー'),'71','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-71/large','Scrydex public card image (adv4_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/080 マグマ団の男
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団の男',
  name_normalized=public.normalize_card_name('マグマ団の男'),
  rarity='◆',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-72/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団の男',public.normalize_card_name('マグマ団の男'),'72','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-72/large','Scrydex public card image (adv4_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/080 アクア団の男
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団の男',
  name_normalized=public.normalize_card_name('アクア団の男'),
  rarity='◆',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-73/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団の男',public.normalize_card_name('アクア団の男'),'73','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-73/large','Scrydex public card image (adv4_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/080 マツブサ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マツブサ',
  name_normalized=public.normalize_card_name('マツブサ'),
  rarity='★',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-74/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マツブサ',public.normalize_card_name('マツブサ'),'74','★','normal','https://images.scrydex.com/pokemon/adv4_ja-74/large','Scrydex public card image (adv4_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/080 アオギリ
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アオギリ',
  name_normalized=public.normalize_card_name('アオギリ'),
  rarity='★',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-75/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アオギリ',public.normalize_card_name('アオギリ'),'75','★','normal','https://images.scrydex.com/pokemon/adv4_ja-75/large','Scrydex public card image (adv4_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/080 マグマ団のワザマシン01
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマ団のワザマシン01',
  name_normalized=public.normalize_card_name('マグマ団のワザマシン01'),
  rarity='◆',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-76/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマ団のワザマシン01',public.normalize_card_name('マグマ団のワザマシン01'),'76','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-76/large','Scrydex public card image (adv4_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/080 アクア団のワザマシン01
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクア団のワザマシン01',
  name_normalized=public.normalize_card_name('アクア団のワザマシン01'),
  rarity='◆',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-77/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクア団のワザマシン01',public.normalize_card_name('アクア団のワザマシン01'),'77','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-77/large','Scrydex public card image (adv4_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/080 Wレインボーエネルギー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='Wレインボーエネルギー',
  name_normalized=public.normalize_card_name('Wレインボーエネルギー'),
  rarity='◆',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-78/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'Wレインボーエネルギー',public.normalize_card_name('Wレインボーエネルギー'),'78','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-78/large','Scrydex public card image (adv4_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/080 マグマエネルギー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='マグマエネルギー',
  name_normalized=public.normalize_card_name('マグマエネルギー'),
  rarity='◆',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-79/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマエネルギー',public.normalize_card_name('マグマエネルギー'),'79','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-79/large','Scrydex public card image (adv4_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/080 アクアエネルギー
with st as (select id from public.card_sets where code='ADV4' limit 1)
update public.cards c set
  name='アクアエネルギー',
  name_normalized=public.normalize_card_name('アクアエネルギー'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/adv4_ja-80/large',
  image_source_note='Scrydex public card image (adv4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='ADV4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アクアエネルギー',public.normalize_card_name('アクアエネルギー'),'80','◆','normal','https://images.scrydex.com/pokemon/adv4_ja-80/large','Scrydex public card image (adv4_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

commit;

-- ============================================================
-- ADV4 監査
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
where cs.code = 'ADV4'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'ADV4' as code,
  80 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'ADV4'
having count(distinct c.set_order) <> 80;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'ADV4'
group by c.set_order
having count(*) > 1
order by c.set_order;
