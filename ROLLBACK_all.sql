-- BW～SV Scrydex image refresh rollback
BEGIN;

UPDATE public.cards c
SET
  image_url=b.old_image_url,
  image_source_note=b.old_image_source_note
FROM public.bw_sv_image_backup_scrydex_20260829 b
WHERE c.id=b.card_id;

COMMIT;

SELECT COUNT(*) AS restored_rows
FROM public.bw_sv_image_backup_scrydex_20260829;
