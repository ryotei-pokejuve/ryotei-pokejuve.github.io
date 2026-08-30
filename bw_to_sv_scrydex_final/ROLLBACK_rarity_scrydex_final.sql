BEGIN;
UPDATE public.cards c
SET rarity=b.old_rarity, updated_at=now()
FROM public.bw_sv_rarity_backup_scrydex_final b
WHERE c.id=b.card_id;
COMMIT;
SELECT COUNT(*) AS restored_rows FROM public.bw_sv_rarity_backup_scrydex_final;
