-- WCP 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- WCP ワールドチャンピオンズパック (108 cards)
update public.card_sets
set name='ワールドチャンピオンズパック',
    release_date='2007-07-05'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/World%20Champions%20Pack.jpg'
where code='WCP';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select 'ワールドチャンピオンズパック', 'WCP', '2007-07-05'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/World%20Champions%20Pack.jpg'
where not exists (select 1 from public.card_sets where code='WCP');

-- 001/108 タネボー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='タネボー',
  name_normalized=public.normalize_card_name('タネボー'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-1/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タネボー',public.normalize_card_name('タネボー'),'1','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-1/large','Scrydex public card image (pcg10_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/108 サボネア
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='サボネア',
  name_normalized=public.normalize_card_name('サボネア'),
  rarity='●',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-2/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サボネア',public.normalize_card_name('サボネア'),'2','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-2/large','Scrydex public card image (pcg10_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/108 ハブネーク
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ハブネーク',
  name_normalized=public.normalize_card_name('ハブネーク'),
  rarity='★',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-3/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハブネーク',public.normalize_card_name('ハブネーク'),'3','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-3/large','Scrydex public card image (pcg10_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/108 リリーラ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='リリーラ',
  name_normalized=public.normalize_card_name('リリーラ'),
  rarity='●',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-4/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リリーラ',public.normalize_card_name('リリーラ'),'4','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-4/large','Scrydex public card image (pcg10_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/108 ユレイドル
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ユレイドル',
  name_normalized=public.normalize_card_name('ユレイドル'),
  rarity='★',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-5/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ユレイドル',public.normalize_card_name('ユレイドル'),'5','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-5/large','Scrydex public card image (pcg10_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/108 ヒトカゲ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ヒトカゲ',
  name_normalized=public.normalize_card_name('ヒトカゲ'),
  rarity='●',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-6/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒトカゲ',public.normalize_card_name('ヒトカゲ'),'6','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-6/large','Scrydex public card image (pcg10_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/108 リザード
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='リザード',
  name_normalized=public.normalize_card_name('リザード'),
  rarity='◆',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-7/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リザード',public.normalize_card_name('リザード'),'7','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-7/large','Scrydex public card image (pcg10_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/108 リザードン
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='リザードン',
  name_normalized=public.normalize_card_name('リザードン'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-8/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リザードン',public.normalize_card_name('リザードン'),'8','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-8/large','Scrydex public card image (pcg10_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/108 ロコン
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ロコン',
  name_normalized=public.normalize_card_name('ロコン'),
  rarity='●',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-9/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロコン',public.normalize_card_name('ロコン'),'9','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-9/large','Scrydex public card image (pcg10_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/108 キュウコン
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='キュウコン',
  name_normalized=public.normalize_card_name('キュウコン'),
  rarity='★',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-10/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キュウコン',public.normalize_card_name('キュウコン'),'10','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-10/large','Scrydex public card image (pcg10_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/108 ブースター☆
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ブースター☆',
  name_normalized=public.normalize_card_name('ブースター☆'),
  rarity='★',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-11/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブースター☆',public.normalize_card_name('ブースター☆'),'11','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-11/large','Scrydex public card image (pcg10_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/108 アチャモ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='アチャモ',
  name_normalized=public.normalize_card_name('アチャモ'),
  rarity='●',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-12/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アチャモ',public.normalize_card_name('アチャモ'),'12','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-12/large','Scrydex public card image (pcg10_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/108 ワカシャモ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ワカシャモ',
  name_normalized=public.normalize_card_name('ワカシャモ'),
  rarity='◆',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-13/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワカシャモ',public.normalize_card_name('ワカシャモ'),'13','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-13/large','Scrydex public card image (pcg10_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/108 バシャーモ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='バシャーモ',
  name_normalized=public.normalize_card_name('バシャーモ'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-14/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バシャーモ',public.normalize_card_name('バシャーモ'),'14','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-14/large','Scrydex public card image (pcg10_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/108 シャワーズ☆
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='シャワーズ☆',
  name_normalized=public.normalize_card_name('シャワーズ☆'),
  rarity='★',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-15/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シャワーズ☆',public.normalize_card_name('シャワーズ☆'),'15','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-15/large','Scrydex public card image (pcg10_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/108 オムナイト
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='オムナイト',
  name_normalized=public.normalize_card_name('オムナイト'),
  rarity='●',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-16/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムナイト',public.normalize_card_name('オムナイト'),'16','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-16/large','Scrydex public card image (pcg10_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/108 オムスター
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='オムスター',
  name_normalized=public.normalize_card_name('オムスター'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-17/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムスター',public.normalize_card_name('オムスター'),'17','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-17/large','Scrydex public card image (pcg10_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/108 ユキワラシ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ユキワラシ',
  name_normalized=public.normalize_card_name('ユキワラシ'),
  rarity='●',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-18/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ユキワラシ',public.normalize_card_name('ユキワラシ'),'18','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-18/large','Scrydex public card image (pcg10_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/108 オニゴーリ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='オニゴーリ',
  name_normalized=public.normalize_card_name('オニゴーリ'),
  rarity='◆',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-19/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オニゴーリ',public.normalize_card_name('オニゴーリ'),'19','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-19/large','Scrydex public card image (pcg10_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/108 タマザラシ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='タマザラシ',
  name_normalized=public.normalize_card_name('タマザラシ'),
  rarity='●',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-20/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タマザラシ',public.normalize_card_name('タマザラシ'),'20','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-20/large','Scrydex public card image (pcg10_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/108 トドグラー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='トドグラー',
  name_normalized=public.normalize_card_name('トドグラー'),
  rarity='◆',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-21/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トドグラー',public.normalize_card_name('トドグラー'),'21','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-21/large','Scrydex public card image (pcg10_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/108 トドゼルガex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='トドゼルガex',
  name_normalized=public.normalize_card_name('トドゼルガex'),
  rarity='☆',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-22/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トドゼルガex',public.normalize_card_name('トドゼルガex'),'22','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-22/large','Scrydex public card image (pcg10_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/108 ピカチュウ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ピカチュウ',
  name_normalized=public.normalize_card_name('ピカチュウ'),
  rarity='●',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-23/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピカチュウ',public.normalize_card_name('ピカチュウ'),'23','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-23/large','Scrydex public card image (pcg10_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/108 ライチュウ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ライチュウ',
  name_normalized=public.normalize_card_name('ライチュウ'),
  rarity='★',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-24/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ライチュウ',public.normalize_card_name('ライチュウ'),'24','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-24/large','Scrydex public card image (pcg10_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/108 コイル
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='コイル',
  name_normalized=public.normalize_card_name('コイル'),
  rarity='●',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-25/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コイル',public.normalize_card_name('コイル'),'25','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-25/large','Scrydex public card image (pcg10_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/108 レアコイル
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='レアコイル',
  name_normalized=public.normalize_card_name('レアコイル'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-26/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レアコイル',public.normalize_card_name('レアコイル'),'26','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-26/large','Scrydex public card image (pcg10_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/108 サンダース☆
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='サンダース☆',
  name_normalized=public.normalize_card_name('サンダース☆'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-27/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンダース☆',public.normalize_card_name('サンダース☆'),'27','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-27/large','Scrydex public card image (pcg10_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/108 チョンチー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='チョンチー',
  name_normalized=public.normalize_card_name('チョンチー'),
  rarity='●',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-28/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チョンチー',public.normalize_card_name('チョンチー'),'28','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-28/large','Scrydex public card image (pcg10_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/108 ランターン
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ランターン',
  name_normalized=public.normalize_card_name('ランターン'),
  rarity='★',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-29/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ランターン',public.normalize_card_name('ランターン'),'29','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-29/large','Scrydex public card image (pcg10_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/108 ピチュー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ピチュー',
  name_normalized=public.normalize_card_name('ピチュー'),
  rarity='★',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-30/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピチュー',public.normalize_card_name('ピチュー'),'30','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-30/large','Scrydex public card image (pcg10_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/108 ソーナンス
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ソーナンス',
  name_normalized=public.normalize_card_name('ソーナンス'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-31/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ソーナンス',public.normalize_card_name('ソーナンス'),'31','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-31/large','Scrydex public card image (pcg10_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/108 ラルトス
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ラルトス',
  name_normalized=public.normalize_card_name('ラルトス'),
  rarity='●',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-32/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラルトス',public.normalize_card_name('ラルトス'),'32','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-32/large','Scrydex public card image (pcg10_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/108 キルリア
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='キルリア',
  name_normalized=public.normalize_card_name('キルリア'),
  rarity='◆',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-33/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キルリア',public.normalize_card_name('キルリア'),'33','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-33/large','Scrydex public card image (pcg10_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/108 サーナイト
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='サーナイト',
  name_normalized=public.normalize_card_name('サーナイト'),
  rarity='★',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-34/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サーナイト',public.normalize_card_name('サーナイト'),'34','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-34/large','Scrydex public card image (pcg10_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/108 ヤミラミ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ヤミラミ',
  name_normalized=public.normalize_card_name('ヤミラミ'),
  rarity='★',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-35/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤミラミ',public.normalize_card_name('ヤミラミ'),'35','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-35/large','Scrydex public card image (pcg10_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/108 ヤジロン
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ヤジロン',
  name_normalized=public.normalize_card_name('ヤジロン'),
  rarity='●',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-36/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤジロン',public.normalize_card_name('ヤジロン'),'36','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-36/large','Scrydex public card image (pcg10_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/108 ネンドールex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ネンドールex',
  name_normalized=public.normalize_card_name('ネンドールex'),
  rarity='☆',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-37/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ネンドールex',public.normalize_card_name('ネンドールex'),'37','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-37/large','Scrydex public card image (pcg10_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/108 カゲボウズ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='カゲボウズ',
  name_normalized=public.normalize_card_name('カゲボウズ'),
  rarity='●',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-38/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カゲボウズ',public.normalize_card_name('カゲボウズ'),'38','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-38/large','Scrydex public card image (pcg10_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/108 ジュペッタ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ジュペッタ',
  name_normalized=public.normalize_card_name('ジュペッタ'),
  rarity='★',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-39/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュペッタ',public.normalize_card_name('ジュペッタ'),'39','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-39/large','Scrydex public card image (pcg10_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/108 ヨマワル
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ヨマワル',
  name_normalized=public.normalize_card_name('ヨマワル'),
  rarity='●',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-40/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヨマワル',public.normalize_card_name('ヨマワル'),'40','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-40/large','Scrydex public card image (pcg10_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/108 サマヨール
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='サマヨール',
  name_normalized=public.normalize_card_name('サマヨール'),
  rarity='★',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-41/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サマヨール',public.normalize_card_name('サマヨール'),'41','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-41/large','Scrydex public card image (pcg10_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/108 ソーナノ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ソーナノ',
  name_normalized=public.normalize_card_name('ソーナノ'),
  rarity='●',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-42/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ソーナノ',public.normalize_card_name('ソーナノ'),'42','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-42/large','Scrydex public card image (pcg10_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/108 ワンリキー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ワンリキー',
  name_normalized=public.normalize_card_name('ワンリキー'),
  rarity='●',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-43/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワンリキー',public.normalize_card_name('ワンリキー'),'43','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-43/large','Scrydex public card image (pcg10_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/108 ゴーリキー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ゴーリキー',
  name_normalized=public.normalize_card_name('ゴーリキー'),
  rarity='◆',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-44/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴーリキー',public.normalize_card_name('ゴーリキー'),'44','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-44/large','Scrydex public card image (pcg10_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/108 カイリキー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='カイリキー',
  name_normalized=public.normalize_card_name('カイリキー'),
  rarity='★',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-45/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイリキー',public.normalize_card_name('カイリキー'),'45','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-45/large','Scrydex public card image (pcg10_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/108 カブト
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='カブト',
  name_normalized=public.normalize_card_name('カブト'),
  rarity='●',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-46/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブト',public.normalize_card_name('カブト'),'46','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-46/large','Scrydex public card image (pcg10_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/108 カブトプス
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='カブトプス',
  name_normalized=public.normalize_card_name('カブトプス'),
  rarity='★',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-47/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブトプス',public.normalize_card_name('カブトプス'),'47','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-47/large','Scrydex public card image (pcg10_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/108 アサナン
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='アサナン',
  name_normalized=public.normalize_card_name('アサナン'),
  rarity='●',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-48/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アサナン',public.normalize_card_name('アサナン'),'48','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-48/large','Scrydex public card image (pcg10_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/108 チャーレム
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='チャーレム',
  name_normalized=public.normalize_card_name('チャーレム'),
  rarity='◆',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-49/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チャーレム',public.normalize_card_name('チャーレム'),'49','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-49/large','Scrydex public card image (pcg10_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/108 ナックラー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ナックラー',
  name_normalized=public.normalize_card_name('ナックラー'),
  rarity='●',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-50/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナックラー',public.normalize_card_name('ナックラー'),'50','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-50/large','Scrydex public card image (pcg10_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/108 アノプス
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='アノプス',
  name_normalized=public.normalize_card_name('アノプス'),
  rarity='◆',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-51/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アノプス',public.normalize_card_name('アノプス'),'51','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-51/large','Scrydex public card image (pcg10_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/108 アーマルド
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='アーマルド',
  name_normalized=public.normalize_card_name('アーマルド'),
  rarity='★',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-52/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーマルド',public.normalize_card_name('アーマルド'),'52','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-52/large','Scrydex public card image (pcg10_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/108 ポチエナ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ポチエナ',
  name_normalized=public.normalize_card_name('ポチエナ'),
  rarity='●',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-53/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポチエナ',public.normalize_card_name('ポチエナ'),'53','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-53/large','Scrydex public card image (pcg10_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/108 グラエナ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='グラエナ',
  name_normalized=public.normalize_card_name('グラエナ'),
  rarity='★',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-54/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'グラエナ',public.normalize_card_name('グラエナ'),'54','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-54/large','Scrydex public card image (pcg10_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/108 コノハナ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='コノハナ',
  name_normalized=public.normalize_card_name('コノハナ'),
  rarity='◆',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-55/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コノハナ',public.normalize_card_name('コノハナ'),'55','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-55/large','Scrydex public card image (pcg10_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/108 ダーテングex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ダーテングex',
  name_normalized=public.normalize_card_name('ダーテングex'),
  rarity='☆',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-56/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダーテングex',public.normalize_card_name('ダーテングex'),'56','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-56/large','Scrydex public card image (pcg10_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/108 キバニア
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='キバニア',
  name_normalized=public.normalize_card_name('キバニア'),
  rarity='●',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-57/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キバニア',public.normalize_card_name('キバニア'),'57','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-57/large','Scrydex public card image (pcg10_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/108 サメハダー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='サメハダー',
  name_normalized=public.normalize_card_name('サメハダー'),
  rarity='◆',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-58/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サメハダー',public.normalize_card_name('サメハダー'),'58','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-58/large','Scrydex public card image (pcg10_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/108 ノクタス
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ノクタス',
  name_normalized=public.normalize_card_name('ノクタス'),
  rarity='◆',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-59/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ノクタス',public.normalize_card_name('ノクタス'),'59','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-59/large','Scrydex public card image (pcg10_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/108 アブソルex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='アブソルex',
  name_normalized=public.normalize_card_name('アブソルex'),
  rarity='☆',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-60/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アブソルex',public.normalize_card_name('アブソルex'),'60','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-60/large','Scrydex public card image (pcg10_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/108 エアームドex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='エアームドex',
  name_normalized=public.normalize_card_name('エアームドex'),
  rarity='☆',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-61/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エアームドex',public.normalize_card_name('エアームドex'),'61','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-61/large','Scrydex public card image (pcg10_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/108 クチート
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='クチート',
  name_normalized=public.normalize_card_name('クチート'),
  rarity='★',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-62/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クチート',public.normalize_card_name('クチート'),'62','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-62/large','Scrydex public card image (pcg10_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/108 ココドラ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ココドラ',
  name_normalized=public.normalize_card_name('ココドラ'),
  rarity='●',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-63/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ココドラ',public.normalize_card_name('ココドラ'),'63','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-63/large','Scrydex public card image (pcg10_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/108 コドラ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='コドラ',
  name_normalized=public.normalize_card_name('コドラ'),
  rarity='◆',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-64/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コドラ',public.normalize_card_name('コドラ'),'64','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-64/large','Scrydex public card image (pcg10_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/108 ボスゴドラ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ボスゴドラ',
  name_normalized=public.normalize_card_name('ボスゴドラ'),
  rarity='★',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-65/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボスゴドラ',public.normalize_card_name('ボスゴドラ'),'65','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-65/large','Scrydex public card image (pcg10_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/108 ダンバル
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ダンバル',
  name_normalized=public.normalize_card_name('ダンバル'),
  rarity='●',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-66/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダンバル',public.normalize_card_name('ダンバル'),'66','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-66/large','Scrydex public card image (pcg10_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/108 メタング
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='メタング',
  name_normalized=public.normalize_card_name('メタング'),
  rarity='◆',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-67/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタング',public.normalize_card_name('メタング'),'67','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-67/large','Scrydex public card image (pcg10_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/108 メタグロスex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='メタグロスex',
  name_normalized=public.normalize_card_name('メタグロスex'),
  rarity='☆',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-68/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタグロスex',public.normalize_card_name('メタグロスex'),'68','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-68/large','Scrydex public card image (pcg10_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/108 ナマケロ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ナマケロ',
  name_normalized=public.normalize_card_name('ナマケロ'),
  rarity='●',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-69/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナマケロ',public.normalize_card_name('ナマケロ'),'69','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-69/large','Scrydex public card image (pcg10_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/108 ヤルキモノ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ヤルキモノ',
  name_normalized=public.normalize_card_name('ヤルキモノ'),
  rarity='◆',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-70/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤルキモノ',public.normalize_card_name('ヤルキモノ'),'70','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-70/large','Scrydex public card image (pcg10_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/108 ケッキング
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ケッキング',
  name_normalized=public.normalize_card_name('ケッキング'),
  rarity='★',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-71/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ケッキング',public.normalize_card_name('ケッキング'),'71','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-71/large','Scrydex public card image (pcg10_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/108 エネコ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='エネコ',
  name_normalized=public.normalize_card_name('エネコ'),
  rarity='●',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-72/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコ',public.normalize_card_name('エネコ'),'72','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-72/large','Scrydex public card image (pcg10_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/108 エネコロロ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='エネコロロ',
  name_normalized=public.normalize_card_name('エネコロロ'),
  rarity='★',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-73/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネコロロ',public.normalize_card_name('エネコロロ'),'73','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-73/large','Scrydex public card image (pcg10_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/108 ビブラーバ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ビブラーバ',
  name_normalized=public.normalize_card_name('ビブラーバ'),
  rarity='◆',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-74/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビブラーバ',public.normalize_card_name('ビブラーバ'),'74','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-74/large','Scrydex public card image (pcg10_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/108 フライゴンex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='フライゴンex',
  name_normalized=public.normalize_card_name('フライゴンex'),
  rarity='☆',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-75/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フライゴンex',public.normalize_card_name('フライゴンex'),'75','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-75/large','Scrydex public card image (pcg10_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/108 チルット
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='チルット',
  name_normalized=public.normalize_card_name('チルット'),
  rarity='●',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-76/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルット',public.normalize_card_name('チルット'),'76','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-76/large','Scrydex public card image (pcg10_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/108 チルタリス
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='チルタリス',
  name_normalized=public.normalize_card_name('チルタリス'),
  rarity='★',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-77/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルタリス',public.normalize_card_name('チルタリス'),'77','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-77/large','Scrydex public card image (pcg10_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/108 ザングース
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ザングース',
  name_normalized=public.normalize_card_name('ザングース'),
  rarity='★',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-78/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ザングース',public.normalize_card_name('ザングース'),'78','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-78/large','Scrydex public card image (pcg10_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/108 タツベイ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='タツベイ',
  name_normalized=public.normalize_card_name('タツベイ'),
  rarity='●',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-79/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タツベイ',public.normalize_card_name('タツベイ'),'79','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-79/large','Scrydex public card image (pcg10_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/108 コモルー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='コモルー',
  name_normalized=public.normalize_card_name('コモルー'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-80/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コモルー',public.normalize_card_name('コモルー'),'80','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-80/large','Scrydex public card image (pcg10_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/108 ボーマンダex
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ボーマンダex',
  name_normalized=public.normalize_card_name('ボーマンダex'),
  rarity='☆',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-81/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボーマンダex',public.normalize_card_name('ボーマンダex'),'81','☆','normal','https://images.scrydex.com/pokemon/pcg10_ja-81/large','Scrydex public card image (pcg10_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/108 エネルギー循環装置
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='エネルギー循環装置',
  name_normalized=public.normalize_card_name('エネルギー循環装置'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-82/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネルギー循環装置',public.normalize_card_name('エネルギー循環装置'),'82','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-82/large','Scrydex public card image (pcg10_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

-- 083/108 エネルギーつけかえ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='エネルギーつけかえ',
  name_normalized=public.normalize_card_name('エネルギーつけかえ'),
  rarity='◆',
  set_order=83,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-83/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネルギーつけかえ',public.normalize_card_name('エネルギーつけかえ'),'83','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-83/large','Scrydex public card image (pcg10_ja)',true,83,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83'
);

-- 084/108 エネルギーリムーブ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='エネルギーリムーブ',
  name_normalized=public.normalize_card_name('エネルギーリムーブ'),
  rarity='◆',
  set_order=84,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-84/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エネルギーリムーブ',public.normalize_card_name('エネルギーリムーブ'),'84','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-84/large','Scrydex public card image (pcg10_ja)',true,84,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84'
);

-- 085/108 スーパーボール
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='スーパーボール',
  name_normalized=public.normalize_card_name('スーパーボール'),
  rarity='◆',
  set_order=85,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-85/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スーパーボール',public.normalize_card_name('スーパーボール'),'85','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-85/large','Scrydex public card image (pcg10_ja)',true,85,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85'
);

-- 086/108 ツメの化石
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ツメの化石',
  name_normalized=public.normalize_card_name('ツメの化石'),
  rarity='●',
  set_order=86,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-86/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ツメの化石',public.normalize_card_name('ツメの化石'),'86','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-86/large','Scrydex public card image (pcg10_ja)',true,86,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86'
);

-- 087/108 なにかの化石
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='なにかの化石',
  name_normalized=public.normalize_card_name('なにかの化石'),
  rarity='●',
  set_order=87,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-87/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '87';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'なにかの化石',public.normalize_card_name('なにかの化石'),'87','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-87/large','Scrydex public card image (pcg10_ja)',true,87,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '87'
);

-- 088/108 ねっこの化石
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ねっこの化石',
  name_normalized=public.normalize_card_name('ねっこの化石'),
  rarity='●',
  set_order=88,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-88/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '88';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ねっこの化石',public.normalize_card_name('ねっこの化石'),'88','●','normal','https://images.scrydex.com/pokemon/pcg10_ja-88/large','Scrydex public card image (pcg10_ja)',true,88,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '88'
);

-- 089/108 マスターボール
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='マスターボール',
  name_normalized=public.normalize_card_name('マスターボール'),
  rarity='◆',
  set_order=89,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-89/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '89';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マスターボール',public.normalize_card_name('マスターボール'),'89','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-89/large','Scrydex public card image (pcg10_ja)',true,89,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '89'
);

-- 090/108 エニシダ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='エニシダ',
  name_normalized=public.normalize_card_name('エニシダ'),
  rarity='◆',
  set_order=90,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-90/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '90';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エニシダ',public.normalize_card_name('エニシダ'),'90','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-90/large','Scrydex public card image (pcg10_ja)',true,90,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '90'
);

-- 091/108 オダマキはかせ
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='オダマキはかせ',
  name_normalized=public.normalize_card_name('オダマキはかせ'),
  rarity='◆',
  set_order=91,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-91/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '91';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オダマキはかせ',public.normalize_card_name('オダマキはかせ'),'91','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-91/large','Scrydex public card image (pcg10_ja)',true,91,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '91'
);

-- 092/108 ダイゴのアドバイス
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ダイゴのアドバイス',
  name_normalized=public.normalize_card_name('ダイゴのアドバイス'),
  rarity='◆',
  set_order=92,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-92/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '92';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダイゴのアドバイス',public.normalize_card_name('ダイゴのアドバイス'),'92','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-92/large','Scrydex public card image (pcg10_ja)',true,92,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '92'
);

-- 093/108 バトルフロンティア
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='バトルフロンティア',
  name_normalized=public.normalize_card_name('バトルフロンティア'),
  rarity='◆',
  set_order=93,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-93/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '93';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バトルフロンティア',public.normalize_card_name('バトルフロンティア'),'93','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-93/large','Scrydex public card image (pcg10_ja)',true,93,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '93'
);

-- 094/108 カゲツのスタジアム
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='カゲツのスタジアム',
  name_normalized=public.normalize_card_name('カゲツのスタジアム'),
  rarity='◆',
  set_order=94,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-94/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '94';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カゲツのスタジアム',public.normalize_card_name('カゲツのスタジアム'),'94','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-94/large','Scrydex public card image (pcg10_ja)',true,94,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '94'
);

-- 095/108 ゲンジのスタジアム
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ゲンジのスタジアム',
  name_normalized=public.normalize_card_name('ゲンジのスタジアム'),
  rarity='◆',
  set_order=95,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-95/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '95';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゲンジのスタジアム',public.normalize_card_name('ゲンジのスタジアム'),'95','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-95/large','Scrydex public card image (pcg10_ja)',true,95,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '95'
);

-- 096/108 フヨウのスタジアム
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='フヨウのスタジアム',
  name_normalized=public.normalize_card_name('フヨウのスタジアム'),
  rarity='◆',
  set_order=96,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-96/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '96';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フヨウのスタジアム',public.normalize_card_name('フヨウのスタジアム'),'96','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-96/large','Scrydex public card image (pcg10_ja)',true,96,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '96'
);

-- 097/108 プリムのスタジアム
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='プリムのスタジアム',
  name_normalized=public.normalize_card_name('プリムのスタジアム'),
  rarity='◆',
  set_order=97,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-97/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '97';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プリムのスタジアム',public.normalize_card_name('プリムのスタジアム'),'97','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-97/large','Scrydex public card image (pcg10_ja)',true,97,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '97'
);

-- 098/108 サイクロンエネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='サイクロンエネルギー',
  name_normalized=public.normalize_card_name('サイクロンエネルギー'),
  rarity='◆',
  set_order=98,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-98/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '98';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サイクロンエネルギー',public.normalize_card_name('サイクロンエネルギー'),'98','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-98/large','Scrydex public card image (pcg10_ja)',true,98,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '98'
);

-- 099/108 マルチエネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='マルチエネルギー',
  name_normalized=public.normalize_card_name('マルチエネルギー'),
  rarity='★',
  set_order=99,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-99/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '99';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マルチエネルギー',public.normalize_card_name('マルチエネルギー'),'99','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-99/large','Scrydex public card image (pcg10_ja)',true,99,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '99'
);

-- 100/108 ワープエネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='ワープエネルギー',
  name_normalized=public.normalize_card_name('ワープエネルギー'),
  rarity='◆',
  set_order=100,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-100/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '100';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワープエネルギー',public.normalize_card_name('ワープエネルギー'),'100','◆','normal','https://images.scrydex.com/pokemon/pcg10_ja-100/large','Scrydex public card image (pcg10_ja)',true,100,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '100'
);

-- 101/108 悪エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='悪エネルギー',
  name_normalized=public.normalize_card_name('悪エネルギー'),
  rarity='★',
  set_order=101,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-101/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '101';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'悪エネルギー',public.normalize_card_name('悪エネルギー'),'101','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-101/large','Scrydex public card image (pcg10_ja)',true,101,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '101'
);

-- 102/108 鋼エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='鋼エネルギー',
  name_normalized=public.normalize_card_name('鋼エネルギー'),
  rarity='★',
  set_order=102,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-102/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '102';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'鋼エネルギー',public.normalize_card_name('鋼エネルギー'),'102','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-102/large','Scrydex public card image (pcg10_ja)',true,102,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '102'
);

-- 103/108 草エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='草エネルギー',
  name_normalized=public.normalize_card_name('草エネルギー'),
  rarity='★',
  set_order=103,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-103/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '103';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'草エネルギー',public.normalize_card_name('草エネルギー'),'103','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-103/large','Scrydex public card image (pcg10_ja)',true,103,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '103'
);

-- 104/108 炎エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='炎エネルギー',
  name_normalized=public.normalize_card_name('炎エネルギー'),
  rarity='★',
  set_order=104,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-104/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '104';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'炎エネルギー',public.normalize_card_name('炎エネルギー'),'104','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-104/large','Scrydex public card image (pcg10_ja)',true,104,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '104'
);

-- 105/108 水エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='水エネルギー',
  name_normalized=public.normalize_card_name('水エネルギー'),
  rarity='★',
  set_order=105,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-105/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '105';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'水エネルギー',public.normalize_card_name('水エネルギー'),'105','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-105/large','Scrydex public card image (pcg10_ja)',true,105,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '105'
);

-- 106/108 雷エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='雷エネルギー',
  name_normalized=public.normalize_card_name('雷エネルギー'),
  rarity='★',
  set_order=106,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-106/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '106';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'雷エネルギー',public.normalize_card_name('雷エネルギー'),'106','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-106/large','Scrydex public card image (pcg10_ja)',true,106,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '106'
);

-- 107/108 超エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='超エネルギー',
  name_normalized=public.normalize_card_name('超エネルギー'),
  rarity='★',
  set_order=107,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-107/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '107';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'超エネルギー',public.normalize_card_name('超エネルギー'),'107','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-107/large','Scrydex public card image (pcg10_ja)',true,107,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '107'
);

-- 108/108 闘エネルギー
with st as (select id from public.card_sets where code='WCP' limit 1)
update public.cards c set
  name='闘エネルギー',
  name_normalized=public.normalize_card_name('闘エネルギー'),
  rarity='★',
  set_order=108,
  image_url='https://images.scrydex.com/pokemon/pcg10_ja-108/large',
  image_source_note='Scrydex public card image (pcg10_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '108';

with st as (select id from public.card_sets where code='WCP' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'闘エネルギー',public.normalize_card_name('闘エネルギー'),'108','★','normal','https://images.scrydex.com/pokemon/pcg10_ja-108/large','Scrydex public card image (pcg10_ja)',true,108,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '108'
);

commit;

-- ============================================================
-- WCP 監査
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
where cs.code = 'WCP'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'WCP' as code,
  108 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'WCP'
having count(distinct c.set_order) <> 108;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'WCP'
group by c.set_order
having count(*) > 1
order by c.set_order;
