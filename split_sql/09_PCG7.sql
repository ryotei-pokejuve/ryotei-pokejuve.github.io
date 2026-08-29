-- PCG7 単体実行用 / Supabase SQL Editor向け
-- 元の一括SQLから自動分割

begin;

-- PCG7 拡張パック ホロンの幻影 (52 cards)
update public.card_sets
set name='拡張パック ホロンの幻影',
    release_date='2006-01-27'::date,
    tcgdex_series_id='PCG',
    series_name='ADV・PCGシリーズ',
    image_url='https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG7%20Holon%20Phantom%20pack.jpg'
where code='PCG7';

insert into public.card_sets (name, code, release_date, tcgdex_series_id, series_name, image_url)
select '拡張パック ホロンの幻影', 'PCG7', '2006-01-27'::date, 'PCG', 'ADV・PCGシリーズ', 'https://archives.bulbagarden.net/wiki/Special:Redirect/file/PCG7%20Holon%20Phantom%20pack.jpg'
where not exists (select 1 from public.card_sets where code='PCG7');

-- 001/052 ナックラーδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ナックラーδ-デルタ種',
  name_normalized=public.normalize_card_name('ナックラーδ-デルタ種'),
  rarity='●',
  set_order=1,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-1/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナックラーδ-デルタ種',public.normalize_card_name('ナックラーδ-デルタ種'),'1','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-1/large','Scrydex public card image (pcg7_ja)',true,1,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '1'
);

-- 002/052 ビブラーバδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ビブラーバδ-デルタ種',
  name_normalized=public.normalize_card_name('ビブラーバδ-デルタ種'),
  rarity='◆',
  set_order=2,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-2/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ビブラーバδ-デルタ種',public.normalize_card_name('ビブラーバδ-デルタ種'),'2','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-2/large','Scrydex public card image (pcg7_ja)',true,2,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '2'
);

-- 003/052 フライゴンδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='フライゴンδ-デルタ種',
  name_normalized=public.normalize_card_name('フライゴンδ-デルタ種'),
  rarity='★',
  set_order=3,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-3/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'フライゴンδ-デルタ種',public.normalize_card_name('フライゴンδ-デルタ種'),'3','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-3/large','Scrydex public card image (pcg7_ja)',true,3,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '3'
);

-- 004/052 マンキーδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='マンキーδ-デルタ種',
  name_normalized=public.normalize_card_name('マンキーδ-デルタ種'),
  rarity='●',
  set_order=4,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-4/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'マンキーδ-デルタ種',public.normalize_card_name('マンキーδ-デルタ種'),'4','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-4/large','Scrydex public card image (pcg7_ja)',true,4,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '4'
);

-- 005/052 オコリザルδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='オコリザルδ-デルタ種',
  name_normalized=public.normalize_card_name('オコリザルδ-デルタ種'),
  rarity='◆',
  set_order=5,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-5/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オコリザルδ-デルタ種',public.normalize_card_name('オコリザルδ-デルタ種'),'5','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-5/large','Scrydex public card image (pcg7_ja)',true,5,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '5'
);

-- 006/052 タッツーδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='タッツーδ-デルタ種',
  name_normalized=public.normalize_card_name('タッツーδ-デルタ種'),
  rarity='●',
  set_order=6,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-6/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タッツーδ-デルタ種',public.normalize_card_name('タッツーδ-デルタ種'),'6','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-6/large','Scrydex public card image (pcg7_ja)',true,6,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '6'
);

-- 007/052 シードラδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='シードラδ-デルタ種',
  name_normalized=public.normalize_card_name('シードラδ-デルタ種'),
  rarity='◆',
  set_order=7,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-7/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'シードラδ-デルタ種',public.normalize_card_name('シードラδ-デルタ種'),'7','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-7/large','Scrydex public card image (pcg7_ja)',true,7,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '7'
);

-- 008/052 ギャラドス☆δ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ギャラドス☆δ-デルタ種',
  name_normalized=public.normalize_card_name('ギャラドス☆δ-デルタ種'),
  rarity='★',
  set_order=8,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-8/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ギャラドス☆δ-デルタ種',public.normalize_card_name('ギャラドス☆δ-デルタ種'),'8','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-8/large','Scrydex public card image (pcg7_ja)',true,8,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '8'
);

-- 009/052 プテラδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='プテラδ-デルタ種',
  name_normalized=public.normalize_card_name('プテラδ-デルタ種'),
  rarity='◆',
  set_order=9,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-9/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'プテラδ-デルタ種',public.normalize_card_name('プテラδ-デルタ種'),'9','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-9/large','Scrydex public card image (pcg7_ja)',true,9,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '9'
);

