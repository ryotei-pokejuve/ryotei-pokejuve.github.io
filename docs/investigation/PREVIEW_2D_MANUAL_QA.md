# preview-2d 手動QAチェックリスト

対象: `preview-2d.html`  
目的: NIGHT_GOAL「Claudeレビュー必須項目」の17項目を、実機ブラウザで再現可能な形で記録する。  
判定欄: `未実施 / PASS / FAIL / N/A`。FAIL時は環境、再現手順、期待結果、実際結果、スクリーンショットまたはConsoleログを記録する。

## 実施情報

- 実施日: 2026-08-24
- 実施者: Codex
- Git commit: `24e05f4`（TASK-007検証時HEAD。commitは作成していない）
- OS / ブラウザ / バージョン: Windows / TASK-007では操作可能なブラウザがセッションに公開されず、実ブラウザ追加検証は未実施。既存のChrome 151による320〜430px記録は維持
- 起動方法・URL: `python -m http.server 8765 --bind 127.0.0.1` / `http://127.0.0.1:8765/preview-2d.html`
- Console error件数: 未計測（操作可能なブラウザが利用できないため）。JavaScript構文検査とNode回帰テストは全件PASS

## 画面サイズ別マトリクス

各幅で、ページ初期表示、全メニュー選択、MESSAGE、広告枠、Theme切替まで確認する。高さは実機相当とし、ズーム100%を基本とする。

| Viewport | 横スクロールなし | 文字が判読可能 | 操作領域44px目安 | MENU / CONTENT | MESSAGE | 広告枠 | Theme | 判定・備考 |
|---|---|---|---|---|---|---|---|---|
| 320px | PASS | PASS | PASS | PASS | PASS | PASS | PASS | Chrome実レンダリングを目視確認。`innerWidth = clientWidth = scrollWidth = 320`。全11項目が1行表示で、`CARD VIDEOS` / `ACHIEVEMENTS` / `CARD MARKET`を含め折返し・はみ出しなし。MENU行48px、Theme 44px。 |
| 375px | PASS | PASS | PASS | PASS | PASS | PASS | PASS | Chrome実レンダリングを目視確認。`innerWidth = clientWidth = scrollWidth = 375`。全11項目が1行表示で、長い英字ラベルの折返し・はみ出しなし。MENU行48px、Theme 44px。 |
| 390px | PASS | PASS | PASS | PASS | PASS | PASS | PASS | Chrome実レンダリングを目視確認。`innerWidth = clientWidth = scrollWidth = 390`。全11項目が1行表示で、長い英字ラベルの折返し・はみ出しなし。MENU行48px、Theme 44px。 |
| 430px | PASS | PASS | PASS | PASS | PASS | PASS | PASS | Chrome実レンダリングを目視確認。`innerWidth = clientWidth = scrollWidth = 430`。全11項目が1行表示で、長い英字ラベルの折返し・はみ出しなし。MENU行48px、Theme 44px。 |
| 760px付近 | 未実施 | 未実施 | 静的契約PASS | 未実施 | 未実施 | 静的契約PASS | 未実施 | CSS契約テストで760px以下の2列MENU、通常フローの広告枠、44px以上の操作領域を確認。実レンダリングは要追試。 |
| Desktop（例: 1440×900） | 未実施 | 未実施 | 静的契約PASS | 未実施 | 未実施 | 静的契約PASS | 未実施 | CSS契約テストでDesktopの操作領域と広告予約高を確認。実レンダリングは要追試。 |

画面幅別の追加実測: 320 / 375 / 390 / 430pxの各幅で`.menu-list`は2列、各ラベルの要素高と算出`line-height`は同一（1行）で、各ラベルの`scrollWidth > clientWidth`はすべて`false`だった。Themeボタンを各幅でクリックし、`data-theme`、表示ラベル、`aria-pressed`が同期して反転することも確認した。CSS変更は不要と判断した。

## 操作回帰

| # | 観点 | 手順と期待結果 | 判定 | 記録 |
|---|---|---|---|---|
| 1 | Mouse | 各MENUをクリックすると選択表示、CONTENT、MESSAGEが同じ項目へ更新される。CARD MARKETはプレビュー更新後に`search.html`へ進む | 未実施 | |
| 2 | Touch | 320〜430pxのタッチ環境で各項目をタップでき、誤反応や二重遷移がない。CARD MARKETもMouse/Keyboardと同じ遷移になる | 未実施 | |
| 3 | Keyboard | MENU上で↑↓←→により循環選択でき、選択表示、CONTENT、MESSAGE、フォーカスが同期する | 未実施 | |
| 4 | Enter | CARD MARKET選択中のEnterで、MESSAGEが外部リンクの説明になった後`search.html`へ進む | 未実施 | |
| 5 | Tab | Tab / Shift+Tabの標準順序が維持され、Skip link、Theme、MENU項目、CONTENT内リンクへ到達できる。Tabを押してもゲームカーソルが勝手に移動しない | 未実施 | |
| 6 | Esc | CONTENT表示中にEscを押すとMENU画面へ戻り、MENUコンテナへフォーカスし、古いCONTENTと選択状態を残さない | 未実施 | |
| 7 | cursor state | 項目を選択→Esc→方向キーの順で操作し、Esc前の位置を基準に選択が再開する。CONTENT表示中に別MENUを直接クリックしても位置が一致する | 未実施 | |
| 8 | 編集要素との競合 | CONTENT内のinput / textarea / select / contenteditableで方向キー、Enter、Escを操作してもサイト側選択が変わらず、既定入力操作を妨げない | 未実施 | |
| 9 | keydown一元化 | DevTools/Event Listenersまたはコード確認で、document直下のkeydownが意図した1リスナーのみである | 未実施 | |

