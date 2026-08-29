-- PCG9 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG9 拡張パック さいはての攻防 (68 cards)
update public.card_sets
set name='拡張パック さいはての攻防',
    release_date='2006-06-29'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG9%20Offense%20Defense%20Furthest%20Ends%20pack.jpg'
where code='PCG9';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック さいはての攻防', 'PCG9', '2006-06-29'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG9%20Offense%20Defense%20Furthest%20Ends%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG9');

-- 001/068 カビゴンδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='カビゴンδ-デルタ種',
  name_normalized=public.normalize_card_name('カビゴンδ-デルタ種'),
  rarity='★',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-1/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カビゴンδ-デルタ種',public.normalize_card_name('カビゴンδ-デルタ種'),'1','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-1/large','Scrydex public card image (pcg9_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/068 ミニリュウδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ミニリュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ミニリュウδ-デルタ種'),
  rarity='●',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-2/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミニリュウδ-デルタ種',public.normalize_card_name('ミニリュウδ-デルタ種'),'2','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-2/large','Scrydex public card image (pcg9_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/068 ハクリューδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ハクリューδ-デルタ種',
  name_normalized=public.normalize_card_name('ハクリューδ-デルタ種'),
  rarity='◆',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-3/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハクリューδ-デルタ種',public.normalize_card_name('ハクリューδ-デルタ種'),'3','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-3/large','Scrydex public card image (pcg9_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/068 カイリューexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='カイリューexδ-デルタ種',
  name_normalized=public.normalize_card_name('カイリューexδ-デルタ種'),
  rarity='☆',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-4/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイリューexδ-デルタ種',public.normalize_card_name('カイリューexδ-デルタ種'),'4','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-4/large','Scrydex public card image (pcg9_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/068 ウパーδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ウパーδ-デルタ種',
  name_normalized=public.normalize_card_name('ウパーδ-デルタ種'),
  rarity='●',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-5/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウパーδ-デルタ種',public.normalize_card_name('ウパーδ-デルタ種'),'5','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-5/large','Scrydex public card image (pcg9_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/068 ヌオーδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ヌオーδ-デルタ種',
  name_normalized=public.normalize_card_name('ヌオーδ-デルタ種'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-6/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヌオーδ-デルタ種',public.normalize_card_name('ヌオーδ-デルタ種'),'6','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-6/large','Scrydex public card image (pcg9_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/068 アーボδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='アーボδ-デルタ種',
  name_normalized=public.normalize_card_name('アーボδ-デルタ種'),
  rarity='●',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-7/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーボδ-デルタ種',public.normalize_card_name('アーボδ-デルタ種'),'7','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-7/large','Scrydex public card image (pcg9_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/068 アーボックδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='アーボックδ-デルタ種',
  name_normalized=public.normalize_card_name('アーボックδ-デルタ種'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-8/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーボックδ-デルタ種',public.normalize_card_name('アーボックδ-デルタ種'),'8','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-8/large','Scrydex public card image (pcg9_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/068 ヘラクロスδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ヘラクロスδ-デルタ種',
  name_normalized=public.normalize_card_name('ヘラクロスδ-デルタ種'),
  rarity='★',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-9/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヘラクロスδ-デルタ種',public.normalize_card_name('ヘラクロスδ-デルタ種'),'9','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-9/large','Scrydex public card image (pcg9_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/068 スバメδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='スバメδ-デルタ種',
  name_normalized=public.normalize_card_name('スバメδ-デルタ種'),
  rarity='●',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-10/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スバメδ-デルタ種',public.normalize_card_name('スバメδ-デルタ種'),'10','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-10/large','Scrydex public card image (pcg9_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/068 オオスバメδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='オオスバメδ-デルタ種',
  name_normalized=public.normalize_card_name('オオスバメδ-デルタ種'),
  rarity='★',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-11/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オオスバメδ-デルタ種',public.normalize_card_name('オオスバメδ-デルタ種'),'11','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-11/large','Scrydex public card image (pcg9_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/068 ヒンバスδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ヒンバスδ-デルタ種',
  name_normalized=public.normalize_card_name('ヒンバスδ-デルタ種'),
  rarity='◆',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-12/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒンバスδ-デルタ種',public.normalize_card_name('ヒンバスδ-デルタ種'),'12','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-12/large','Scrydex public card image (pcg9_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/068 ミロカロスδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ミロカロスδ-デルタ種',
  name_normalized=public.normalize_card_name('ミロカロスδ-デルタ種'),
  rarity='★',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-13/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミロカロスδ-デルタ種',public.normalize_card_name('ミロカロスδ-デルタ種'),'13','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-13/large','Scrydex public card image (pcg9_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/068 ラティアスexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ラティアスexδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティアスexδ-デルタ種'),
  rarity='☆',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-14/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティアスexδ-デルタ種',public.normalize_card_name('ラティアスexδ-デルタ種'),'14','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-14/large','Scrydex public card image (pcg9_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/068 ミュウ☆δ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ミュウ☆δ-デルタ種',
  name_normalized=public.normalize_card_name('ミュウ☆δ-デルタ種'),
  rarity='★',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-15/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミュウ☆δ-デルタ種',public.normalize_card_name('ミュウ☆δ-デルタ種'),'15','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-15/large','Scrydex public card image (pcg9_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/068 トゲピーδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='トゲピーδ-デルタ種',
  name_normalized=public.normalize_card_name('トゲピーδ-デルタ種'),
  rarity='◆',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-16/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トゲピーδ-デルタ種',public.normalize_card_name('トゲピーδ-デルタ種'),'16','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-16/large','Scrydex public card image (pcg9_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/068 トゲチックδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='トゲチックδ-デルタ種',
  name_normalized=public.normalize_card_name('トゲチックδ-デルタ種'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-17/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トゲチックδ-デルタ種',public.normalize_card_name('トゲチックδ-デルタ種'),'17','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-17/large','Scrydex public card image (pcg9_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/068 チルットδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='チルットδ-デルタ種',
  name_normalized=public.normalize_card_name('チルットδ-デルタ種'),
  rarity='●',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-18/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルットδ-デルタ種',public.normalize_card_name('チルットδ-デルタ種'),'18','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-18/large','Scrydex public card image (pcg9_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/068 チルタリスexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='チルタリスexδ-デルタ種',
  name_normalized=public.normalize_card_name('チルタリスexδ-デルタ種'),
  rarity='☆',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-19/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チルタリスexδ-デルタ種',public.normalize_card_name('チルタリスexδ-デルタ種'),'19','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-19/large','Scrydex public card image (pcg9_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/068 タツベイδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='タツベイδ-デルタ種',
  name_normalized=public.normalize_card_name('タツベイδ-デルタ種'),
  rarity='●',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-20/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タツベイδ-デルタ種',public.normalize_card_name('タツベイδ-デルタ種'),'20','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-20/large','Scrydex public card image (pcg9_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/068 コモルーδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='コモルーδ-デルタ種',
  name_normalized=public.normalize_card_name('コモルーδ-デルタ種'),
  rarity='◆',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-21/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コモルーδ-デルタ種',public.normalize_card_name('コモルーδ-デルタ種'),'21','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-21/large','Scrydex public card image (pcg9_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/068 ボーマンダexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ボーマンダexδ-デルタ種',
  name_normalized=public.normalize_card_name('ボーマンダexδ-デルタ種'),
  rarity='☆',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-22/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボーマンダexδ-デルタ種',public.normalize_card_name('ボーマンダexδ-デルタ種'),'22','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-22/large','Scrydex public card image (pcg9_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/068 ラティオスexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ラティオスexδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティオスexδ-デルタ種'),
  rarity='☆',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-23/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティオスexδ-デルタ種',public.normalize_card_name('ラティオスexδ-デルタ種'),'23','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-23/large','Scrydex public card image (pcg9_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/068 ワニノコδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ワニノコδ-デルタ種',
  name_normalized=public.normalize_card_name('ワニノコδ-デルタ種'),
  rarity='●',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-24/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワニノコδ-デルタ種',public.normalize_card_name('ワニノコδ-デルタ種'),'24','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-24/large','Scrydex public card image (pcg9_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/068 アリゲイツδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='アリゲイツδ-デルタ種',
  name_normalized=public.normalize_card_name('アリゲイツδ-デルタ種'),
  rarity='◆',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-25/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アリゲイツδ-デルタ種',public.normalize_card_name('アリゲイツδ-デルタ種'),'25','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-25/large','Scrydex public card image (pcg9_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/068 オーダイルδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='オーダイルδ-デルタ種',
  name_normalized=public.normalize_card_name('オーダイルδ-デルタ種'),
  rarity='★',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-26/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オーダイルδ-デルタ種',public.normalize_card_name('オーダイルδ-デルタ種'),'26','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-26/large','Scrydex public card image (pcg9_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/068 マンタインδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='マンタインδ-デルタ種',
  name_normalized=public.normalize_card_name('マンタインδ-デルタ種'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-27/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マンタインδ-デルタ種',public.normalize_card_name('マンタインδ-デルタ種'),'27','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-27/large','Scrydex public card image (pcg9_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/068 レックウザexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='レックウザexδ-デルタ種',
  name_normalized=public.normalize_card_name('レックウザexδ-デルタ種'),
  rarity='☆',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-28/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レックウザexδ-デルタ種',public.normalize_card_name('レックウザexδ-デルタ種'),'28','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-28/large','Scrydex public card image (pcg9_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/068 ロコンδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ロコンδ-デルタ種',
  name_normalized=public.normalize_card_name('ロコンδ-デルタ種'),
  rarity='◆',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-29/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロコンδ-デルタ種',public.normalize_card_name('ロコンδ-デルタ種'),'29','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-29/large','Scrydex public card image (pcg9_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/068 キュウコンδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='キュウコンδ-デルタ種',
  name_normalized=public.normalize_card_name('キュウコンδ-デルタ種'),
  rarity='★',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-30/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キュウコンδ-デルタ種',public.normalize_card_name('キュウコンδ-デルタ種'),'30','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-30/large','Scrydex public card image (pcg9_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/068 ベロリンガδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ベロリンガδ-デルタ種',
  name_normalized=public.normalize_card_name('ベロリンガδ-デルタ種'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-31/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ベロリンガδ-デルタ種',public.normalize_card_name('ベロリンガδ-デルタ種'),'31','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-31/large','Scrydex public card image (pcg9_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/068 ヒノアラシδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ヒノアラシδ-デルタ種',
  name_normalized=public.normalize_card_name('ヒノアラシδ-デルタ種'),
  rarity='●',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-32/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヒノアラシδ-デルタ種',public.normalize_card_name('ヒノアラシδ-デルタ種'),'32','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-32/large','Scrydex public card image (pcg9_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/068 マグマラシδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='マグマラシδ-デルタ種',
  name_normalized=public.normalize_card_name('マグマラシδ-デルタ種'),
  rarity='◆',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-33/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マグマラシδ-デルタ種',public.normalize_card_name('マグマラシδ-デルタ種'),'33','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-33/large','Scrydex public card image (pcg9_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/068 バクフーンδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='バクフーンδ-デルタ種',
  name_normalized=public.normalize_card_name('バクフーンδ-デルタ種'),
  rarity='★',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-34/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'バクフーンδ-デルタ種',public.normalize_card_name('バクフーンδ-デルタ種'),'34','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-34/large','Scrydex public card image (pcg9_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/068 ナックラーδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ナックラーδ-デルタ種',
  name_normalized=public.normalize_card_name('ナックラーδ-デルタ種'),
  rarity='●',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-35/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナックラーδ-デルタ種',public.normalize_card_name('ナックラーδ-デルタ種'),'35','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-35/large','Scrydex public card image (pcg9_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/068 ビブラーバδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ビブラーバδ-デルタ種',
  name_normalized=public.normalize_card_name('ビブラーバδ-デルタ種'),
  rarity='★',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-36/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビブラーバδ-デルタ種',public.normalize_card_name('ビブラーバδ-デルタ種'),'36','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-36/large','Scrydex public card image (pcg9_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/068 フライゴンexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='フライゴンexδ-デルタ種',
  name_normalized=public.normalize_card_name('フライゴンexδ-デルタ種'),
  rarity='☆',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-37/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フライゴンexδ-デルタ種',public.normalize_card_name('フライゴンexδ-デルタ種'),'37','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-37/large','Scrydex public card image (pcg9_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/068 シェルダーδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='シェルダーδ-デルタ種',
  name_normalized=public.normalize_card_name('シェルダーδ-デルタ種'),
  rarity='●',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-38/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シェルダーδ-デルタ種',public.normalize_card_name('シェルダーδ-デルタ種'),'38','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-38/large','Scrydex public card image (pcg9_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/068 パルシェンδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='パルシェンδ-デルタ種',
  name_normalized=public.normalize_card_name('パルシェンδ-デルタ種'),
  rarity='★',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-39/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パルシェンδ-デルタ種',public.normalize_card_name('パルシェンδ-デルタ種'),'39','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-39/large','Scrydex public card image (pcg9_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/068 タッツーδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='タッツーδ-デルタ種',
  name_normalized=public.normalize_card_name('タッツーδ-デルタ種'),
  rarity='◆',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-40/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タッツーδ-デルタ種',public.normalize_card_name('タッツーδ-デルタ種'),'40','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-40/large','Scrydex public card image (pcg9_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/068 シードラδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='シードラδ-デルタ種',
  name_normalized=public.normalize_card_name('シードラδ-デルタ種'),
  rarity='★',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-41/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シードラδ-デルタ種',public.normalize_card_name('シードラδ-デルタ種'),'41','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-41/large','Scrydex public card image (pcg9_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/068 カイロスδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='カイロスδ-デルタ種',
  name_normalized=public.normalize_card_name('カイロスδ-デルタ種'),
  rarity='★',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-42/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カイロスδ-デルタ種',public.normalize_card_name('カイロスδ-デルタ種'),'42','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-42/large','Scrydex public card image (pcg9_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/068 チコリータδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='チコリータδ-デルタ種',
  name_normalized=public.normalize_card_name('チコリータδ-デルタ種'),
  rarity='●',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-43/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チコリータδ-デルタ種',public.normalize_card_name('チコリータδ-デルタ種'),'43','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-43/large','Scrydex public card image (pcg9_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/068 ベイリーフδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ベイリーフδ-デルタ種',
  name_normalized=public.normalize_card_name('ベイリーフδ-デルタ種'),
  rarity='◆',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-44/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ベイリーフδ-デルタ種',public.normalize_card_name('ベイリーフδ-デルタ種'),'44','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-44/large','Scrydex public card image (pcg9_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/068 メガニウムδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='メガニウムδ-デルタ種',
  name_normalized=public.normalize_card_name('メガニウムδ-デルタ種'),
  rarity='★',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-45/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メガニウムδ-デルタ種',public.normalize_card_name('メガニウムδ-デルタ種'),'45','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-45/large','Scrydex public card image (pcg9_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/068 キングドラexδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='キングドラexδ-デルタ種',
  name_normalized=public.normalize_card_name('キングドラexδ-デルタ種'),
  rarity='☆',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-46/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キングドラexδ-デルタ種',public.normalize_card_name('キングドラexδ-デルタ種'),'46','☆','normal','https://images.scrydex.com/pokemon/pcg9_ja-46/large','Scrydex public card image (pcg9_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/068 パウワウδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='パウワウδ-デルタ種',
  name_normalized=public.normalize_card_name('パウワウδ-デルタ種'),
  rarity='●',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-47/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'パウワウδ-デルタ種',public.normalize_card_name('パウワウδ-デルタ種'),'47','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-47/large','Scrydex public card image (pcg9_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/068 ジュゴンδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ジュゴンδ-デルタ種',
  name_normalized=public.normalize_card_name('ジュゴンδ-デルタ種'),
  rarity='★',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-48/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ジュゴンδ-デルタ種',public.normalize_card_name('ジュゴンδ-デルタ種'),'48','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-48/large','Scrydex public card image (pcg9_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/068 メリープδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='メリープδ-デルタ種',
  name_normalized=public.normalize_card_name('メリープδ-デルタ種'),
  rarity='●',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-49/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メリープδ-デルタ種',public.normalize_card_name('メリープδ-デルタ種'),'49','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-49/large','Scrydex public card image (pcg9_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/068 モココδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='モココδ-デルタ種',
  name_normalized=public.normalize_card_name('モココδ-デルタ種'),
  rarity='◆',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-50/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'モココδ-デルタ種',public.normalize_card_name('モココδ-デルタ種'),'50','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-50/large','Scrydex public card image (pcg9_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/068 デンリュウδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='デンリュウδ-デルタ種',
  name_normalized=public.normalize_card_name('デンリュウδ-デルタ種'),
  rarity='★',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-51/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デンリュウδ-デルタ種',public.normalize_card_name('デンリュウδ-デルタ種'),'51','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-51/large','Scrydex public card image (pcg9_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/068 リザードン☆δ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='リザードン☆δ-デルタ種',
  name_normalized=public.normalize_card_name('リザードン☆δ-デルタ種'),
  rarity='★',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-52/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リザードン☆δ-デルタ種',public.normalize_card_name('リザードン☆δ-デルタ種'),'52','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-52/large','Scrydex public card image (pcg9_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/068 ニドラン♂δ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ニドラン♂δ-デルタ種',
  name_normalized=public.normalize_card_name('ニドラン♂δ-デルタ種'),
  rarity='●',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-53/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドラン♂δ-デルタ種',public.normalize_card_name('ニドラン♂δ-デルタ種'),'53','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-53/large','Scrydex public card image (pcg9_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/068 ニドリーノδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ニドリーノδ-デルタ種',
  name_normalized=public.normalize_card_name('ニドリーノδ-デルタ種'),
  rarity='◆',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-54/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドリーノδ-デルタ種',public.normalize_card_name('ニドリーノδ-デルタ種'),'54','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-54/large','Scrydex public card image (pcg9_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/068 ニドキングδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ニドキングδ-デルタ種',
  name_normalized=public.normalize_card_name('ニドキングδ-デルタ種'),
  rarity='★',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-55/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドキングδ-デルタ種',public.normalize_card_name('ニドキングδ-デルタ種'),'55','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-55/large','Scrydex public card image (pcg9_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/068 ネイティδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ネイティδ-デルタ種',
  name_normalized=public.normalize_card_name('ネイティδ-デルタ種'),
  rarity='●',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-56/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ネイティδ-デルタ種',public.normalize_card_name('ネイティδ-デルタ種'),'56','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-56/large','Scrydex public card image (pcg9_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/068 ネイティオδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ネイティオδ-デルタ種',
  name_normalized=public.normalize_card_name('ネイティオδ-デルタ種'),
  rarity='★',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-57/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ネイティオδ-デルタ種',public.normalize_card_name('ネイティオδ-デルタ種'),'57','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-57/large','Scrydex public card image (pcg9_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/068 ニドラン♀δ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ニドラン♀δ-デルタ種',
  name_normalized=public.normalize_card_name('ニドラン♀δ-デルタ種'),
  rarity='●',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-58/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドラン♀δ-デルタ種',public.normalize_card_name('ニドラン♀δ-デルタ種'),'58','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-58/large','Scrydex public card image (pcg9_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/068 ニドリーナδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ニドリーナδ-デルタ種',
  name_normalized=public.normalize_card_name('ニドリーナδ-デルタ種'),
  rarity='◆',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-59/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドリーナδ-デルタ種',public.normalize_card_name('ニドリーナδ-デルタ種'),'59','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-59/large','Scrydex public card image (pcg9_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/068 ニドクインδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ニドクインδ-デルタ種',
  name_normalized=public.normalize_card_name('ニドクインδ-デルタ種'),
  rarity='★',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-60/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニドクインδ-デルタ種',public.normalize_card_name('ニドクインδ-デルタ種'),'60','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-60/large','Scrydex public card image (pcg9_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/068 レディバδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='レディバδ-デルタ種',
  name_normalized=public.normalize_card_name('レディバδ-デルタ種'),
  rarity='●',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-61/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レディバδ-デルタ種',public.normalize_card_name('レディバδ-デルタ種'),'61','●','normal','https://images.scrydex.com/pokemon/pcg9_ja-61/large','Scrydex public card image (pcg9_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/068 レディアンδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='レディアンδ-デルタ種',
  name_normalized=public.normalize_card_name('レディアンδ-デルタ種'),
  rarity='★',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-62/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レディアンδ-デルタ種',public.normalize_card_name('レディアンδ-デルタ種'),'62','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-62/large','Scrydex public card image (pcg9_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/068 トロピウスδ-デルタ種
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='トロピウスδ-デルタ種',
  name_normalized=public.normalize_card_name('トロピウスδ-デルタ種'),
  rarity='★',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-63/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トロピウスδ-デルタ種',public.normalize_card_name('トロピウスδ-デルタ種'),'63','★','normal','https://images.scrydex.com/pokemon/pcg9_ja-63/large','Scrydex public card image (pcg9_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/068 ボロのつりざお
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ボロのつりざお',
  name_normalized=public.normalize_card_name('ボロのつりざお'),
  rarity='◆',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-64/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ボロのつりざお',public.normalize_card_name('ボロのつりざお'),'64','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-64/large','Scrydex public card image (pcg9_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/068 孤島の隠者
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='孤島の隠者',
  name_normalized=public.normalize_card_name('孤島の隠者'),
  rarity='◆',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-65/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'孤島の隠者',public.normalize_card_name('孤島の隠者'),'65','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-65/large','Scrydex public card image (pcg9_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/068 ちからのかけら
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ちからのかけら',
  name_normalized=public.normalize_card_name('ちからのかけら'),
  rarity='◆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-66/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ちからのかけら',public.normalize_card_name('ちからのかけら'),'66','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-66/large','Scrydex public card image (pcg9_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/068 ホロンの聖跡
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='ホロンの聖跡',
  name_normalized=public.normalize_card_name('ホロンの聖跡'),
  rarity='◆',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-67/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの聖跡',public.normalize_card_name('ホロンの聖跡'),'67','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-67/large','Scrydex public card image (pcg9_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/068 スクランブルエネルギー
with st as (select id from public.card_sets where code='PCG9' limit 1)
update public.cards c set
  name='スクランブルエネルギー',
  name_normalized=public.normalize_card_name('スクランブルエネルギー'),
  rarity='◆',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg9_ja-68/large',
  image_source_note='Scrydex public card image (pcg9_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG9' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スクランブルエネルギー',public.normalize_card_name('スクランブルエネルギー'),'68','◆','normal','https://images.scrydex.com/pokemon/pcg9_ja-68/large','Scrydex public card image (pcg9_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

commit;

-- ============================================================
-- PCG9 監査
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
where cs.code = 'PCG9'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG9' as code,
  68 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG9'
having count(distinct c.set_order) <> 68;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG9'
group by c.set_order
having count(*) > 1
order by c.set_order;
