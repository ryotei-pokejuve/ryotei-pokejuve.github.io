-- MEGA rarity correction generated from Scrydex PUBLIC card pages.
-- No Scrydex API is used.
-- Safety: UPDATE only if the DB rarity still equals the value seen in the exported cards.csv.

BEGIN;

CREATE TABLE IF NOT EXISTS public.mega_rarity_backup_20260829 (
    card_id uuid PRIMARY KEY,
    old_rarity text,
    backed_up_at timestamptz NOT NULL DEFAULT now()
);

-- M1S 076 メガユキノオーex : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '3262b574-be73-49fe-bf6b-ed5fbcaf200d'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '3262b574-be73-49fe-bf6b-ed5fbcaf200d'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 077 メガライボルトex : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'd101e144-d068-4183-bdd0-fa757bd48ac9'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'd101e144-d068-4183-bdd0-fa757bd48ac9'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 078 メガサーナイトex : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'fc0b0fab-0620-416b-a9f4-fb2d33a9d27f'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'fc0b0fab-0620-416b-a9f4-fb2d33a9d27f'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 079 メガラティアスex : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '51103713-85d9-4c07-a5bb-9f732a3ead17'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '51103713-85d9-4c07-a5bb-9f732a3ead17'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 080 メガガルーラex : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '56eac2ff-1673-4420-b743-b70068bf4dca'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '56eac2ff-1673-4420-b743-b70068bf4dca'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 081 なかよしポフィン : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '650d6aec-4dfc-422b-bcff-5d17ec46c024'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '650d6aec-4dfc-422b-bcff-5d17ec46c024'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 082 ふしぎなアメ : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '0a50013e-2c6e-41ca-b01d-815ddbd31095'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '0a50013e-2c6e-41ca-b01d-815ddbd31095'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 083 メガシグナル : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'f8a11039-2ff7-4f21-8e14-f96f13c50be5'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'f8a11039-2ff7-4f21-8e14-f96f13c50be5'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 084 アセロラのいたずら : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '42d6d70d-fbcb-46ba-98b8-ef85edc53076'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '42d6d70d-fbcb-46ba-98b8-ef85edc53076'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 085 ミツルの思いやり : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'ae66a6f5-b239-4253-8249-1eab35f23771'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'ae66a6f5-b239-4253-8249-1eab35f23771'
  AND COALESCE(rarity, '') = 'UR';

-- M1S 086 ミステリーガーデン : UR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'a8b9ec20-a773-4b41-b3cf-401c926a8e21'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'a8b9ec20-a773-4b41-b3cf-401c926a8e21'
  AND COALESCE(rarity, '') = 'UR';

-- M2 102 ポケモンいれかえ : SR -> PROMO
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '6bc3e6e7-16ed-4d1e-b4d8-460eb7a21345'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'PROMO', updated_at = now()
WHERE id = '6bc3e6e7-16ed-4d1e-b4d8-460eb7a21345'
  AND COALESCE(rarity, '') = 'SR';

-- M2 065 プクリン : U -> C
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'e5171e1e-c3cf-4f20-80c6-ccec1a6bc739'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'C', updated_at = now()
WHERE id = 'e5171e1e-c3cf-4f20-80c6-ccec1a6bc739'
  AND COALESCE(rarity, '') = 'U';

-- M2a 223 メガリザードンXex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '6d5a2013-7d77-440d-83cf-ee7c6464f00d'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = '6d5a2013-7d77-440d-83cf-ee7c6464f00d'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 224 メガユキメノコex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '3c1bbfb4-9459-4564-914e-65c79948bc96'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = '3c1bbfb4-9459-4564-914e-65c79948bc96'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 225 メガシビルドンex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'ec4fdfb7-3766-4d82-99e9-0fd20fb0a56a'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = 'ec4fdfb7-3766-4d82-99e9-0fd20fb0a56a'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 226 メガサーナイトex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '4c48277a-409d-43e8-8746-371f71484b43'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = '4c48277a-409d-43e8-8746-371f71484b43'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 227 メガディアンシーex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '5b4b2016-546c-4567-900c-24048546bdc1'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = '5b4b2016-546c-4567-900c-24048546bdc1'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 228 メガルカリオex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '9a6456ae-9355-4117-8b2e-3bf151df1c7a'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = '9a6456ae-9355-4117-8b2e-3bf151df1c7a'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 229 メガルチャブルex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '2f81fd40-26a2-4487-b78e-9a08529681f8'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = '2f81fd40-26a2-4487-b78e-9a08529681f8'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 230 メガゲンガーex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'e7f92c05-4c1f-468c-a52d-6e479d0fc923'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = 'e7f92c05-4c1f-468c-a52d-6e479d0fc923'
  AND COALESCE(rarity, '') = 'SR';