## UI・品質レビュー（CODEX FINAL REVIEW対応）

| # | レビュー観点 | 合格基準 | 判定 | 記録 |
|---|---|---|---|---|
| 1 | PROJECT.md準拠 | 既存実データを使い、2Dフォールバック、Web操作性、非破壊方針を維持 | 未実施 | |
| 2 | Claude Design準拠 | P1二重縁、P2三段、P3非色依存選択、P4限定分類色、P6複数入力を確認 | 未実施 | |
| 3 | 前回正常機能の回帰 | 全MENUと既存リンクが表示・動作し、`index.html`等の本番ページに変更がない | 未実施 | |
| 4 | JavaScriptエラー | 初期表示と全操作後にConsoleの未処理errorが0件 | 未実施 | |
| 5 | Mouse | 「操作回帰 #1」をPASS | 未実施 | |
| 6 | Touch | 「操作回帰 #2」をPASS | 未実施 | |
| 7 | Keyboard | 「操作回帰 #3〜4」をPASS | 未実施 | |
| 8 | Tab標準操作 | 「操作回帰 #5」をPASSし、フォーカス表示が視認可能 | 未実施 | |
| 9 | Esc | 「操作回帰 #6」をPASS | 未実施 | |
| 10 | cursor state | 「操作回帰 #7」をPASS | 未実施 | |
| 11 | responsive | レイアウト切替で重なり・欠落・意図しない固定オーバーレイがない | 未実施 | |
| 12 | 320〜430px | 画面サイズ別マトリクス4幅をすべてPASS | 未実施 | |
| 13 | Desktop | Desktop行をPASSし、過大な空白や読みにくい行長がない | 未実施 | |
| 14 | MESSAGE | 選択対象の説明が即時に同期し、操作ヒントが実際の操作と一致 | 未実施 | |
| 15 | CONTENT | 各画面が実コンテンツまたは正直な空状態を示し、架空の本番データがない | 未実施 | |
| 16 | Theme | DARK/LIGHTが即時反映され、ラベルと`aria-pressed`が同期し、再読込後もlocalStorageから復元 | 未実施 | |
| 17 | prefers-reduced-motion | OS設定をReduceにして不要な動きが停止し、情報や操作が失われない | 未実施 | |
| 18 | 広告枠 | MESSAGE直下に予約領域とADVERTISEMENT表示があり、操作UIと誤認せず、幅変更時もCLSや遮蔽を起こさない | 未実施 | |
| 19 | SEOへの悪影響 | previewは`noindex,nofollow`であり、本番SEOファイル・既存URL・重要HTMLを変更していない | 未実施 | |
| 20 | Accessibility | semantic要素、見出し、ラベル、aria-live、選択状態、コントラスト、Keyboard/Mouse/Touchを確認 | 未実施 | |
| 21 | Performance | 2D表示で3D/WebGL/Three.jsを読み込まず、操作中に長時間タスクや著しいレイアウトシフトがない | 未実施 | |
| 22 | 第三者素材 | 特定ゲームの画像・キャラクター・ロゴ・フォント・音・テクスチャ等を直接使用していない | 未実施 | |
| 23 | 将来3D MODE | content/state/navigationを2D固有データとして重複させず、今回3D実装や大型依存を追加していない | 未実施 | |
| 24 | index.html非変更 | `git diff -- index.html lain.html content.js`が空である | 未実施 | |

注: NIGHT_GOALの「Claudeレビュー必須項目」は17項目である。このうち「NIGHT_GOAL.md準拠」「A案80% + B案20%方針との整合」「2D MODEとして十分なゲーム感」「Webサイトとしての可読性・利便性」は個別行を設けず、表全体の目視レビューで確認する。表には入力方式・画面幅などを分けた確認単位に加え、Performance、cursor state、index.html非変更などPROJECT.mdの一般要件および内部QA観点も含むため、全24行となる。

## 自動回帰テスト

TASK-007実行結果（2026-08-24、HEAD `24e05f4`）:

```text
node --check assets/js/preview-2d.js          PASS
node --check content.js                       PASS
node tests/preview-2d-content.test.js         PASS
node tests/preview-2d-responsive.test.js      PASS
node tests/preview-2d-selection.test.js       PASS
node tests/preview-2d-theme-bootstrap.test.js PASS
git diff --exit-code -- index.html lain.html content.js  PASS（差分なし）
```

自動テストは実コンテンツ契約、レスポンシブCSS契約、arrow選択、focus+click二重mount防止、Esc、cursor復帰、Mouse/Touch由来click、CARD MARKET遷移、Tab非捕捉、Theme/localStorage、編集要素のkeydown除外、reduced-motion時の文字送り停止を検証した。実ブラウザでのみ確定できるDesktop/760pxの見た目、実Tab順、実タッチ、Console、フォーカスリングの視認性は未実施のため、Claudeまたは人間のブラウザ再確認へ引き継ぐ。

## 最終判定

- 総合判定: **NEEDS_CLAUDE_REVIEW / CLAUDE_REVIEW_PENDING**
- Blocker / Critical: なし（自動検査範囲）
- Major: なし（自動検査範囲）
- Minor: 操作可能なブラウザがセッションに公開されず、Desktop、760px付近、実Mouse/Touch/Keyboard/Tab、Console、focus-visible、OS設定によるreduced-motionの実ブラウザ確認が未実施
- 次の確認者への引き継ぎ: 操作可能なブラウザで未実施項目を追試する。主観的なClaude Design最終一致もClaudeレビュー待ち。TASK-007ではpreviewコードの修正は不要と判断し、commitは作成していない
