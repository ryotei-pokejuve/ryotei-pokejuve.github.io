# Phase 2 実施報告 v2（CODEXレビュー対応）

`phase2_report.md`へのレビューで指摘された全項目を修正した。対象: `search.html`／`card.html`／`market.js`／`restore_runbook.md`。新規SQL: `phase2_patch.sql`（本番へ未適用・要実行）。

---

## 1. 最重要: 画像URLのXSS対策（修正済み）

指摘の通り、`search.html`で`card.image_url`を文字列結合で`innerHTML`に入れていた（報告書の記述と実装が不一致だった点はお詫びします）。

- `search.html`の結果一覧を、文字列結合＋`innerHTML`から**DOM API（`createElement`／`textContent`／`setAttribute`相当のプロパティ代入）による組み立てに全面変更**。カード名・番号・レアリティ・パック名はすべて`textContent`で設定するため、値に何が入っていてもHTMLとして解釈されない
- 画像URLは`market.js`に追加した`MARKET.sanitizeImageUrl()`を必ず通す。`new URL()`でパースし、`https:`以外のプロトコル（`javascript:`等）は`null`を返してプレースホルダー表示にフォールバック
- `card.html`（元々プロパティ代入で相対的に安全だった側）にも同じ`sanitizeImageUrl()`を適用し、両画面で検証ロジックを共通化

---

## 2. Phase 2で修正が必要な点（すべて対応）

| # | 指摘 | 対応 |
|---|---|---|
| 1 | CDNのバージョンが`@2`固定で未確定、SRI未設定 | `@2.112.3`（現時点の最新2.x）に固定し、`integrity`（SHA-256、jsdelivr提供のハッシュ）と`crossorigin="anonymous"`を設定。あわせて`Content-Security-Policy`メタタグを追加（`script-src`をjsdelivrと自身のみに限定、`connect-src`をSupabaseプロジェクトのみに限定）。既存の構造上インラインスクリプトを使っているため`script-src`に`'unsafe-inline'`を含めており、完全な効果ではない点は申し添える |
| 2 | 検索リクエストの競合（古い応答が新しい応答を上書き） | `search.html`にリクエスト連番（`searchSeq`）を導入。応答が来た時点で最新の連番と一致しない場合は結果を破棄。検索中は検索ボタン・ページ送りボタンを無効化 |
| 3 | `Promise.all`で価格履歴の失敗がカード詳細全体を巻き込む | `card.html`を`MARKET.getCard()`→成功したら表示→そのあと`MARKET.getPriceHistory()`を別途実行、に分離。履歴取得のみ失敗した場合は「価格履歴を取得できませんでした。」を履歴欄にだけ表示し、カード詳細本体は表示されたまま |
| 4 | 検索失敗時に古い結果が残る | エラー時に結果一覧・ページ情報を空にし、ページ送りボタンを無効化。「もう一度試す」ボタンを追加 |
| 5 | パック絞り込み未実装 | `phase2_patch.sql`で`api.list_card_sets()`（パック一覧の公開読み取り関数）を追加。`market.js`に`listCardSets()`、`search.html`にパック選択のセレクトボックスを追加し、`search_cards`の`p_set_id`に接続 |
| 6 | `maximum-scale=1`がピンチズームを妨げる | `search.html`／`card.html`両方のviewportから削除 |
| 7 | 検索状態にスクロール位置が含まれない | 検索結果一覧クリック時に`window.scrollY`を`sessionStorage`の検索状態へ保存し、検索ページへ戻った直後（初回読み込み時のみ）に復元する処理を追加 |

---

## 3. 本番への適用が必要な作業

`phase2_patch.sql`はまだ本番プロジェクトへ未適用。以下の手順で反映が必要:

1. 本番プロジェクトのSQL Editorで`phase2_patch.sql`を実行
2. Settings → Data API → Exposed functions で`api.list_card_sets`が有効になっていることを確認
3. `search.html`を開き、パックの絞り込みセレクトボックスに選択肢が表示されることを確認

---

## 4. 復元手順書（restore_runbook.md）の改善（すべて対応）

| # | 指摘 | 対応 |
|---|---|---|
| 1 | `admin_users`データを手作業で除外している | `pg_dump`のデータ取得コマンドに`--exclude-table-data=public.admin_users`を追加し、最初から除外するよう変更 |
| 2 | `.bat`内で`PGPASSWORD`がシェルに残る | すべての`.bat`例を`setlocal`／`endlocal`で囲むよう変更 |
| 3 | Storage移行時のバックアップ手順が未記載 | 「将来メモ」として、Supabase Storage導入時にファイル本体のバックアップ・復元手順を追加する旨を明記 |
| 4 | Session poolerの接続情報がDirect connectionと異なる可能性 | 冒頭に、接続方式によりホスト名・ポート・ユーザー名が異なるため、ダッシュボード表示の値をそのまま使う旨の注意書きを追加 |

---

## 5. 確認したいこと

画像URLのXSS対策を含む全指摘事項を修正した。`phase2_patch.sql`の本番適用は依頼者（りょてい氏）側での作業となるため、適用・動作確認後にあらためて報告する。コードレベルでの修正内容についてご確認をお願いしたい。
