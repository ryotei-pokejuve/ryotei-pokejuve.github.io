# preview-2d 3D拡張可能性チェックリスト

作成日: 2026-08-24

対象: `preview-2d.html` / `assets/js/preview-2d.js`

目的: PROJECT.md 第13・29章、および承認済みDesign仕様 `docs/design/2d/IMPLEMENTATION.md` 第9章に対し、Phase 5で3D rendererを追加する前に必要な構造整理を明文化する。

## 1. 結論

現行プレビューは、実コンテンツを `window.SITE.PAGES` / `PAGE_ORDER` から参照しており、2D専用のコンテンツ複製や3Dライブラリの先行読込はない。この点は将来拡張に適合している。

一方、`assets/js/preview-2d.js` は単一IIFE内で、データ適応、状態更新、キーボード制御、DOM描画、フォーカス移動、テーマ永続化を直接結合している。現在の `state` も3D rendererがそのまま購読できる公開・共通状態ではない。したがって、**2D完成候補としては維持可能だが、現状のまま3D rendererを追加すると状態・操作ロジックの複製が発生する**。

Phase 5着手前に、次の3層へ段階的に切り出す必要がある。

```text
content.js / content adapter
          ↓
common state + navigation + actions
          ↓
   2D renderer     3D renderer (lazy)
```

本書は将来変更のチェックリストであり、今回のTASKではコードを変更しない。`index.html` への統合、3D実装、依存追加も行わない。

## 2. 現状の適合点

- [x] コンテンツの正本は既存 `content.js` の `window.SITE.PAGES` / `PAGE_ORDER` であり、2D用コピーを作っていない。
- [x] カード相場は既存 `search.html` への通常リンクであり、検索・価格ロジックを複製していない。
- [x] `state` にDOMノードや色値は格納していない。
- [x] テーマ色はCSS Custom Properties側にあり、JSは `light` / `dark` の識別子だけを扱う。
- [x] キーボード入力はdocument上の単一 `keydown` listenerへ集約されている。
- [x] メッセージ本文の元は `deriveMessage(item)` で選択対象から導出している。
- [x] 2D表示時にThree.js、WebGL、3D用アセットを読み込んでいない。
- [x] 3D未実装でも2Dだけで実コンテンツ閲覧、テーマ、Mouse / Touch / Keyboard操作が成立する。

## 3. 現状の結合とギャップ

| 領域 | 現状 | 3D追加時の問題 | 判定 |
|---|---|---|---|
| content adapter | `menu` の組み立てがIIFEの初期化処理内にある | 3D側でも同じ変換を再実装しやすい | 要切り出し |
| common state | `{ theme, screen, cursor, message }` はIIFE内の可変オブジェクト | rendererから購読できず、更新通知もない | 要切り出し |
| view state | `view` がなく、表示は常に2D | `?view=3d` とrenderer選択を表現できない | 未実装 |
| cursor | 単一数値で、画面別の保持構造ではない | 画面追加時やrenderer切替時の位置復元が曖昧 | 要拡張 |
| actions | `select()` がcursor計算とDOM・focus・message更新を同時実行 | 3D側から再利用すると2D DOMを必須にする | 要分離 |
| navigation | `activate()` は外部ページへの `location.href` のみ | route、query、戻る/進む、再読込復元を共有できない | 未実装 |
| renderer | `renderDetail()` / `resetToMenu()` が固定DOM IDへ直接書き込む | 2D/3D rendererの差し替え境界がない | 要分離 |
| message | `deriveMessage()` は導出関数だが、`setMessage()` はstate更新・DOM更新・文字送りを兼務 | 共通messageと2D演出を分けて利用できない | 要分離 |
| theme | `setTheme()` がstate、DOM、ARIA、localStorageを一括更新 | 共通設定と各rendererの表示同期が結合する | 要分離 |
| content lifecycle | `renderDetail()` が `page.html()` と `page.onMount()` を直接呼ぶ | renderer切替時のmount/unmount責務や副作用管理がない | 要設計 |
| input | `handleKeydown()` が直接 `select()` / `resetToMenu()` を呼ぶ | 入力を共通actionとして別rendererへ渡せない | 要分離 |
| lazy loading | 3D entry point、dynamic `import()`、失敗時fallbackがない | 3Dロード失敗時の2D継続を保証できない | 未実装 |

`docs/investigation/2D_FINAL_DESIGN_REVIEW.md` ではstateの形が将来共有の土台になる点を確認済みだが、これは概念上の拡張余地を示すものである。現在のIIFEローカルstateとDOM直結actionは、まだ共有アーキテクチャそのものではない。

## 4. 3D着手前の必須チェックリスト

### 4.1 Content / data

- [ ] `window.SITE` からrenderer非依存のmenu entityを作るadapterを1か所にする。
- [ ] entityは安定した `id`、表示名、種別、遷移先、既存page参照を持ち、DOMノードやCSS classを持たない。
- [ ] 2D/3Dの双方が同じentity配列または読取APIを利用し、コンテンツをコピーしない。
- [ ] `page.html()` / `page.onMount()` の既存契約をadapterまたはcontent host境界に隔離する。

### 4.2 Common state / actions

- [ ] stateをIIFEの2D rendererから独立させ、最低限 `{ theme, view, screen, cursor, message }` を持たせる。
- [ ] `cursor` は画面キー別（例: `{ menu: 0, content: 0, settings: 0 }`）に保持する。
- [ ] `getState()` と更新通知（subscribe等）を用意し、rendererがstateを直接書き換えない。
- [ ] `select(index)` は巡回計算とstate更新だけを行い、DOM、focus、文字送りを操作しない。
- [ ] `move(delta)`、`enter()`、`back()`、`setTheme(theme)`、`setView(view)` を共通actionとして定義する。
- [ ] messageの内容はstateと選択entityから純粋に導出し、文字送りはrenderer側の演出にする。
- [ ] action単体をDOMなしでテストできるようにする。

