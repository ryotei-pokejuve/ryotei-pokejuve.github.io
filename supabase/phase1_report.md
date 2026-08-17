# Phase 1 実施報告（Codexレビュー用）

設計ドキュメント`card-market-design-v4.md`にもとづき、Supabase上にPhase 1（DB・権限・バックアップの土台構築）を実装しました。以下、実施内容と検証結果です。

---

## 1. 実装したもの

`phase1_schema.sql`として以下をSupabaseプロジェクト（`ryotei-pokeca`）に適用済みです。

**テーブル（`public`スキーマ）**
`card_sets` / `price_sources` / `import_batches` / `cards` / `price_observations` / `current_prices` / `admin_users`。設計書v4通り、`current_prices`の主キーは`(card_id, price_type, condition)`。

**索引**
`cards(set_id, rarity)`、`cards(card_number)`、`price_observations(card_id, source_id, condition, observed_at desc)`。

**関数・トリガー**
- `public.normalize_card_name(text)`：NFKC正規化＋ひらがな→カタカナ統一＋空白除去＋小文字化。DB側1箇所のみに実装
- `public.set_card_name_normalized()`：`cards`のinsert/update時に`name_normalized`を自動生成するBEFOREトリガー
- `public.is_admin()`：`admin_users`照合による管理者判定。`SECURITY DEFINER`、`search_path=''`固定、`PUBLIC`から実行権限剥奪済み
- `public.sync_current_price()`：`price_observations`へのAFTER INSERTトリガー。実際にINSERTされた行についてのみ発火し、`current_prices`を原子的に同期（`observed_at`が新しい場合のみ上書き）

**`api`スキーマ（外部公開する関数のみを配置）**
- `api.search_cards` / `api.get_card` / `api.get_price_history`：公開読み取り（`anon`, `authenticated`にGRANT）
- `api.admin_upsert_card` / `api.admin_record_price`：管理者専用書き込み。内部で`is_admin()`必須。`authenticated`にのみGRANT

**権限モデル**
`public`スキーマの実テーブルには`anon`/`authenticated`への直接GRANTを一切与えず（`REVOKE ALL`済み）、全テーブルでRLSを有効化（ポリシーは意図的に作成せずデフォルト拒否）。読み書きはすべて`api`スキーマの関数経由に統一。

**ダッシュボード側の設定**
- Settings → API → Exposed schemas に`api`を追加
- Exposed functions で、`api.*`の5関数のみ公開、`public.*`の内部関数（`is_admin`等）は非公開に設定
- Authentication → Usersで管理者アカウントを1件作成し、`admin_users`に登録

---

## 2. 受け入れテスト結果

ブラウザ上で動く簡易テストツール（supabase-js使用）を使い、実際のAPIキー・実際のログインセッションで検証しました。

| # | 項目 | 結果 |
|---|---|---|
| 1 | 未認証ユーザーは公開検索（`api.search_cards`）が成功する | ✅ 成功 |
| 2 | 未認証ユーザーは実テーブル（`public.cards`）に直接アクセスできない | ✅ `permission denied for table cards`で拒否 |
| 3 | 管理者アカウントでログインできる | ✅ 成功 |
| 4 | カード詳細（`api.get_card`）が取得できる | ✅ 成功 |
| 5 | 未ログイン状態では価格登録（`api.admin_record_price`）が拒否される | ✅ `not authorized`で拒否（ログアウトして再検証済み） |
| 6 | ログイン済み管理者は価格登録が成功する | ✅ 成功 |
| 7 | 同一条件（card_id, source_id, price_type, condition, observed_at）の重複登録は2回目が無視される | ✅ 1回目成功、2回目`data: null` |
| 8-a | 不正な価格（マイナス値）は拒否される | ✅ `price must be positive` |
| 8-b | 未来すぎる日時は拒否される | ✅ `observed_at is invalid or in the future` |
| 8-c | 存在しないカードIDは拒否される | ✅ `card not found` |
| 9 | 現在価格（`current_prices`）が最新の観測値を正しく反映する | ✅ 複数回登録後、常に最新の`observed_at`の価格が反映されることを確認 |
| 10 | バックアップ取得・別環境への復元確認 | ⏳ 未実施（Supabase CLIのセットアップが必要なため後日実施予定） |

テストに使用したデータ: `card_sets`に1件（テストパック／TEST01）、`cards`に1件（テストリーリエ／001/001／SR）、`price_observations`に数件（動作確認のための正常系・重複系データ）。

---

## 3. 未実施・今後の予定

- 受け入れ項目⑩（バックアップ取得・復元テスト）は未実施です。Supabase CLIのインストールが必要なため、別途スケジュールして実施します
- テストデータ（テストパック／テストリーリエ）は開発確認用であり、Phase 2以降で実データに置き換える、または削除する予定です

---

## 4. 確認したいこと

上記の実装・テスト結果について、設計v4およびこれまでのレビュー指摘（5つの必須修正＋公開ビュー権限方式の修正）が正しく反映されているか、Codexの確認をお願いしたいです。特に、実際のテスト結果（②の権限拒否、⑤の未ログイン拒否、⑦の重複防止、⑨の現在価格同期）が期待通りであることは、りょていさん自身の操作で実機検証済みです。

問題なければ、Phase 2（検索ページ・カード詳細ページの読み取り専用MVP実装）に進む予定です。
