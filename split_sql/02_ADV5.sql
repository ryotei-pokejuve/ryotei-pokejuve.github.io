-- ADV5 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- ADV5 第4弾拡張パック とかれた封印 (83 cards)
update public.card_sets
set name='第4弾拡張パック とかれた封印',
    release_date='2004-01-16'::date,
    tcgdex_series_id='ADV',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/ADV4%20Undone%20Seal%20pack.jpg'
where code='ADV5';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '第4弾拡張パック とかれた封印', 'ADV5', '2004-01-16'::date, 'ADV', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/ADV4%20Undone%20Seal%20pack.jpg'
where not exists (select 1 from public.card_sets where code='ADV5');

-- 001/083 ズバット
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ズバット',
  name_normalized=public.normalize_card_name('ズバット'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-1/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ズバット',public.normalize_card_name('ズバット'),'1','●','normal','https://images.scrydex.com/pokemon/adv5_ja-1/large','Scrydex public card image (adv5_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/083 ゴルバット
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ゴルバット',
  name_normalized=public.normalize_card_name('ゴルバット'),
  rarity='★',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-2/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴルバット',public.normalize_card_name('ゴルバット'),'2','★','normal','https://images.scrydex.com/pokemon/adv5_ja-2/large','Scrydex public card image (adv5_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/083 ナゾノクサ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ナゾノクサ',
  name_normalized=public.normalize_card_name('ナゾノクサ'),
  rarity='●',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-3/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナゾノクサ',public.normalize_card_name('ナゾノクサ'),'3','●','normal','https://images.scrydex.com/pokemon/adv5_ja-3/large','Scrydex public card image (adv5_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/083 クサイハナ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='クサイハナ',
  name_normalized=public.normalize_card_name('クサイハナ'),
  rarity='◆',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-4/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クサイハナ',public.normalize_card_name('クサイハナ'),'4','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-4/large','Scrydex public card image (adv5_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/083 ラフレシアex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ラフレシアex',
  name_normalized=public.normalize_card_name('ラフレシアex'),
  rarity='☆',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-5/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラフレシアex',public.normalize_card_name('ラフレシアex'),'5','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-5/large','Scrydex public card image (adv5_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/083 カイロス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='カイロス',
  name_normalized=public.normalize_card_name('カイロス'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-6/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイロス',public.normalize_card_name('カイロス'),'6','★','normal','https://images.scrydex.com/pokemon/adv5_ja-6/large','Scrydex public card image (adv5_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/083 クロバット
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='クロバット',
  name_normalized=public.normalize_card_name('クロバット'),
  rarity='★',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-7/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クロバット',public.normalize_card_name('クロバット'),'7','★','normal','https://images.scrydex.com/pokemon/adv5_ja-7/large','Scrydex public card image (adv5_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/083 キレイハナ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='キレイハナ',
  name_normalized=public.normalize_card_name('キレイハナ'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-8/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キレイハナ',public.normalize_card_name('キレイハナ'),'8','★','normal','https://images.scrydex.com/pokemon/adv5_ja-8/large','Scrydex public card image (adv5_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/083 ヘラクロス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ヘラクロス',
  name_normalized=public.normalize_card_name('ヘラクロス'),
  rarity='★',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-9/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヘラクロス',public.normalize_card_name('ヘラクロス'),'9','★','normal','https://images.scrydex.com/pokemon/adv5_ja-9/large','Scrydex public card image (adv5_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/083 タネボー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='タネボー',
  name_normalized=public.normalize_card_name('タネボー'),
  rarity='●',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-10/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タネボー',public.normalize_card_name('タネボー'),'10','●','normal','https://images.scrydex.com/pokemon/adv5_ja-10/large','Scrydex public card image (adv5_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/083 アメタマ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='アメタマ',
  name_normalized=public.normalize_card_name('アメタマ'),
  rarity='●',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-11/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アメタマ',public.normalize_card_name('アメタマ'),'11','●','normal','https://images.scrydex.com/pokemon/adv5_ja-11/large','Scrydex public card image (adv5_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/083 アメモース
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='アメモース',
  name_normalized=public.normalize_card_name('アメモース'),
  rarity='★',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-12/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アメモース',public.normalize_card_name('アメモース'),'12','★','normal','https://images.scrydex.com/pokemon/adv5_ja-12/large','Scrydex public card image (adv5_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/083 ゴクリン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ゴクリン',
  name_normalized=public.normalize_card_name('ゴクリン'),
  rarity='●',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-13/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴクリン',public.normalize_card_name('ゴクリン'),'13','●','normal','https://images.scrydex.com/pokemon/adv5_ja-13/large','Scrydex public card image (adv5_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/083 マルノーム
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='マルノーム',
  name_normalized=public.normalize_card_name('マルノーム'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-14/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マルノーム',public.normalize_card_name('マルノーム'),'14','★','normal','https://images.scrydex.com/pokemon/adv5_ja-14/large','Scrydex public card image (adv5_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/083 トロピウス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='トロピウス',
  name_normalized=public.normalize_card_name('トロピウス'),
  rarity='★',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-15/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トロピウス',public.normalize_card_name('トロピウス'),'15','★','normal','https://images.scrydex.com/pokemon/adv5_ja-15/large','Scrydex public card image (adv5_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/083 ロコン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ロコン',
  name_normalized=public.normalize_card_name('ロコン'),
  rarity='●',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-16/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロコン',public.normalize_card_name('ロコン'),'16','●','normal','https://images.scrydex.com/pokemon/adv5_ja-16/large','Scrydex public card image (adv5_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/083 キュウコン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='キュウコン',
  name_normalized=public.normalize_card_name('キュウコン'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-17/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キュウコン',public.normalize_card_name('キュウコン'),'17','★','normal','https://images.scrydex.com/pokemon/adv5_ja-17/large','Scrydex public card image (adv5_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/083 キュウコンex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='キュウコンex',
  name_normalized=public.normalize_card_name('キュウコンex'),
  rarity='☆',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-18/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キュウコンex',public.normalize_card_name('キュウコンex'),'18','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-18/large','Scrydex public card image (adv5_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/083 太陽のポワルン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='太陽のポワルン',
  name_normalized=public.normalize_card_name('太陽のポワルン'),
  rarity='★',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-19/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'太陽のポワルン',public.normalize_card_name('太陽のポワルン'),'19','★','normal','https://images.scrydex.com/pokemon/adv5_ja-19/large','Scrydex public card image (adv5_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/083 メノクラゲ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='メノクラゲ',
  name_normalized=public.normalize_card_name('メノクラゲ'),
  rarity='●',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-20/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メノクラゲ',public.normalize_card_name('メノクラゲ'),'20','●','normal','https://images.scrydex.com/pokemon/adv5_ja-20/large','Scrydex public card image (adv5_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/083 ドククラゲ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ドククラゲ',
  name_normalized=public.normalize_card_name('ドククラゲ'),
  rarity='★',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-21/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドククラゲ',public.normalize_card_name('ドククラゲ'),'21','★','normal','https://images.scrydex.com/pokemon/adv5_ja-21/large','Scrydex public card image (adv5_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/083 ヒトデマン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ヒトデマン',
  name_normalized=public.normalize_card_name('ヒトデマン'),
  rarity='●',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-22/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒトデマン',public.normalize_card_name('ヒトデマン'),'22','●','normal','https://images.scrydex.com/pokemon/adv5_ja-22/large','Scrydex public card image (adv5_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/083 サニーゴ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='サニーゴ',
  name_normalized=public.normalize_card_name('サニーゴ'),
  rarity='◆',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-23/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サニーゴ',public.normalize_card_name('サニーゴ'),'23','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-23/large','Scrydex public card image (adv5_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/083 ヒンバス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ヒンバス',
  name_normalized=public.normalize_card_name('ヒンバス'),
  rarity='◆',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-24/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒンバス',public.normalize_card_name('ヒンバス'),'24','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-24/large','Scrydex public card image (adv5_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/083 ミロカロス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ミロカロス',
  name_normalized=public.normalize_card_name('ミロカロス'),
  rarity='★',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-25/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミロカロス',public.normalize_card_name('ミロカロス'),'25','★','normal','https://images.scrydex.com/pokemon/adv5_ja-25/large','Scrydex public card image (adv5_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/083 雨水のポワルン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='雨水のポワルン',
  name_normalized=public.normalize_card_name('雨水のポワルン'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-26/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'雨水のポワルン',public.normalize_card_name('雨水のポワルン'),'26','★','normal','https://images.scrydex.com/pokemon/adv5_ja-26/large','Scrydex public card image (adv5_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/083 雪雲のポワルン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='雪雲のポワルン',
  name_normalized=public.normalize_card_name('雪雲のポワルン'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-27/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'雪雲のポワルン',public.normalize_card_name('雪雲のポワルン'),'27','★','normal','https://images.scrydex.com/pokemon/adv5_ja-27/large','Scrydex public card image (adv5_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/083 ユキワラシ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ユキワラシ',
  name_normalized=public.normalize_card_name('ユキワラシ'),
  rarity='●',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-28/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ユキワラシ',public.normalize_card_name('ユキワラシ'),'28','●','normal','https://images.scrydex.com/pokemon/adv5_ja-28/large','Scrydex public card image (adv5_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/083 オニゴーリ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='オニゴーリ',
  name_normalized=public.normalize_card_name('オニゴーリ'),
  rarity='★',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-29/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オニゴーリ',public.normalize_card_name('オニゴーリ'),'29','★','normal','https://images.scrydex.com/pokemon/adv5_ja-29/large','Scrydex public card image (adv5_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/083 タマザラシ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='タマザラシ',
  name_normalized=public.normalize_card_name('タマザラシ'),
  rarity='●',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-30/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タマザラシ',public.normalize_card_name('タマザラシ'),'30','●','normal','https://images.scrydex.com/pokemon/adv5_ja-30/large','Scrydex public card image (adv5_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/083 トドグラー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='トドグラー',
  name_normalized=public.normalize_card_name('トドグラー'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-31/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トドグラー',public.normalize_card_name('トドグラー'),'31','★','normal','https://images.scrydex.com/pokemon/adv5_ja-31/large','Scrydex public card image (adv5_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/083 トドゼルガ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='トドゼルガ',
  name_normalized=public.normalize_card_name('トドゼルガ'),
  rarity='★',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-32/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トドゼルガ',public.normalize_card_name('トドゼルガ'),'32','★','normal','https://images.scrydex.com/pokemon/adv5_ja-32/large','Scrydex public card image (adv5_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/083 パールル
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='パールル',
  name_normalized=public.normalize_card_name('パールル'),
  rarity='◆',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-33/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パールル',public.normalize_card_name('パールル'),'33','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-33/large','Scrydex public card image (adv5_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/083 ハンテール
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ハンテール',
  name_normalized=public.normalize_card_name('ハンテール'),
  rarity='★',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-34/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハンテール',public.normalize_card_name('ハンテール'),'34','★','normal','https://images.scrydex.com/pokemon/adv5_ja-34/large','Scrydex public card image (adv5_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/083 サクラビス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='サクラビス',
  name_normalized=public.normalize_card_name('サクラビス'),
  rarity='★',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-35/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サクラビス',public.normalize_card_name('サクラビス'),'35','★','normal','https://images.scrydex.com/pokemon/adv5_ja-35/large','Scrydex public card image (adv5_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/083 ジーランス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ジーランス',
  name_normalized=public.normalize_card_name('ジーランス'),
  rarity='★',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-36/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジーランス',public.normalize_card_name('ジーランス'),'36','★','normal','https://images.scrydex.com/pokemon/adv5_ja-36/large','Scrydex public card image (adv5_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/083 ラブカス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ラブカス',
  name_normalized=public.normalize_card_name('ラブカス'),
  rarity='★',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-37/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラブカス',public.normalize_card_name('ラブカス'),'37','★','normal','https://images.scrydex.com/pokemon/adv5_ja-37/large','Scrydex public card image (adv5_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/083 レジアイスex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='レジアイスex',
  name_normalized=public.normalize_card_name('レジアイスex'),
  rarity='☆',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-38/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レジアイスex',public.normalize_card_name('レジアイスex'),'38','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-38/large','Scrydex public card image (adv5_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/083 カイオーガex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='カイオーガex',
  name_normalized=public.normalize_card_name('カイオーガex'),
  rarity='☆',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-39/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイオーガex',public.normalize_card_name('カイオーガex'),'39','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-39/large','Scrydex public card image (adv5_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/083 ビリリダマ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ビリリダマ',
  name_normalized=public.normalize_card_name('ビリリダマ'),
  rarity='●',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-40/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビリリダマ',public.normalize_card_name('ビリリダマ'),'40','●','normal','https://images.scrydex.com/pokemon/adv5_ja-40/large','Scrydex public card image (adv5_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/083 マルマイン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='マルマイン',
  name_normalized=public.normalize_card_name('マルマイン'),
  rarity='★',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-41/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マルマイン',public.normalize_card_name('マルマイン'),'41','★','normal','https://images.scrydex.com/pokemon/adv5_ja-41/large','Scrydex public card image (adv5_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/083 チョンチー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='チョンチー',
  name_normalized=public.normalize_card_name('チョンチー'),
  rarity='●',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-42/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チョンチー',public.normalize_card_name('チョンチー'),'42','●','normal','https://images.scrydex.com/pokemon/adv5_ja-42/large','Scrydex public card image (adv5_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/083 ランターン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ランターン',
  name_normalized=public.normalize_card_name('ランターン'),
  rarity='★',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-43/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ランターン',public.normalize_card_name('ランターン'),'43','★','normal','https://images.scrydex.com/pokemon/adv5_ja-43/large','Scrydex public card image (adv5_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/083 スターミー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='スターミー',
  name_normalized=public.normalize_card_name('スターミー'),
  rarity='★',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-44/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スターミー',public.normalize_card_name('スターミー'),'44','★','normal','https://images.scrydex.com/pokemon/adv5_ja-44/large','Scrydex public card image (adv5_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/083 ネンドール
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ネンドール',
  name_normalized=public.normalize_card_name('ネンドール'),
  rarity='★',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-45/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ネンドール',public.normalize_card_name('ネンドール'),'45','★','normal','https://images.scrydex.com/pokemon/adv5_ja-45/large','Scrydex public card image (adv5_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/083 カゲボウズ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='カゲボウズ',
  name_normalized=public.normalize_card_name('カゲボウズ'),
  rarity='●',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-46/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カゲボウズ',public.normalize_card_name('カゲボウズ'),'46','●','normal','https://images.scrydex.com/pokemon/adv5_ja-46/large','Scrydex public card image (adv5_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/083 ジュペッタ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ジュペッタ',
  name_normalized=public.normalize_card_name('ジュペッタ'),
  rarity='★',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-47/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュペッタ',public.normalize_card_name('ジュペッタ'),'47','★','normal','https://images.scrydex.com/pokemon/adv5_ja-47/large','Scrydex public card image (adv5_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/083 チリーン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='チリーン',
  name_normalized=public.normalize_card_name('チリーン'),
  rarity='★',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-48/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チリーン',public.normalize_card_name('チリーン'),'48','★','normal','https://images.scrydex.com/pokemon/adv5_ja-48/large','Scrydex public card image (adv5_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/083 ワンリキー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ワンリキー',
  name_normalized=public.normalize_card_name('ワンリキー'),
  rarity='●',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-49/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワンリキー',public.normalize_card_name('ワンリキー'),'49','●','normal','https://images.scrydex.com/pokemon/adv5_ja-49/large','Scrydex public card image (adv5_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/083 ゴーリキー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ゴーリキー',
  name_normalized=public.normalize_card_name('ゴーリキー'),
  rarity='◆',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-50/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴーリキー',public.normalize_card_name('ゴーリキー'),'50','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-50/large','Scrydex public card image (adv5_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/083 カイリキー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='カイリキー',
  name_normalized=public.normalize_card_name('カイリキー'),
  rarity='★',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-51/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイリキー',public.normalize_card_name('カイリキー'),'51','★','normal','https://images.scrydex.com/pokemon/adv5_ja-51/large','Scrydex public card image (adv5_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/083 サイホーン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='サイホーン',
  name_normalized=public.normalize_card_name('サイホーン'),
  rarity='●',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-52/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サイホーン',public.normalize_card_name('サイホーン'),'52','●','normal','https://images.scrydex.com/pokemon/adv5_ja-52/large','Scrydex public card image (adv5_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/083 サイドン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='サイドン',
  name_normalized=public.normalize_card_name('サイドン'),
  rarity='★',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-53/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サイドン',public.normalize_card_name('サイドン'),'53','★','normal','https://images.scrydex.com/pokemon/adv5_ja-53/large','Scrydex public card image (adv5_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/083 チャーレム
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='チャーレム',
  name_normalized=public.normalize_card_name('チャーレム'),
  rarity='★',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-54/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チャーレム',public.normalize_card_name('チャーレム'),'54','★','normal','https://images.scrydex.com/pokemon/adv5_ja-54/large','Scrydex public card image (adv5_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/083 レジロックex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='レジロックex',
  name_normalized=public.normalize_card_name('レジロックex'),
  rarity='☆',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-55/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レジロックex',public.normalize_card_name('レジロックex'),'55','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-55/large','Scrydex public card image (adv5_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/083 グラードンex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='グラードンex',
  name_normalized=public.normalize_card_name('グラードンex'),
  rarity='☆',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-56/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'グラードンex',public.normalize_card_name('グラードンex'),'56','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-56/large','Scrydex public card image (adv5_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/083 プリン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='プリン',
  name_normalized=public.normalize_card_name('プリン'),
  rarity='●',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-57/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プリン',public.normalize_card_name('プリン'),'57','●','normal','https://images.scrydex.com/pokemon/adv5_ja-57/large','Scrydex public card image (adv5_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/083 プクリンex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='プクリンex',
  name_normalized=public.normalize_card_name('プクリンex'),
  rarity='☆',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-58/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プクリンex',public.normalize_card_name('プクリンex'),'58','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-58/large','Scrydex public card image (adv5_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/083 ドードー
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ドードー',
  name_normalized=public.normalize_card_name('ドードー'),
  rarity='●',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-59/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドードー',public.normalize_card_name('ドードー'),'59','●','normal','https://images.scrydex.com/pokemon/adv5_ja-59/large','Scrydex public card image (adv5_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/083 ドードリオ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ドードリオ',
  name_normalized=public.normalize_card_name('ドードリオ'),
  rarity='★',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-60/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドードリオ',public.normalize_card_name('ドードリオ'),'60','★','normal','https://images.scrydex.com/pokemon/adv5_ja-60/large','Scrydex public card image (adv5_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/083 ププリン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ププリン',
  name_normalized=public.normalize_card_name('ププリン'),
  rarity='◆',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-61/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ププリン',public.normalize_card_name('ププリン'),'61','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-61/large','Scrydex public card image (adv5_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/083 ゴニョニョ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ゴニョニョ',
  name_normalized=public.normalize_card_name('ゴニョニョ'),
  rarity='●',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-62/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴニョニョ',public.normalize_card_name('ゴニョニョ'),'62','●','normal','https://images.scrydex.com/pokemon/adv5_ja-62/large','Scrydex public card image (adv5_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/083 ドゴーム
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ドゴーム',
  name_normalized=public.normalize_card_name('ドゴーム'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-63/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドゴーム',public.normalize_card_name('ドゴーム'),'63','★','normal','https://images.scrydex.com/pokemon/adv5_ja-63/large','Scrydex public card image (adv5_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/083 バクオング
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='バクオング',
  name_normalized=public.normalize_card_name('バクオング'),
  rarity='★',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-64/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バクオング',public.normalize_card_name('バクオング'),'64','★','normal','https://images.scrydex.com/pokemon/adv5_ja-64/large','Scrydex public card image (adv5_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/083 パッチール
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='パッチール',
  name_normalized=public.normalize_card_name('パッチール'),
  rarity='★',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-65/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パッチール',public.normalize_card_name('パッチール'),'65','★','normal','https://images.scrydex.com/pokemon/adv5_ja-65/large','Scrydex public card image (adv5_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/083 ポワルン
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ポワルン',
  name_normalized=public.normalize_card_name('ポワルン'),
  rarity='◆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-66/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポワルン',public.normalize_card_name('ポワルン'),'66','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-66/large','Scrydex public card image (adv5_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/083 コノハナ
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='コノハナ',
  name_normalized=public.normalize_card_name('コノハナ'),
  rarity='◆',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-67/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コノハナ',public.normalize_card_name('コノハナ'),'67','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-67/large','Scrydex public card image (adv5_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/083 ダーテング
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ダーテング',
  name_normalized=public.normalize_card_name('ダーテング'),
  rarity='★',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-68/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダーテング',public.normalize_card_name('ダーテング'),'68','★','normal','https://images.scrydex.com/pokemon/adv5_ja-68/large','Scrydex public card image (adv5_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/083 ダンバル
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ダンバル',
  name_normalized=public.normalize_card_name('ダンバル'),
  rarity='◆',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-69/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダンバル',public.normalize_card_name('ダンバル'),'69','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-69/large','Scrydex public card image (adv5_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/083 メタング
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='メタング',
  name_normalized=public.normalize_card_name('メタング'),
  rarity='★',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-70/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタング',public.normalize_card_name('メタング'),'70','★','normal','https://images.scrydex.com/pokemon/adv5_ja-70/large','Scrydex public card image (adv5_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/083 メタグロスex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='メタグロスex',
  name_normalized=public.normalize_card_name('メタグロスex'),
  rarity='☆',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-71/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタグロスex',public.normalize_card_name('メタグロスex'),'71','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-71/large','Scrydex public card image (adv5_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/083 レジスチルex
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='レジスチルex',
  name_normalized=public.normalize_card_name('レジスチルex'),
  rarity='☆',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-72/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レジスチルex',public.normalize_card_name('レジスチルex'),'72','☆','normal','https://images.scrydex.com/pokemon/adv5_ja-72/large','Scrydex public card image (adv5_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/083 ふっかつそう
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ふっかつそう',
  name_normalized=public.normalize_card_name('ふっかつそう'),
  rarity='◆',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-73/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ふっかつそう',public.normalize_card_name('ふっかつそう'),'73','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-73/large','Scrydex public card image (adv5_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/083 ダイゴのアドバイス
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='ダイゴのアドバイス',
  name_normalized=public.normalize_card_name('ダイゴのアドバイス'),
  rarity='◆',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-74/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダイゴのアドバイス',public.normalize_card_name('ダイゴのアドバイス'),'74','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-74/large','Scrydex public card image (adv5_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/083 超古代のワザマシン氷
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='超古代のワザマシン氷',
  name_normalized=public.normalize_card_name('超古代のワザマシン氷'),
  rarity='◆',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-75/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'超古代のワザマシン氷',public.normalize_card_name('超古代のワザマシン氷'),'75','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-75/large','Scrydex public card image (adv5_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/083 超古代のワザマシン岩
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='超古代のワザマシン岩',
  name_normalized=public.normalize_card_name('超古代のワザマシン岩'),
  rarity='◆',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-76/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'超古代のワザマシン岩',public.normalize_card_name('超古代のワザマシン岩'),'76','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-76/large','Scrydex public card image (adv5_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/083 超古代のワザマシン鋼
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='超古代のワザマシン鋼',
  name_normalized=public.normalize_card_name('超古代のワザマシン鋼'),
  rarity='◆',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-77/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'超古代のワザマシン鋼',public.normalize_card_name('超古代のワザマシン鋼'),'77','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-77/large','Scrydex public card image (adv5_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/083 小島の横穴
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='小島の横穴',
  name_normalized=public.normalize_card_name('小島の横穴'),
  rarity='◆',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-78/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'小島の横穴',public.normalize_card_name('小島の横穴'),'78','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-78/large','Scrydex public card image (adv5_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/083 古代塚
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='古代塚',
  name_normalized=public.normalize_card_name('古代塚'),
  rarity='◆',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-79/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'古代塚',public.normalize_card_name('古代塚'),'79','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-79/large','Scrydex public card image (adv5_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/083 砂漠の遺跡
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='砂漠の遺跡',
  name_normalized=public.normalize_card_name('砂漠の遺跡'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-80/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'砂漠の遺跡',public.normalize_card_name('砂漠の遺跡'),'80','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-80/large','Scrydex public card image (adv5_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/083 高気圧
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='高気圧',
  name_normalized=public.normalize_card_name('高気圧'),
  rarity='◆',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-81/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'高気圧',public.normalize_card_name('高気圧'),'81','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-81/large','Scrydex public card image (adv5_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/083 低気圧
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='低気圧',
  name_normalized=public.normalize_card_name('低気圧'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-82/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'低気圧',public.normalize_card_name('低気圧'),'82','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-82/large','Scrydex public card image (adv5_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

-- 083/083 磁気嵐
with st as (select id from public.card_sets where code='ADV5' limit 1)
update public.cards c set
  name='磁気嵐',
  name_normalized=public.normalize_card_name('磁気嵐'),
  rarity='◆',
  set_order=83,
  image_url='https://images.scrydex.com/pokemon/adv5_ja-83/large',
  image_source_note='Scrydex public card image (adv5_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83';

with st as (select id from public.card_sets where code='ADV5' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'磁気嵐',public.normalize_card_name('磁気嵐'),'83','◆','normal','https://images.scrydex.com/pokemon/adv5_ja-83/large','Scrydex public card image (adv5_ja)',true,83,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83'
);

commit;

-- ============================================================
-- ADV5 監査
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
where cs.code = 'ADV5'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'ADV5' as code,
  83 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'ADV5'
having count(distinct c.set_order) <> 83;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'ADV5'
group by c.set_order
having count(*) > 1
order by c.set_order;
