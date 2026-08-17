# Phase 1 セットアップ手順・受け入れテスト

対象プロジェクト: `https://idnhamxtwxfcxflenxko.supabase.co`

`phase1_schema.sql` を実行したあとの手順です。SQLファイル自体の内容は設計ドキュメント`card-market-design-v4.md`にもとづいています。

---

## 1. SQLを実行する

1. Supabaseダッシュボード → 左メニュー「SQL Editor」を開く
2. 「New query」で新規タブを作成
3. `phase1_schema.sql`の中身を全部貼り付けて「Run」
4. エラーが出た場合は、エラーメッセージをそのまま教えてください（作成したSQLを修正します）

---

## 2. `api`スキーマをREST APIに公開する（必須・SQLでは自動化できません）

これを忘れると、作成した`api.search_cards`等の関数がすべて「見つからない」扱いになります。

1. ダッシュボード → 「Settings」→「API」を開く
2. 「Exposed schemas」という項目に `api` を追加して保存（デフォルトでは`public`と`graphql_public`だけが公開されています）

---

## 3. 自分用の管理者アカウントを作る

これは「サイトの管理画面(admin.html)」用のアカウントです。Supabaseダッシュボードにログインする自分のアカウントとは別物として作ります。

1. ダッシュボード → 「Authentication」→「Users」→「Add user」
2. メールアドレスとパスワードを設定して作成（今の時点ではメールアドレスは実在するものでなくても、確認自体をスキップして作成できます。「Auto Confirm User」的なチェックを入れてください）
3. 作成されたユーザーの一覧に表示される **UUID** をコピーする
4. SQL Editorで以下を実行し、自分を管理者として登録する

```sql
insert into public.admin_users (user_id)
values ('ここに3.でコピーしたUUID');
```

---

## 4. テストの前に：カードを1件登録してみる

まだ管理画面（admin.html）がないため、SQL Editorから直接テストデータを作ります。

```sql
-- パックを1件登録
insert into public.card_sets (name, code, release_date)
values ('テストパック', 'TEST01', '2026-01-01')
returning id;
-- ↑ 返ってきたidを次のカード登録で使う

-- カードを1件登録（set_idは上のidに差し替え）
insert into public.cards (set_id, name, card_number, rarity)
values ('上でコピーしたset_id', 'テストリーリエ', '001/001', 'SR')
returning id;
-- ↑ 返ってきたidを次のテストで使う
```

---

## 5. 受け入れテスト（Codex指摘の10項目）

Supabaseの「SQL Editor」はpostgresの管理者権限で動くため、RLSやAPI権限のテストには使えません。**実際のAPIキーを使ったHTTPリクエスト**で確認する必要があります。以下は`curl`での例です。以下のcurlは説明用です。実行はSupabase CLIやPostmanでも構いません。

以下、`YOUR_ANON_KEY`は今回教えていただいた`sb_publishable_...`のキー、`YOUR_CARD_ID`は4.で作ったカードのidに置き換えてください。

### ① 未認証ユーザーは公開関数だけ成功する

```bash
curl -X POST 'https://idnhamxtwxfcxflenxko.supabase.co/rest/v1/rpc/search_cards' \
  -H "apikey: YOUR_ANON_KEY" \
  -H "Content-Type: application/json" \
  -H "Content-Profile: api" \
  -d '{"p_query": "リーリエ"}'
```

→ 200 OKで、4.で登録したテストカードが返ってくればOK。

### ② 未認証ユーザーは実テーブルを直接読めない

```bash
curl 'https://idnhamxtwxfcxflenxko.supabase.co/rest/v1/cards?select=*' \
  -H "apikey: YOUR_ANON_KEY"
```

→ 空配列、または権限エラー（`cards`はスキーマ非公開なので、`public`スキーマの`cards`はそもそも通常のREST APIパスに出てきません。もし何か返ってきた場合は権限設定の見直しが必要なので教えてください）。

### ③ 一般`authenticated`ユーザー（管理者未登録）は管理RPCを実行できない