### 4.3 Navigation / URL

- [ ] URLの既存ハッシュ・通常ページ契約を維持するroute adapterを定義する。
- [ ] `?view=2d|3d` を解釈し、未知値・3D未対応・ロード失敗時は2Dへ安全にフォールバックする。
- [ ] view切替では現在のroute、screen、cursorを維持し、コンテンツ選択を初期化しない。
- [ ] query更新時に既存query/hashを失わない。
- [ ] 初期読込、リロード、`popstate` でstateをURLから復元する。
- [ ] 外部ページ遷移は共通navigation actionにまとめ、rendererが `location.href` を直接変更しない。

### 4.4 Renderer境界

- [ ] 2D rendererを `mount(root, services)` / `render(state)` / `unmount()` 相当の境界へ整理する。
- [ ] `renderDetail()` のDOM更新と、選択対象・表示モデルの計算を分離する。
- [ ] `resetToMenu()` のstate遷移と、2D DOM初期化・focus移動を分離する。
- [ ] ARIA、focus、文字送りtimer、event listenerは2D rendererのmount/unmountで確実に開始・停止する。
- [ ] `page.onMount()` の重複実行と、renderer切替後に残る非同期処理を防ぐcleanup方針を決める。
- [ ] 常設メッセージ窓は共有shellまたは両renderer共通componentとし、3D canvas/WebGL内だけに置かない。
- [ ] 重要コンテンツは通常HTMLに残し、3D表現のみへ閉じ込めない。

### 4.5 3D lazy loader / fallback

- [ ] 3D rendererはユーザーが `view=3d` を選んだ時だけdynamic import等で読み込む。
- [ ] 2D初期表示のbundle/requestsに3Dライブラリや大型アセットを含めない。
- [ ] 読込中、読込失敗、WebGL非対応、context lossの状態を定義する。
- [ ] 失敗時は同じroute・cursorの2D表示へ戻し、操作可能なメッセージを表示する。
- [ ] renderer切替でdocument-level listener、animation frame、observer、timerを重複させない。
- [ ] `prefers-reduced-motion` とサイト設定を3D transitionにも適用する。

## 5. 推奨する最小分離単位

ファイル名はPhase 5実装時に既存構成へ合わせて決定するが、責務は最低限次の単位に分ける。

| 単位 | 主な責務 | 現行から移す対象 |
|---|---|---|
| content adapter | `PAGES` / `PAGE_ORDER` を共通entityへ変換 | `menu` 構築、`pageHtml()`、必要に応じて`plainSummary()` |
| state store | state保持、購読、renderer非依存action | `state`、`select()` のcursor計算、screen遷移、theme/view値 |
| navigation | URL解析・同期、履歴、通常遷移 | `activate()` の遷移部分、将来の`popstate` / `?view=` |
| shared input | キーを共通actionへ変換 | `isEditing()`、`handleKeydown()` のキー判定 |
| 2D renderer | DOM、ARIA、focus、2D message演出 | DOM参照、`renderDetail()`、選択class/属性更新、timer |
| renderer loader | viewに応じたmount/unmountと3D遅延読込 | 新規。失敗時は2Dへ戻す |

大規模なフレームワーク移行は不要である。ブラウザ標準のES modulesまたは現行構成に合う小さな名前空間でも、この境界は実現できる。

## 6. 実施順と安全境界

1. 現行2Dの自動・手動回帰を固定する。
2. content adapterと純粋なstate/actionを切り出し、既存2D rendererをその利用側へ変更する。
3. URL adapterと `view` を追加する。ただし3D rendererがない間はUI上で3Dを有効化しない。
4. 2D rendererのmount/unmountと副作用cleanupを確立する。
5. 小さな3D placeholder rendererで同一state・route・cursorの継続を検証する。
6. その後にだけ本格3D rendererを遅延ロードで追加する。

各段階で2Dの完全動作を維持する。共有化のために `content.js`、検索、カード詳細、管理機能、既存URLの仕様を変更しない。3D都合で2D rendererへWebGL依存や3D固有stateを持ち込まない。

## 7. Phase 5開始ゲート

次をすべて満たした時点で、3D renderer実装へ進める。

- [ ] common state/actionがDOMなしのテストで通る。
- [ ] 2D rendererが共通stateを購読し、現行のMouse / Touch / Keyboard / Tab / Esc / Enter動作を維持する。
- [ ] route直接アクセス、リロード、戻る、進む、view切替で選択状態が維持される。
- [ ] 2Dだけの初期表示では3Dコード・アセットを要求しない。
- [ ] 3Dロード失敗を模擬しても2Dへ復帰できる。
- [ ] Dark / Light、320〜430px、Desktop、`prefers-reduced-motion` の既存回帰がない。
- [ ] メッセージ窓、広告予約枠、semantic HTML、SEO対象本文が3D切替後も利用可能である。
- [ ] 2D/3D間でcontent、navigation、state更新ロジックのコピーがない。

## 8. 今回の判定

**3D readiness: PARTIAL / REFACTOR BEFORE PHASE 5**

データ正本の共有、2Dフォールバック、3D非読込という基礎条件は満たす。未達はrenderer非依存state/action、URL上のview、renderer lifecycle、lazy-load fallbackである。これらは現行2D最終候補の採否を妨げる重大問題ではなく、3D実装開始前に解消すべき構造課題として扱う。