-- M2a 231 メガズルズキンex : SR -> R
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'dca01781-8d22-4659-b8fc-acc7c748ae7c'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'R', updated_at = now()
WHERE id = 'dca01781-8d22-4659-b8fc-acc7c748ae7c'
  AND COALESCE(rarity, '') = 'SR';

-- M6 100 MCの盛り上げ : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '95957582-7230-45f4-a2cf-cf0204c2d49c'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '95957582-7230-45f4-a2cf-cf0204c2d49c'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 101 ギリー : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '75e3dfb1-1826-444e-91b6-8f40162343aa'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '75e3dfb1-1826-444e-91b6-8f40162343aa'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 102 ヒガナの信頼 : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'ff570a52-e28b-402b-9392-70ef46fc20a6'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'ff570a52-e28b-402b-9392-70ef46fc20a6'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 103 フウとランの修行 : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '4393fee0-dc33-4453-8001-645898a0884e'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '4393fee0-dc33-4453-8001-645898a0884e'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 104 グロウ草エネルギー : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '0c1fec2e-7533-473d-8f95-8f1eb83b94ea'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '0c1fec2e-7533-473d-8f95-8f1eb83b94ea'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 105 ニトロ炎エネルギー : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '7427f543-85a5-488f-bf02-c78da19994f5'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '7427f543-85a5-488f-bf02-c78da19994f5'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 106 バブル水エネルギー : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '787fd970-1b75-4dd8-bc6b-33a29479be41'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '787fd970-1b75-4dd8-bc6b-33a29479be41'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 107 メガグソクムシャex : MUR -> SAR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '55f975f9-925a-489c-b443-1583173c9c2a'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SAR', updated_at = now()
WHERE id = '55f975f9-925a-489c-b443-1583173c9c2a'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 108 ライコウex : MUR -> SAR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '332f8127-b133-4ea1-8e23-2ad48dc09184'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SAR', updated_at = now()
WHERE id = '332f8127-b133-4ea1-8e23-2ad48dc09184'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 109 メガゴルーグex : MUR -> SAR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'bb4e9a28-bfbd-48d5-85a9-53a4585951ef'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SAR', updated_at = now()
WHERE id = 'bb4e9a28-bfbd-48d5-85a9-53a4585951ef'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 110 メガレックウザex : MUR -> SAR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'd0dce076-652b-4105-a54d-ef5849da783d'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SAR', updated_at = now()
WHERE id = 'd0dce076-652b-4105-a54d-ef5849da783d'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 111 ギリー : MUR -> SAR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '3e5ab5c8-86c5-4b49-9e48-72ab126e52be'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SAR', updated_at = now()
WHERE id = '3e5ab5c8-86c5-4b49-9e48-72ab126e52be'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 112 ヒガナの信頼 : MUR -> SAR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'b779a3f1-c862-4b47-95b1-7eab6219aae3'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SAR', updated_at = now()
WHERE id = 'b779a3f1-c862-4b47-95b1-7eab6219aae3'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 077 アメモース : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'd17d8d29-86ad-4d72-a7ab-48bbe2797981'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = 'd17d8d29-86ad-4d72-a7ab-48bbe2797981'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 078 ガーディ : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'e03a6425-edcf-4486-93e7-77f0ee708b31'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = 'e03a6425-edcf-4486-93e7-77f0ee708b31'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 079 ブーバーン : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '43ae2665-2bd9-46a6-ad7d-ef2cb4715db7'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '43ae2665-2bd9-46a6-ad7d-ef2cb4715db7'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 080 カイオーガ : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '099a8fc4-a35e-4fa2-a15e-009ff4128191'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '099a8fc4-a35e-4fa2-a15e-009ff4128191'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 081 エレキブル : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '381ca521-7c09-4ec4-a309-57b5a6585474'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '381ca521-7c09-4ec4-a309-57b5a6585474'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 082 バチンウニ : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '83ad16bd-a21b-4307-a4d8-fc3ec80997bf'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '83ad16bd-a21b-4307-a4d8-fc3ec80997bf'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 083 ラブトロス : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '15b533ea-4457-426d-86a9-9bf7c6f1a661'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '15b533ea-4457-426d-86a9-9bf7c6f1a661'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 084 グラードン : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'aa9a19bc-9ae8-480e-9bed-9c838fe04e51'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = 'aa9a19bc-9ae8-480e-9bed-9c838fe04e51'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 085 マーイーカ : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '8eb32504-0a49-49c0-adfd-75531bf56f32'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '8eb32504-0a49-49c0-adfd-75531bf56f32'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 086 ルリリ : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '62bb9f45-c378-4aac-8f57-43e41e3ddcde'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '62bb9f45-c378-4aac-8f57-43e41e3ddcde'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 087 チルタリス : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'b4898b33-1061-40c8-9957-335b2cf1b92c'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = 'b4898b33-1061-40c8-9957-335b2cf1b92c'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 088 カクレオン : MUR -> AR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '8bb47bb8-3f21-4678-99c7-d757fde3edca'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'AR', updated_at = now()
WHERE id = '8bb47bb8-3f21-4678-99c7-d757fde3edca'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 089 メガグソクムシャex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '39dea0f5-f125-48af-afb8-69cca5566c8b'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '39dea0f5-f125-48af-afb8-69cca5566c8b'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 090 ヒートロトムex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '49586f21-86d0-4530-bf03-8dd302d2878a'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '49586f21-86d0-4530-bf03-8dd302d2878a'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 091 ヨワシex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '5ab69939-4101-4cc4-b2c4-a2d89b7c56f9'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '5ab69939-4101-4cc4-b2c4-a2d89b7c56f9'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 092 ライコウex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'ce1a6a46-6e68-4247-b9ba-ff15cf45c2f0'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'ce1a6a46-6e68-4247-b9ba-ff15cf45c2f0'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 093 メガゴルーグex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '55add139-95ec-41f7-8960-d73f9706d37e'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '55add139-95ec-41f7-8960-d73f9706d37e'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 094 メガカラマネロex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '136ac92d-eb4e-4240-bf2d-d86d5d262860'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '136ac92d-eb4e-4240-bf2d-d86d5d262860'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 095 メガレックウザex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = 'c5845efc-578e-4452-967f-0a06630e9756'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = 'c5845efc-578e-4452-967f-0a06630e9756'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 096 ファイアローex : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '6a1787a4-7379-46d1-8673-901b9848e88b'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '6a1787a4-7379-46d1-8673-901b9848e88b'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 097 ぼうけんのランタン : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '4c19459a-9072-4a5d-b19a-323704ff4543'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '4c19459a-9072-4a5d-b19a-323704ff4543'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 098 とくちゅうチョッキ : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '84ae8d72-1e94-40dd-a039-c955e5ce5d53'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '84ae8d72-1e94-40dd-a039-c955e5ce5d53'
  AND COALESCE(rarity, '') = 'MUR';

-- M6 099 ポケモンキャッチャー : MUR -> SR
INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)
SELECT id, rarity FROM public.cards WHERE id = '4ec825c1-2237-48b4-a522-8b594ab0ac7c'
ON CONFLICT (card_id) DO NOTHING;
UPDATE public.cards
SET rarity = 'SR', updated_at = now()
WHERE id = '4ec825c1-2237-48b4-a522-8b594ab0ac7c'
  AND COALESCE(rarity, '') = 'MUR';

COMMIT;
