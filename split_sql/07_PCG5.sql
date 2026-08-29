-- PCG5 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG5 拡張パック まぼろしの森 (86 cards)
update public.card_sets
set name='拡張パック まぼろしの森',
    release_date='2005-06-30'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG5%20Mirage%20Forest%20pack.jpg'
where code='PCG5';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック まぼろしの森', 'PCG5', '2005-06-30'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG5%20Mirage%20Forest%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG5');

-- 001/086 マダツボミ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='マダツボミ',
  name_normalized=public.normalize_card_name('マダツボミ'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-1/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マダツボミ',public.normalize_card_name('マダツボミ'),'1','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-1/large','Scrydex public card image (pcg5_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/086 ウツドン
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ウツドン',
  name_normalized=public.normalize_card_name('ウツドン'),
  rarity='◆',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-2/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウツドン',public.normalize_card_name('ウツドン'),'2','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-2/large','Scrydex public card image (pcg5_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/086 ウツボット
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ウツボット',
  name_normalized=public.normalize_card_name('ウツボット'),
  rarity='★',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-3/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウツボット',public.normalize_card_name('ウツボット'),'3','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-3/large','Scrydex public card image (pcg5_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/086 ベトベター
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ベトベター',
  name_normalized=public.normalize_card_name('ベトベター'),
  rarity='●',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-4/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ベトベター',public.normalize_card_name('ベトベター'),'4','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-4/large','Scrydex public card image (pcg5_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/086 ベトベトン
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ベトベトン',
  name_normalized=public.normalize_card_name('ベトベトン'),
  rarity='★',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-5/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ベトベトン',public.normalize_card_name('ベトベトン'),'5','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-5/large','Scrydex public card image (pcg5_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/086 モンジャラ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='モンジャラ',
  name_normalized=public.normalize_card_name('モンジャラ'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-6/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'モンジャラ',public.normalize_card_name('モンジャラ'),'6','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-6/large','Scrydex public card image (pcg5_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/086 カイロス
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='カイロス',
  name_normalized=public.normalize_card_name('カイロス'),
  rarity='★',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-7/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイロス',public.normalize_card_name('カイロス'),'7','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-7/large','Scrydex public card image (pcg5_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/086 ケムッソ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ケムッソ',
  name_normalized=public.normalize_card_name('ケムッソ'),
  rarity='●',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-8/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ケムッソ',public.normalize_card_name('ケムッソ'),'8','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-8/large','Scrydex public card image (pcg5_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/086 マユルド
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='マユルド',
  name_normalized=public.normalize_card_name('マユルド'),
  rarity='◆',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-9/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マユルド',public.normalize_card_name('マユルド'),'9','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-9/large','Scrydex public card image (pcg5_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/086 ドクケイルex
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ドクケイルex',
  name_normalized=public.normalize_card_name('ドクケイルex'),
  rarity='☆',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-10/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドクケイルex',public.normalize_card_name('ドクケイルex'),'10','☆','normal','https://images.scrydex.com/pokemon/pcg5_ja-10/large','Scrydex public card image (pcg5_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/086 タネボー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='タネボー',
  name_normalized=public.normalize_card_name('タネボー'),
  rarity='●',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-11/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タネボー',public.normalize_card_name('タネボー'),'11','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-11/large','Scrydex public card image (pcg5_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/086 ロゼリア
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ロゼリア',
  name_normalized=public.normalize_card_name('ロゼリア'),
  rarity='★',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-12/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロゼリア',public.normalize_card_name('ロゼリア'),'12','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-12/large','Scrydex public card image (pcg5_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/086 リリーラ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='リリーラ',
  name_normalized=public.normalize_card_name('リリーラ'),
  rarity='●',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-13/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リリーラ',public.normalize_card_name('リリーラ'),'13','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-13/large','Scrydex public card image (pcg5_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/086 ユレイドル
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ユレイドル',
  name_normalized=public.normalize_card_name('ユレイドル'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-14/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ユレイドル',public.normalize_card_name('ユレイドル'),'14','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-14/large','Scrydex public card image (pcg5_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/086 ガーディ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ガーディ',
  name_normalized=public.normalize_card_name('ガーディ'),
  rarity='●',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-15/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ガーディ',public.normalize_card_name('ガーディ'),'15','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-15/large','Scrydex public card image (pcg5_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/086 ウインディex
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ウインディex',
  name_normalized=public.normalize_card_name('ウインディex'),
  rarity='☆',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-16/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウインディex',public.normalize_card_name('ウインディex'),'16','☆','normal','https://images.scrydex.com/pokemon/pcg5_ja-16/large','Scrydex public card image (pcg5_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/086 ブーバー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ブーバー',
  name_normalized=public.normalize_card_name('ブーバー'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-17/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブーバー',public.normalize_card_name('ブーバー'),'17','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-17/large','Scrydex public card image (pcg5_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/086 ブビィ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ブビィ',
  name_normalized=public.normalize_card_name('ブビィ'),
  rarity='★',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-18/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブビィ',public.normalize_card_name('ブビィ'),'18','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-18/large','Scrydex public card image (pcg5_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/086 コータス
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='コータス',
  name_normalized=public.normalize_card_name('コータス'),
  rarity='★',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-19/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コータス',public.normalize_card_name('コータス'),'19','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-19/large','Scrydex public card image (pcg5_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/086 メノクラゲ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='メノクラゲ',
  name_normalized=public.normalize_card_name('メノクラゲ'),
  rarity='●',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-20/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メノクラゲ',public.normalize_card_name('メノクラゲ'),'20','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-20/large','Scrydex public card image (pcg5_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/086 ドククラゲ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ドククラゲ',
  name_normalized=public.normalize_card_name('ドククラゲ'),
  rarity='★',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-21/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドククラゲ',public.normalize_card_name('ドククラゲ'),'21','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-21/large','Scrydex public card image (pcg5_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/086 ラプラス
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ラプラス',
  name_normalized=public.normalize_card_name('ラプラス'),
  rarity='★',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-22/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラプラス',public.normalize_card_name('ラプラス'),'22','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-22/large','Scrydex public card image (pcg5_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/086 オムナイト
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='オムナイト',
  name_normalized=public.normalize_card_name('オムナイト'),
  rarity='●',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-23/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムナイト',public.normalize_card_name('オムナイト'),'23','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-23/large','Scrydex public card image (pcg5_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/086 オムスター
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='オムスター',
  name_normalized=public.normalize_card_name('オムスター'),
  rarity='★',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-24/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムスター',public.normalize_card_name('オムスター'),'24','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-24/large','Scrydex public card image (pcg5_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/086 ホエルコ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ホエルコ',
  name_normalized=public.normalize_card_name('ホエルコ'),
  rarity='●',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-25/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホエルコ',public.normalize_card_name('ホエルコ'),'25','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-25/large','Scrydex public card image (pcg5_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/086 ホエルオー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ホエルオー',
  name_normalized=public.normalize_card_name('ホエルオー'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-26/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホエルオー',public.normalize_card_name('ホエルオー'),'26','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-26/large','Scrydex public card image (pcg5_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/086 タマザラシ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='タマザラシ',
  name_normalized=public.normalize_card_name('タマザラシ'),
  rarity='●',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-27/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タマザラシ',public.normalize_card_name('タマザラシ'),'27','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-27/large','Scrydex public card image (pcg5_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/086 トドグラー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='トドグラー',
  name_normalized=public.normalize_card_name('トドグラー'),
  rarity='★',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-28/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トドグラー',public.normalize_card_name('トドグラー'),'28','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-28/large','Scrydex public card image (pcg5_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/086 トドゼルガex
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='トドゼルガex',
  name_normalized=public.normalize_card_name('トドゼルガex'),
  rarity='☆',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-29/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トドゼルガex',public.normalize_card_name('トドゼルガex'),'29','☆','normal','https://images.scrydex.com/pokemon/pcg5_ja-29/large','Scrydex public card image (pcg5_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/086 パールル
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='パールル',
  name_normalized=public.normalize_card_name('パールル'),
  rarity='●',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-30/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パールル',public.normalize_card_name('パールル'),'30','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-30/large','Scrydex public card image (pcg5_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/086 ハンテール
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ハンテール',
  name_normalized=public.normalize_card_name('ハンテール'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-31/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハンテール',public.normalize_card_name('ハンテール'),'31','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-31/large','Scrydex public card image (pcg5_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/086 サクラビス
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='サクラビス',
  name_normalized=public.normalize_card_name('サクラビス'),
  rarity='★',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-32/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サクラビス',public.normalize_card_name('サクラビス'),'32','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-32/large','Scrydex public card image (pcg5_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/086 レジアイス☆
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='レジアイス☆',
  name_normalized=public.normalize_card_name('レジアイス☆'),
  rarity='★',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-33/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レジアイス☆',public.normalize_card_name('レジアイス☆'),'33','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-33/large','Scrydex public card image (pcg5_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/086 コイル
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='コイル',
  name_normalized=public.normalize_card_name('コイル'),
  rarity='●',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-34/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コイル',public.normalize_card_name('コイル'),'34','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-34/large','Scrydex public card image (pcg5_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/086 レアコイル
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='レアコイル',
  name_normalized=public.normalize_card_name('レアコイル'),
  rarity='★',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-35/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レアコイル',public.normalize_card_name('レアコイル'),'35','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-35/large','Scrydex public card image (pcg5_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/086 チョンチー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='チョンチー',
  name_normalized=public.normalize_card_name('チョンチー'),
  rarity='●',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-36/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チョンチー',public.normalize_card_name('チョンチー'),'36','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-36/large','Scrydex public card image (pcg5_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/086 ランターン
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ランターン',
  name_normalized=public.normalize_card_name('ランターン'),
  rarity='★',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-37/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ランターン',public.normalize_card_name('ランターン'),'37','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-37/large','Scrydex public card image (pcg5_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/086 ゴース
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ゴース',
  name_normalized=public.normalize_card_name('ゴース'),
  rarity='●',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-38/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴース',public.normalize_card_name('ゴース'),'38','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-38/large','Scrydex public card image (pcg5_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/086 ゴースト
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ゴースト',
  name_normalized=public.normalize_card_name('ゴースト'),
  rarity='◆',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-39/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴースト',public.normalize_card_name('ゴースト'),'39','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-39/large','Scrydex public card image (pcg5_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/086 ゲンガー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ゲンガー',
  name_normalized=public.normalize_card_name('ゲンガー'),
  rarity='★',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-40/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゲンガー',public.normalize_card_name('ゲンガー'),'40','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-40/large','Scrydex public card image (pcg5_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/086 ミュウex
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ミュウex',
  name_normalized=public.normalize_card_name('ミュウex'),
  rarity='☆',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-41/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミュウex',public.normalize_card_name('ミュウex'),'41','☆','normal','https://images.scrydex.com/pokemon/pcg5_ja-41/large','Scrydex public card image (pcg5_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/086 ムウマ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ムウマ',
  name_normalized=public.normalize_card_name('ムウマ'),
  rarity='★',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-42/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ムウマ',public.normalize_card_name('ムウマ'),'42','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-42/large','Scrydex public card image (pcg5_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/086 ソーナンス
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ソーナンス',
  name_normalized=public.normalize_card_name('ソーナンス'),
  rarity='★',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-43/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ソーナンス',public.normalize_card_name('ソーナンス'),'43','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-43/large','Scrydex public card image (pcg5_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/086 キリンリキ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='キリンリキ',
  name_normalized=public.normalize_card_name('キリンリキ'),
  rarity='★',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-44/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キリンリキ',public.normalize_card_name('キリンリキ'),'44','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-44/large','Scrydex public card image (pcg5_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/086 ルナトーン
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ルナトーン',
  name_normalized=public.normalize_card_name('ルナトーン'),
  rarity='★',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-45/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ルナトーン',public.normalize_card_name('ルナトーン'),'45','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-45/large','Scrydex public card image (pcg5_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/086 ソーナノ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ソーナノ',
  name_normalized=public.normalize_card_name('ソーナノ'),
  rarity='★',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-46/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ソーナノ',public.normalize_card_name('ソーナノ'),'46','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-46/large','Scrydex public card image (pcg5_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/086 ワンリキー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ワンリキー',
  name_normalized=public.normalize_card_name('ワンリキー'),
  rarity='●',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-47/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワンリキー',public.normalize_card_name('ワンリキー'),'47','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-47/large','Scrydex public card image (pcg5_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/086 ゴーリキー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ゴーリキー',
  name_normalized=public.normalize_card_name('ゴーリキー'),
  rarity='★',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-48/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴーリキー',public.normalize_card_name('ゴーリキー'),'48','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-48/large','Scrydex public card image (pcg5_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/086 カイリキー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='カイリキー',
  name_normalized=public.normalize_card_name('カイリキー'),
  rarity='★',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-49/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイリキー',public.normalize_card_name('カイリキー'),'49','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-49/large','Scrydex public card image (pcg5_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/086 イシツブテ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='イシツブテ',
  name_normalized=public.normalize_card_name('イシツブテ'),
  rarity='●',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-50/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イシツブテ',public.normalize_card_name('イシツブテ'),'50','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-50/large','Scrydex public card image (pcg5_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/086 ゴローン
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ゴローン',
  name_normalized=public.normalize_card_name('ゴローン'),
  rarity='◆',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-51/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴローン',public.normalize_card_name('ゴローン'),'51','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-51/large','Scrydex public card image (pcg5_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/086 ゴローニャ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ゴローニャ',
  name_normalized=public.normalize_card_name('ゴローニャ'),
  rarity='★',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-52/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴローニャ',public.normalize_card_name('ゴローニャ'),'52','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-52/large','Scrydex public card image (pcg5_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/086 カブト
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='カブト',
  name_normalized=public.normalize_card_name('カブト'),
  rarity='★',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-53/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブト',public.normalize_card_name('カブト'),'53','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-53/large','Scrydex public card image (pcg5_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/086 カブトプス
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='カブトプス',
  name_normalized=public.normalize_card_name('カブトプス'),
  rarity='★',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-54/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブトプス',public.normalize_card_name('カブトプス'),'54','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-54/large','Scrydex public card image (pcg5_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/086 ナックラー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ナックラー',
  name_normalized=public.normalize_card_name('ナックラー'),
  rarity='●',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-55/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナックラー',public.normalize_card_name('ナックラー'),'55','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-55/large','Scrydex public card image (pcg5_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/086 ソルロック
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ソルロック',
  name_normalized=public.normalize_card_name('ソルロック'),
  rarity='★',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-56/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ソルロック',public.normalize_card_name('ソルロック'),'56','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-56/large','Scrydex public card image (pcg5_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/086 アノプス
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='アノプス',
  name_normalized=public.normalize_card_name('アノプス'),
  rarity='★',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-57/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アノプス',public.normalize_card_name('アノプス'),'57','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-57/large','Scrydex public card image (pcg5_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/086 アーマルドex
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='アーマルドex',
  name_normalized=public.normalize_card_name('アーマルドex'),
  rarity='☆',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-58/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーマルドex',public.normalize_card_name('アーマルドex'),'58','☆','normal','https://images.scrydex.com/pokemon/pcg5_ja-58/large','Scrydex public card image (pcg5_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/086 レジロック☆
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='レジロック☆',
  name_normalized=public.normalize_card_name('レジロック☆'),
  rarity='★',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-59/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レジロック☆',public.normalize_card_name('レジロック☆'),'59','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-59/large','Scrydex public card image (pcg5_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/086 プテラ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='プテラ',
  name_normalized=public.normalize_card_name('プテラ'),
  rarity='★',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-60/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プテラ',public.normalize_card_name('プテラ'),'60','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-60/large','Scrydex public card image (pcg5_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/086 ノコッチ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ノコッチ',
  name_normalized=public.normalize_card_name('ノコッチ'),
  rarity='◆',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-61/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ノコッチ',public.normalize_card_name('ノコッチ'),'61','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-61/large','Scrydex public card image (pcg5_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/086 エネコ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='エネコ',
  name_normalized=public.normalize_card_name('エネコ'),
  rarity='●',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-62/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコ',public.normalize_card_name('エネコ'),'62','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-62/large','Scrydex public card image (pcg5_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/086 エネコロロ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='エネコロロ',
  name_normalized=public.normalize_card_name('エネコロロ'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-63/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコロロ',public.normalize_card_name('エネコロロ'),'63','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-63/large','Scrydex public card image (pcg5_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/086 パッチール
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='パッチール',
  name_normalized=public.normalize_card_name('パッチール'),
  rarity='★',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-64/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パッチール',public.normalize_card_name('パッチール'),'64','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-64/large','Scrydex public card image (pcg5_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/086 ビブラーバ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ビブラーバ',
  name_normalized=public.normalize_card_name('ビブラーバ'),
  rarity='◆',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-65/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビブラーバ',public.normalize_card_name('ビブラーバ'),'65','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-65/large','Scrydex public card image (pcg5_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/086 フライゴンex
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='フライゴンex',
  name_normalized=public.normalize_card_name('フライゴンex'),
  rarity='☆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-66/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フライゴンex',public.normalize_card_name('フライゴンex'),'66','☆','normal','https://images.scrydex.com/pokemon/pcg5_ja-66/large','Scrydex public card image (pcg5_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/086 チルット
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='チルット',
  name_normalized=public.normalize_card_name('チルット'),
  rarity='●',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-67/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルット',public.normalize_card_name('チルット'),'67','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-67/large','Scrydex public card image (pcg5_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/086 チルタリスex
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='チルタリスex',
  name_normalized=public.normalize_card_name('チルタリスex'),
  rarity='☆',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-68/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルタリスex',public.normalize_card_name('チルタリスex'),'68','☆','normal','https://images.scrydex.com/pokemon/pcg5_ja-68/large','Scrydex public card image (pcg5_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/086 カクレオン
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='カクレオン',
  name_normalized=public.normalize_card_name('カクレオン'),
  rarity='★',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-69/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カクレオン',public.normalize_card_name('カクレオン'),'69','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-69/large','Scrydex public card image (pcg5_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/086 コノハナ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='コノハナ',
  name_normalized=public.normalize_card_name('コノハナ'),
  rarity='◆',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-70/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コノハナ',public.normalize_card_name('コノハナ'),'70','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-70/large','Scrydex public card image (pcg5_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/086 ダーテング
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ダーテング',
  name_normalized=public.normalize_card_name('ダーテング'),
  rarity='★',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-71/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダーテング',public.normalize_card_name('ダーテング'),'71','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-71/large','Scrydex public card image (pcg5_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/086 アブソル
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='アブソル',
  name_normalized=public.normalize_card_name('アブソル'),
  rarity='★',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-72/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アブソル',public.normalize_card_name('アブソル'),'72','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-72/large','Scrydex public card image (pcg5_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/086 ココドラ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ココドラ',
  name_normalized=public.normalize_card_name('ココドラ'),
  rarity='●',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-73/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ココドラ',public.normalize_card_name('ココドラ'),'73','●','normal','https://images.scrydex.com/pokemon/pcg5_ja-73/large','Scrydex public card image (pcg5_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/086 コドラ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='コドラ',
  name_normalized=public.normalize_card_name('コドラ'),
  rarity='◆',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-74/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コドラ',public.normalize_card_name('コドラ'),'74','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-74/large','Scrydex public card image (pcg5_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/086 ボスゴドラ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ボスゴドラ',
  name_normalized=public.normalize_card_name('ボスゴドラ'),
  rarity='★',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-75/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボスゴドラ',public.normalize_card_name('ボスゴドラ'),'75','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-75/large','Scrydex public card image (pcg5_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/086 レジスチル☆
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='レジスチル☆',
  name_normalized=public.normalize_card_name('レジスチル☆'),
  rarity='★',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-76/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レジスチル☆',public.normalize_card_name('レジスチル☆'),'76','★','normal','https://images.scrydex.com/pokemon/pcg5_ja-76/large','Scrydex public card image (pcg5_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/086 ツメの化石
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ツメの化石',
  name_normalized=public.normalize_card_name('ツメの化石'),
  rarity='◆',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-77/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ツメの化石',public.normalize_card_name('ツメの化石'),'77','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-77/large','Scrydex public card image (pcg5_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/086 なにかの化石
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='なにかの化石',
  name_normalized=public.normalize_card_name('なにかの化石'),
  rarity='◆',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-78/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'なにかの化石',public.normalize_card_name('なにかの化石'),'78','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-78/large','Scrydex public card image (pcg5_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/086 ねっこの化石
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='ねっこの化石',
  name_normalized=public.normalize_card_name('ねっこの化石'),
  rarity='◆',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-79/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ねっこの化石',public.normalize_card_name('ねっこの化石'),'79','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-79/large','Scrydex public card image (pcg5_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/086 フィールドワーカー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='フィールドワーカー',
  name_normalized=public.normalize_card_name('フィールドワーカー'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-80/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フィールドワーカー',public.normalize_card_name('フィールドワーカー'),'80','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-80/large','Scrydex public card image (pcg5_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/086 妖しい洞窟
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='妖しい洞窟',
  name_normalized=public.normalize_card_name('妖しい洞窟'),
  rarity='◆',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-81/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'妖しい洞窟',public.normalize_card_name('妖しい洞窟'),'81','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-81/large','Scrydex public card image (pcg5_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/086 消えない炎
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='消えない炎',
  name_normalized=public.normalize_card_name('消えない炎'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-82/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'消えない炎',public.normalize_card_name('消えない炎'),'82','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-82/large','Scrydex public card image (pcg5_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

-- 083/086 巨大な切りかぶ
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='巨大な切りかぶ',
  name_normalized=public.normalize_card_name('巨大な切りかぶ'),
  rarity='◆',
  set_order=83,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-83/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'巨大な切りかぶ',public.normalize_card_name('巨大な切りかぶ'),'83','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-83/large','Scrydex public card image (pcg5_ja)',true,83,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83'
);

-- 084/086 呪われたほこら
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='呪われたほこら',
  name_normalized=public.normalize_card_name('呪われたほこら'),
  rarity='◆',
  set_order=84,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-84/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'呪われたほこら',public.normalize_card_name('呪われたほこら'),'84','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-84/large','Scrydex public card image (pcg5_ja)',true,84,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84'
);

-- 085/086 不思議な大樹
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='不思議な大樹',
  name_normalized=public.normalize_card_name('不思議な大樹'),
  rarity='◆',
  set_order=85,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-85/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'不思議な大樹',public.normalize_card_name('不思議な大樹'),'85','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-85/large','Scrydex public card image (pcg5_ja)',true,85,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85'
);

-- 086/086 リアクトエネルギー
with st as (select id from public.card_sets where code='PCG5' limit 1)
update public.cards c set
  name='リアクトエネルギー',
  name_normalized=public.normalize_card_name('リアクトエネルギー'),
  rarity='◆',
  set_order=86,
  image_url='https://images.scrydex.com/pokemon/pcg5_ja-86/large',
  image_source_note='Scrydex public card image (pcg5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86';

with st as (select id from public.card_sets where code='PCG5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リアクトエネルギー',public.normalize_card_name('リアクトエネルギー'),'86','◆','normal','https://images.scrydex.com/pokemon/pcg5_ja-86/large','Scrydex public card image (pcg5_ja)',true,86,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86'
);

commit;

-- ============================================================
-- PCG5 監査
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
where cs.code = 'PCG5'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG5' as code,
  86 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG5'
having count(distinct c.set_order) <> 86;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG5'
group by c.set_order
having count(*) > 1
order by c.set_order;
