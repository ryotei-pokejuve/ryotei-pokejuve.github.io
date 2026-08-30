BEGIN;
UPDATE public.cards c
SET rarity = b.old_rarity,
    updated_at = now()
FROM public.mega_rarity_backup_20260829 b
WHERE c.id = b.card_id;
COMMIT;
