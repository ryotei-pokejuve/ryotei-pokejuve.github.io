-- PCG2 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG2 拡張パック 蒼空の激突 (82 cards)
update public.card_sets
set name='拡張パック 蒼空の激突',
    release_date='2004-07-01'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG2%20Clash%20of%20the%20Blue%20Sky%20pack.jpg'
where code='PCG2';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック 蒼空の激突', 'PCG2', '2004-07-01'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG2%20Clash%20of%20the%20Blue%20Sky%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG2');

-- 001/082 ズバット
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ズバット',
  name_normalized=public.normalize_card_name('ズバット'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-1/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ズバット',public.normalize_card_name('ズバット'),'1','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-1/large','Scrydex public card image (pcg2_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/082 ゴルバット
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ゴルバット',
  name_normalized=public.normalize_card_name('ゴルバット'),
  rarity='◆',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-2/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴルバット',public.normalize_card_name('ゴルバット'),'2','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-2/large','Scrydex public card image (pcg2_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/082 ドガース
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ドガース',
  name_normalized=public.normalize_card_name('ドガース'),
  rarity='●',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-3/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドガース',public.normalize_card_name('ドガース'),'3','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-3/large','Scrydex public card image (pcg2_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/082 マタドガス
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='マタドガス',
  name_normalized=public.normalize_card_name('マタドガス'),
  rarity='★',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-4/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マタドガス',public.normalize_card_name('マタドガス'),'4','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-4/large','Scrydex public card image (pcg2_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/082 クロバットex
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='クロバットex',
  name_normalized=public.normalize_card_name('クロバットex'),
  rarity='☆',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-5/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クロバットex',public.normalize_card_name('クロバットex'),'5','☆','normal','https://images.scrydex.com/pokemon/pcg2_ja-5/large','Scrydex public card image (pcg2_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/082 ケムッソ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ケムッソ',
  name_normalized=public.normalize_card_name('ケムッソ'),
  rarity='●',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-6/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ケムッソ',public.normalize_card_name('ケムッソ'),'6','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-6/large','Scrydex public card image (pcg2_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/082 カラサリス
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='カラサリス',
  name_normalized=public.normalize_card_name('カラサリス'),
  rarity='◆',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-7/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カラサリス',public.normalize_card_name('カラサリス'),'7','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-7/large','Scrydex public card image (pcg2_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/082 アゲハント
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='アゲハント',
  name_normalized=public.normalize_card_name('アゲハント'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-8/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アゲハント',public.normalize_card_name('アゲハント'),'8','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-8/large','Scrydex public card image (pcg2_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/082 アメタマ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='アメタマ',
  name_normalized=public.normalize_card_name('アメタマ'),
  rarity='◆',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-9/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アメタマ',public.normalize_card_name('アメタマ'),'9','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-9/large','Scrydex public card image (pcg2_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/082 アメモース
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='アメモース',
  name_normalized=public.normalize_card_name('アメモース'),
  rarity='★',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-10/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アメモース',public.normalize_card_name('アメモース'),'10','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-10/large','Scrydex public card image (pcg2_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/082 キノココ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='キノココ',
  name_normalized=public.normalize_card_name('キノココ'),
  rarity='●',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-11/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キノココ',public.normalize_card_name('キノココ'),'11','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-11/large','Scrydex public card image (pcg2_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/082 ツチニン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ツチニン',
  name_normalized=public.normalize_card_name('ツチニン'),
  rarity='◆',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-12/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ツチニン',public.normalize_card_name('ツチニン'),'12','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-12/large','Scrydex public card image (pcg2_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/082 テッカニン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='テッカニン',
  name_normalized=public.normalize_card_name('テッカニン'),
  rarity='★',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-13/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'テッカニン',public.normalize_card_name('テッカニン'),'13','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-13/large','Scrydex public card image (pcg2_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/082 トロピウス
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='トロピウス',
  name_normalized=public.normalize_card_name('トロピウス'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-14/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トロピウス',public.normalize_card_name('トロピウス'),'14','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-14/large','Scrydex public card image (pcg2_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/082 マグマッグ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='マグマッグ',
  name_normalized=public.normalize_card_name('マグマッグ'),
  rarity='●',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-15/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマッグ',public.normalize_card_name('マグマッグ'),'15','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-15/large','Scrydex public card image (pcg2_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/082 マグカルゴ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='マグカルゴ',
  name_normalized=public.normalize_card_name('マグカルゴ'),
  rarity='★',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-16/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグカルゴ',public.normalize_card_name('マグカルゴ'),'16','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-16/large','Scrydex public card image (pcg2_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/082 ドンメル
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ドンメル',
  name_normalized=public.normalize_card_name('ドンメル'),
  rarity='●',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-17/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドンメル',public.normalize_card_name('ドンメル'),'17','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-17/large','Scrydex public card image (pcg2_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/082 バクーダ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='バクーダ',
  name_normalized=public.normalize_card_name('バクーダ'),
  rarity='★',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-18/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バクーダ',public.normalize_card_name('バクーダ'),'18','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-18/large','Scrydex public card image (pcg2_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/082 トサキント
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='トサキント',
  name_normalized=public.normalize_card_name('トサキント'),
  rarity='●',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-19/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トサキント',public.normalize_card_name('トサキント'),'19','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-19/large','Scrydex public card image (pcg2_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/082 アズマオウ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='アズマオウ',
  name_normalized=public.normalize_card_name('アズマオウ'),
  rarity='★',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-20/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アズマオウ',public.normalize_card_name('アズマオウ'),'20','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-20/large','Scrydex public card image (pcg2_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/082 ヒトデマン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヒトデマン',
  name_normalized=public.normalize_card_name('ヒトデマン'),
  rarity='●',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-21/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒトデマン',public.normalize_card_name('ヒトデマン'),'21','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-21/large','Scrydex public card image (pcg2_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/082 スターミー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='スターミー',
  name_normalized=public.normalize_card_name('スターミー'),
  rarity='★',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-22/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スターミー',public.normalize_card_name('スターミー'),'22','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-22/large','Scrydex public card image (pcg2_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/082 コイキング
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='コイキング',
  name_normalized=public.normalize_card_name('コイキング'),
  rarity='●',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-23/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コイキング',public.normalize_card_name('コイキング'),'23','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-23/large','Scrydex public card image (pcg2_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/082 ギャラドス
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ギャラドス',
  name_normalized=public.normalize_card_name('ギャラドス'),
  rarity='★',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-24/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ギャラドス',public.normalize_card_name('ギャラドス'),'24','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-24/large','Scrydex public card image (pcg2_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/082 ハスボー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ハスボー',
  name_normalized=public.normalize_card_name('ハスボー'),
  rarity='◆',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-25/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハスボー',public.normalize_card_name('ハスボー'),'25','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-25/large','Scrydex public card image (pcg2_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/082 ハスブレロ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ハスブレロ',
  name_normalized=public.normalize_card_name('ハスブレロ'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-26/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハスブレロ',public.normalize_card_name('ハスブレロ'),'26','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-26/large','Scrydex public card image (pcg2_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/082 ルンパッパ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ルンパッパ',
  name_normalized=public.normalize_card_name('ルンパッパ'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-27/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ルンパッパ',public.normalize_card_name('ルンパッパ'),'27','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-27/large','Scrydex public card image (pcg2_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/082 キャモメ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='キャモメ',
  name_normalized=public.normalize_card_name('キャモメ'),
  rarity='●',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-28/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キャモメ',public.normalize_card_name('キャモメ'),'28','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-28/large','Scrydex public card image (pcg2_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/082 ペリッパー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ペリッパー',
  name_normalized=public.normalize_card_name('ペリッパー'),
  rarity='★',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-29/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ペリッパー',public.normalize_card_name('ペリッパー'),'29','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-29/large','Scrydex public card image (pcg2_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/082 ドジョッチ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ドジョッチ',
  name_normalized=public.normalize_card_name('ドジョッチ'),
  rarity='●',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-30/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドジョッチ',public.normalize_card_name('ドジョッチ'),'30','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-30/large','Scrydex public card image (pcg2_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/082 ヘイガニ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヘイガニ',
  name_normalized=public.normalize_card_name('ヘイガニ'),
  rarity='◆',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-31/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヘイガニ',public.normalize_card_name('ヘイガニ'),'31','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-31/large','Scrydex public card image (pcg2_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/082 ラクライ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ラクライ',
  name_normalized=public.normalize_card_name('ラクライ'),
  rarity='●',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-32/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラクライ',public.normalize_card_name('ラクライ'),'32','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-32/large','Scrydex public card image (pcg2_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/082 ライボルトex
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ライボルトex',
  name_normalized=public.normalize_card_name('ライボルトex'),
  rarity='☆',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-33/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ライボルトex',public.normalize_card_name('ライボルトex'),'33','☆','normal','https://images.scrydex.com/pokemon/pcg2_ja-33/large','Scrydex public card image (pcg2_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/082 プラスル
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='プラスル',
  name_normalized=public.normalize_card_name('プラスル'),
  rarity='★',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-34/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プラスル',public.normalize_card_name('プラスル'),'34','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-34/large','Scrydex public card image (pcg2_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/082 マイナン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='マイナン',
  name_normalized=public.normalize_card_name('マイナン'),
  rarity='★',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-35/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マイナン',public.normalize_card_name('マイナン'),'35','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-35/large','Scrydex public card image (pcg2_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/082 ネイティ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ネイティ',
  name_normalized=public.normalize_card_name('ネイティ'),
  rarity='●',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-36/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ネイティ',public.normalize_card_name('ネイティ'),'36','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-36/large','Scrydex public card image (pcg2_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/082 ネイティオ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ネイティオ',
  name_normalized=public.normalize_card_name('ネイティオ'),
  rarity='★',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-37/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ネイティオ',public.normalize_card_name('ネイティオ'),'37','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-37/large','Scrydex public card image (pcg2_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/082 ヌケニン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヌケニン',
  name_normalized=public.normalize_card_name('ヌケニン'),
  rarity='★',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-38/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヌケニン',public.normalize_card_name('ヌケニン'),'38','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-38/large','Scrydex public card image (pcg2_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/082 ソルロック
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ソルロック',
  name_normalized=public.normalize_card_name('ソルロック'),
  rarity='★',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-39/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ソルロック',public.normalize_card_name('ソルロック'),'39','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-39/large','Scrydex public card image (pcg2_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/082 ヨマワル
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヨマワル',
  name_normalized=public.normalize_card_name('ヨマワル'),
  rarity='◆',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-40/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヨマワル',public.normalize_card_name('ヨマワル'),'40','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-40/large','Scrydex public card image (pcg2_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/082 サマヨール
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='サマヨール',
  name_normalized=public.normalize_card_name('サマヨール'),
  rarity='★',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-41/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サマヨール',public.normalize_card_name('サマヨール'),'41','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-41/large','Scrydex public card image (pcg2_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/082 ダンバル
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ダンバル',
  name_normalized=public.normalize_card_name('ダンバル'),
  rarity='◆',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-42/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダンバル',public.normalize_card_name('ダンバル'),'42','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-42/large','Scrydex public card image (pcg2_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/082 メタング
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='メタング',
  name_normalized=public.normalize_card_name('メタング'),
  rarity='★',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-43/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタング',public.normalize_card_name('メタング'),'43','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-43/large','Scrydex public card image (pcg2_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/082 メタグロス
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='メタグロス',
  name_normalized=public.normalize_card_name('メタグロス'),
  rarity='★',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-44/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタグロス',public.normalize_card_name('メタグロス'),'44','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-44/large','Scrydex public card image (pcg2_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/082 デオキシスex
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='デオキシスex',
  name_normalized=public.normalize_card_name('デオキシスex'),
  rarity='☆',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-45/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デオキシスex',public.normalize_card_name('デオキシスex'),'45','☆','normal','https://images.scrydex.com/pokemon/pcg2_ja-45/large','Scrydex public card image (pcg2_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/082 デオキシスex
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='デオキシスex',
  name_normalized=public.normalize_card_name('デオキシスex'),
  rarity='☆',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-46/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デオキシスex',public.normalize_card_name('デオキシスex'),'46','☆','normal','https://images.scrydex.com/pokemon/pcg2_ja-46/large','Scrydex public card image (pcg2_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/082 キノガッサ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='キノガッサ',
  name_normalized=public.normalize_card_name('キノガッサ'),
  rarity='★',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-47/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キノガッサ',public.normalize_card_name('キノガッサ'),'47','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-47/large','Scrydex public card image (pcg2_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/082 マクノシタ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='マクノシタ',
  name_normalized=public.normalize_card_name('マクノシタ'),
  rarity='●',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-48/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マクノシタ',public.normalize_card_name('マクノシタ'),'48','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-48/large','Scrydex public card image (pcg2_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/082 ハリテヤマex
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ハリテヤマex',
  name_normalized=public.normalize_card_name('ハリテヤマex'),
  rarity='☆',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-49/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハリテヤマex',public.normalize_card_name('ハリテヤマex'),'49','☆','normal','https://images.scrydex.com/pokemon/pcg2_ja-49/large','Scrydex public card image (pcg2_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/082 ノズパス
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ノズパス',
  name_normalized=public.normalize_card_name('ノズパス'),
  rarity='★',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-50/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ノズパス',public.normalize_card_name('ノズパス'),'50','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-50/large','Scrydex public card image (pcg2_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/082 ルナトーン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ルナトーン',
  name_normalized=public.normalize_card_name('ルナトーン'),
  rarity='★',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-51/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ルナトーン',public.normalize_card_name('ルナトーン'),'51','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-51/large','Scrydex public card image (pcg2_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/082 ナマズン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ナマズン',
  name_normalized=public.normalize_card_name('ナマズン'),
  rarity='★',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-52/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナマズン',public.normalize_card_name('ナマズン'),'52','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-52/large','Scrydex public card image (pcg2_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/082 ヤジロン
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヤジロン',
  name_normalized=public.normalize_card_name('ヤジロン'),
  rarity='●',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-53/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤジロン',public.normalize_card_name('ヤジロン'),'53','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-53/large','Scrydex public card image (pcg2_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/082 ネンドール
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ネンドール',
  name_normalized=public.normalize_card_name('ネンドール'),
  rarity='★',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-54/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ネンドール',public.normalize_card_name('ネンドール'),'54','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-54/large','Scrydex public card image (pcg2_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/082 スバメ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='スバメ',
  name_normalized=public.normalize_card_name('スバメ'),
  rarity='●',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-55/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スバメ',public.normalize_card_name('スバメ'),'55','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-55/large','Scrydex public card image (pcg2_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/082 オオスバメ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='オオスバメ',
  name_normalized=public.normalize_card_name('オオスバメ'),
  rarity='★',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-56/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オオスバメ',public.normalize_card_name('オオスバメ'),'56','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-56/large','Scrydex public card image (pcg2_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/082 ナマケロ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ナマケロ',
  name_normalized=public.normalize_card_name('ナマケロ'),
  rarity='●',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-57/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナマケロ',public.normalize_card_name('ナマケロ'),'57','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-57/large','Scrydex public card image (pcg2_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/082 ヤルキモノ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヤルキモノ',
  name_normalized=public.normalize_card_name('ヤルキモノ'),
  rarity='★',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-58/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤルキモノ',public.normalize_card_name('ヤルキモノ'),'58','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-58/large','Scrydex public card image (pcg2_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/082 ケッキング
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ケッキング',
  name_normalized=public.normalize_card_name('ケッキング'),
  rarity='★',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-59/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ケッキング',public.normalize_card_name('ケッキング'),'59','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-59/large','Scrydex public card image (pcg2_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/082 チルット
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='チルット',
  name_normalized=public.normalize_card_name('チルット'),
  rarity='◆',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-60/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルット',public.normalize_card_name('チルット'),'60','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-60/large','Scrydex public card image (pcg2_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/082 チルタリス
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='チルタリス',
  name_normalized=public.normalize_card_name('チルタリス'),
  rarity='★',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-61/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルタリス',public.normalize_card_name('チルタリス'),'61','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-61/large','Scrydex public card image (pcg2_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/082 タツベイ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='タツベイ',
  name_normalized=public.normalize_card_name('タツベイ'),
  rarity='●',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-62/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タツベイ',public.normalize_card_name('タツベイ'),'62','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-62/large','Scrydex public card image (pcg2_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/082 コモルー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='コモルー',
  name_normalized=public.normalize_card_name('コモルー'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-63/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コモルー',public.normalize_card_name('コモルー'),'63','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-63/large','Scrydex public card image (pcg2_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/082 ボーマンダex
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ボーマンダex',
  name_normalized=public.normalize_card_name('ボーマンダex'),
  rarity='☆',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-64/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボーマンダex',public.normalize_card_name('ボーマンダex'),'64','☆','normal','https://images.scrydex.com/pokemon/pcg2_ja-64/large','Scrydex public card image (pcg2_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/082 ラティアス☆
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ラティアス☆',
  name_normalized=public.normalize_card_name('ラティアス☆'),
  rarity='★',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-65/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティアス☆',public.normalize_card_name('ラティアス☆'),'65','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-65/large','Scrydex public card image (pcg2_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/082 ラティオス☆
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ラティオス☆',
  name_normalized=public.normalize_card_name('ラティオス☆'),
  rarity='★',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-66/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティオス☆',public.normalize_card_name('ラティオス☆'),'66','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-66/large','Scrydex public card image (pcg2_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/082 レックウザ☆
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='レックウザ☆',
  name_normalized=public.normalize_card_name('レックウザ☆'),
  rarity='★',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-67/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レックウザ☆',public.normalize_card_name('レックウザ☆'),'67','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-67/large','Scrydex public card image (pcg2_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/082 ポチエナ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ポチエナ',
  name_normalized=public.normalize_card_name('ポチエナ'),
  rarity='●',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-68/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポチエナ',public.normalize_card_name('ポチエナ'),'68','●','normal','https://images.scrydex.com/pokemon/pcg2_ja-68/large','Scrydex public card image (pcg2_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/082 グラエナ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='グラエナ',
  name_normalized=public.normalize_card_name('グラエナ'),
  rarity='★',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-69/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'グラエナ',public.normalize_card_name('グラエナ'),'69','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-69/large','Scrydex public card image (pcg2_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/082 ヤミラミ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヤミラミ',
  name_normalized=public.normalize_card_name('ヤミラミ'),
  rarity='★',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-70/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤミラミ',public.normalize_card_name('ヤミラミ'),'70','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-70/large','Scrydex public card image (pcg2_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/082 キバニア
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='キバニア',
  name_normalized=public.normalize_card_name('キバニア'),
  rarity='◆',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-71/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キバニア',public.normalize_card_name('キバニア'),'71','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-71/large','Scrydex public card image (pcg2_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/082 サメハダーex
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='サメハダーex',
  name_normalized=public.normalize_card_name('サメハダーex'),
  rarity='☆',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-72/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サメハダーex',public.normalize_card_name('サメハダーex'),'72','☆','normal','https://images.scrydex.com/pokemon/pcg2_ja-72/large','Scrydex public card image (pcg2_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/082 シザリガー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='シザリガー',
  name_normalized=public.normalize_card_name('シザリガー'),
  rarity='★',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-73/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シザリガー',public.normalize_card_name('シザリガー'),'73','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-73/large','Scrydex public card image (pcg2_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/082 エアームド
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='エアームド',
  name_normalized=public.normalize_card_name('エアームド'),
  rarity='★',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-74/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'エアームド',public.normalize_card_name('エアームド'),'74','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-74/large','Scrydex public card image (pcg2_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/082 ジラーチ
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ジラーチ',
  name_normalized=public.normalize_card_name('ジラーチ'),
  rarity='★',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-75/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジラーチ',public.normalize_card_name('ジラーチ'),'75','★','normal','https://images.scrydex.com/pokemon/pcg2_ja-75/large','Scrydex public card image (pcg2_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/082 ソライシはかせの発見
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ソライシはかせの発見',
  name_normalized=public.normalize_card_name('ソライシはかせの発見'),
  rarity='◆',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-76/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ソライシはかせの発見',public.normalize_card_name('ソライシはかせの発見'),'76','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-76/large','Scrydex public card image (pcg2_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/082 水晶のかけら
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='水晶のかけら',
  name_normalized=public.normalize_card_name('水晶のかけら'),
  rarity='◆',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-77/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'水晶のかけら',public.normalize_card_name('水晶のかけら'),'77','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-77/large','Scrydex public card image (pcg2_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/082 宇宙センター
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='宇宙センター',
  name_normalized=public.normalize_card_name('宇宙センター'),
  rarity='◆',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-78/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'宇宙センター',public.normalize_card_name('宇宙センター'),'78','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-78/large','Scrydex public card image (pcg2_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/082 流星の滝
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='流星の滝',
  name_normalized=public.normalize_card_name('流星の滝'),
  rarity='◆',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-79/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'流星の滝',public.normalize_card_name('流星の滝'),'79','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-79/large','Scrydex public card image (pcg2_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/082 スクランブルエネルギー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='スクランブルエネルギー',
  name_normalized=public.normalize_card_name('スクランブルエネルギー'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-80/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スクランブルエネルギー',public.normalize_card_name('スクランブルエネルギー'),'80','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-80/large','Scrydex public card image (pcg2_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/082 ヒーリングエネルギー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ヒーリングエネルギー',
  name_normalized=public.normalize_card_name('ヒーリングエネルギー'),
  rarity='◆',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-81/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒーリングエネルギー',public.normalize_card_name('ヒーリングエネルギー'),'81','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-81/large','Scrydex public card image (pcg2_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/082 ブーストエネルギー
with st as (select id from public.card_sets where code='PCG2' limit 1)
update public.cards c set
  name='ブーストエネルギー',
  name_normalized=public.normalize_card_name('ブーストエネルギー'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcg2_ja-82/large',
  image_source_note='Scrydex public card image (pcg2_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='PCG2' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブーストエネルギー',public.normalize_card_name('ブーストエネルギー'),'82','◆','normal','https://images.scrydex.com/pokemon/pcg2_ja-82/large','Scrydex public card image (pcg2_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

commit;

-- ============================================================
-- PCG2 監査
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
where cs.code = 'PCG2'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG2' as code,
  82 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG2'
having count(distinct c.set_order) <> 82;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG2'
group by c.set_order
having count(*) > 1
order by c.set_order;
