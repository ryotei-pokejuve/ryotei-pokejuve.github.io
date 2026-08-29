-- PCG1 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG1 拡張パック 伝説の飛翔 (82 cards)
update public.card_sets
set name='拡張パック 伝説の飛翔',
    release_date='2004-04-09'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG1%20Flight%20of%20Legends%20pack.jpg'
where code='PCG1';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック 伝説の飛翔', 'PCG1', '2004-04-09'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG1%20Flight%20of%20Legends%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG1');

-- 001/082 キャタピー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='キャタピー',
  name_normalized=public.normalize_card_name('キャタピー'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-1/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キャタピー',public.normalize_card_name('キャタピー'),'1','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-1/large','Scrydex public card image (pcg1_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/082 トランセル
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='トランセル',
  name_normalized=public.normalize_card_name('トランセル'),
  rarity='◆',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-2/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トランセル',public.normalize_card_name('トランセル'),'2','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-2/large','Scrydex public card image (pcg1_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/082 バタフリー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='バタフリー',
  name_normalized=public.normalize_card_name('バタフリー'),
  rarity='★',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-3/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バタフリー',public.normalize_card_name('バタフリー'),'3','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-3/large','Scrydex public card image (pcg1_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/082 ビードル
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ビードル',
  name_normalized=public.normalize_card_name('ビードル'),
  rarity='●',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-4/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビードル',public.normalize_card_name('ビードル'),'4','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-4/large','Scrydex public card image (pcg1_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/082 コクーン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='コクーン',
  name_normalized=public.normalize_card_name('コクーン'),
  rarity='◆',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-5/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コクーン',public.normalize_card_name('コクーン'),'5','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-5/large','Scrydex public card image (pcg1_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/082 スピアー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='スピアー',
  name_normalized=public.normalize_card_name('スピアー'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-6/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スピアー',public.normalize_card_name('スピアー'),'6','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-6/large','Scrydex public card image (pcg1_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/082 ニドラン♀
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニドラン♀',
  name_normalized=public.normalize_card_name('ニドラン♀'),
  rarity='●',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-7/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドラン♀',public.normalize_card_name('ニドラン♀'),'7','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-7/large','Scrydex public card image (pcg1_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/082 ニドリーナ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニドリーナ',
  name_normalized=public.normalize_card_name('ニドリーナ'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-8/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドリーナ',public.normalize_card_name('ニドリーナ'),'8','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-8/large','Scrydex public card image (pcg1_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/082 ニドラン♂
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニドラン♂',
  name_normalized=public.normalize_card_name('ニドラン♂'),
  rarity='●',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-9/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドラン♂',public.normalize_card_name('ニドラン♂'),'9','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-9/large','Scrydex public card image (pcg1_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/082 ニドリーノ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニドリーノ',
  name_normalized=public.normalize_card_name('ニドリーノ'),
  rarity='★',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-10/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドリーノ',public.normalize_card_name('ニドリーノ'),'10','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-10/large','Scrydex public card image (pcg1_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/082 パラス
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='パラス',
  name_normalized=public.normalize_card_name('パラス'),
  rarity='●',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-11/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パラス',public.normalize_card_name('パラス'),'11','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-11/large','Scrydex public card image (pcg1_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/082 パラセクト
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='パラセクト',
  name_normalized=public.normalize_card_name('パラセクト'),
  rarity='★',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-12/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パラセクト',public.normalize_card_name('パラセクト'),'12','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-12/large','Scrydex public card image (pcg1_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/082 コンパン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='コンパン',
  name_normalized=public.normalize_card_name('コンパン'),
  rarity='◆',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-13/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コンパン',public.normalize_card_name('コンパン'),'13','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-13/large','Scrydex public card image (pcg1_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/082 モルフォン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='モルフォン',
  name_normalized=public.normalize_card_name('モルフォン'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-14/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'モルフォン',public.normalize_card_name('モルフォン'),'14','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-14/large','Scrydex public card image (pcg1_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/082 マダツボミ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='マダツボミ',
  name_normalized=public.normalize_card_name('マダツボミ'),
  rarity='●',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-15/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マダツボミ',public.normalize_card_name('マダツボミ'),'15','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-15/large','Scrydex public card image (pcg1_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/082 ウツドン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ウツドン',
  name_normalized=public.normalize_card_name('ウツドン'),
  rarity='★',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-16/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウツドン',public.normalize_card_name('ウツドン'),'16','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-16/large','Scrydex public card image (pcg1_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/082 ウツボット
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ウツボット',
  name_normalized=public.normalize_card_name('ウツボット'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-17/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウツボット',public.normalize_card_name('ウツボット'),'17','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-17/large','Scrydex public card image (pcg1_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/082 モンジャラ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='モンジャラ',
  name_normalized=public.normalize_card_name('モンジャラ'),
  rarity='★',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-18/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'モンジャラ',public.normalize_card_name('モンジャラ'),'18','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-18/large','Scrydex public card image (pcg1_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/082 ストライク
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ストライク',
  name_normalized=public.normalize_card_name('ストライク'),
  rarity='★',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-19/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ストライク',public.normalize_card_name('ストライク'),'19','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-19/large','Scrydex public card image (pcg1_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/082 ガーディ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ガーディ',
  name_normalized=public.normalize_card_name('ガーディ'),
  rarity='◆',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-20/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ガーディ',public.normalize_card_name('ガーディ'),'20','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-20/large','Scrydex public card image (pcg1_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/082 ウインディ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ウインディ',
  name_normalized=public.normalize_card_name('ウインディ'),
  rarity='★',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-21/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウインディ',public.normalize_card_name('ウインディ'),'21','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-21/large','Scrydex public card image (pcg1_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/082 ポニータ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ポニータ',
  name_normalized=public.normalize_card_name('ポニータ'),
  rarity='●',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-22/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポニータ',public.normalize_card_name('ポニータ'),'22','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-22/large','Scrydex public card image (pcg1_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/082 ギャロップ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ギャロップ',
  name_normalized=public.normalize_card_name('ギャロップ'),
  rarity='★',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-23/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ギャロップ',public.normalize_card_name('ギャロップ'),'23','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-23/large','Scrydex public card image (pcg1_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/082 ファイヤーex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ファイヤーex',
  name_normalized=public.normalize_card_name('ファイヤーex'),
  rarity='☆',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-24/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ファイヤーex',public.normalize_card_name('ファイヤーex'),'24','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-24/large','Scrydex public card image (pcg1_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/082 ニョロモ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニョロモ',
  name_normalized=public.normalize_card_name('ニョロモ'),
  rarity='●',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-25/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニョロモ',public.normalize_card_name('ニョロモ'),'25','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-25/large','Scrydex public card image (pcg1_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/082 ニョロゾ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニョロゾ',
  name_normalized=public.normalize_card_name('ニョロゾ'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-26/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニョロゾ',public.normalize_card_name('ニョロゾ'),'26','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-26/large','Scrydex public card image (pcg1_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/082 ニョロボン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニョロボン',
  name_normalized=public.normalize_card_name('ニョロボン'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-27/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニョロボン',public.normalize_card_name('ニョロボン'),'27','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-27/large','Scrydex public card image (pcg1_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/082 パウワウ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='パウワウ',
  name_normalized=public.normalize_card_name('パウワウ'),
  rarity='●',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-28/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パウワウ',public.normalize_card_name('パウワウ'),'28','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-28/large','Scrydex public card image (pcg1_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/082 ジュゴン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ジュゴン',
  name_normalized=public.normalize_card_name('ジュゴン'),
  rarity='★',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-29/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュゴン',public.normalize_card_name('ジュゴン'),'29','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-29/large','Scrydex public card image (pcg1_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/082 シェルダー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='シェルダー',
  name_normalized=public.normalize_card_name('シェルダー'),
  rarity='◆',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-30/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シェルダー',public.normalize_card_name('シェルダー'),'30','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-30/large','Scrydex public card image (pcg1_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/082 パルシェン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='パルシェン',
  name_normalized=public.normalize_card_name('パルシェン'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-31/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パルシェン',public.normalize_card_name('パルシェン'),'31','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-31/large','Scrydex public card image (pcg1_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/082 クラブ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='クラブ',
  name_normalized=public.normalize_card_name('クラブ'),
  rarity='●',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-32/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クラブ',public.normalize_card_name('クラブ'),'32','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-32/large','Scrydex public card image (pcg1_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/082 キングラー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='キングラー',
  name_normalized=public.normalize_card_name('キングラー'),
  rarity='★',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-33/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キングラー',public.normalize_card_name('キングラー'),'33','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-33/large','Scrydex public card image (pcg1_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/082 コイキング
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='コイキング',
  name_normalized=public.normalize_card_name('コイキング'),
  rarity='●',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-34/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コイキング',public.normalize_card_name('コイキング'),'34','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-34/large','Scrydex public card image (pcg1_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/082 ギャラドスex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ギャラドスex',
  name_normalized=public.normalize_card_name('ギャラドスex'),
  rarity='☆',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-35/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ギャラドスex',public.normalize_card_name('ギャラドスex'),'35','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-35/large','Scrydex public card image (pcg1_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/082 フリーザーex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='フリーザーex',
  name_normalized=public.normalize_card_name('フリーザーex'),
  rarity='☆',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-36/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フリーザーex',public.normalize_card_name('フリーザーex'),'36','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-36/large','Scrydex public card image (pcg1_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/082 ピカチュウ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ピカチュウ',
  name_normalized=public.normalize_card_name('ピカチュウ'),
  rarity='●',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-37/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピカチュウ',public.normalize_card_name('ピカチュウ'),'37','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-37/large','Scrydex public card image (pcg1_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/082 ライチュウ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ライチュウ',
  name_normalized=public.normalize_card_name('ライチュウ'),
  rarity='★',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-38/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ライチュウ',public.normalize_card_name('ライチュウ'),'38','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-38/large','Scrydex public card image (pcg1_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/082 コイル
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='コイル',
  name_normalized=public.normalize_card_name('コイル'),
  rarity='◆',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-39/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コイル',public.normalize_card_name('コイル'),'39','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-39/large','Scrydex public card image (pcg1_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/082 レアコイル
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='レアコイル',
  name_normalized=public.normalize_card_name('レアコイル'),
  rarity='★',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-40/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レアコイル',public.normalize_card_name('レアコイル'),'40','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-40/large','Scrydex public card image (pcg1_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/082 ビリリダマ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ビリリダマ',
  name_normalized=public.normalize_card_name('ビリリダマ'),
  rarity='●',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-41/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビリリダマ',public.normalize_card_name('ビリリダマ'),'41','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-41/large','Scrydex public card image (pcg1_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/082 マルマインex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='マルマインex',
  name_normalized=public.normalize_card_name('マルマインex'),
  rarity='☆',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-42/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マルマインex',public.normalize_card_name('マルマインex'),'42','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-42/large','Scrydex public card image (pcg1_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/082 サンダーex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='サンダーex',
  name_normalized=public.normalize_card_name('サンダーex'),
  rarity='☆',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-43/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンダーex',public.normalize_card_name('サンダーex'),'43','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-43/large','Scrydex public card image (pcg1_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/082 ヤドン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ヤドン',
  name_normalized=public.normalize_card_name('ヤドン'),
  rarity='●',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-44/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドン',public.normalize_card_name('ヤドン'),'44','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-44/large','Scrydex public card image (pcg1_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/082 ヤドラン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ヤドラン',
  name_normalized=public.normalize_card_name('ヤドラン'),
  rarity='★',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-45/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドラン',public.normalize_card_name('ヤドラン'),'45','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-45/large','Scrydex public card image (pcg1_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/082 ゴース
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ゴース',
  name_normalized=public.normalize_card_name('ゴース'),
  rarity='●',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-46/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴース',public.normalize_card_name('ゴース'),'46','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-46/large','Scrydex public card image (pcg1_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/082 ゴースト
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ゴースト',
  name_normalized=public.normalize_card_name('ゴースト'),
  rarity='★',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-47/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴースト',public.normalize_card_name('ゴースト'),'47','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-47/large','Scrydex public card image (pcg1_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/082 ゲンガーex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ゲンガーex',
  name_normalized=public.normalize_card_name('ゲンガーex'),
  rarity='☆',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-48/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゲンガーex',public.normalize_card_name('ゲンガーex'),'48','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-48/large','Scrydex public card image (pcg1_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/082 スリープ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='スリープ',
  name_normalized=public.normalize_card_name('スリープ'),
  rarity='◆',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-49/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スリープ',public.normalize_card_name('スリープ'),'49','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-49/large','Scrydex public card image (pcg1_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/082 スリーパー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='スリーパー',
  name_normalized=public.normalize_card_name('スリーパー'),
  rarity='★',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-50/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スリーパー',public.normalize_card_name('スリーパー'),'50','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-50/large','Scrydex public card image (pcg1_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/082 タマタマ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='タマタマ',
  name_normalized=public.normalize_card_name('タマタマ'),
  rarity='◆',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-51/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タマタマ',public.normalize_card_name('タマタマ'),'51','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-51/large','Scrydex public card image (pcg1_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/082 ナッシー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ナッシー',
  name_normalized=public.normalize_card_name('ナッシー'),
  rarity='★',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-52/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナッシー',public.normalize_card_name('ナッシー'),'52','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-52/large','Scrydex public card image (pcg1_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/082 バリヤードex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='バリヤードex',
  name_normalized=public.normalize_card_name('バリヤードex'),
  rarity='☆',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-53/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バリヤードex',public.normalize_card_name('バリヤードex'),'53','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-53/large','Scrydex public card image (pcg1_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/082 バリヤードex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='バリヤードex',
  name_normalized=public.normalize_card_name('バリヤードex'),
  rarity='☆',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-54/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バリヤードex',public.normalize_card_name('バリヤードex'),'54','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-54/large','Scrydex public card image (pcg1_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/082 ニドクイン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニドクイン',
  name_normalized=public.normalize_card_name('ニドクイン'),
  rarity='★',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-55/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドクイン',public.normalize_card_name('ニドクイン'),'55','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-55/large','Scrydex public card image (pcg1_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/082 ニドキング
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニドキング',
  name_normalized=public.normalize_card_name('ニドキング'),
  rarity='★',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-56/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドキング',public.normalize_card_name('ニドキング'),'56','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-56/large','Scrydex public card image (pcg1_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/082 ディグダ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ディグダ',
  name_normalized=public.normalize_card_name('ディグダ'),
  rarity='●',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-57/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ディグダ',public.normalize_card_name('ディグダ'),'57','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-57/large','Scrydex public card image (pcg1_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/082 ダグトリオ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ダグトリオ',
  name_normalized=public.normalize_card_name('ダグトリオ'),
  rarity='★',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-58/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダグトリオ',public.normalize_card_name('ダグトリオ'),'58','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-58/large','Scrydex public card image (pcg1_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/082 マンキー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='マンキー',
  name_normalized=public.normalize_card_name('マンキー'),
  rarity='◆',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-59/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マンキー',public.normalize_card_name('マンキー'),'59','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-59/large','Scrydex public card image (pcg1_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/082 オコリザル
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='オコリザル',
  name_normalized=public.normalize_card_name('オコリザル'),
  rarity='★',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-60/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オコリザル',public.normalize_card_name('オコリザル'),'60','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-60/large','Scrydex public card image (pcg1_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/082 イワーク
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='イワーク',
  name_normalized=public.normalize_card_name('イワーク'),
  rarity='◆',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-61/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イワーク',public.normalize_card_name('イワーク'),'61','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-61/large','Scrydex public card image (pcg1_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/082 カラカラ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='カラカラ',
  name_normalized=public.normalize_card_name('カラカラ'),
  rarity='●',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-62/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カラカラ',public.normalize_card_name('カラカラ'),'62','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-62/large','Scrydex public card image (pcg1_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/082 ガラガラ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ガラガラ',
  name_normalized=public.normalize_card_name('ガラガラ'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-63/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ガラガラ',public.normalize_card_name('ガラガラ'),'63','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-63/large','Scrydex public card image (pcg1_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/082 ピジョット
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ピジョット',
  name_normalized=public.normalize_card_name('ピジョット'),
  rarity='★',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-64/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピジョット',public.normalize_card_name('ピジョット'),'64','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-64/large','Scrydex public card image (pcg1_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/082 ピッピ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ピッピ',
  name_normalized=public.normalize_card_name('ピッピ'),
  rarity='●',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-65/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピッピ',public.normalize_card_name('ピッピ'),'65','●','normal','https://images.scrydex.com/pokemon/pcg1_ja-65/large','Scrydex public card image (pcg1_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/082 ピクシーex
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ピクシーex',
  name_normalized=public.normalize_card_name('ピクシーex'),
  rarity='☆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-66/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピクシーex',public.normalize_card_name('ピクシーex'),'66','☆','normal','https://images.scrydex.com/pokemon/pcg1_ja-66/large','Scrydex public card image (pcg1_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/082 カモネギ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='カモネギ',
  name_normalized=public.normalize_card_name('カモネギ'),
  rarity='★',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-67/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カモネギ',public.normalize_card_name('カモネギ'),'67','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-67/large','Scrydex public card image (pcg1_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/082 ベロリンガ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ベロリンガ',
  name_normalized=public.normalize_card_name('ベロリンガ'),
  rarity='★',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-68/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ベロリンガ',public.normalize_card_name('ベロリンガ'),'68','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-68/large','Scrydex public card image (pcg1_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/082 ラッキー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ラッキー',
  name_normalized=public.normalize_card_name('ラッキー'),
  rarity='★',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-69/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラッキー',public.normalize_card_name('ラッキー'),'69','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-69/large','Scrydex public card image (pcg1_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/082 ガルーラ
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ガルーラ',
  name_normalized=public.normalize_card_name('ガルーラ'),
  rarity='★',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-70/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ガルーラ',public.normalize_card_name('ガルーラ'),'70','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-70/large','Scrydex public card image (pcg1_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/082 ケンタロス
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ケンタロス',
  name_normalized=public.normalize_card_name('ケンタロス'),
  rarity='★',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-71/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ケンタロス',public.normalize_card_name('ケンタロス'),'71','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-71/large','Scrydex public card image (pcg1_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/082 メタモン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='メタモン',
  name_normalized=public.normalize_card_name('メタモン'),
  rarity='★',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-72/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メタモン',public.normalize_card_name('メタモン'),'72','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-72/large','Scrydex public card image (pcg1_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/082 ポリゴン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ポリゴン',
  name_normalized=public.normalize_card_name('ポリゴン'),
  rarity='◆',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-73/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポリゴン',public.normalize_card_name('ポリゴン'),'73','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-73/large','Scrydex public card image (pcg1_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/082 カビゴン
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='カビゴン',
  name_normalized=public.normalize_card_name('カビゴン'),
  rarity='★',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-74/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カビゴン',public.normalize_card_name('カビゴン'),'74','★','normal','https://images.scrydex.com/pokemon/pcg1_ja-74/large','Scrydex public card image (pcg1_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/082 スーパーボール
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='スーパーボール',
  name_normalized=public.normalize_card_name('スーパーボール'),
  rarity='◆',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-75/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スーパーボール',public.normalize_card_name('スーパーボール'),'75','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-75/large','Scrydex public card image (pcg1_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/082 バトルサーチャー
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='バトルサーチャー',
  name_normalized=public.normalize_card_name('バトルサーチャー'),
  rarity='◆',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-76/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バトルサーチャー',public.normalize_card_name('バトルサーチャー'),'76','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-76/large','Scrydex public card image (pcg1_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/082 ポケモン図鑑HANDY909
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ポケモン図鑑HANDY909',
  name_normalized=public.normalize_card_name('ポケモン図鑑HANDY909'),
  rarity='◆',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-77/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポケモン図鑑HANDY909',public.normalize_card_name('ポケモン図鑑HANDY909'),'77','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-77/large','Scrydex public card image (pcg1_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/082 オーキドはかせの研究
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='オーキドはかせの研究',
  name_normalized=public.normalize_card_name('オーキドはかせの研究'),
  rarity='◆',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-78/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オーキドはかせの研究',public.normalize_card_name('オーキドはかせの研究'),'78','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-78/large','Scrydex public card image (pcg1_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/082 ニシキのネットワーク
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='ニシキのネットワーク',
  name_normalized=public.normalize_card_name('ニシキのネットワーク'),
  rarity='◆',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-79/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニシキのネットワーク',public.normalize_card_name('ニシキのネットワーク'),'79','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-79/large','Scrydex public card image (pcg1_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/082 マサキのメンテナンス
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='マサキのメンテナンス',
  name_normalized=public.normalize_card_name('マサキのメンテナンス'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-80/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マサキのメンテナンス',public.normalize_card_name('マサキのメンテナンス'),'80','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-80/large','Scrydex public card image (pcg1_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/082 学習装置
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='学習装置',
  name_normalized=public.normalize_card_name('学習装置'),
  rarity='◆',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-81/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'学習装置',public.normalize_card_name('学習装置'),'81','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-81/large','Scrydex public card image (pcg1_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/082 おつきみ山
with st as (select id from public.card_sets where code='PCG1' limit 1)
update public.cards c set
  name='おつきみ山',
  name_normalized=public.normalize_card_name('おつきみ山'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcg1_ja-82/large',
  image_source_note='Scrydex public card image (pcg1_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='PCG1' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'おつきみ山',public.normalize_card_name('おつきみ山'),'82','◆','normal','https://images.scrydex.com/pokemon/pcg1_ja-82/large','Scrydex public card image (pcg1_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

commit;

-- ============================================================
-- PCG1 監査
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
where cs.code = 'PCG1'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG1' as code,
  82 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG1'
having count(distinct c.set_order) <> 82;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG1'
group by c.set_order
having count(*) > 1
order by c.set_order;
