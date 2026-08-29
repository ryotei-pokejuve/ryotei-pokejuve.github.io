-- PCG3 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG3 拡張パック ロケット団の逆襲 (85 cards)
update public.card_sets
set name='拡張パック ロケット団の逆襲',
    release_date='2004-10-15'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG3%20Rocket%20Gang%20Strikes%20Back%20pack.jpg'
where code='PCG3';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック ロケット団の逆襲', 'PCG3', '2004-10-15'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG3%20Rocket%20Gang%20Strikes%20Back%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG3');

-- 001/085 アーボ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='アーボ',
  name_normalized=public.normalize_card_name('アーボ'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-1/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーボ',public.normalize_card_name('アーボ'),'1','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-1/large','Scrydex public card image (pcg3_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/085 ズバット
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ズバット',
  name_normalized=public.normalize_card_name('ズバット'),
  rarity='●',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-2/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ズバット',public.normalize_card_name('ズバット'),'2','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-2/large','Scrydex public card image (pcg3_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/085 ベトベター
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ベトベター',
  name_normalized=public.normalize_card_name('ベトベター'),
  rarity='●',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-3/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ベトベター',public.normalize_card_name('ベトベター'),'3','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-3/large','Scrydex public card image (pcg3_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/085 ドガース
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ドガース',
  name_normalized=public.normalize_card_name('ドガース'),
  rarity='●',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-4/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ドガース',public.normalize_card_name('ドガース'),'4','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-4/large','Scrydex public card image (pcg3_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/085 レディバ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='レディバ',
  name_normalized=public.normalize_card_name('レディバ'),
  rarity='●',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-5/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レディバ',public.normalize_card_name('レディバ'),'5','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-5/large','Scrydex public card image (pcg3_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/085 レディアン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='レディアン',
  name_normalized=public.normalize_card_name('レディアン'),
  rarity='★',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-6/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レディアン',public.normalize_card_name('レディアン'),'6','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-6/large','Scrydex public card image (pcg3_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/085 ハネッコ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ハネッコ',
  name_normalized=public.normalize_card_name('ハネッコ'),
  rarity='●',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-7/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハネッコ',public.normalize_card_name('ハネッコ'),'7','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-7/large','Scrydex public card image (pcg3_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/085 ポポッコ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ポポッコ',
  name_normalized=public.normalize_card_name('ポポッコ'),
  rarity='◆',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-8/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポポッコ',public.normalize_card_name('ポポッコ'),'8','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-8/large','Scrydex public card image (pcg3_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/085 ワタッコ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ワタッコ',
  name_normalized=public.normalize_card_name('ワタッコ'),
  rarity='★',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-9/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ワタッコ',public.normalize_card_name('ワタッコ'),'9','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-9/large','Scrydex public card image (pcg3_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/085 ヤンヤンマ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ヤンヤンマ',
  name_normalized=public.normalize_card_name('ヤンヤンマ'),
  rarity='★',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-10/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤンヤンマ',public.normalize_card_name('ヤンヤンマ'),'10','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-10/large','Scrydex public card image (pcg3_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/085 キモリ☆
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='キモリ☆',
  name_normalized=public.normalize_card_name('キモリ☆'),
  rarity='★',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-11/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キモリ☆',public.normalize_card_name('キモリ☆'),'11','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-11/large','Scrydex public card image (pcg3_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/085 わるいアーボック
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいアーボック',
  name_normalized=public.normalize_card_name('わるいアーボック'),
  rarity='★',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-12/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいアーボック',public.normalize_card_name('わるいアーボック'),'12','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-12/large','Scrydex public card image (pcg3_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/085 わるいゴルバット
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいゴルバット',
  name_normalized=public.normalize_card_name('わるいゴルバット'),
  rarity='★',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-13/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいゴルバット',public.normalize_card_name('わるいゴルバット'),'13','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-13/large','Scrydex public card image (pcg3_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/085 わるいベトベトン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいベトベトン',
  name_normalized=public.normalize_card_name('わるいベトベトン'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-14/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいベトベトン',public.normalize_card_name('わるいベトベトン'),'14','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-14/large','Scrydex public card image (pcg3_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/085 わるいマタドガス
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいマタドガス',
  name_normalized=public.normalize_card_name('わるいマタドガス'),
  rarity='★',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-15/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいマタドガス',public.normalize_card_name('わるいマタドガス'),'15','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-15/large','Scrydex public card image (pcg3_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/085 わるいクロバット
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいクロバット',
  name_normalized=public.normalize_card_name('わるいクロバット'),
  rarity='★',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-16/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいクロバット',public.normalize_card_name('わるいクロバット'),'16','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-16/large','Scrydex public card image (pcg3_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/085 ブーバー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ブーバー',
  name_normalized=public.normalize_card_name('ブーバー'),
  rarity='★',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-17/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブーバー',public.normalize_card_name('ブーバー'),'17','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-17/large','Scrydex public card image (pcg3_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/085 デルビル
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='デルビル',
  name_normalized=public.normalize_card_name('デルビル'),
  rarity='●',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-18/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デルビル',public.normalize_card_name('デルビル'),'18','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-18/large','Scrydex public card image (pcg3_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/085 ブビィ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ブビィ',
  name_normalized=public.normalize_card_name('ブビィ'),
  rarity='★',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-19/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ブビィ',public.normalize_card_name('ブビィ'),'19','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-19/large','Scrydex public card image (pcg3_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/085 アチャモ☆
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='アチャモ☆',
  name_normalized=public.normalize_card_name('アチャモ☆'),
  rarity='★',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-20/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アチャモ☆',public.normalize_card_name('アチャモ☆'),'20','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-20/large','Scrydex public card image (pcg3_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/085 わるいヘルガー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいヘルガー',
  name_normalized=public.normalize_card_name('わるいヘルガー'),
  rarity='★',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-21/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいヘルガー',public.normalize_card_name('わるいヘルガー'),'21','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-21/large','Scrydex public card image (pcg3_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/085 タッツー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='タッツー',
  name_normalized=public.normalize_card_name('タッツー'),
  rarity='●',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-22/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タッツー',public.normalize_card_name('タッツー'),'22','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-22/large','Scrydex public card image (pcg3_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/085 シードラ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='シードラ',
  name_normalized=public.normalize_card_name('シードラ'),
  rarity='◆',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-23/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シードラ',public.normalize_card_name('シードラ'),'23','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-23/large','Scrydex public card image (pcg3_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/085 マリル
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='マリル',
  name_normalized=public.normalize_card_name('マリル'),
  rarity='●',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-24/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マリル',public.normalize_card_name('マリル'),'24','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-24/large','Scrydex public card image (pcg3_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/085 マリルリ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='マリルリ',
  name_normalized=public.normalize_card_name('マリルリ'),
  rarity='★',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-25/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マリルリ',public.normalize_card_name('マリルリ'),'25','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-25/large','Scrydex public card image (pcg3_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/085 ウパー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ウパー',
  name_normalized=public.normalize_card_name('ウパー'),
  rarity='●',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-26/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウパー',public.normalize_card_name('ウパー'),'26','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-26/large','Scrydex public card image (pcg3_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/085 ヌオー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ヌオー',
  name_normalized=public.normalize_card_name('ヌオー'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-27/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヌオー',public.normalize_card_name('ヌオー'),'27','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-27/large','Scrydex public card image (pcg3_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/085 ハリーセン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ハリーセン',
  name_normalized=public.normalize_card_name('ハリーセン'),
  rarity='★',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-28/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ハリーセン',public.normalize_card_name('ハリーセン'),'28','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-28/large','Scrydex public card image (pcg3_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/085 テッポウオ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='テッポウオ',
  name_normalized=public.normalize_card_name('テッポウオ'),
  rarity='●',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-29/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'テッポウオ',public.normalize_card_name('テッポウオ'),'29','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-29/large','Scrydex public card image (pcg3_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/085 デリバード
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='デリバード',
  name_normalized=public.normalize_card_name('デリバード'),
  rarity='★',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-30/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デリバード',public.normalize_card_name('デリバード'),'30','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-30/large','Scrydex public card image (pcg3_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/085 マンタイン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='マンタイン',
  name_normalized=public.normalize_card_name('マンタイン'),
  rarity='★',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-31/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マンタイン',public.normalize_card_name('マンタイン'),'31','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-31/large','Scrydex public card image (pcg3_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/085 キングドラ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='キングドラ',
  name_normalized=public.normalize_card_name('キングドラ'),
  rarity='★',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-32/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キングドラ',public.normalize_card_name('キングドラ'),'32','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-32/large','Scrydex public card image (pcg3_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/085 ミズゴロウ☆
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ミズゴロウ☆',
  name_normalized=public.normalize_card_name('ミズゴロウ☆'),
  rarity='★',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-33/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ミズゴロウ☆',public.normalize_card_name('ミズゴロウ☆'),'33','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-33/large','Scrydex public card image (pcg3_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/085 わるいオクタン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいオクタン',
  name_normalized=public.normalize_card_name('わるいオクタン'),
  rarity='★',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-34/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいオクタン',public.normalize_card_name('わるいオクタン'),'34','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-34/large','Scrydex public card image (pcg3_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/085 ビリリダマ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ビリリダマ',
  name_normalized=public.normalize_card_name('ビリリダマ'),
  rarity='●',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-35/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビリリダマ',public.normalize_card_name('ビリリダマ'),'35','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-35/large','Scrydex public card image (pcg3_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/085 メリープ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='メリープ',
  name_normalized=public.normalize_card_name('メリープ'),
  rarity='●',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-36/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'メリープ',public.normalize_card_name('メリープ'),'36','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-36/large','Scrydex public card image (pcg3_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/085 わるいマルマイン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいマルマイン',
  name_normalized=public.normalize_card_name('わるいマルマイン'),
  rarity='★',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-37/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいマルマイン',public.normalize_card_name('わるいマルマイン'),'37','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-37/large','Scrydex public card image (pcg3_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/085 わるいモココ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいモココ',
  name_normalized=public.normalize_card_name('わるいモココ'),
  rarity='★',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-38/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいモココ',public.normalize_card_name('わるいモココ'),'38','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-38/large','Scrydex public card image (pcg3_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/085 わるいデンリュウ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいデンリュウ',
  name_normalized=public.normalize_card_name('わるいデンリュウ'),
  rarity='★',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-39/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいデンリュウ',public.normalize_card_name('わるいデンリュウ'),'39','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-39/large','Scrydex public card image (pcg3_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/085 ヤドン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ヤドン',
  name_normalized=public.normalize_card_name('ヤドン'),
  rarity='●',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-40/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヤドン',public.normalize_card_name('ヤドン'),'40','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-40/large','Scrydex public card image (pcg3_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/085 スリープ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='スリープ',
  name_normalized=public.normalize_card_name('スリープ'),
  rarity='●',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-41/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'スリープ',public.normalize_card_name('スリープ'),'41','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-41/large','Scrydex public card image (pcg3_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/085 ムウマ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ムウマ',
  name_normalized=public.normalize_card_name('ムウマ'),
  rarity='★',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-42/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ムウマ',public.normalize_card_name('ムウマ'),'42','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-42/large','Scrydex public card image (pcg3_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/085 わるいスリーパー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいスリーパー',
  name_normalized=public.normalize_card_name('わるいスリーパー'),
  rarity='★',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-43/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいスリーパー',public.normalize_card_name('わるいスリーパー'),'43','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-43/large','Scrydex public card image (pcg3_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/085 わるいヤドキング
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいヤドキング',
  name_normalized=public.normalize_card_name('わるいヤドキング'),
  rarity='★',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-44/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいヤドキング',public.normalize_card_name('わるいヤドキング'),'44','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-44/large','Scrydex public card image (pcg3_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/085 サンド
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='サンド',
  name_normalized=public.normalize_card_name('サンド'),
  rarity='●',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-45/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サンド',public.normalize_card_name('サンド'),'45','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-45/large','Scrydex public card image (pcg3_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/085 イワーク
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='イワーク',
  name_normalized=public.normalize_card_name('イワーク'),
  rarity='◆',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-46/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イワーク',public.normalize_card_name('イワーク'),'46','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-46/large','Scrydex public card image (pcg3_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/085 カラカラ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='カラカラ',
  name_normalized=public.normalize_card_name('カラカラ'),
  rarity='●',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-47/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カラカラ',public.normalize_card_name('カラカラ'),'47','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-47/large','Scrydex public card image (pcg3_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/085 ヘラクロス
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ヘラクロス',
  name_normalized=public.normalize_card_name('ヘラクロス'),
  rarity='★',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-48/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ヘラクロス',public.normalize_card_name('ヘラクロス'),'48','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-48/large','Scrydex public card image (pcg3_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/085 ウリムー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ウリムー',
  name_normalized=public.normalize_card_name('ウリムー'),
  rarity='●',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-49/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ウリムー',public.normalize_card_name('ウリムー'),'49','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-49/large','Scrydex public card image (pcg3_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/085 イノムー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='イノムー',
  name_normalized=public.normalize_card_name('イノムー'),
  rarity='★',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-50/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'イノムー',public.normalize_card_name('イノムー'),'50','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-50/large','Scrydex public card image (pcg3_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/085 わるいサンドパン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいサンドパン',
  name_normalized=public.normalize_card_name('わるいサンドパン'),
  rarity='★',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-51/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいサンドパン',public.normalize_card_name('わるいサンドパン'),'51','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-51/large','Scrydex public card image (pcg3_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/085 わるいガラガラ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいガラガラ',
  name_normalized=public.normalize_card_name('わるいガラガラ'),
  rarity='★',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-52/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいガラガラ',public.normalize_card_name('わるいガラガラ'),'52','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-52/large','Scrydex public card image (pcg3_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

-- 053/085 コラッタ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='コラッタ',
  name_normalized=public.normalize_card_name('コラッタ'),
  rarity='●',
  set_order=53,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-53/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コラッタ',public.normalize_card_name('コラッタ'),'53','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-53/large','Scrydex public card image (pcg3_ja)',true,53,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '53'
);

-- 054/085 オタチ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='オタチ',
  name_normalized=public.normalize_card_name('オタチ'),
  rarity='●',
  set_order=54,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-54/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オタチ',public.normalize_card_name('オタチ'),'54','●','normal','https://images.scrydex.com/pokemon/pcg3_ja-54/large','Scrydex public card image (pcg3_ja)',true,54,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '54'
);

-- 055/085 オオタチ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='オオタチ',
  name_normalized=public.normalize_card_name('オオタチ'),
  rarity='★',
  set_order=55,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-55/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オオタチ',public.normalize_card_name('オオタチ'),'55','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-55/large','Scrydex public card image (pcg3_ja)',true,55,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '55'
);

-- 056/085 トゲピー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='トゲピー',
  name_normalized=public.normalize_card_name('トゲピー'),
  rarity='◆',
  set_order=56,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-56/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トゲピー',public.normalize_card_name('トゲピー'),'56','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-56/large','Scrydex public card image (pcg3_ja)',true,56,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '56'
);

-- 057/085 トゲチック
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='トゲチック',
  name_normalized=public.normalize_card_name('トゲチック'),
  rarity='★',
  set_order=57,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-57/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'トゲチック',public.normalize_card_name('トゲチック'),'57','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-57/large','Scrydex public card image (pcg3_ja)',true,57,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '57'
);

-- 058/085 わるいラッタ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいラッタ',
  name_normalized=public.normalize_card_name('わるいラッタ'),
  rarity='★',
  set_order=58,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-58/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいラッタ',public.normalize_card_name('わるいラッタ'),'58','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-58/large','Scrydex public card image (pcg3_ja)',true,58,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '58'
);

-- 059/085 R団のニャース
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のニャース',
  name_normalized=public.normalize_card_name('R団のニャース'),
  rarity='★',
  set_order=59,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-59/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のニャース',public.normalize_card_name('R団のニャース'),'59','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-59/large','Scrydex public card image (pcg3_ja)',true,59,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '59'
);

-- 060/085 R団のエビワラーex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のエビワラーex',
  name_normalized=public.normalize_card_name('R団のエビワラーex'),
  rarity='☆',
  set_order=60,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-60/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のエビワラーex',public.normalize_card_name('R団のエビワラーex'),'60','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-60/large','Scrydex public card image (pcg3_ja)',true,60,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '60'
);

-- 061/085 R団のストライクex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のストライクex',
  name_normalized=public.normalize_card_name('R団のストライクex'),
  rarity='☆',
  set_order=61,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-61/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のストライクex',public.normalize_card_name('R団のストライクex'),'61','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-61/large','Scrydex public card image (pcg3_ja)',true,61,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '61'
);

-- 062/085 R団のカビゴンex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のカビゴンex',
  name_normalized=public.normalize_card_name('R団のカビゴンex'),
  rarity='☆',
  set_order=62,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-62/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のカビゴンex',public.normalize_card_name('R団のカビゴンex'),'62','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-62/large','Scrydex public card image (pcg3_ja)',true,62,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '62'
);

-- 063/085 R団のサンダーex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のサンダーex',
  name_normalized=public.normalize_card_name('R団のサンダーex'),
  rarity='☆',
  set_order=63,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-63/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のサンダーex',public.normalize_card_name('R団のサンダーex'),'63','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-63/large','Scrydex public card image (pcg3_ja)',true,63,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '63'
);

-- 064/085 R団のミュウツーex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のミュウツーex',
  name_normalized=public.normalize_card_name('R団のミュウツーex'),
  rarity='☆',
  set_order=64,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-64/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のミュウツーex',public.normalize_card_name('R団のミュウツーex'),'64','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-64/large','Scrydex public card image (pcg3_ja)',true,64,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '64'
);

-- 065/085 R団のソーナンス
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のソーナンス',
  name_normalized=public.normalize_card_name('R団のソーナンス'),
  rarity='★',
  set_order=65,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-65/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のソーナンス',public.normalize_card_name('R団のソーナンス'),'65','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-65/large','Scrydex public card image (pcg3_ja)',true,65,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '65'
);

-- 066/085 R団のハッサムex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のハッサムex',
  name_normalized=public.normalize_card_name('R団のハッサムex'),
  rarity='☆',
  set_order=66,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-66/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のハッサムex',public.normalize_card_name('R団のハッサムex'),'66','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-66/large','Scrydex public card image (pcg3_ja)',true,66,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '66'
);

-- 067/085 R団のニューラex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のニューラex',
  name_normalized=public.normalize_card_name('R団のニューラex'),
  rarity='☆',
  set_order=67,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-67/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のニューラex',public.normalize_card_name('R団のニューラex'),'67','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-67/large','Scrydex public card image (pcg3_ja)',true,67,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '67'
);

-- 068/085 R団のエンテイex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のエンテイex',
  name_normalized=public.normalize_card_name('R団のエンテイex'),
  rarity='☆',
  set_order=68,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-68/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のエンテイex',public.normalize_card_name('R団のエンテイex'),'68','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-68/large','Scrydex public card image (pcg3_ja)',true,68,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '68'
);

-- 069/085 R団のスイクンex
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のスイクンex',
  name_normalized=public.normalize_card_name('R団のスイクンex'),
  rarity='☆',
  set_order=69,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-69/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のスイクンex',public.normalize_card_name('R団のスイクンex'),'69','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-69/large','Scrydex public card image (pcg3_ja)',true,69,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '69'
);

-- 070/085 わるいバンギラス
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいバンギラス',
  name_normalized=public.normalize_card_name('わるいバンギラス'),
  rarity='★',
  set_order=70,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-70/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいバンギラス',public.normalize_card_name('わるいバンギラス'),'70','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-70/large','Scrydex public card image (pcg3_ja)',true,70,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '70'
);

-- 071/085 R団のセレビィ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R団のセレビィ',
  name_normalized=public.normalize_card_name('R団のセレビィ'),
  rarity='★',
  set_order=71,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-71/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R団のセレビィ',public.normalize_card_name('R団のセレビィ'),'71','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-71/large','Scrydex public card image (pcg3_ja)',true,71,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '71'
);

-- 072/085 わるいハガネール
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='わるいハガネール',
  name_normalized=public.normalize_card_name('わるいハガネール'),
  rarity='★',
  set_order=72,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-72/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'わるいハガネール',public.normalize_card_name('わるいハガネール'),'72','★','normal','https://images.scrydex.com/pokemon/pcg3_ja-72/large','Scrydex public card image (pcg3_ja)',true,72,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '72'
);

-- 073/085 逆転! マジックハンド
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='逆転! マジックハンド',
  name_normalized=public.normalize_card_name('逆転! マジックハンド'),
  rarity='◆',
  set_order=73,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-73/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'逆転! マジックハンド',public.normalize_card_name('逆転! マジックハンド'),'73','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-73/large','Scrydex public card image (pcg3_ja)',true,73,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '73'
);

-- 074/085 そっくり! テレポーター
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='そっくり! テレポーター',
  name_normalized=public.normalize_card_name('そっくり! テレポーター'),
  rarity='◆',
  set_order=74,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-74/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'そっくり! テレポーター',public.normalize_card_name('そっくり! テレポーター'),'74','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-74/large','Scrydex public card image (pcg3_ja)',true,74,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '74'
);

-- 075/085 どっきり! タイムマシーン
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='どっきり! タイムマシーン',
  name_normalized=public.normalize_card_name('どっきり! タイムマシーン'),
  rarity='◆',
  set_order=75,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-75/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'どっきり! タイムマシーン',public.normalize_card_name('どっきり! タイムマシーン'),'75','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-75/large','Scrydex public card image (pcg3_ja)',true,75,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '75'
);

-- 076/085 びっくりボム!
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='びっくりボム!',
  name_normalized=public.normalize_card_name('びっくりボム!'),
  rarity='◆',
  set_order=76,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-76/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'びっくりボム!',public.normalize_card_name('びっくりボム!'),'76','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-76/large','Scrydex public card image (pcg3_ja)',true,76,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '76'
);

-- 077/085 ポケモン回収装置
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ポケモン回収装置',
  name_normalized=public.normalize_card_name('ポケモン回収装置'),
  rarity='◆',
  set_order=77,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-77/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポケモン回収装置',public.normalize_card_name('ポケモン回収装置'),'77','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-77/large','Scrydex public card image (pcg3_ja)',true,77,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '77'
);

-- 078/085 モノマネむすめ
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='モノマネむすめ',
  name_normalized=public.normalize_card_name('モノマネむすめ'),
  rarity='◆',
  set_order=78,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-78/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'モノマネむすめ',public.normalize_card_name('モノマネむすめ'),'78','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-78/large','Scrydex public card image (pcg3_ja)',true,78,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '78'
);

-- 079/085 ロケット団の幹部
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ロケット団の幹部',
  name_normalized=public.normalize_card_name('ロケット団の幹部'),
  rarity='◆',
  set_order=79,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-79/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロケット団の幹部',public.normalize_card_name('ロケット団の幹部'),'79','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-79/large','Scrydex public card image (pcg3_ja)',true,79,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '79'
);

-- 080/085 ロケット団のミッション
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ロケット団のミッション',
  name_normalized=public.normalize_card_name('ロケット団のミッション'),
  rarity='◆',
  set_order=80,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-80/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロケット団のミッション',public.normalize_card_name('ロケット団のミッション'),'80','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-80/large','Scrydex public card image (pcg3_ja)',true,80,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '80'
);

-- 081/085 ロケット団のアジト
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ロケット団のアジト',
  name_normalized=public.normalize_card_name('ロケット団のアジト'),
  rarity='◆',
  set_order=81,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-81/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロケット団のアジト',public.normalize_card_name('ロケット団のアジト'),'81','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-81/large','Scrydex public card image (pcg3_ja)',true,81,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '81'
);

-- 082/085 ロケット団のトリックジム
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ロケット団のトリックジム',
  name_normalized=public.normalize_card_name('ロケット団のトリックジム'),
  rarity='◆',
  set_order=82,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-82/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロケット団のトリックジム',public.normalize_card_name('ロケット団のトリックジム'),'82','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-82/large','Scrydex public card image (pcg3_ja)',true,82,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '82'
);

-- 083/085 R-エネルギー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='R-エネルギー',
  name_normalized=public.normalize_card_name('R-エネルギー'),
  rarity='◆',
  set_order=83,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-83/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'R-エネルギー',public.normalize_card_name('R-エネルギー'),'83','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-83/large','Scrydex public card image (pcg3_ja)',true,83,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '83'
);

-- 084/085 ダークメタルエネルギー
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ダークメタルエネルギー',
  name_normalized=public.normalize_card_name('ダークメタルエネルギー'),
  rarity='◆',
  set_order=84,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-84/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ダークメタルエネルギー',public.normalize_card_name('ダークメタルエネルギー'),'84','◆','normal','https://images.scrydex.com/pokemon/pcg3_ja-84/large','Scrydex public card image (pcg3_ja)',true,84,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '84'
);

-- 085/085 ロケット団参上!
with st as (select id from public.card_sets where code='PCG3' limit 1)
update public.cards c set
  name='ロケット団参上!',
  name_normalized=public.normalize_card_name('ロケット団参上!'),
  rarity='☆',
  set_order=85,
  image_url='https://images.scrydex.com/pokemon/pcg3_ja-85/large',
  image_source_note='Scrydex public card image (pcg3_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85';

with st as (select id from public.card_sets where code='PCG3' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ロケット団参上!',public.normalize_card_name('ロケット団参上!'),'85','☆','normal','https://images.scrydex.com/pokemon/pcg3_ja-85/large','Scrydex public card image (pcg3_ja)',true,85,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '85'
);

commit;

-- ============================================================
-- PCG3 監査
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
where cs.code = 'PCG3'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG3' as code,
  85 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG3'
having count(distinct c.set_order) <> 85;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG3'
group by c.set_order
having count(*) > 1
order by c.set_order;