-- 010/052 ラティアスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ラティアスδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティアスδ-デルタ種'),
  rarity='★',
  set_order=10,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-10/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティアスδ-デルタ種',public.normalize_card_name('ラティアスδ-デルタ種'),'10','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-10/large','Scrydex public card image (pcg7_ja)',true,10,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '10'
);

-- 011/052 キングドラδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='キングドラδ-デルタ種',
  name_normalized=public.normalize_card_name('キングドラδ-デルタ種'),
  rarity='★',
  set_order=11,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-11/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キングドラδ-デルタ種',public.normalize_card_name('キングドラδ-デルタ種'),'11','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-11/large','Scrydex public card image (pcg7_ja)',true,11,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '11'
);

-- 012/052 ナゾノクサδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ナゾノクサδ-デルタ種',
  name_normalized=public.normalize_card_name('ナゾノクサδ-デルタ種'),
  rarity='●',
  set_order=12,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-12/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナゾノクサδ-デルタ種',public.normalize_card_name('ナゾノクサδ-デルタ種'),'12','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-12/large','Scrydex public card image (pcg7_ja)',true,12,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '12'
);

-- 013/052 キレイハナδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='キレイハナδ-デルタ種',
  name_normalized=public.normalize_card_name('キレイハナδ-デルタ種'),
  rarity='◆',
  set_order=13,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-13/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キレイハナδ-デルタ種',public.normalize_card_name('キレイハナδ-デルタ種'),'13','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-13/large','Scrydex public card image (pcg7_ja)',true,13,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '13'
);

-- 014/052 ラティオスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ラティオスδ-デルタ種',
  name_normalized=public.normalize_card_name('ラティオスδ-デルタ種'),
  rarity='★',
  set_order=14,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-14/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラティオスδ-デルタ種',public.normalize_card_name('ラティオスδ-デルタ種'),'14','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-14/large','Scrydex public card image (pcg7_ja)',true,14,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '14'
);

-- 015/052 レックウザδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='レックウザδ-デルタ種',
  name_normalized=public.normalize_card_name('レックウザδ-デルタ種'),
  rarity='★',
  set_order=15,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-15/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'レックウザδ-デルタ種',public.normalize_card_name('レックウザδ-デルタ種'),'15','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-15/large','Scrydex public card image (pcg7_ja)',true,15,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '15'
);

-- 016/052 ポッポδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ポッポδ-デルタ種',
  name_normalized=public.normalize_card_name('ポッポδ-デルタ種'),
  rarity='●',
  set_order=16,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-16/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ポッポδ-デルタ種',public.normalize_card_name('ポッポδ-デルタ種'),'16','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-16/large','Scrydex public card image (pcg7_ja)',true,16,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '16'
);

-- 017/052 ピジョンδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ピジョンδ-デルタ種',
  name_normalized=public.normalize_card_name('ピジョンδ-デルタ種'),
  rarity='◆',
  set_order=17,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-17/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピジョンδ-デルタ種',public.normalize_card_name('ピジョンδ-デルタ種'),'17','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-17/large','Scrydex public card image (pcg7_ja)',true,17,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '17'
);

-- 018/052 コダックδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='コダックδ-デルタ種',
  name_normalized=public.normalize_card_name('コダックδ-デルタ種'),
  rarity='●',
  set_order=18,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-18/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コダックδ-デルタ種',public.normalize_card_name('コダックδ-デルタ種'),'18','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-18/large','Scrydex public card image (pcg7_ja)',true,18,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '18'
);

-- 019/052 ゴルダックδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ゴルダックδ-デルタ種',
  name_normalized=public.normalize_card_name('ゴルダックδ-デルタ種'),
  rarity='◆',
  set_order=19,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-19/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ゴルダックδ-デルタ種',public.normalize_card_name('ゴルダックδ-デルタ種'),'19','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-19/large','Scrydex public card image (pcg7_ja)',true,19,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '19'
);

-- 020/052 カブトδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='カブトδ-デルタ種',
  name_normalized=public.normalize_card_name('カブトδ-デルタ種'),
  rarity='●',
  set_order=20,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-20/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブトδ-デルタ種',public.normalize_card_name('カブトδ-デルタ種'),'20','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-20/large','Scrydex public card image (pcg7_ja)',true,20,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '20'
);

-- 021/052 カブトプスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='カブトプスδ-デルタ種',
  name_normalized=public.normalize_card_name('カブトプスδ-デルタ種'),
  rarity='★',
  set_order=21,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-21/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'カブトプスδ-デルタ種',public.normalize_card_name('カブトプスδ-デルタ種'),'21','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-21/large','Scrydex public card image (pcg7_ja)',true,21,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '21'
);

