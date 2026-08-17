# Phase 1 実施報告 v2（Codex 2回目レビュー対応後）

Codexの2回目レビューで指摘された5点＋追加テスト項目を反映しました。`phase1_patch.sql`として適用済みです。

---

## 1. 今回のレビューで指摘・修正した点

| # | 指摘 | 対応 |
|---|---|---|
| 1 | 内部関数（`normalize_card_name`等）にPUBLICのEXECUTE権限が残っている | 3つの内部関数すべてに`revoke execute ... from public`を明示的に適用 |
| 2 | 一般authenticatedユーザーの拒否テストが未実施 | 別アカウント（`admin_users`未登録）を作成し、`admin_record_price`／`admin_upsert_card`／実テーブル直接アクセスの3つすべてで拒否を確認 |
| 3 | 将来作成するテーブル・関数のデフォルト権限が未制限 | `ALTER DEFAULT PRIVILEGES FOR ROLE postgres`で、`public`／`api`両スキーマの将来オブジェクトについて、関数のPUBLIC EXECUTE・テーブルのanon/authenticated権限をデフォルトで剥奪。`public`スキーマへのCREATE権限もPUBLICから剥奪 |
| 4 | `search_cards`のlimitがマイナス値でエラーになりうる | `greatest(1, least(...))`で1〜100に必ず収まるよう修正。あわせて検索語を100文字に切り詰め、`%`/`_`/`\`をエスケープしてLIKEワイルドカードとして誤動作しないようにし、offsetにも上限（100,000）を設定 |
| 5 | `get_price_history`が販売／買取／状態区分を区別せず返す | `p_price_type`／`p_condition`を引数化（デフォルト`sell`／`default`）。`get_card`も同様に引数化。索引を`(card_id, price_type, condition, observed_at desc)`に張り替え |

---

## 2. 受け入れテスト結果（全項目再検証済み）

| # | 項目 | 結果 |
|---|---|---|
| 1 | 未認証ユーザーは公開検索が成功する | ✅ |
| 2 | 未認証ユーザーは実テーブルに直接アクセスできない | ✅ `permission denied for table cards` |
| 3 | 管理者アカウントでログインできる | ✅ |
| 4 | カード詳細が取得できる | ✅ |
| 5 | 未ログイン状態では価格登録が拒否される | ✅ `not authorized` |
| 6 | ログイン済み管理者は価格登録が成功する | ✅ |
| 7 | 重複登録は2回目が無視される | ✅ 1回目成功、2回目`data: null` |
| 8-a | マイナス価格は拒否される | ✅ `price must be positive` |
| 8-b | 未来すぎる日時は拒否される | ✅ `observed_at is invalid or in the future` |
| 8-c | 存在しないカードIDは拒否される | ✅ `card not found` |
| 9-a | 一般ユーザー（`admin_users`未登録）は`admin_record_price`を実行できない | ✅ `not authorized` |
| 9-b | 一般ユーザーは`admin_upsert_card`を実行できない | ✅ `not authorized` |
| 9-c | 一般ユーザーは実テーブルに直接アクセスできない | ✅ `permission denied for table cards` |
| 10 | `p_limit=0`／`p_limit=-5`でもエラーにならず正常に返る | ✅ 両方とも1件以上返却、エラーなし |
| 11 | 古い観測値を後から登録しても現在価格が巻き戻らない | ✅ 3000円登録後に1日前の300円を登録しても current_price は3000のまま |
| 12 | 販売価格／買取価格が別々の`current_prices`行になる | ✅ sell=5000円、buy=4000円で正しく分離 |
| 13 | 内部関数（`public.normalize_card_name`）に直接アクセスできない | ✅ `permission denied for function normalize_card_name` |
| バックアップ | バックアップ取得・別環境への復元確認 | ⏳ 未実施（Supabase CLIのセットアップが必要なため次回実施） |

---

## 3. 未実施の項目

バックアップ取得・復元確認のみ残っています。Supabase CLIのインストールが必要なため、別途スケジュールして実施します。それ以外の指摘事項はすべて反映・検証済みです。

---

## 4. 確認したいこと

上記により、前回指摘された5点の修正と追加テスト項目（9〜13）はすべて完了しました。バックアップ確認を除き、Phase 1は完了とみなしてよいか、Codexの確認をお願いします。
