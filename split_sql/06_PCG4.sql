-- PCG4 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG4 拡張パック 金の空、銀の海 (106 cards)
update public.card_sets
set name='拡張パック 金の空、銀の海',
    release_date='2005-04-08'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG4%20Golden%20Sky%20Silvery%20Ocean%20pack.jpg'
where code='PCG4';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック 金の空、銀の海', 'PCG4', '2005-04-08'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG4%20Golden%20Sky%20Silvery%20Ocean%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG4');

-- 001/106 ナゾノクサ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ナゾノクサ',
  name_normalized=public.normalize_card_name('ナゾノクサ'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-1/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナゾノクサ',public.normalize_card_name('ナゾノクサ'),'1','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-1/large','Scrydex public card image (pcg4_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/106 クサイハナ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='クサイハナ',
  name_normalized=public.normalize_card_name('クサイハナ'),
  rarity='●',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-2/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クサイハナ',public.normalize_card_name('クサイハナ'),'2','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-2/large','Scrydex public card image (pcg4_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/106 ストライク
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ストライク',
  name_normalized=public.normalize_card_name('ストライク'),
  rarity='★',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-3/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ストライク',public.normalize_card_name('ストライク'),'3','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-3/large','Scrydex public card image (pcg4_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/106 メガニウム
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='メガニウム',
  name_normalized=public.normalize_card_name('メガニウム'),
  rarity='★',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-4/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メガニウム',public.normalize_card_name('メガニウム'),'4','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-4/large','Scrydex public card image (pcg4_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/106 イトマル
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='イトマル',
  name_normalized=public.normalize_card_name('イトマル'),
  rarity='●',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-5/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イトマル',public.normalize_card_name('イトマル'),'5','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-5/large','Scrydex public card image (pcg4_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/106 アリアドス
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アリアドス',
  name_normalized=public.normalize_card_name('アリアドス'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-6/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アリアドス',public.normalize_card_name('アリアドス'),'6','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-6/large','Scrydex public card image (pcg4_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/106 キレイハナ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='キレイハナ',
  name_normalized=public.normalize_card_name('キレイハナ'),
  rarity='★',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-7/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キレイハナ',public.normalize_card_name('キレイハナ'),'7','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-7/large','Scrydex public card image (pcg4_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/106 ヒマナッツ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヒマナッツ',
  name_normalized=public.normalize_card_name('ヒマナッツ'),
  rarity='●',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-8/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒマナッツ',public.normalize_card_name('ヒマナッツ'),'8','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-8/large','Scrydex public card image (pcg4_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/106 キマワリ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='キマワリ',
  name_normalized=public.normalize_card_name('キマワリ'),
  rarity='★',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-9/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キマワリ',public.normalize_card_name('キマワリ'),'9','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-9/large','Scrydex public card image (pcg4_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/106 ヤンヤンマ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヤンヤンマ',
  name_normalized=public.normalize_card_name('ヤンヤンマ'),
  rarity='◆',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-10/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤンヤンマ',public.normalize_card_name('ヤンヤンマ'),'10','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-10/large','Scrydex public card image (pcg4_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/106 クヌギダマ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='クヌギダマ',
  name_normalized=public.normalize_card_name('クヌギダマ'),
  rarity='●',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-11/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クヌギダマ',public.normalize_card_name('クヌギダマ'),'11','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-11/large','Scrydex public card image (pcg4_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/106 ツボツボ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ツボツボ',
  name_normalized=public.normalize_card_name('ツボツボ'),
  rarity='★',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-12/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ツボツボ',public.normalize_card_name('ツボツボ'),'12','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-12/large','Scrydex public card image (pcg4_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/106 ブースター
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ブースター',
  name_normalized=public.normalize_card_name('ブースター'),
  rarity='★',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-13/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブースター',public.normalize_card_name('ブースター'),'13','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-13/large','Scrydex public card image (pcg4_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/106 バクフーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='バクフーン',
  name_normalized=public.normalize_card_name('バクフーン'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-14/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バクフーン',public.normalize_card_name('バクフーン'),'14','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-14/large','Scrydex public card image (pcg4_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/106 マグマッグ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='マグマッグ',
  name_normalized=public.normalize_card_name('マグマッグ'),
  rarity='●',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-15/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマッグ',public.normalize_card_name('マグマッグ'),'15','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-15/large','Scrydex public card image (pcg4_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/106 マグカルゴ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='マグカルゴ',
  name_normalized=public.normalize_card_name('マグカルゴ'),
  rarity='★',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-16/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグカルゴ',public.normalize_card_name('マグカルゴ'),'16','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-16/large','Scrydex public card image (pcg4_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/106 デルビル
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='デルビル',
  name_normalized=public.normalize_card_name('デルビル'),
  rarity='●',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-17/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デルビル',public.normalize_card_name('デルビル'),'17','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-17/large','Scrydex public card image (pcg4_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/106 ヘルガー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヘルガー',
  name_normalized=public.normalize_card_name('ヘルガー'),
  rarity='★',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-18/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヘルガー',public.normalize_card_name('ヘルガー'),'18','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-18/large','Scrydex public card image (pcg4_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/106 エンテイ☆
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='エンテイ☆',
  name_normalized=public.normalize_card_name('エンテイ☆'),
  rarity='★',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-19/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エンテイ☆',public.normalize_card_name('エンテイ☆'),'19','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-19/large','Scrydex public card image (pcg4_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/106 ホウオウex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ホウオウex',
  name_normalized=public.normalize_card_name('ホウオウex'),
  rarity='☆',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-20/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホウオウex',public.normalize_card_name('ホウオウex'),'20','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-20/large','Scrydex public card image (pcg4_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/106 ニョロモ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ニョロモ',
  name_normalized=public.normalize_card_name('ニョロモ'),
  rarity='●',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-21/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニョロモ',public.normalize_card_name('ニョロモ'),'21','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-21/large','Scrydex public card image (pcg4_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/106 ニョロゾ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ニョロゾ',
  name_normalized=public.normalize_card_name('ニョロゾ'),
  rarity='●',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-22/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニョロゾ',public.normalize_card_name('ニョロゾ'),'22','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-22/large','Scrydex public card image (pcg4_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/106 ヤドラン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヤドラン',
  name_normalized=public.normalize_card_name('ヤドラン'),
  rarity='★',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-23/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドラン',public.normalize_card_name('ヤドラン'),'23','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-23/large','Scrydex public card image (pcg4_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/106 ルージュラ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ルージュラ',
  name_normalized=public.normalize_card_name('ルージュラ'),
  rarity='★',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-24/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ルージュラ',public.normalize_card_name('ルージュラ'),'24','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-24/large','Scrydex public card image (pcg4_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/106 シャワーズ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='シャワーズ',
  name_normalized=public.normalize_card_name('シャワーズ'),
  rarity='★',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-25/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シャワーズ',public.normalize_card_name('シャワーズ'),'25','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-25/large','Scrydex public card image (pcg4_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/106 オーダイル
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='オーダイル',
  name_normalized=public.normalize_card_name('オーダイル'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-26/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オーダイル',public.normalize_card_name('オーダイル'),'26','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-26/large','Scrydex public card image (pcg4_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/106 ニョロトノex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ニョロトノex',
  name_normalized=public.normalize_card_name('ニョロトノex'),
  rarity='☆',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-27/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニョロトノex',public.normalize_card_name('ニョロトノex'),'27','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-27/large','Scrydex public card image (pcg4_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/106 サニーゴ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='サニーゴ',
  name_normalized=public.normalize_card_name('サニーゴ'),
  rarity='★',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-28/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サニーゴ',public.normalize_card_name('サニーゴ'),'28','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-28/large','Scrydex public card image (pcg4_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/106 テッポウオ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='テッポウオ',
  name_normalized=public.normalize_card_name('テッポウオ'),
  rarity='●',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-29/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'テッポウオ',public.normalize_card_name('テッポウオ'),'29','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-29/large','Scrydex public card image (pcg4_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/106 オクタン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='オクタン',
  name_normalized=public.normalize_card_name('オクタン'),
  rarity='★',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-30/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オクタン',public.normalize_card_name('オクタン'),'30','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-30/large','Scrydex public card image (pcg4_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/106 ムチュール
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ムチュール',
  name_normalized=public.normalize_card_name('ムチュール'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-31/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ムチュール',public.normalize_card_name('ムチュール'),'31','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-31/large','Scrydex public card image (pcg4_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/106 スイクン☆
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='スイクン☆',
  name_normalized=public.normalize_card_name('スイクン☆'),
  rarity='★',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-32/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スイクン☆',public.normalize_card_name('スイクン☆'),'32','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-32/large','Scrydex public card image (pcg4_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/106 エレブー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='エレブー',
  name_normalized=public.normalize_card_name('エレブー'),
  rarity='★',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-33/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エレブー',public.normalize_card_name('エレブー'),'33','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-33/large','Scrydex public card image (pcg4_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/106 サンダース
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='サンダース',
  name_normalized=public.normalize_card_name('サンダース'),
  rarity='★',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-34/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンダース',public.normalize_card_name('サンダース'),'34','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-34/large','Scrydex public card image (pcg4_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/106 メリープ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='メリープ',
  name_normalized=public.normalize_card_name('メリープ'),
  rarity='●',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-35/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メリープ',public.normalize_card_name('メリープ'),'35','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-35/large','Scrydex public card image (pcg4_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/106 モココ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='モココ',
  name_normalized=public.normalize_card_name('モココ'),
  rarity='●',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-36/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'モココ',public.normalize_card_name('モココ'),'36','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-36/large','Scrydex public card image (pcg4_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/106 デンリュウ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='デンリュウ',
  name_normalized=public.normalize_card_name('デンリュウ'),
  rarity='★',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-37/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デンリュウ',public.normalize_card_name('デンリュウ'),'37','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-37/large','Scrydex public card image (pcg4_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/106 エレキッド
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='エレキッド',
  name_normalized=public.normalize_card_name('エレキッド'),
  rarity='★',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-38/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エレキッド',public.normalize_card_name('エレキッド'),'38','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-38/large','Scrydex public card image (pcg4_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/106 ライコウ☆
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ライコウ☆',
  name_normalized=public.normalize_card_name('ライコウ☆'),
  rarity='★',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-39/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ライコウ☆',public.normalize_card_name('ライコウ☆'),'39','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-39/large','Scrydex public card image (pcg4_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/106 ヤドン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヤドン',
  name_normalized=public.normalize_card_name('ヤドン'),
  rarity='●',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-40/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドン',public.normalize_card_name('ヤドン'),'40','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-40/large','Scrydex public card image (pcg4_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/106 エーフィex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='エーフィex',
  name_normalized=public.normalize_card_name('エーフィex'),
  rarity='☆',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-41/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エーフィex',public.normalize_card_name('エーフィex'),'41','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-41/large','Scrydex public card image (pcg4_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/106 ヤドキング
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヤドキング',
  name_normalized=public.normalize_card_name('ヤドキング'),
  rarity='★',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-42/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドキング',public.normalize_card_name('ヤドキング'),'42','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-42/large','Scrydex public card image (pcg4_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-43/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'43','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-43/large','Scrydex public card image (pcg4_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-44/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'44','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-44/large','Scrydex public card image (pcg4_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-45/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'45','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-45/large','Scrydex public card image (pcg4_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-46/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'46','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-46/large','Scrydex public card image (pcg4_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-47/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'47','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-47/large','Scrydex public card image (pcg4_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-48/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'48','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-48/large','Scrydex public card image (pcg4_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-49/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'49','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-49/large','Scrydex public card image (pcg4_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-50/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'50','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-50/large','Scrydex public card image (pcg4_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-51/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'51','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-51/large','Scrydex public card image (pcg4_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-52/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'52','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-52/large','Scrydex public card image (pcg4_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-53/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'53','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-53/large','Scrydex public card image (pcg4_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-54/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'54','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-54/large','Scrydex public card image (pcg4_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-55/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'55','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-55/large','Scrydex public card image (pcg4_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-56/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'56','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-56/large','Scrydex public card image (pcg4_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-57/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'57','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-57/large','Scrydex public card image (pcg4_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-58/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'58','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-58/large','Scrydex public card image (pcg4_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-59/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'59','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-59/large','Scrydex public card image (pcg4_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-60/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'60','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-60/large','Scrydex public card image (pcg4_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-61/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'61','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-61/large','Scrydex public card image (pcg4_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-62/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'62','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-62/large','Scrydex public card image (pcg4_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-63/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'63','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-63/large','Scrydex public card image (pcg4_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-64/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'64','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-64/large','Scrydex public card image (pcg4_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='●',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-65/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'65','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-65/large','Scrydex public card image (pcg4_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-66/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'66','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-66/large','Scrydex public card image (pcg4_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/106 アンノーン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='アンノーン',
  name_normalized=public.normalize_card_name('アンノーン'),
  rarity='◆',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-67/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アンノーン',public.normalize_card_name('アンノーン'),'67','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-67/large','Scrydex public card image (pcg4_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/106 ニョロボン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ニョロボン',
  name_normalized=public.normalize_card_name('ニョロボン'),
  rarity='★',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-68/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニョロボン',public.normalize_card_name('ニョロボン'),'68','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-68/large','Scrydex public card image (pcg4_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/106 イワーク
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='イワーク',
  name_normalized=public.normalize_card_name('イワーク'),
  rarity='●',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-69/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イワーク',public.normalize_card_name('イワーク'),'69','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-69/large','Scrydex public card image (pcg4_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/106 サワムラー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='サワムラー',
  name_normalized=public.normalize_card_name('サワムラー'),
  rarity='★',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-70/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サワムラー',public.normalize_card_name('サワムラー'),'70','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-70/large','Scrydex public card image (pcg4_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/106 エビワラー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='エビワラー',
  name_normalized=public.normalize_card_name('エビワラー'),
  rarity='★',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-71/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エビワラー',public.normalize_card_name('エビワラー'),'71','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-71/large','Scrydex public card image (pcg4_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/106 ウソッキー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ウソッキー',
  name_normalized=public.normalize_card_name('ウソッキー'),
  rarity='★',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-72/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウソッキー',public.normalize_card_name('ウソッキー'),'72','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-72/large','Scrydex public card image (pcg4_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/106 グライガー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='グライガー',
  name_normalized=public.normalize_card_name('グライガー'),
  rarity='◆',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-73/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'グライガー',public.normalize_card_name('グライガー'),'73','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-73/large','Scrydex public card image (pcg4_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/106 バルキー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='バルキー',
  name_normalized=public.normalize_card_name('バルキー'),
  rarity='★',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-74/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バルキー',public.normalize_card_name('バルキー'),'74','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-74/large','Scrydex public card image (pcg4_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/106 カポエラー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='カポエラー',
  name_normalized=public.normalize_card_name('カポエラー'),
  rarity='★',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-75/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カポエラー',public.normalize_card_name('カポエラー'),'75','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-75/large','Scrydex public card image (pcg4_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/106 ヨーギラス
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヨーギラス',
  name_normalized=public.normalize_card_name('ヨーギラス'),
  rarity='●',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-76/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヨーギラス',public.normalize_card_name('ヨーギラス'),'76','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-76/large','Scrydex public card image (pcg4_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/106 サナギラス
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='サナギラス',
  name_normalized=public.normalize_card_name('サナギラス'),
  rarity='●',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-77/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サナギラス',public.normalize_card_name('サナギラス'),'77','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-77/large','Scrydex public card image (pcg4_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/106 ラッキー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ラッキー',
  name_normalized=public.normalize_card_name('ラッキー'),
  rarity='★',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-78/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラッキー',public.normalize_card_name('ラッキー'),'78','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-78/large','Scrydex public card image (pcg4_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/106 イーブイ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='イーブイ',
  name_normalized=public.normalize_card_name('イーブイ'),
  rarity='●',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-79/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イーブイ',public.normalize_card_name('イーブイ'),'79','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-79/large','Scrydex public card image (pcg4_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/106 ポリゴン
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ポリゴン',
  name_normalized=public.normalize_card_name('ポリゴン'),
  rarity='●',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-80/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポリゴン',public.normalize_card_name('ポリゴン'),'80','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-80/large','Scrydex public card image (pcg4_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/106 ピィ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ピィ',
  name_normalized=public.normalize_card_name('ピィ'),
  rarity='★',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-81/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピィ',public.normalize_card_name('ピィ'),'81','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-81/large','Scrydex public card image (pcg4_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/106 エイパム
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='エイパム',
  name_normalized=public.normalize_card_name('エイパム'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-82/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エイパム',public.normalize_card_name('エイパム'),'82','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-82/large','Scrydex public card image (pcg4_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

-- 083/106 ヒメグマ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヒメグマ',
  name_normalized=public.normalize_card_name('ヒメグマ'),
  rarity='●',
  set_order=83,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-83/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒメグマ',public.normalize_card_name('ヒメグマ'),'83','●','normal','https://images.scrydex.com/pokemon/pcg4_ja-83/large','Scrydex public card image (pcg4_ja)',true,83,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83'
);

-- 084/106 リングマ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='リングマ',
  name_normalized=public.normalize_card_name('リングマ'),
  rarity='★',
  set_order=84,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-84/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リングマ',public.normalize_card_name('リングマ'),'84','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-84/large','Scrydex public card image (pcg4_ja)',true,84,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84'
);

-- 085/106 ポリゴン2
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ポリゴン2',
  name_normalized=public.normalize_card_name('ポリゴン2'),
  rarity='★',
  set_order=85,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-85/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポリゴン2',public.normalize_card_name('ポリゴン2'),'85','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-85/large','Scrydex public card image (pcg4_ja)',true,85,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85'
);

-- 086/106 オドシシ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='オドシシ',
  name_normalized=public.normalize_card_name('オドシシ'),
  rarity='★',
  set_order=86,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-86/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オドシシ',public.normalize_card_name('オドシシ'),'86','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-86/large','Scrydex public card image (pcg4_ja)',true,86,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86'
);

-- 087/106 ドーブル
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ドーブル',
  name_normalized=public.normalize_card_name('ドーブル'),
  rarity='★',
  set_order=87,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-87/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '87';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドーブル',public.normalize_card_name('ドーブル'),'87','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-87/large','Scrydex public card image (pcg4_ja)',true,87,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '87'
);

-- 088/106 ミルタンク
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ミルタンク',
  name_normalized=public.normalize_card_name('ミルタンク'),
  rarity='◆',
  set_order=88,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-88/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '88';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミルタンク',public.normalize_card_name('ミルタンク'),'88','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-88/large','Scrydex public card image (pcg4_ja)',true,88,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '88'
);

-- 089/106 ハピナスex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ハピナスex',
  name_normalized=public.normalize_card_name('ハピナスex'),
  rarity='☆',
  set_order=89,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-89/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '89';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハピナスex',public.normalize_card_name('ハピナスex'),'89','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-89/large','Scrydex public card image (pcg4_ja)',true,89,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '89'
);

-- 090/106 ルギアex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ルギアex',
  name_normalized=public.normalize_card_name('ルギアex'),
  rarity='☆',
  set_order=90,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-90/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '90';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ルギアex',public.normalize_card_name('ルギアex'),'90','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-90/large','Scrydex public card image (pcg4_ja)',true,90,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '90'
);

-- 091/106 ブラッキーex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ブラッキーex',
  name_normalized=public.normalize_card_name('ブラッキーex'),
  rarity='☆',
  set_order=91,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-91/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '91';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブラッキーex',public.normalize_card_name('ブラッキーex'),'91','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-91/large','Scrydex public card image (pcg4_ja)',true,91,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '91'
);

-- 092/106 ヤミカラス
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ヤミカラス',
  name_normalized=public.normalize_card_name('ヤミカラス'),
  rarity='★',
  set_order=92,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-92/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '92';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤミカラス',public.normalize_card_name('ヤミカラス'),'92','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-92/large','Scrydex public card image (pcg4_ja)',true,92,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '92'
);

-- 093/106 バンギラスex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='バンギラスex',
  name_normalized=public.normalize_card_name('バンギラスex'),
  rarity='☆',
  set_order=93,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-93/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '93';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バンギラスex',public.normalize_card_name('バンギラスex'),'93','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-93/large','Scrydex public card image (pcg4_ja)',true,93,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '93'
);

-- 094/106 フォレトス
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='フォレトス',
  name_normalized=public.normalize_card_name('フォレトス'),
  rarity='★',
  set_order=94,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-94/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '94';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フォレトス',public.normalize_card_name('フォレトス'),'94','★','normal','https://images.scrydex.com/pokemon/pcg4_ja-94/large','Scrydex public card image (pcg4_ja)',true,94,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '94'
);

-- 095/106 ハガネールex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ハガネールex',
  name_normalized=public.normalize_card_name('ハガネールex'),
  rarity='☆',
  set_order=95,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-95/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '95';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハガネールex',public.normalize_card_name('ハガネールex'),'95','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-95/large','Scrydex public card image (pcg4_ja)',true,95,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '95'
);

-- 096/106 ハッサムex
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ハッサムex',
  name_normalized=public.normalize_card_name('ハッサムex'),
  rarity='☆',
  set_order=96,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-96/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '96';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハッサムex',public.normalize_card_name('ハッサムex'),'96','☆','normal','https://images.scrydex.com/pokemon/pcg4_ja-96/large','Scrydex public card image (pcg4_ja)',true,96,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '96'
);

-- 097/106 ウツギはかせの育てかた
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ウツギはかせの育てかた',
  name_normalized=public.normalize_card_name('ウツギはかせの育てかた'),
  rarity='◆',
  set_order=97,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-97/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '97';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウツギはかせの育てかた',public.normalize_card_name('ウツギはかせの育てかた'),'97','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-97/large','Scrydex public card image (pcg4_ja)',true,97,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '97'
);

-- 098/106 クルミのリクエスト
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='クルミのリクエスト',
  name_normalized=public.normalize_card_name('クルミのリクエスト'),
  rarity='◆',
  set_order=98,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-98/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '98';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クルミのリクエスト',public.normalize_card_name('クルミのリクエスト'),'98','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-98/large','Scrydex public card image (pcg4_ja)',true,98,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '98'
);

-- 099/106 いかりの結晶
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='いかりの結晶',
  name_normalized=public.normalize_card_name('いかりの結晶'),
  rarity='◆',
  set_order=99,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-99/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '99';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'いかりの結晶',public.normalize_card_name('いかりの結晶'),'99','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-99/large','Scrydex public card image (pcg4_ja)',true,99,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '99'
);

-- 100/106 オボンのみ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='オボンのみ',
  name_normalized=public.normalize_card_name('オボンのみ'),
  rarity='◆',
  set_order=100,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-100/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '100';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オボンのみ',public.normalize_card_name('オボンのみ'),'100','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-100/large','Scrydex public card image (pcg4_ja)',true,100,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '100'
);

-- 101/106 ちからのねっこ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ちからのねっこ',
  name_normalized=public.normalize_card_name('ちからのねっこ'),
  rarity='◆',
  set_order=101,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-101/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '101';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ちからのねっこ',public.normalize_card_name('ちからのねっこ'),'101','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-101/large','Scrydex public card image (pcg4_ja)',true,101,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '101'
);

-- 102/106 のろいのこな
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='のろいのこな',
  name_normalized=public.normalize_card_name('のろいのこな'),
  rarity='◆',
  set_order=102,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-102/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '102';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'のろいのこな',public.normalize_card_name('のろいのこな'),'102','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-102/large','Scrydex public card image (pcg4_ja)',true,102,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '102'
);

-- 103/106 ふわふわのみ
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ふわふわのみ',
  name_normalized=public.normalize_card_name('ふわふわのみ'),
  rarity='◆',
  set_order=103,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-103/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '103';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ふわふわのみ',public.normalize_card_name('ふわふわのみ'),'103','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-103/large','Scrydex public card image (pcg4_ja)',true,103,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '103'
);

-- 104/106 まもりのたま
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='まもりのたま',
  name_normalized=public.normalize_card_name('まもりのたま'),
  rarity='◆',
  set_order=104,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-104/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '104';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'まもりのたま',public.normalize_card_name('まもりのたま'),'104','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-104/large','Scrydex public card image (pcg4_ja)',true,104,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '104'
);

-- 105/106 サイクロンエネルギー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='サイクロンエネルギー',
  name_normalized=public.normalize_card_name('サイクロンエネルギー'),
  rarity='◆',
  set_order=105,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-105/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '105';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サイクロンエネルギー',public.normalize_card_name('サイクロンエネルギー'),'105','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-105/large','Scrydex public card image (pcg4_ja)',true,105,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '105'
);

-- 106/106 ワープエネルギー
with st as (select id from public.card_sets where code='PCG4' limit 1)
update public.cards c set
  name='ワープエネルギー',
  name_normalized=public.normalize_card_name('ワープエネルギー'),
  rarity='◆',
  set_order=106,
  image_url='https://images.scrydex.com/pokemon/pcg4_ja-106/large',
  image_source_note='Scrydex public card image (pcg4_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '106';

with st as (select id from public.card_sets where code='PCG4' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワープエネルギー',public.normalize_card_name('ワープエネルギー'),'106','◆','normal','https://images.scrydex.com/pokemon/pcg4_ja-106/large','Scrydex public card image (pcg4_ja)',true,106,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '106'
);

commit;

-- ============================================================
-- PCG4 監査
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
where cs.code = 'PCG4'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG4' as code,
  106 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG4'
having count(distinct c.set_order) <> 106;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG4'
group by c.set_order
having count(*) > 1
order by c.set_order;
