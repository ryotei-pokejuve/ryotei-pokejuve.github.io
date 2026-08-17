# Phase 4 実施報告（管理画面）

Phase 2完了を受け、カード・価格の登録用管理画面（`admin.html`）を実装した。

対象ファイル: `admin.html`／`admin.js`／`supabase/phase4_patch.sql`

---

## 1. 全体構成

- `admin.html`はサイトのメニュー（`index.html`／`lain.html`）には**表示していない**。URLを直接知っている場合のみアクセス可能（依頼者の判断）
- ログイン（Supabase Auth）→ カード検索・編集フォーム・価格登録フォームという構成
- 一般公開の`market.js`（読み取り専用）とは別に、管理者専用の処理を`admin.js`に分離（`market.js`には管理者操作を含めないという既存の方針を維持）
- 実際の権限チェックはすべてDB側（`is_admin()`）で行われる。`admin.html`を開けること自体、ログインできること自体はセキュリティ境界ではなく、UI上の都合に過ぎない

---

## 2. 新規追加したDBオブジェクト（`phase4_patch.sql`）

公開APIの`api.get_card`／`api.search_cards`は`set_id`（パックのUUID）や`image_source_note`を返さないため、編集フォームの初期値取得に使えない。管理者専用の読み取り関数を追加した。

```
api.admin_get_card(p_card_id uuid) returns table(id, set_id, name, card_number, rarity, variant, image_url, image_source_note)
```

- `security definer` / `search_path = ''`
- 内部で`is_admin()`を確認し、管理者以外は`not authorized`で拒否
- `revoke ... from public` の上で `grant execute ... to authenticated` のみ（`anon`には付与しない）

Data API側でも`Exposed functions`に追加し、公開状態を確認済み。

---

## 3. XSS・入力値対策（Phase 2で確立した方針を踏襲）

- カード検索結果一覧はDOM API（`textContent`）で組み立て（Phase 2と同じ）
- 画像URLは`market.js`の`sanitizeImageUrl()`を管理画面のプレビュー表示にも使用（https以外を拒否）
- CDN（supabase-js）はバージョン固定＋SRI＋`crossorigin`、CSPメタタグも同様に設定

---

## 4. 動作確認結果（依頼者が実ブラウザで確認）

| # | 項目 | 結果 |
|---|---|---|
| 1 | 管理者未登録アカウントでログインした場合、`admin_get_card`が`not authorized`で拒否される | ✅（意図的にテスト用非管理者アカウントで確認。DB側の権限チェックが機能していることを確認できた） |
| 2 | 管理者登録済みアカウントでログインし、既存カードを「編集」→ フォームに既存値が正しく読み込まれる | ✅ |
| 3 | 内容を変更して更新 → 保存成功 | ✅ |
| 4 | 価格登録フォームから新しい価格を登録 → 成功 | ✅ |
| 5 | 新規カードとして登録 → 成功 | ✅ |

---

## 5. 確認したいこと

管理画面の実装・動作確認が完了した。設計・実装内容についてご確認をお願いしたい。