1. Authentication → Usersで、管理者登録していない「一般ユーザー」をもう1人作る
2. そのユーザーでログインしてアクセストークン（JWT）を取得する（例えばSupabaseのJS клиента`supabase.auth.signInWithPassword(...)`で取得できます。今回は動作確認用なので、`supabase-js`を使った簡単な確認スクリプトを別途用意することもできます）
3. そのJWTを使って`admin_record_price`を呼び、`not authorized`エラーになることを確認する

```bash
curl -X POST 'https://idnhamxtwxfcxflenxko.supabase.co/rest/v1/rpc/admin_record_price' \
  -H "apikey: YOUR_ANON_KEY" \
  -H "Authorization: Bearer 一般ユーザーのJWT" \
  -H "Content-Type: application/json" \
  -H "Content-Profile: api" \
  -d '{"p_card_id": "YOUR_CARD_ID", "p_price": 1000}'
```

→ `not authorized`エラーになればOK。

### ④ `admin_users`登録済みユーザーだけが価格を登録できる

3.で管理者登録したユーザーのJWTで同じリクエストを送る。

```bash
curl -X POST 'https://idnhamxtwxfcxflenxko.supabase.co/rest/v1/rpc/admin_record_price' \
  -H "apikey: YOUR_ANON_KEY" \
  -H "Authorization: Bearer 管理者のJWT" \
  -H "Content-Type: application/json" \
  -H "Content-Profile: api" \
  -d '{"p_card_id": "YOUR_CARD_ID", "p_price": 1000}'
```

→ 価格観測のidが返ってくればOK。SQL Editorで`select * from public.current_prices;`を実行し、`price = 1000`になっていることも確認する。

### ⑤ 重複した価格を登録しても履歴と現在価格が食い違わない

同じ`observed_at`を明示的に指定して同じリクエストをもう一度送る（例えば`p_observed_at`を固定値にして2回叩く）。2回目は`null`が返ってくる（重複でINSERTされなかった）ことを確認し、`current_prices`の値が変わっていないことを確認する。

### ⑥ 過去の観測日時のデータを後から登録しても現在価格が戻らない

現在価格を1000円で登録した後、`p_observed_at`を「1週間前」に指定して500円を登録してみる。`current_prices`が1000円のままであることを確認する（`sync_current_price`のWHERE条件が効いていればOK）。

### ⑦ 販売／買取、状態区分ごとに現在価格が分離される

`p_price_type: "buy"`で別の価格を登録し、`current_prices`に`(card_id, 'sell', 'default')`と`(card_id, 'buy', 'default')`の2行が別々にできることを確認する。

### ⑧ 不正な価格・未来日時・存在しないカードIDが拒否される

- `p_price: -100` → エラーになることを確認
- `p_observed_at`を1年後の日付にする → エラーになることを確認
- `p_card_id`にランダムなUUIDを指定する → `card not found`になることを確認

### ⑨ `anon`／`authenticated`／管理者それぞれの実権限をJWTで確認する

上記①〜⑧を一通り実施すれば、実質的にこの項目もカバーされます。

### ⑩ バックアップを取得し、別環境へ復元できることを確認する

Supabase無料プランには自動バックアップがないため、手動でのバックアップ運用が必要です。

```bash
# Supabase CLIのインストールが必要です（未導入なら別途ご案内します）
supabase login
supabase db dump --db-url "postgresql://postgres:[DBパスワード]@db.idnhamxtwxfcxflenxko.supabase.co:5432/postgres" -f backup.sql
```

取得した`backup.sql`を、別の空のSupabaseプロジェクト（無料でもう1つ作成可能）に対して`psql`等で流し込み、復元できることを確認します。この手順は今すぐでなくても構いませんが、Phase 1完了の条件として一度は実施をお願いします。

---

## 6. すべて確認できたら

上記①〜⑩が確認できれば、設計ドキュメントで定義したPhase 1は完了です。教えていただければ、Phase 2（検索ページ・詳細ページの実装）に進みます。途中でエラーが出た場合や、curlでのテストが難しい場合は、簡単な確認用スクリプト（Node.jsやブラウザのコンソールから叩けるもの）を別途用意しますので、お知らせください。