-- 022/052 デオキシスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='デオキシスδ-デルタ種',
  name_normalized=public.normalize_card_name('デオキシスδ-デルタ種'),
  rarity='★',
  set_order=22,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-22/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デオキシスδ-デルタ種',public.normalize_card_name('デオキシスδ-デルタ種'),'22','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-22/large','Scrydex public card image (pcg7_ja)',true,22,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '22'
);

-- 023/052 ピジョットδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ピジョットδ-デルタ種',
  name_normalized=public.normalize_card_name('ピジョットδ-デルタ種'),
  rarity='★',
  set_order=23,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-23/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピジョットδ-デルタ種',public.normalize_card_name('ピジョットδ-デルタ種'),'23','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-23/large','Scrydex public card image (pcg7_ja)',true,23,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '23'
);

-- 024/052 ギャラドスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ギャラドスδ-デルタ種',
  name_normalized=public.normalize_card_name('ギャラドスδ-デルタ種'),
  rarity='★',
  set_order=24,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-24/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ギャラドスδ-デルタ種',public.normalize_card_name('ギャラドスδ-デルタ種'),'24','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-24/large','Scrydex public card image (pcg7_ja)',true,24,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '24'
);

-- 025/052 クサイハナδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='クサイハナδ-デルタ種',
  name_normalized=public.normalize_card_name('クサイハナδ-デルタ種'),
  rarity='◆',
  set_order=25,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-25/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'クサイハナδ-デルタ種',public.normalize_card_name('クサイハナδ-デルタ種'),'25','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-25/large','Scrydex public card image (pcg7_ja)',true,25,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '25'
);

-- 026/052 オムナイトδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='オムナイトδ-デルタ種',
  name_normalized=public.normalize_card_name('オムナイトδ-デルタ種'),
  rarity='●',
  set_order=26,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-26/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムナイトδ-デルタ種',public.normalize_card_name('オムナイトδ-デルタ種'),'26','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-26/large','Scrydex public card image (pcg7_ja)',true,26,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '26'
);

-- 027/052 オムスターδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='オムスターδ-デルタ種',
  name_normalized=public.normalize_card_name('オムスターδ-デルタ種'),
  rarity='★',
  set_order=27,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-27/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'オムスターδ-デルタ種',public.normalize_card_name('オムスターδ-デルタ種'),'27','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-27/large','Scrydex public card image (pcg7_ja)',true,27,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '27'
);

-- 028/052 ラフレシアδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ラフレシアδ-デルタ種',
  name_normalized=public.normalize_card_name('ラフレシアδ-デルタ種'),
  rarity='★',
  set_order=28,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-28/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ラフレシアδ-デルタ種',public.normalize_card_name('ラフレシアδ-デルタ種'),'28','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-28/large','Scrydex public card image (pcg7_ja)',true,28,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '28'
);

-- 029/052 タマタマδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='タマタマδ-デルタ種',
  name_normalized=public.normalize_card_name('タマタマδ-デルタ種'),
  rarity='●',
  set_order=29,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-29/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'タマタマδ-デルタ種',public.normalize_card_name('タマタマδ-デルタ種'),'29','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-29/large','Scrydex public card image (pcg7_ja)',true,29,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '29'
);

-- 030/052 ナッシーδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ナッシーδ-デルタ種',
  name_normalized=public.normalize_card_name('ナッシーδ-デルタ種'),
  rarity='◆',
  set_order=30,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-30/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ナッシーδ-デルタ種',public.normalize_card_name('ナッシーδ-デルタ種'),'30','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-30/large','Scrydex public card image (pcg7_ja)',true,30,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '30'
);

-- 031/052 キバニアδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='キバニアδ-デルタ種',
  name_normalized=public.normalize_card_name('キバニアδ-デルタ種'),
  rarity='●',
  set_order=31,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-31/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'キバニアδ-デルタ種',public.normalize_card_name('キバニアδ-デルタ種'),'31','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-31/large','Scrydex public card image (pcg7_ja)',true,31,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '31'
);

-- 032/052 サメハダーδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='サメハダーδ-デルタ種',
  name_normalized=public.normalize_card_name('サメハダーδ-デルタ種'),
  rarity='◆',
  set_order=32,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-32/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'サメハダーδ-デルタ種',public.normalize_card_name('サメハダーδ-デルタ種'),'32','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-32/large','Scrydex public card image (pcg7_ja)',true,32,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '32'
);

