# TASK-002 PUSH STARTゲート DOM / ARIA設計

## 目的と変更境界

本書は、後続のPUSH START実装で `index.html` に追加する最小DOMとCSSクラスの契約を定める。TASK-002では設計だけを確定し、`index.html`、CSS、JavaScript、既存テストは変更しない。

承認済み2D Design正本 `docs/design/2d/IMPLEMENTATION.md` の既存トークンと `.win2` の表現を再利用する。新しい色トークン、メニュー配置変更、320px overflow修正、warp演出変更は本設計の対象外とする。

## 配置

`index.html` の `<body>` 直下で、既存の `#warp-entry-overlay` の直後、skip linkと `.terminal-shell` の前に置く。

- `.terminal-shell` のgridや幅計算へ参加させず、既存レイアウトと320px時の横幅に影響させない。
- warp-entryと同じbody直下のオーバーレイ層に置き、両者の表示判断はDOM順ではなく後続JavaScriptで排他的に行う。
- `sessionStorage['ryotei-warp-entry'] === '1'` の場合はgateを表示せず、既存warp-entry演出を優先する。この判定契約は後続の挙動実装で保証する。

## 採用するHTML断片

```html
<div
  id="push-start-gate"
  class="push-start-gate"
  role="dialog"
  aria-modal="true"
  aria-labelledby="push-start-title"
  aria-hidden="true"
  hidden
>
  <div class="push-start-panel win2">
    <h2 id="push-start-title" class="push-start-title">RYOTEI INFORMATION TERMINAL</h2>
    <button id="push-start-button" class="push-start-button" type="button">
      PUSH START
    </button>
  </div>
</div>
```

### DOM / ARIA契約

- `#push-start-gate` は既存テストが識別する一意の要素とし、`role="dialog"`、`aria-modal="true"`、`aria-labelledby="push-start-title"` を固定する。
- ラベル参照先は実在する `#push-start-title` とする。既存の唯一の`h1`を増やさず、dialog内見出しは`h2`とする。
- 初期マークアップは `hidden` と `aria-hidden="true"` を併記し、JavaScriptが表示条件を確認する前にgateが露出することを防ぐ。表示時は両方を解除し、非表示時は両方を戻す。
- 操作対象は `type="button"` のnative button一つだけとする。リンクやクリック可能な非button要素は追加しない。
- 装飾要素は増やさず、読み上げ名を「RYOTEI INFORMATION TERMINAL」、操作名を「PUSH START」とする。

## CSSクラス契約

後続実装で追加できるselectorは次の3クラスを基本とする。

| クラス | 責務 |
|---|---|
| `.push-start-gate` | viewport全体を覆う固定配置、背景、中央寄せ、背後へのpointer遮断を担当する |
| `.push-start-panel` | dialogの視覚的な枠と余白を担当し、既存 `.win2` と既存トークンを再利用する |
| `.push-start-button` | 44px以上の操作領域、既存トークンによる通常・hover・active表示を担当する |

`.push-start-title` は既存の見出しタイポグラフィとの差分が必要な場合だけ使用し、色・フォント・枠・影には `--deep`、`--card`、`--text`、`--dim`、`--accent`、`--accent-ink`、`--edge`、`--bw`、`--ring` 等の既存トークンを使う。固定幅を持たせず、panel幅は `calc(100% - 32px)` 以下に制限する。これにより320px viewportでも横スクロールを発生させない。

## 後続挙動実装への受け入れ契約

本タスクではJavaScriptを実装しないが、後続実装は次を満たすこと。

- warp-entry要求時はgateを開かない。
- gate表示時にbuttonへfocusを移し、Tab / Shift+Tabを唯一のbutton内に留める。
- gate表示中のArrow各キー、Escape、Enter、Space等を背後のMENU、URL、history、アプリ状態へ伝播させない。
- pointer / keyboard / touchのいずれでも解除は一度だけ行い、touchstart直後の合成clickを背後へ着弾させない。
- gateを閉じた後に `aria-hidden="true"` と `hidden` を復元し、rendererの `unmount()` 後にlistenerや副作用を残さない。

## 実装後の検証条件

後続実装では少なくとも以下を確認する。既存assertionの削除・緩和・skipは禁止する。

1. `tests/task-011-production-feature-regression.test.js` がPASSする。
2. `tests/task-012-seo-a11y-advertisement.test.js` がPASSする。
3. PUSH START専用回帰テストでwarp優先、keyboard遮断、focus containment、touchゴーストクリック防止を確認する。
4. 320 / 375 / 390 / 430pxで横スクロールが増えない。
5. `git diff --check` がPASSする。
