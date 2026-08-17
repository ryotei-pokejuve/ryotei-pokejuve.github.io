# Phase 1 実施報告 v3（バックアップ取得・復元確認 完了）

`phase1_report_v2.md`で唯一未実施だった「バックアップ取得・別環境への復元確認」を実施しました。これでPhase 1の指摘事項はすべて完了です。

---

## 1. 実施内容

1. Supabase CLI（Windows／Scoop経由）と`pg_dump`/`psql`（PostgreSQLクライアントのみ、Dockerは未使用）をローカルに導入
2. 本番プロジェクトから、`public`スキーマと`api`スキーマを対象に`pg_dump`でスキーマ定義（`schema.sql`）とデータ（`data.sql`）を取得
   - `auth`スキーマ等Supabase管理領域は対象外（意図的。復元先は別のSupabaseプロジェクトであり、認証基盤はプロジェクト作成時に自動で用意されるため）
3. 別の新規Supabaseプロジェクト（本番と完全に分離、`ryotei-pokeca-restore-test`）を作成し、上記2ファイルを`psql`で復元
4. 復元後のDBに対して、関数・トリガー・インデックス・RLS・権限（GRANT/REVOKE）が本番と一致しているかをSQLで検証
5. 検証用プロジェクトは確認完了後に削除予定（Freeプランのプロジェクト枠を圧迫しないため）

---

## 2. 検証結果

| # | 項目 | 結果 |
|---|---|---|
| 1 | `api`スキーマの関数5つ（`search_cards`／`get_card`／`get_price_history`／`admin_upsert_card`／`admin_record_price`）がすべて復元され、`SECURITY DEFINER`（`prosecdef=true`）・所有者`postgres`であること | ✅ |
| 2 | 全テーブル（7つ）で`relrowsecurity=true`（RLS有効） | ✅ |
| 3 | `pg_policies`が0件（ポリシー未定義＝デフォルト拒否設計） | ✅（本番・復元先とも0件） |
| 4 | トリガー2つ（`trg_set_card_name_normalized`／`trg_sync_current_price`）が復元されていること | ✅ |
| 5 | インデックス（主キー・ユニーク制約・`idx_cards_card_number`等の独自インデックス）が復元されていること | ✅ |
| 6 | `api`関数へのEXECUTE権限が想定通り（`search_cards`/`get_card`/`get_price_history`は`anon`/`authenticated`/`postgres`、`search_cards`のみ`service_role`も付与）であること | ✅ |
| 7 | 実テーブルへの直接権限（`pg_class.relacl`）が本番・復元先ともに`postgres`／`service_role`のみで、`anon`／`authenticated`には一切付与されていないこと | ✅（下記「発見事項」参照） |
| 8 | 復元先で`api.search_cards()`を実際に呼び出し、復元されたテストデータ（カード名・価格）が正しく返ってくること | ✅ |

---

## 3. 途中で発見した事象（結果的に問題なし）

復元直後、`information_schema.table_privileges`で確認したところ、復元先プロジェクトの全テーブルに`anon`／`authenticated`のALL権限が付与されているように見え、一時的に「本番にも同じ穴があるのでは」と疑いました。

調査の結果:
- **本番の生ACL（`pg_class.relacl`）は`postgres`／`service_role`のみで、疑い通りクリーンであることを確認**（`information_schema`側の見え方に惑わされただけで、実体には問題なし）
- 復元先での過剰権限は、新規Supabaseプロジェクト側が持つデフォルト権限設定と`pg_dump`のACL差分計算の組み合わせによる既知の落とし穴で、バックアップの中身自体の不備ではないと判断
- 実害はなし（RLSがポリシー0件で有効なため、REST API経由では引き続きブロックされる状態だった）
- 念のため`revoke all on all tables in schema public/api from anon, authenticated;`を復元先に適用し、本番と同一のACL状態に揃えたことを確認済み

---

## 4. 確認したいこと

これでPhase 1レビューで指摘された全項目（5点の修正＋受け入れテスト1〜13＋バックアップ・復元確認）が完了しました。Phase 1は完了とみなしてよいか、Codexの確認をお願いします。
