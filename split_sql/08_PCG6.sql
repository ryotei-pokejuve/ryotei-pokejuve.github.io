-- PCG6 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG6 拡張パック ホロンの研究塔 (86 cards)
update public.card_sets
set name='拡張パック ホロンの研究塔',
    release_date='2005-10-28'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG6%20Holon%20Research%20Tower%20pack.jpg'
where code='PCG6';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック ホロンの研究塔', 'PCG6', '2005-10-28'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG6%20Holon%20Research%20Tower%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG6');

-- 001/086 ビードル
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ビードル',
  name_normalized=public.normalize_card_name('ビードル'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-1/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビードル',public.normalize_card_name('ビードル'),'1','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-1/large','Scrydex public card image (pcg6_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/086 コクーン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='コクーン',
  name_normalized=public.normalize_card_name('コクーン'),
  rarity='●',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-2/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コクーン',public.normalize_card_name('コクーン'),'2','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-2/large','Scrydex public card image (pcg6_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/086 ズバット
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ズバット',
  name_normalized=public.normalize_card_name('ズバット'),
  rarity='●',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-3/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ズバット',public.normalize_card_name('ズバット'),'3','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-3/large','Scrydex public card image (pcg6_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/086 ゴルバット
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ゴルバット',
  name_normalized=public.normalize_card_name('ゴルバット'),
  rarity='●',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-4/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴルバット',public.normalize_card_name('ゴルバット'),'4','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-4/large','Scrydex public card image (pcg6_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/086 ドガース
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ドガース',
  name_normalized=public.normalize_card_name('ドガース'),
  rarity='●',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-5/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドガース',public.normalize_card_name('ドガース'),'5','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-5/large','Scrydex public card image (pcg6_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/086 マタドガス
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='マタドガス',
  name_normalized=public.normalize_card_name('マタドガス'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-6/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マタドガス',public.normalize_card_name('マタドガス'),'6','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-6/large','Scrydex public card image (pcg6_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/086 メタモン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-7/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'7','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-7/large','Scrydex public card image (pcg6_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/086 バルビート
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='バルビート',
  name_normalized=public.normalize_card_name('バルビート'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-8/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バルビート',public.normalize_card_name('バルビート'),'8','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-8/large','Scrydex public card image (pcg6_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/086 イルミーゼ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='イルミーゼ',
  name_normalized=public.normalize_card_name('イルミーゼ'),
  rarity='★',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-9/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イルミーゼ',public.normalize_card_name('イルミーゼ'),'9','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-9/large','Scrydex public card image (pcg6_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/086 スピアーδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='スピアーδ-デルタ種',
  name_normalized=public.normalize_card_name('スピアーδ-デルタ種'),
  rarity='★',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-10/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スピアーδ-デルタ種',public.normalize_card_name('スピアーδ-デルタ種'),'10','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-10/large','Scrydex public card image (pcg6_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/086 クロバットδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='クロバットδ-デルタ種',
  name_normalized=public.normalize_card_name('クロバットδ-デルタ種'),
  rarity='★',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-11/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クロバットδ-デルタ種',public.normalize_card_name('クロバットδ-デルタ種'),'11','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-11/large','Scrydex public card image (pcg6_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/086 メタモン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-12/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'12','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-12/large','Scrydex public card image (pcg6_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/086 ヨーギラスδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ヨーギラスδ-デルタ種',
  name_normalized=public.normalize_card_name('ヨーギラスδ-デルタ種'),
  rarity='●',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-13/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヨーギラスδ-デルタ種',public.normalize_card_name('ヨーギラスδ-デルタ種'),'13','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-13/large','Scrydex public card image (pcg6_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/086 サナギラスδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='サナギラスδ-デルタ種',
  name_normalized=public.normalize_card_name('サナギラスδ-デルタ種'),
  rarity='◆',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-14/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サナギラスδ-デルタ種',public.normalize_card_name('サナギラスδ-デルタ種'),'14','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-14/large','Scrydex public card image (pcg6_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/086 太陽のポワルン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='太陽のポワルン',
  name_normalized=public.normalize_card_name('太陽のポワルン'),
  rarity='★',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-15/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'太陽のポワルン',public.normalize_card_name('太陽のポワルン'),'15','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-15/large','Scrydex public card image (pcg6_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/086 タツベイδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='タツベイδ-デルタ種',
  name_normalized=public.normalize_card_name('タツベイδ-デルタ種'),
  rarity='●',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-16/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タツベイδ-デルタ種',public.normalize_card_name('タツベイδ-デルタ種'),'16','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-16/large','Scrydex public card image (pcg6_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/086 コモルーδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='コモルーδ-デルタ種',
  name_normalized=public.normalize_card_name('コモルーδ-デルタ種'),
  rarity='◆',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-17/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コモルーδ-デルタ種',public.normalize_card_name('コモルーδ-デルタ種'),'17','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-17/large','Scrydex public card image (pcg6_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/086 ブースターδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ブースターδ-デルタ種',
  name_normalized=public.normalize_card_name('ブースターδ-デルタ種'),
  rarity='★',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-18/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブースターδ-デルタ種',public.normalize_card_name('ブースターδ-デルタ種'),'18','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-18/large','Scrydex public card image (pcg6_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/086 ミュウツーδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ミュウツーδ-デルタ種',
  name_normalized=public.normalize_card_name('ミュウツーδ-デルタ種'),
  rarity='★',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-19/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミュウツーδ-デルタ種',public.normalize_card_name('ミュウツーδ-デルタ種'),'19','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-19/large','Scrydex public card image (pcg6_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/086 バンギラスδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='バンギラスδ-デルタ種',
  name_normalized=public.normalize_card_name('バンギラスδ-デルタ種'),
  rarity='★',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-20/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バンギラスδ-デルタ種',public.normalize_card_name('バンギラスδ-デルタ種'),'20','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-20/large','Scrydex public card image (pcg6_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/086 ボーマンダδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ボーマンダδ-デルタ種',
  name_normalized=public.normalize_card_name('ボーマンダδ-デルタ種'),
  rarity='★',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-21/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボーマンダδ-デルタ種',public.normalize_card_name('ボーマンダδ-デルタ種'),'21','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-21/large','Scrydex public card image (pcg6_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/086 ヤドン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ヤドン',
  name_normalized=public.normalize_card_name('ヤドン'),
  rarity='●',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-22/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドン',public.normalize_card_name('ヤドン'),'22','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-22/large','Scrydex public card image (pcg6_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/086 ヒトデマン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ヒトデマン',
  name_normalized=public.normalize_card_name('ヒトデマン'),
  rarity='●',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-23/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒトデマン',public.normalize_card_name('ヒトデマン'),'23','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-23/large','Scrydex public card image (pcg6_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/086 メタモン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-24/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'24','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-24/large','Scrydex public card image (pcg6_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/086 ヤドキング
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ヤドキング',
  name_normalized=public.normalize_card_name('ヤドキング'),
  rarity='★',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-25/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドキング',public.normalize_card_name('ヤドキング'),'25','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-25/large','Scrydex public card image (pcg6_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/086 雨水のポワルン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='雨水のポワルン',
  name_normalized=public.normalize_card_name('雨水のポワルン'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-26/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'雨水のポワルン',public.normalize_card_name('雨水のポワルン'),'26','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-26/large','Scrydex public card image (pcg6_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/086 雪雲のポワルン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='雪雲のポワルン',
  name_normalized=public.normalize_card_name('雪雲のポワルン'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-27/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'雪雲のポワルン',public.normalize_card_name('雪雲のポワルン'),'27','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-27/large','Scrydex public card image (pcg6_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/086 カイオーガ☆
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='カイオーガ☆',
  name_normalized=public.normalize_card_name('カイオーガ☆'),
  rarity='★',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-28/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイオーガ☆',public.normalize_card_name('カイオーガ☆'),'28','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-28/large','Scrydex public card image (pcg6_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/086 スターミーδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='スターミーδ-デルタ種',
  name_normalized=public.normalize_card_name('スターミーδ-デルタ種'),
  rarity='★',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-29/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スターミーδ-デルタ種',public.normalize_card_name('スターミーδ-デルタ種'),'29','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-29/large','Scrydex public card image (pcg6_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/086 シャワーズδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='シャワーズδ-デルタ種',
  name_normalized=public.normalize_card_name('シャワーズδ-デルタ種'),
  rarity='★',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-30/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シャワーズδ-デルタ種',public.normalize_card_name('シャワーズδ-デルタ種'),'30','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-30/large','Scrydex public card image (pcg6_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/086 ホロンのビリリダマ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンのビリリダマ',
  name_normalized=public.normalize_card_name('ホロンのビリリダマ'),
  rarity='◆',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-31/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンのビリリダマ',public.normalize_card_name('ホロンのビリリダマ'),'31','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-31/large','Scrydex public card image (pcg6_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/086 ホロンのマルマイン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンのマルマイン',
  name_normalized=public.normalize_card_name('ホロンのマルマイン'),
  rarity='★',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-32/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンのマルマイン',public.normalize_card_name('ホロンのマルマイン'),'32','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-32/large','Scrydex public card image (pcg6_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/086 メタモン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-33/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'33','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-33/large','Scrydex public card image (pcg6_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/086 ミニリュウδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ミニリュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ミニリュウδ-デルタ種'),
  rarity='●',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-34/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミニリュウδ-デルタ種',public.normalize_card_name('ミニリュウδ-デルタ種'),'34','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-34/large','Scrydex public card image (pcg6_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/086 ハクリューδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ハクリューδ-デルタ種',
  name_normalized=public.normalize_card_name('ハクリューδ-デルタ種'),
  rarity='◆',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-35/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハクリューδ-デルタ種',public.normalize_card_name('ハクリューδ-デルタ種'),'35','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-35/large','Scrydex public card image (pcg6_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/086 ダンバルδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ダンバルδ-デルタ種',
  name_normalized=public.normalize_card_name('ダンバルδ-デルタ種'),
  rarity='●',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-36/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダンバルδ-デルタ種',public.normalize_card_name('ダンバルδ-デルタ種'),'36','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-36/large','Scrydex public card image (pcg6_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/086 メタングδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタングδ-デルタ種',
  name_normalized=public.normalize_card_name('メタングδ-デルタ種'),
  rarity='◆',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-37/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタングδ-デルタ種',public.normalize_card_name('メタングδ-デルタ種'),'37','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-37/large','Scrydex public card image (pcg6_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/086 サンダースδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='サンダースδ-デルタ種',
  name_normalized=public.normalize_card_name('サンダースδ-デルタ種'),
  rarity='★',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-38/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンダースδ-デルタ種',public.normalize_card_name('サンダースδ-デルタ種'),'38','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-38/large','Scrydex public card image (pcg6_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/086 カイリューδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='カイリューδ-デルタ種',
  name_normalized=public.normalize_card_name('カイリューδ-デルタ種'),
  rarity='★',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-39/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイリューδ-デルタ種',public.normalize_card_name('カイリューδ-デルタ種'),'39','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-39/large','Scrydex public card image (pcg6_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/086 メタグロスδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタグロスδ-デルタ種',
  name_normalized=public.normalize_card_name('メタグロスδ-デルタ種'),
  rarity='★',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-40/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタグロスδ-デルタ種',public.normalize_card_name('メタグロスδ-デルタ種'),'40','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-40/large','Scrydex public card image (pcg6_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/086 ラティアスδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ラティアスδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティアスδ-デルタ種'),
  rarity='★',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-41/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティアスδ-デルタ種',public.normalize_card_name('ラティアスδ-デルタ種'),'41','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-41/large','Scrydex public card image (pcg6_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/086 ラティオスδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ラティオスδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティオスδ-デルタ種'),
  rarity='★',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-42/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティオスδ-デルタ種',public.normalize_card_name('ラティオスδ-デルタ種'),'42','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-42/large','Scrydex public card image (pcg6_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/086 レックウザδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='レックウザδ-デルタ種',
  name_normalized=public.normalize_card_name('レックウザδ-デルタ種'),
  rarity='★',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-43/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レックウザδ-デルタ種',public.normalize_card_name('レックウザδ-デルタ種'),'43','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-43/large','Scrydex public card image (pcg6_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/086 スリープ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='スリープ',
  name_normalized=public.normalize_card_name('スリープ'),
  rarity='●',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-44/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スリープ',public.normalize_card_name('スリープ'),'44','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-44/large','Scrydex public card image (pcg6_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/086 スリーパー
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='スリーパー',
  name_normalized=public.normalize_card_name('スリーパー'),
  rarity='★',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-45/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スリーパー',public.normalize_card_name('スリーパー'),'45','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-45/large','Scrydex public card image (pcg6_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/086 メタモン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-46/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'46','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-46/large','Scrydex public card image (pcg6_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/086 ラルトス
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ラルトス',
  name_normalized=public.normalize_card_name('ラルトス'),
  rarity='●',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-47/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラルトス',public.normalize_card_name('ラルトス'),'47','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-47/large','Scrydex public card image (pcg6_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/086 キルリア
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='キルリア',
  name_normalized=public.normalize_card_name('キルリア'),
  rarity='●',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-48/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キルリア',public.normalize_card_name('キルリア'),'48','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-48/large','Scrydex public card image (pcg6_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/086 エーフィδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='エーフィδ-デルタ種',
  name_normalized=public.normalize_card_name('エーフィδ-デルタ種'),
  rarity='★',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-49/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エーフィδ-デルタ種',public.normalize_card_name('エーフィδ-デルタ種'),'49','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-49/large','Scrydex public card image (pcg6_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/086 サーナイトδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='サーナイトδ-デルタ種',
  name_normalized=public.normalize_card_name('サーナイトδ-デルタ種'),
  rarity='★',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-50/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サーナイトδ-デルタ種',public.normalize_card_name('サーナイトδ-デルタ種'),'50','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-50/large','Scrydex public card image (pcg6_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/086 サンド
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='サンド',
  name_normalized=public.normalize_card_name('サンド'),
  rarity='●',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-51/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンド',public.normalize_card_name('サンド'),'51','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-51/large','Scrydex public card image (pcg6_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/086 カラカラ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='カラカラ',
  name_normalized=public.normalize_card_name('カラカラ'),
  rarity='●',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-52/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カラカラ',public.normalize_card_name('カラカラ'),'52','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-52/large','Scrydex public card image (pcg6_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/086 メタモン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-53/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'53','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-53/large','Scrydex public card image (pcg6_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/086 マクノシタ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='マクノシタ',
  name_normalized=public.normalize_card_name('マクノシタ'),
  rarity='●',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-54/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マクノシタ',public.normalize_card_name('マクノシタ'),'54','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-54/large','Scrydex public card image (pcg6_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/086 ハリテヤマ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ハリテヤマ',
  name_normalized=public.normalize_card_name('ハリテヤマ'),
  rarity='★',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-55/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハリテヤマ',public.normalize_card_name('ハリテヤマ'),'55','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-55/large','Scrydex public card image (pcg6_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/086 グラードン☆
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='グラードン☆',
  name_normalized=public.normalize_card_name('グラードン☆'),
  rarity='★',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-56/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'グラードン☆',public.normalize_card_name('グラードン☆'),'56','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-56/large','Scrydex public card image (pcg6_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/086 サンドパンδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='サンドパンδ-デルタ種',
  name_normalized=public.normalize_card_name('サンドパンδ-デルタ種'),
  rarity='★',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-57/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンドパンδ-デルタ種',public.normalize_card_name('サンドパンδ-デルタ種'),'57','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-57/large','Scrydex public card image (pcg6_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/086 ガラガラδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ガラガラδ-デルタ種',
  name_normalized=public.normalize_card_name('ガラガラδ-デルタ種'),
  rarity='★',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-58/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ガラガラδ-デルタ種',public.normalize_card_name('ガラガラδ-デルタ種'),'58','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-58/large','Scrydex public card image (pcg6_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/086 ニャース
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ニャース',
  name_normalized=public.normalize_card_name('ニャース'),
  rarity='●',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-59/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニャース',public.normalize_card_name('ニャース'),'59','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-59/large','Scrydex public card image (pcg6_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/086 ペルシアン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ペルシアン',
  name_normalized=public.normalize_card_name('ペルシアン'),
  rarity='★',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-60/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ペルシアン',public.normalize_card_name('ペルシアン'),'60','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-60/large','Scrydex public card image (pcg6_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/086 メタモン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-61/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'61','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-61/large','Scrydex public card image (pcg6_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/086 ポリゴン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ポリゴン',
  name_normalized=public.normalize_card_name('ポリゴン'),
  rarity='●',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-62/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポリゴン',public.normalize_card_name('ポリゴン'),'62','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-62/large','Scrydex public card image (pcg6_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/086 ポリゴン2
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ポリゴン2',
  name_normalized=public.normalize_card_name('ポリゴン2'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-63/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポリゴン2',public.normalize_card_name('ポリゴン2'),'63','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-63/large','Scrydex public card image (pcg6_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/086 スバメ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='スバメ',
  name_normalized=public.normalize_card_name('スバメ'),
  rarity='●',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-64/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スバメ',public.normalize_card_name('スバメ'),'64','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-64/large','Scrydex public card image (pcg6_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/086 オオスバメ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='オオスバメ',
  name_normalized=public.normalize_card_name('オオスバメ'),
  rarity='★',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-65/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オオスバメ',public.normalize_card_name('オオスバメ'),'65','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-65/large','Scrydex public card image (pcg6_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/086 ルリリ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ルリリ',
  name_normalized=public.normalize_card_name('ルリリ'),
  rarity='◆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-66/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ルリリ',public.normalize_card_name('ルリリ'),'66','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-66/large','Scrydex public card image (pcg6_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/086 ポワルン
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ポワルン',
  name_normalized=public.normalize_card_name('ポワルン'),
  rarity='★',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-67/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポワルン',public.normalize_card_name('ポワルン'),'67','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-67/large','Scrydex public card image (pcg6_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/086 ポチエナ
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ポチエナ',
  name_normalized=public.normalize_card_name('ポチエナ'),
  rarity='●',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-68/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポチエナ',public.normalize_card_name('ポチエナ'),'68','●','normal','https://images.scrydex.com/pokemon/pcg6_ja-68/large','Scrydex public card image (pcg6_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/086 ブラッキーδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ブラッキーδ-デルタ種',
  name_normalized=public.normalize_card_name('ブラッキーδ-デルタ種'),
  rarity='★',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-69/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブラッキーδ-デルタ種',public.normalize_card_name('ブラッキーδ-デルタ種'),'69','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-69/large','Scrydex public card image (pcg6_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/086 グラエナδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='グラエナδ-デルタ種',
  name_normalized=public.normalize_card_name('グラエナδ-デルタ種'),
  rarity='★',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-70/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'グラエナδ-デルタ種',public.normalize_card_name('グラエナδ-デルタ種'),'70','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-70/large','Scrydex public card image (pcg6_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/086 ホロンのコイル
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンのコイル',
  name_normalized=public.normalize_card_name('ホロンのコイル'),
  rarity='◆',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-71/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンのコイル',public.normalize_card_name('ホロンのコイル'),'71','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-71/large','Scrydex public card image (pcg6_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/086 ホロンのレアコイル
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンのレアコイル',
  name_normalized=public.normalize_card_name('ホロンのレアコイル'),
  rarity='★',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-72/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンのレアコイル',public.normalize_card_name('ホロンのレアコイル'),'72','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-72/large','Scrydex public card image (pcg6_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/086 イーブイδ-デルタ種
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='イーブイδ-デルタ種',
  name_normalized=public.normalize_card_name('イーブイδ-デルタ種'),
  rarity='◆',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-73/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イーブイδ-デルタ種',public.normalize_card_name('イーブイδ-デルタ種'),'73','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-73/large','Scrydex public card image (pcg6_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/086 エアームド
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='エアームド',
  name_normalized=public.normalize_card_name('エアームド'),
  rarity='◆',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-74/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エアームド',public.normalize_card_name('エアームド'),'74','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-74/large','Scrydex public card image (pcg6_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/086 メタグロス☆
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='メタグロス☆',
  name_normalized=public.normalize_card_name('メタグロス☆'),
  rarity='★',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-75/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタグロス☆',public.normalize_card_name('メタグロス☆'),'75','★','normal','https://images.scrydex.com/pokemon/pcg6_ja-75/large','Scrydex public card image (pcg6_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/086 ホロンのトランシーバー
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンのトランシーバー',
  name_normalized=public.normalize_card_name('ホロンのトランシーバー'),
  rarity='◆',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-76/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンのトランシーバー',public.normalize_card_name('ホロンのトランシーバー'),'76','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-76/large','Scrydex public card image (pcg6_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/086 ホロンの科学者
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンの科学者',
  name_normalized=public.normalize_card_name('ホロンの科学者'),
  rarity='◆',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-77/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの科学者',public.normalize_card_name('ホロンの科学者'),'77','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-77/large','Scrydex public card image (pcg6_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/086 ホロンの研究員
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンの研究員',
  name_normalized=public.normalize_card_name('ホロンの研究員'),
  rarity='◆',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-78/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの研究員',public.normalize_card_name('ホロンの研究員'),'78','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-78/large','Scrydex public card image (pcg6_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/086 ホロンの導師
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンの導師',
  name_normalized=public.normalize_card_name('ホロンの導師'),
  rarity='◆',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-79/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの導師',public.normalize_card_name('ホロンの導師'),'79','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-79/large','Scrydex public card image (pcg6_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/086 ホロンの農夫
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンの農夫',
  name_normalized=public.normalize_card_name('ホロンの農夫'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-80/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの農夫',public.normalize_card_name('ホロンの農夫'),'80','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-80/large','Scrydex public card image (pcg6_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/086 ホロンの娘
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンの娘',
  name_normalized=public.normalize_card_name('ホロンの娘'),
  rarity='◆',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-81/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの娘',public.normalize_card_name('ホロンの娘'),'81','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-81/large','Scrydex public card image (pcg6_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/086 ホロンの研究塔
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンの研究塔',
  name_normalized=public.normalize_card_name('ホロンの研究塔'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-82/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの研究塔',public.normalize_card_name('ホロンの研究塔'),'82','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-82/large','Scrydex public card image (pcg6_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

-- 083/086 ホロンの廃墟
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンの廃墟',
  name_normalized=public.normalize_card_name('ホロンの廃墟'),
  rarity='◆',
  set_order=83,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-83/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの廃墟',public.normalize_card_name('ホロンの廃墟'),'83','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-83/large','Scrydex public card image (pcg6_ja)',true,83,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83'
);

-- 084/086 ホロンエネルギーSYN:GL
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンエネルギーSYN:GL',
  name_normalized=public.normalize_card_name('ホロンエネルギーSYN:GL'),
  rarity='◆',
  set_order=84,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-84/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンエネルギーSYN:GL',public.normalize_card_name('ホロンエネルギーSYN:GL'),'84','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-84/large','Scrydex public card image (pcg6_ja)',true,84,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84'
);

-- 085/086 ホロンエネルギーSYN:FF
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンエネルギーSYN:FF',
  name_normalized=public.normalize_card_name('ホロンエネルギーSYN:FF'),
  rarity='◆',
  set_order=85,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-85/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンエネルギーSYN:FF',public.normalize_card_name('ホロンエネルギーSYN:FF'),'85','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-85/large','Scrydex public card image (pcg6_ja)',true,85,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85'
);

-- 086/086 ホロンエネルギーSYN:WP
with st as (select id from public.card_sets where code='PCG6' limit 1)
update public.cards c set
  name='ホロンエネルギーSYN:WP',
  name_normalized=public.normalize_card_name('ホロンエネルギーSYN:WP'),
  rarity='◆',
  set_order=86,
  image_url='https://images.scrydex.com/pokemon/pcg6_ja-86/large',
  image_source_note='Scrydex public card image (pcg6_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86';

with st as (select id from public.card_sets where code='PCG6' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンエネルギーSYN:WP',public.normalize_card_name('ホロンエネルギーSYN:WP'),'86','◆','normal','https://images.scrydex.com/pokemon/pcg6_ja-86/large','Scrydex public card image (pcg6_ja)',true,86,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '86'
);

commit;

-- ============================================================
-- PCG6 監査
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
where cs.code = 'PCG6'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG6' as code,
  86 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG6'
having count(distinct c.set_order) <> 86;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG6'
group by c.set_order
having count(*) > 1
order by c.set_order;