-- 033/052 アーマルドδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='アーマルドδ-デルタ種',
  name_normalized=public.normalize_card_name('アーマルドδ-デルタ種'),
  rarity='★',
  set_order=33,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-33/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アーマルドδ-デルタ種',public.normalize_card_name('アーマルドδ-デルタ種'),'33','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-33/large','Scrydex public card image (pcg7_ja)',true,33,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '33'
);

-- 034/052 ホロンのポワルン
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ホロンのポワルン',
  name_normalized=public.normalize_card_name('ホロンのポワルン'),
  rarity='◆',
  set_order=34,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-34/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンのポワルン',public.normalize_card_name('ホロンのポワルン'),'34','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-34/large','Scrydex public card image (pcg7_ja)',true,34,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '34'
);

-- 035/052 デオキシスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='デオキシスδ-デルタ種',
  name_normalized=public.normalize_card_name('デオキシスδ-デルタ種'),
  rarity='★',
  set_order=35,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-35/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デオキシスδ-デルタ種',public.normalize_card_name('デオキシスδ-デルタ種'),'35','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-35/large','Scrydex public card image (pcg7_ja)',true,35,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '35'
);

-- 036/052 リリーラδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='リリーラδ-デルタ種',
  name_normalized=public.normalize_card_name('リリーラδ-デルタ種'),
  rarity='●',
  set_order=36,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-36/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'リリーラδ-デルタ種',public.normalize_card_name('リリーラδ-デルタ種'),'36','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-36/large','Scrydex public card image (pcg7_ja)',true,36,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '36'
);

-- 037/052 デオキシスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='デオキシスδ-デルタ種',
  name_normalized=public.normalize_card_name('デオキシスδ-デルタ種'),
  rarity='★',
  set_order=37,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-37/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デオキシスδ-デルタ種',public.normalize_card_name('デオキシスδ-デルタ種'),'37','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-37/large','Scrydex public card image (pcg7_ja)',true,37,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '37'
);

-- 038/052 ニャースδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ニャースδ-デルタ種',
  name_normalized=public.normalize_card_name('ニャースδ-デルタ種'),
  rarity='●',
  set_order=38,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-38/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ニャースδ-デルタ種',public.normalize_card_name('ニャースδ-デルタ種'),'38','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-38/large','Scrydex public card image (pcg7_ja)',true,38,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '38'
);

-- 039/052 ペルシアンδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ペルシアンδ-デルタ種',
  name_normalized=public.normalize_card_name('ペルシアンδ-デルタ種'),
  rarity='◆',
  set_order=39,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-39/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ペルシアンδ-デルタ種',public.normalize_card_name('ペルシアンδ-デルタ種'),'39','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-39/large','Scrydex public card image (pcg7_ja)',true,39,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '39'
);

-- 040/052 ユレイドルδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ユレイドルδ-デルタ種',
  name_normalized=public.normalize_card_name('ユレイドルδ-デルタ種'),
  rarity='★',
  set_order=40,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-40/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ユレイドルδ-デルタ種',public.normalize_card_name('ユレイドルδ-デルタ種'),'40','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-40/large','Scrydex public card image (pcg7_ja)',true,40,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '40'
);

-- 041/052 ピカチュウδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ピカチュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ピカチュウδ-デルタ種'),
  rarity='●',
  set_order=41,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-41/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピカチュウδ-デルタ種',public.normalize_card_name('ピカチュウδ-デルタ種'),'41','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-41/large','Scrydex public card image (pcg7_ja)',true,41,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '41'
);

-- 042/052 ライチュウδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ライチュウδ-デルタ種',
  name_normalized=public.normalize_card_name('ライチュウδ-デルタ種'),
  rarity='★',
  set_order=42,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-42/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ライチュウδ-デルタ種',public.normalize_card_name('ライチュウδ-デルタ種'),'42','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-42/large','Scrydex public card image (pcg7_ja)',true,42,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '42'
);

-- 043/052 コイキングδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='コイキングδ-デルタ種',
  name_normalized=public.normalize_card_name('コイキングδ-デルタ種'),
  rarity='●',
  set_order=43,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-43/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'コイキングδ-デルタ種',public.normalize_card_name('コイキングδ-デルタ種'),'43','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-43/large','Scrydex public card image (pcg7_ja)',true,43,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '43'
);

-- 044/052 ピチューδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ピチューδ-デルタ種',
  name_normalized=public.normalize_card_name('ピチューδ-デルタ種'),
  rarity='●',
  set_order=44,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-44/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ピチューδ-デルタ種',public.normalize_card_name('ピチューδ-デルタ種'),'44','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-44/large','Scrydex public card image (pcg7_ja)',true,44,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '44'
);

