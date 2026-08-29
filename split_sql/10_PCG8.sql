-- PCG8 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG8 拡張パック きせきの結晶 (75 cards)
update public.card_sets
set name='拡張パック きせきの結晶',
    release_date='2006-03-10'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG8%20Miracle%20Crystal%20pack.jpg'
where code='PCG8';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック きせきの結晶', 'PCG8', '2006-03-10'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG8%20Miracle%20Crystal%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG8');

-- 001/075 フシギダネ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='フシギダネ',
  name_normalized=public.normalize_card_name('フシギダネ'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-1/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フシギダネ',public.normalize_card_name('フシギダネ'),'1','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-1/large','Scrydex public card image (pcg8_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/075 フシギソウ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='フシギソウ',
  name_normalized=public.normalize_card_name('フシギソウ'),
  rarity='◆',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-2/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フシギソウ',public.normalize_card_name('フシギソウ'),'2','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-2/large','Scrydex public card image (pcg8_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/075 フシギバナ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='フシギバナ',
  name_normalized=public.normalize_card_name('フシギバナ'),
  rarity='★',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-3/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フシギバナ',public.normalize_card_name('フシギバナ'),'3','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-3/large','Scrydex public card image (pcg8_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/075 セレビィ☆
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='セレビィ☆',
  name_normalized=public.normalize_card_name('セレビィ☆'),
  rarity='★',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-4/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'セレビィ☆',public.normalize_card_name('セレビィ☆'),'4','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-4/large','Scrydex public card image (pcg8_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/075 キモリ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='キモリ',
  name_normalized=public.normalize_card_name('キモリ'),
  rarity='●',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-5/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キモリ',public.normalize_card_name('キモリ'),'5','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-5/large','Scrydex public card image (pcg8_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/075 ジュプトル
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ジュプトル',
  name_normalized=public.normalize_card_name('ジュプトル'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-6/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュプトル',public.normalize_card_name('ジュプトル'),'6','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-6/large','Scrydex public card image (pcg8_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/075 タネボー
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='タネボー',
  name_normalized=public.normalize_card_name('タネボー'),
  rarity='●',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-7/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タネボー',public.normalize_card_name('タネボー'),'7','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-7/large','Scrydex public card image (pcg8_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/075 ゴクリン
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ゴクリン',
  name_normalized=public.normalize_card_name('ゴクリン'),
  rarity='◆',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-8/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴクリン',public.normalize_card_name('ゴクリン'),'8','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-8/large','Scrydex public card image (pcg8_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/075 マルノーム
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='マルノーム',
  name_normalized=public.normalize_card_name('マルノーム'),
  rarity='★',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-9/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マルノーム',public.normalize_card_name('マルノーム'),'9','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-9/large','Scrydex public card image (pcg8_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/075 サボネア
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='サボネア',
  name_normalized=public.normalize_card_name('サボネア'),
  rarity='◆',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-10/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サボネア',public.normalize_card_name('サボネア'),'10','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-10/large','Scrydex public card image (pcg8_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/075 ヒトカゲ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ヒトカゲ',
  name_normalized=public.normalize_card_name('ヒトカゲ'),
  rarity='●',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-11/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒトカゲ',public.normalize_card_name('ヒトカゲ'),'11','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-11/large','Scrydex public card image (pcg8_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/075 リザード
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='リザード',
  name_normalized=public.normalize_card_name('リザード'),
  rarity='◆',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-12/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リザード',public.normalize_card_name('リザード'),'12','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-12/large','Scrydex public card image (pcg8_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/075 アチャモ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='アチャモ',
  name_normalized=public.normalize_card_name('アチャモ'),
  rarity='●',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-13/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アチャモ',public.normalize_card_name('アチャモ'),'13','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-13/large','Scrydex public card image (pcg8_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/075 ルンパッパδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ルンパッパδ-デルタ種',
  name_normalized=public.normalize_card_name('ルンパッパδ-デルタ種'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-14/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ルンパッパδ-デルタ種',public.normalize_card_name('ルンパッパδ-デルタ種'),'14','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-14/large','Scrydex public card image (pcg8_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/075 ドンメル
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ドンメル',
  name_normalized=public.normalize_card_name('ドンメル'),
  rarity='●',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-15/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドンメル',public.normalize_card_name('ドンメル'),'15','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-15/large','Scrydex public card image (pcg8_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/075 バクーダ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='バクーダ',
  name_normalized=public.normalize_card_name('バクーダ'),
  rarity='★',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-16/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バクーダ',public.normalize_card_name('バクーダ'),'16','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-16/large','Scrydex public card image (pcg8_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/075 キングラーδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='キングラーδ-デルタ種',
  name_normalized=public.normalize_card_name('キングラーδ-デルタ種'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-17/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キングラーδ-デルタ種',public.normalize_card_name('キングラーδ-デルタ種'),'17','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-17/large','Scrydex public card image (pcg8_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/075 ゼニガメ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ゼニガメ',
  name_normalized=public.normalize_card_name('ゼニガメ'),
  rarity='●',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-18/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゼニガメ',public.normalize_card_name('ゼニガメ'),'18','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-18/large','Scrydex public card image (pcg8_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/075 カメール
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='カメール',
  name_normalized=public.normalize_card_name('カメール'),
  rarity='◆',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-19/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カメール',public.normalize_card_name('カメール'),'19','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-19/large','Scrydex public card image (pcg8_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/075 クラブ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='クラブ',
  name_normalized=public.normalize_card_name('クラブ'),
  rarity='◆',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-20/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クラブ',public.normalize_card_name('クラブ'),'20','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-20/large','Scrydex public card image (pcg8_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/075 ミズゴロウ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ミズゴロウ',
  name_normalized=public.normalize_card_name('ミズゴロウ'),
  rarity='●',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-21/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミズゴロウ',public.normalize_card_name('ミズゴロウ'),'21','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-21/large','Scrydex public card image (pcg8_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/075 ヌマクロー
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ヌマクロー',
  name_normalized=public.normalize_card_name('ヌマクロー'),
  rarity='★',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-22/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヌマクロー',public.normalize_card_name('ヌマクロー'),'22','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-22/large','Scrydex public card image (pcg8_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/075 ラグラージex
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ラグラージex',
  name_normalized=public.normalize_card_name('ラグラージex'),
  rarity='☆',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-23/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラグラージex',public.normalize_card_name('ラグラージex'),'23','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-23/large','Scrydex public card image (pcg8_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/075 ハスボー
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ハスボー',
  name_normalized=public.normalize_card_name('ハスボー'),
  rarity='●',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-24/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハスボー',public.normalize_card_name('ハスボー'),'24','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-24/large','Scrydex public card image (pcg8_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/075 ハスブレロ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ハスブレロ',
  name_normalized=public.normalize_card_name('ハスブレロ'),
  rarity='★',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-25/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハスブレロ',public.normalize_card_name('ハスブレロ'),'25','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-25/large','Scrydex public card image (pcg8_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/075 キャモメ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='キャモメ',
  name_normalized=public.normalize_card_name('キャモメ'),
  rarity='●',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-26/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キャモメ',public.normalize_card_name('キャモメ'),'26','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-26/large','Scrydex public card image (pcg8_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/075 ラブカス
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ラブカス',
  name_normalized=public.normalize_card_name('ラブカス'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-27/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラブカス',public.normalize_card_name('ラブカス'),'27','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-27/large','Scrydex public card image (pcg8_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/075 オニドリルδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='オニドリルδ-デルタ種',
  name_normalized=public.normalize_card_name('オニドリルδ-デルタ種'),
  rarity='★',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-28/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オニドリルδ-デルタ種',public.normalize_card_name('オニドリルδ-デルタ種'),'28','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-28/large','Scrydex public card image (pcg8_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/075 ペリッパーδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ペリッパーδ-デルタ種',
  name_normalized=public.normalize_card_name('ペリッパーδ-デルタ種'),
  rarity='★',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-29/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ペリッパーδ-デルタ種',public.normalize_card_name('ペリッパーδ-デルタ種'),'29','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-29/large','Scrydex public card image (pcg8_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/075 ラクライ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ラクライ',
  name_normalized=public.normalize_card_name('ラクライ'),
  rarity='●',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-30/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラクライ',public.normalize_card_name('ラクライ'),'30','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-30/large','Scrydex public card image (pcg8_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/075 ライボルト
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ライボルト',
  name_normalized=public.normalize_card_name('ライボルト'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-31/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ライボルト',public.normalize_card_name('ライボルト'),'31','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-31/large','Scrydex public card image (pcg8_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/075 リザードンδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='リザードンδ-デルタ種',
  name_normalized=public.normalize_card_name('リザードンδ-デルタ種'),
  rarity='★',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-32/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リザードンδ-デルタ種',public.normalize_card_name('リザードンδ-デルタ種'),'32','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-32/large','Scrydex public card image (pcg8_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/075 フーディン☆
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='フーディン☆',
  name_normalized=public.normalize_card_name('フーディン☆'),
  rarity='★',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-33/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フーディン☆',public.normalize_card_name('フーディン☆'),'33','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-33/large','Scrydex public card image (pcg8_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/075 ジュカインexδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ジュカインexδ-デルタ種',
  name_normalized=public.normalize_card_name('ジュカインexδ-デルタ種'),
  rarity='☆',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-34/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュカインexδ-デルタ種',public.normalize_card_name('ジュカインexδ-デルタ種'),'34','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-34/large','Scrydex public card image (pcg8_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/075 バネブー
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='バネブー',
  name_normalized=public.normalize_card_name('バネブー'),
  rarity='●',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-35/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バネブー',public.normalize_card_name('バネブー'),'35','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-35/large','Scrydex public card image (pcg8_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/075 ブーピッグ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ブーピッグ',
  name_normalized=public.normalize_card_name('ブーピッグ'),
  rarity='★',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-36/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブーピッグ',public.normalize_card_name('ブーピッグ'),'36','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-36/large','Scrydex public card image (pcg8_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/075 カゲボウズ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='カゲボウズ',
  name_normalized=public.normalize_card_name('カゲボウズ'),
  rarity='◆',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-37/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カゲボウズ',public.normalize_card_name('カゲボウズ'),'37','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-37/large','Scrydex public card image (pcg8_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/075 ジュペッタ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ジュペッタ',
  name_normalized=public.normalize_card_name('ジュペッタ'),
  rarity='★',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-38/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュペッタ',public.normalize_card_name('ジュペッタ'),'38','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-38/large','Scrydex public card image (pcg8_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/075 ヨマワル
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ヨマワル',
  name_normalized=public.normalize_card_name('ヨマワル'),
  rarity='●',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-39/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヨマワル',public.normalize_card_name('ヨマワル'),'39','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-39/large','Scrydex public card image (pcg8_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/075 サマヨール
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='サマヨール',
  name_normalized=public.normalize_card_name('サマヨール'),
  rarity='★',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-40/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サマヨール',public.normalize_card_name('サマヨール'),'40','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-40/large','Scrydex public card image (pcg8_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/075 ジラーチex
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ジラーチex',
  name_normalized=public.normalize_card_name('ジラーチex'),
  rarity='☆',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-41/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジラーチex',public.normalize_card_name('ジラーチex'),'41','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-41/large','Scrydex public card image (pcg8_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/075 ディグダ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ディグダ',
  name_normalized=public.normalize_card_name('ディグダ'),
  rarity='●',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-42/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ディグダ',public.normalize_card_name('ディグダ'),'42','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-42/large','Scrydex public card image (pcg8_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/075 ダグトリオ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ダグトリオ',
  name_normalized=public.normalize_card_name('ダグトリオ'),
  rarity='★',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-43/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダグトリオ',public.normalize_card_name('ダグトリオ'),'43','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-43/large','Scrydex public card image (pcg8_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/075 ワカシャモ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ワカシャモ',
  name_normalized=public.normalize_card_name('ワカシャモ'),
  rarity='★',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-44/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワカシャモ',public.normalize_card_name('ワカシャモ'),'44','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-44/large','Scrydex public card image (pcg8_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/075 バシャーモex
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='バシャーモex',
  name_normalized=public.normalize_card_name('バシャーモex'),
  rarity='☆',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-45/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バシャーモex',public.normalize_card_name('バシャーモex'),'45','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-45/large','Scrydex public card image (pcg8_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/075 アサナン
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='アサナン',
  name_normalized=public.normalize_card_name('アサナン'),
  rarity='●',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-46/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アサナン',public.normalize_card_name('アサナン'),'46','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-46/large','Scrydex public card image (pcg8_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/075 チャーレム
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='チャーレム',
  name_normalized=public.normalize_card_name('チャーレム'),
  rarity='★',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-47/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チャーレム',public.normalize_card_name('チャーレム'),'47','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-47/large','Scrydex public card image (pcg8_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/075 ノクタスδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ノクタスδ-デルタ種',
  name_normalized=public.normalize_card_name('ノクタスδ-デルタ種'),
  rarity='★',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-48/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ノクタスδ-デルタ種',public.normalize_card_name('ノクタスδ-デルタ種'),'48','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-48/large','Scrydex public card image (pcg8_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/075 カメックスδ-デルタ種
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='カメックスδ-デルタ種',
  name_normalized=public.normalize_card_name('カメックスδ-デルタ種'),
  rarity='★',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-49/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カメックスδ-デルタ種',public.normalize_card_name('カメックスδ-デルタ種'),'49','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-49/large','Scrydex public card image (pcg8_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/075 オニスズメ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='オニスズメ',
  name_normalized=public.normalize_card_name('オニスズメ'),
  rarity='●',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-50/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オニスズメ',public.normalize_card_name('オニスズメ'),'50','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-50/large','Scrydex public card image (pcg8_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/075 プリン
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='プリン',
  name_normalized=public.normalize_card_name('プリン'),
  rarity='●',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-51/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プリン',public.normalize_card_name('プリン'),'51','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-51/large','Scrydex public card image (pcg8_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/075 プクリン
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='プクリン',
  name_normalized=public.normalize_card_name('プクリン'),
  rarity='★',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-52/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プクリン',public.normalize_card_name('プクリン'),'52','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-52/large','Scrydex public card image (pcg8_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/075 ケンタロス
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ケンタロス',
  name_normalized=public.normalize_card_name('ケンタロス'),
  rarity='★',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-53/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ケンタロス',public.normalize_card_name('ケンタロス'),'53','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-53/large','Scrydex public card image (pcg8_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/075 ププリン
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ププリン',
  name_normalized=public.normalize_card_name('ププリン'),
  rarity='★',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-54/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ププリン',public.normalize_card_name('ププリン'),'54','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-54/large','Scrydex public card image (pcg8_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/075 ゴニョニョ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ゴニョニョ',
  name_normalized=public.normalize_card_name('ゴニョニョ'),
  rarity='●',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-55/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴニョニョ',public.normalize_card_name('ゴニョニョ'),'55','●','normal','https://images.scrydex.com/pokemon/pcg8_ja-55/large','Scrydex public card image (pcg8_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/075 ドゴーム
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ドゴーム',
  name_normalized=public.normalize_card_name('ドゴーム'),
  rarity='★',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-56/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドゴーム',public.normalize_card_name('ドゴーム'),'56','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-56/large','Scrydex public card image (pcg8_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/075 バクオングex
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='バクオングex',
  name_normalized=public.normalize_card_name('バクオングex'),
  rarity='☆',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-57/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バクオングex',public.normalize_card_name('バクオングex'),'57','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-57/large','Scrydex public card image (pcg8_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/075 エネコ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='エネコ',
  name_normalized=public.normalize_card_name('エネコ'),
  rarity='◆',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-58/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコ',public.normalize_card_name('エネコ'),'58','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-58/large','Scrydex public card image (pcg8_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/075 エネコロロex
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='エネコロロex',
  name_normalized=public.normalize_card_name('エネコロロex'),
  rarity='☆',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-59/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコロロex',public.normalize_card_name('エネコロロex'),'59','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-59/large','Scrydex public card image (pcg8_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/075 コノハナ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='コノハナ',
  name_normalized=public.normalize_card_name('コノハナ'),
  rarity='★',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-60/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コノハナ',public.normalize_card_name('コノハナ'),'60','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-60/large','Scrydex public card image (pcg8_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/075 ダーテングex
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ダーテングex',
  name_normalized=public.normalize_card_name('ダーテングex'),
  rarity='☆',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-61/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダーテングex',public.normalize_card_name('ダーテングex'),'61','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-61/large','Scrydex public card image (pcg8_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/075 ヤミラミ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ヤミラミ',
  name_normalized=public.normalize_card_name('ヤミラミ'),
  rarity='★',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-62/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤミラミ',public.normalize_card_name('ヤミラミ'),'62','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-62/large','Scrydex public card image (pcg8_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/075 クチート
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='クチート',
  name_normalized=public.normalize_card_name('クチート'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-63/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クチート',public.normalize_card_name('クチート'),'63','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-63/large','Scrydex public card image (pcg8_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/075 ココドラ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ココドラ',
  name_normalized=public.normalize_card_name('ココドラ'),
  rarity='◆',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-64/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ココドラ',public.normalize_card_name('ココドラ'),'64','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-64/large','Scrydex public card image (pcg8_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/075 コドラ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='コドラ',
  name_normalized=public.normalize_card_name('コドラ'),
  rarity='★',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-65/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コドラ',public.normalize_card_name('コドラ'),'65','★','normal','https://images.scrydex.com/pokemon/pcg8_ja-65/large','Scrydex public card image (pcg8_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/075 ボスゴドラex
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ボスゴドラex',
  name_normalized=public.normalize_card_name('ボスゴドラex'),
  rarity='☆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-66/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボスゴドラex',public.normalize_card_name('ボスゴドラex'),'66','☆','normal','https://images.scrydex.com/pokemon/pcg8_ja-66/large','Scrydex public card image (pcg8_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/075 暴風
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='暴風',
  name_normalized=public.normalize_card_name('暴風'),
  rarity='◆',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-67/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'暴風',public.normalize_card_name('暴風'),'67','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-67/large','Scrydex public card image (pcg8_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/075 漂流者
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='漂流者',
  name_normalized=public.normalize_card_name('漂流者'),
  rarity='◆',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-68/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'漂流者',public.normalize_card_name('漂流者'),'68','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-68/large','Scrydex public card image (pcg8_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/075 思い出のみ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='思い出のみ',
  name_normalized=public.normalize_card_name('思い出のみ'),
  rarity='◆',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-69/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'思い出のみ',public.normalize_card_name('思い出のみ'),'69','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-69/large','Scrydex public card image (pcg8_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/075 神秘のかけら
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='神秘のかけら',
  name_normalized=public.normalize_card_name('神秘のかけら'),
  rarity='◆',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-70/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'神秘のかけら',public.normalize_card_name('神秘のかけら'),'70','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-70/large','Scrydex public card image (pcg8_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/075 水晶のかけら
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='水晶のかけら',
  name_normalized=public.normalize_card_name('水晶のかけら'),
  rarity='◆',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-71/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'水晶のかけら',public.normalize_card_name('水晶のかけら'),'71','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-71/large','Scrydex public card image (pcg8_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/075 封印の結晶
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='封印の結晶',
  name_normalized=public.normalize_card_name('封印の結晶'),
  rarity='◆',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-72/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'封印の結晶',public.normalize_card_name('封印の結晶'),'72','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-72/large','Scrydex public card image (pcg8_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/075 クリスタルビーチ
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='クリスタルビーチ',
  name_normalized=public.normalize_card_name('クリスタルビーチ'),
  rarity='◆',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-73/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クリスタルビーチ',public.normalize_card_name('クリスタルビーチ'),'73','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-73/large','Scrydex public card image (pcg8_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/075 ホロンサークル
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='ホロンサークル',
  name_normalized=public.normalize_card_name('ホロンサークル'),
  rarity='◆',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-74/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンサークル',public.normalize_card_name('ホロンサークル'),'74','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-74/large','Scrydex public card image (pcg8_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/075 Wレインボーエネルギー
with st as (select id from public.card_sets where code='PCG8' limit 1)
update public.cards c set
  name='Wレインボーエネルギー',
  name_normalized=public.normalize_card_name('Wレインボーエネルギー'),
  rarity='◆',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg8_ja-75/large',
  image_source_note='Scrydex public card image (pcg8_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='PCG8' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'Wレインボーエネルギー',public.normalize_card_name('Wレインボーエネルギー'),'75','◆','normal','https://images.scrydex.com/pokemon/pcg8_ja-75/large','Scrydex public card image (pcg8_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

commit;

-- ============================================================
-- PCG8 監査
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
where cs.code = 'PCG8'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG8' as code,
  75 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG8'
having count(distinct c.set_order) <> 75;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG8'
group by c.set_order
having count(*) > 1
order by c.set_order;
