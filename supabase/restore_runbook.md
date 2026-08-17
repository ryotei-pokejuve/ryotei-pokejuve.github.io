# バックアップ・復元 手順書

災害復旧（本番プロジェクトが失われた場合）または定期的な復元確認のための手順。Windows環境（PostgreSQLクライアントツール、Dockerなし）を前提とする。

---

## 0. 事前準備（初回のみ）

1. PostgreSQLクライアントツール（`pg_dump`/`psql`）をインストール
   - `winget install -e --id PostgreSQL.PostgreSQL.17`
   - インストーラの「Select Components」で **Command Line Tools のみ** を選択（Server／pgAdmin／Stack Builderは不要）
   - `pg_dump --version` で確認
2. 作業フォルダを用意（Gitリポジトリの外）: `C:\supabase-backup`

---

## 1. バックアップ取得

本番プロジェクトの接続情報（Dashboard → 画面上部「Connect」→ Direct connection または Session pooler のホスト名、DBパスワード）を用意。**接続方式によってホスト名・ポート・ユーザー名の形式が異なる**ため（例: Session poolerは`postgres.<ref>`のようなユーザー名になることがある）、下記は一例として扱い、実際はダッシュボードに表示された値をそのまま使うこと。

```
cd C:\supabase-backup
setlocal
set PGPASSWORD=（本番プロジェクトのDBパスワード）
pg_dump -h db.<本番のプロジェクトref>.supabase.co -p 5432 -U postgres -d postgres --schema=public --schema=api --no-owner --schema-only -f schema.sql
pg_dump -h db.<本番のプロジェクトref>.supabase.co -p 5432 -U postgres -d postgres --schema=public --schema=api --no-owner --data-only --exclude-table-data=public.admin_users -f data.sql
endlocal
```

`setlocal`/`endlocal`で囲むことで、`PGPASSWORD`がこのバッチファイルの実行が終わったあとにコマンドプロンプトの環境変数として残らないようにしている。

**意図的にバックアップ対象外にしているもの**:
- `auth`スキーマ（Supabase管理領域。復元先プロジェクトには自動で用意されるため）
- `admin_users`テーブルのデータ（`--exclude-table-data`で明示的に除外。`auth.users`を参照する外部キーがあり、復元先には元の認証ユーザーが存在しないため。管理者登録は4章の手順で復元先に作り直す）

コマンドは長いため、直接貼り付けると途中で切れることがある。メモ帳で`.bat`ファイルとして保存してから実行すること。**バッチファイルには平文パスワードが残るので、作業後は必ず削除する。**

---

## 2. 復元先の準備

- 災害復旧時: 新しいSupabaseプロジェクトを作成
- 定期確認時: 本番とは別の使い捨て検証用プロジェクトを作成し、確認後に削除する

---

## 3. スキーマ・データの復元

```
cd C:\supabase-backup
setlocal
set PGPASSWORD=（復元先プロジェクトのDBパスワード）
psql -h db.<復元先のプロジェクトref>.supabase.co -p 5432 -U postgres -d postgres -v ON_ERROR_STOP=1 -f schema.sql
psql -h db.<復元先のプロジェクトref>.supabase.co -p 5432 -U postgres -d postgres -v ON_ERROR_STOP=1 -f data.sql
endlocal
```

**既知のつまずきポイント**:

- `schema "public" already exists` エラー: 新規Supabaseプロジェクトには最初から`public`スキーマが存在するため。`schema.sql`内の`CREATE SCHEMA public;`をコメントアウトしてから再実行する。
- `ALTER DEFAULT PRIVILEGES ... permission denied`: `psql`の直接接続では`supabase_admin`向けのデフォルト権限を変更できない。これはSupabaseが新規プロジェクトへ自動で設定済みのため、その部分は無視してよい。`postgres`向けの行（自分たちで追加したもの）のみ、ダッシュボードのSQL Editorで実行する。
- `admin_users`のFK違反（`data.sql`実行時）: 1章の`--exclude-table-data=public.admin_users`を付け忘れた場合に発生する。`auth.users`が復元対象外のため、既存の管理者ユーザーIDは復元先に存在しないことが原因。`data.sql`内の`COPY public.admin_users (...) FROM stdin;`ブロック内のデータ行を削除してから再実行する（管理者登録は4章で作り直す）。

---

## 4. 管理者Authユーザーの作り直し（災害復旧時は必須）

`auth`スキーマは復元対象外のため、管理者ユーザーは復元先で作り直す必要がある。

1. 復元先プロジェクトの Authentication → Users で、管理者用のメールアドレス・パスワードを新規登録
2. 発行されたユーザーUUIDを控える
3. SQL Editorで登録:
   ```sql
   insert into public.admin_users (user_id, role) values ('（新しいUUID）', 'admin');
   ```
4. その管理者アカウントでログインし、`admin_upsert_card`／`admin_record_price`が実行できることを確認する

---

## 5. 復元後のACL（権限）再検証

新規Supabaseプロジェクト側のデフォルト権限設定と`pg_dump`のACL差分計算の組み合わせにより、復元直後は`anon`/`authenticated`にテーブルへの直接権限が残ってしまうことがある（バックアップの中身自体の不備ではなく、既知の環境要因）。**復元のたびに必ず以下を実施する。**

1. 実テーブルの直接権限を強制的に剥奪:
   ```sql
   revoke all on all tables in schema public from anon, authenticated;
   revoke all on all tables in schema api from anon, authenticated;
   ```
2. 生ACLを確認し、`postgres`／`service_role`以外に付与されていないことを確認:
   ```sql
   select relname, relacl
   from pg_class
   where relnamespace = 'public'::regnamespace and relkind = 'r'
   order by relname;
   ```
3. 公開RPC（`api.search_cards`／`api.get_card`／`api.get_price_history`）へのEXECUTE権限が`anon`/`authenticated`に付与されていることを確認:
   ```sql
   select grantee, routine_schema, routine_name, privilege_type
   from information_schema.routine_privileges
   where routine_schema = 'api'
   order by routine_name, grantee;
   ```
4. ダッシュボードの Settings → Data API（または Database → Settings）で、**Exposed schemas に`api`を含める**、**Exposed functions で公開すべき5関数のみが有効になっている**ことを確認
5. `test-phase1.html`の接続先（`SUPABASE_URL`／`SUPABASE_ANON_KEY`）を復元先プロジェクトのものに書き換え、JWTを使った簡易テスト（未認証での検索成功／実テーブル直接アクセス拒否／管理者ログイン後のRPC成功）を実行し、想定通りの結果が返ることを確認する

---

## 6. バックアップファイルの取り扱い

- `schema.sql`／`data.sql`は**公開GitHubリポジトリへコミットしない**（`C:\supabase-backup`はリポジトリの外に置く）
- 接続文字列・DBパスワードを含む`.bat`ファイルは、復元作業後に**必ず削除する**
- カード・価格データ以外に個人情報を保存するようになった場合は、バックアップファイル自体を暗号化して保管する
- 保持期間の目安: 直近3世代程度を残し、古いものは削除
- 取得頻度の目安: 月1回程度、または重要なスキーマ変更（マイグレーション）の直後
- 復元確認（本手順書どおりの一連の作業）は、数か月ごと、または重要なスキーマ変更後に実施する

**将来メモ**: カード画像をSupabase Storageに置くようになった場合、`pg_dump`はStorageのファイル本体をバックアップしない（`storage.objects`のメタデータのみ）。その段階になったら、Storage側のファイル自体の取得・復元手順（Supabase CLIの`supabase storage`系コマンド、または管理画面からの個別ダウンロード）をこの手順書に追加すること。