-- 045/052 アノプスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='アノプスδ-デルタ種',
  name_normalized=public.normalize_card_name('アノプスδ-デルタ種'),
  rarity='●',
  set_order=45,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-45/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'アノプスδ-デルタ種',public.normalize_card_name('アノプスδ-デルタ種'),'45','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-45/large','Scrydex public card image (pcg7_ja)',true,45,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '45'
);

-- 046/052 チリーンδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='チリーンδ-デルタ種',
  name_normalized=public.normalize_card_name('チリーンδ-デルタ種'),
  rarity='◆',
  set_order=46,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-46/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'チリーンδ-デルタ種',public.normalize_card_name('チリーンδ-デルタ種'),'46','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-46/large','Scrydex public card image (pcg7_ja)',true,46,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '46'
);

-- 047/052 デオキシスδ-デルタ種
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='デオキシスδ-デルタ種',
  name_normalized=public.normalize_card_name('デオキシスδ-デルタ種'),
  rarity='★',
  set_order=47,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-47/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'デオキシスδ-デルタ種',public.normalize_card_name('デオキシスδ-デルタ種'),'47','★','normal','https://images.scrydex.com/pokemon/pcg7_ja-47/large','Scrydex public card image (pcg7_ja)',true,47,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '47'
);

-- 048/052 ふしぎなアメ
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ふしぎなアメ',
  name_normalized=public.normalize_card_name('ふしぎなアメ'),
  rarity='◆',
  set_order=48,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-48/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ふしぎなアメ',public.normalize_card_name('ふしぎなアメ'),'48','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-48/large','Scrydex public card image (pcg7_ja)',true,48,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '48'
);

-- 049/052 ホロンの化石
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ホロンの化石',
  name_normalized=public.normalize_card_name('ホロンの化石'),
  rarity='●',
  set_order=49,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-49/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの化石',public.normalize_card_name('ホロンの化石'),'49','●','normal','https://images.scrydex.com/pokemon/pcg7_ja-49/large','Scrydex public card image (pcg7_ja)',true,49,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '49'
);

-- 050/052 ホロンの冒険家
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ホロンの冒険家',
  name_normalized=public.normalize_card_name('ホロンの冒険家'),
  rarity='◆',
  set_order=50,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-50/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの冒険家',public.normalize_card_name('ホロンの冒険家'),'50','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-50/large','Scrydex public card image (pcg7_ja)',true,50,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '50'
);

-- 051/052 ホロンの湖
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='ホロンの湖',
  name_normalized=public.normalize_card_name('ホロンの湖'),
  rarity='◆',
  set_order=51,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-51/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'ホロンの湖',public.normalize_card_name('ホロンの湖'),'51','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-51/large','Scrydex public card image (pcg7_ja)',true,51,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '51'
);

-- 052/052 δレインボーエネルギー
with st as (select id from public.card_sets where code='PCG7' limit 1)
update public.cards c set
  name='δレインボーエネルギー',
  name_normalized=public.normalize_card_name('δレインボーエネルギー'),
  rarity='◆',
  set_order=52,
  image_url='https://images.scrydex.com/pokemon/pcg7_ja-52/large',
  image_source_note='Scrydex public card image (pcg7_ja)',
  is_active=true,
  updated_at=now()
from st
where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52';

with st as (select id from public.card_sets where code='PCG7' limit 1)
insert into public.cards
  (set_id,name,name_normalized,card_number,rarity,variant,image_url,image_source_note,is_active,set_order,created_at,updated_at)
select st.id,'δレインボーエネルギー',public.normalize_card_name('δレインボーエネルギー'),'52','◆','normal','https://images.scrydex.com/pokemon/pcg7_ja-52/large','Scrydex public card image (pcg7_ja)',true,52,now(),now()
from st
where not exists (
  select 1 from public.cards c
  where c.set_id=st.id and coalesce(nullif(ltrim(split_part(c.card_number,'/',1),'0'),''),'0') = '52'
);

commit;

-- ============================================================
-- PCG7 監査
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
where cs.code = 'PCG7'
group by cs.code, cs.name, cs.release_date, cs.image_url;

-- 件数不一致なら1行返る。0 rows が正常。
select
  'PCG7' as code,
  52 as expected,
  count(distinct c.set_order) as actual
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG7'
having count(distinct c.set_order) <> 52;

-- set_order重複。0 rows が正常。
select
  c.set_order,
  count(*) as dup_count
from public.card_sets cs
join public.cards c on c.set_id = cs.id
where cs.code = 'PCG7'
group by c.set_order
having count(*) > 1
order by c.set_order;
