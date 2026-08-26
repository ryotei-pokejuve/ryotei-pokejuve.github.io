# RYOTEI SITE 2D MODE 段階的実装計画

作成日: 2026-08-24

対象: TASK-002（計画書のみ。コード変更なし）

## 1. 目的と正本

本書は、既存サイトのコンテンツ・URL・主要機能を維持したまま、承認済み2D Designを段階的に導入するための実装順序と安全境界を定める。

判断の優先順位は次のとおりとする。

1. 依頼本文の `PROJECT.md`（恒久仕様）と `NIGHT_GOAL.md`（RUN 01目標）
2. 承認済みDesign仕様 `docs/design/2d/IMPLEMENTATION.md`
3. TASK-001調査結果 `docs/investigation/SITE_AND_DESIGN_MAP.md`
4. 現行コードと `README.md`

リポジトリ内には `PROJECT.md` / `NIGHT_GOAL.md` 本体がないため、依頼本文で提示された内容を正本として扱う。Designプロトタイプの `NOTA-II`、`SPECIMENS`、`AREAS`、`LOG`、架空の標本・区域・観測記録は本番データとして使用しない。参考画像や第三者ゲーム素材も完成サイトへ流用しない。

## 2. 技術方針

- 現行の素のHTML / CSS / JavaScript構成を踏襲し、フレームワークへ移行しない。
- RUN 01では新規ランタイム依存を追加しない。CSS Custom Properties、DOM API、History API、Web Storage等のブラウザ標準機能で実装する。
- `content.js` をサイトコンテンツ、`market.js` を公開カード相場ロジックの正本として維持する。2D用データを複製しない。
- `admin.html` / `admin.js` とSupabaseの認証・管理RPC・SQLには触れない。公開UI改修を理由に権限境界を変更しない。
- 既存のハッシュURL、`search.html`、`card.html?id=...`、About / Privacy / Terms / Contactの独立URLを維持する。GitHub Pagesでサーバー側rewriteを要するパスルーティングは導入しない。
- 2D rendererを完全に利用可能な既定・フォールバックとする。将来の3D rendererは同じcontent / navigation / stateを受け取り、必要時のみ遅延ロードする。
- 初期実装は既存公開ページを直接置換せず、新規の独立プロトタイプページと専用ファイルに閉じ込める。`index.html` への統合は本ランでは行わず、次フェーズの人間承認後に判断する。

## 3. 責務分離

| 層 | 責務 | 既存資産との関係 |
|---|---|---|
| existing content / data | 実コンテンツ、YouTube取得、カード検索・価格 | `content.js` / `market.js` を参照し、Designダミーを持ち込まない |
| navigation | route解決、URL・履歴同期、通常リンク | `PAGE_ORDER` と既存ハッシュ/独立URLを維持する |
| common state | `theme`、`screen`、画面別`cursor`、`message`、`view` | renderer非依存の単一stateと更新関数を持つ |
| theme | Dark / Lightトークン、初期値、永続化 | CSS変数で表現し、JSに色をハードコードしない |
| settings | theme、SE、animation、reduced motion、将来view | 表示UIと保存/反映ロジックを分離する |
| 2D renderer / UI | 状態バー、主領域、二重縁、選択表示 | Design P1〜P6を実サイトの語彙とデータへ適用する |
| future 3D renderer | 同じstateを別表示する拡張点 | 2Dコードへ3D固有状態を混在させず、RUN 01では実装しない |
| message window | 選択対象の説明・操作ヒント・状態 | stateを直接書き換えず、対象データから純関数で導出する |
| ad slot | 広告ラベル、予約領域、レスポンシブ寸法 | メッセージ窓直下に置き、本物の広告コードは入れない |
| responsive behavior | desktop / tablet / mobile配置 | CSS中心で切り替え、JS側の操作モデルを分岐させない |

`common state` の概念形は次とする。データ本体やDOMノードはstateへ格納しない。

```js
{
  theme: "dark" | "light",
  screen: "menu" | "content" | "settings",
  cursor: { menu: 0, content: 0, settings: 0 },
  message: { kind: "description" | "hint" | "status", entityId: null },
  view: "2d"
}
```

実画面キーは `content.js` の実在キーを包む形で定義し、Designの4画面へ無理に削減しない。`view: "3d"` は3D rendererが安全に提供できるまで選択肢として有効化しない。

## 4. 段階的実装順序

各段階は、完了条件を満たしてから次へ進む。問題が出た場合は既存公開ページへ波及させず、その段階内で修正または停止する。

### Step 0: ベースライン固定

実施内容:

- `docs/investigation/SITE_AND_DESIGN_MAP.md` の主要機能一覧を回帰確認項目へ変換する。
- `index.html#top` から全10コンテンツ、Lain往復、カード検索/詳細、情報4ページ、管理画面の非公開導線を維持対象として記録する。
- 現行のURL、テーマ保存キー、検索状態、外部依存、SEOメタ、キーボード処理を比較可能な状態にする。

完了条件:

- 変更前に確認すべき画面・操作・URLのチェックリストが揃っている。
- 外部APIや認証が利用できない環境では、未確認事項を失敗扱いにせず明記できる。

### Step 1: 共通CSSトークン・テーマ基盤

実施内容:

- Design指定のDark / LightトークンをCSS Custom Propertiesとして専用CSSへ分離する。
- 二重縁、選択表示、focus ring、分類チップ、離散ピップ等を再利用可能なクラスとして設計する。
- 初期テーマは `prefers-color-scheme`、ユーザー選択はDesign指定の `localStorage['nota.theme']` を用いる。
- 現行 `localStorage['ryotei-theme']` からの一度限りの互換移行を検討し、不正値・Storage利用不可でも既定値へフォールバックする。
- 外部フォント失敗時の和文/等幅フォールバックを定義し、`font-display: swap` を使う。

完了条件:

- JS内に色値を重複保持せず、Dark / Light双方で本文・操作・focusの判別が可能である。
- テーマ切替、再読込後の復元、OS設定のみの場合の初期値が確認できる。
- `prefers-reduced-motion` で不要な演出を抑制できる。

### Step 2: 独立プロトタイプの端末シェル

実施内容:

- 既存ページから直接リンクしない独立プロトタイプページを作り、状態バー / 中段のmain slot / 常設メッセージ窓 / 広告slotの三段構成を実装する。
- ウィンドウは外周borderとinsetによる二重縁とし、過度な影を使わない。
- semantic HTML、見出し階層、通常リンク、button、見えるfocusを初期段階から組み込む。
- 表示内容は `content.js` の実サイトデータを利用するか、構造確認に必要な最小限の実在ラベルだけを用いる。Designの架空名称・世界設定は使用しない。

完了条件:

- 上段 / 中段 / 下段がPC・タブレット・スマートフォンで成立する。
- JavaScriptが失敗しても、少なくとも通常リンクと主要説明がHTMLとして利用できる。
- 既存公開HTML、API、DB、秘密情報に変更がない。

### Step 3: 共通stateとキーボード / マウス / タッチ操作

実施内容:

- `select`、`move`、`enter`、`back` をrenderer非依存の状態遷移として定義し、クリック/タップ/方向キーから同じ関数を呼ぶ。
- `keydown` はdocumentに1つだけ登録し、`ArrowUp` / `ArrowDown` / `ArrowLeft` / `ArrowRight` / `Enter` / `Escape` のみ必要時に処理する。
- `input`、`textarea`、`select`、button操作中、`contenteditable` 等ではゲームカーソルがフォーム入力を妨げないようにする。
- Tabは捕捉せず、標準focus順を維持する。ゲームカーソルは背景反転 + 左バー + `▶` で示し、必要な複合UIでは `aria-activedescendant` を同期する。
- カーソル位置は画面ごとに保持し、ブラウザ戻る/進むとURL再読込を含めて復元可能にする。
- メッセージは現在選択中の実エンティティから純関数で導出する。文字送りは設定と `prefers-reduced-motion` に従う。

完了条件:

- Mouse / Touch / Keyboardで同じ対象を選択・決定・復帰できる。
- Tab、フォーム入力、通常リンク、ブラウザ履歴を妨害しない。
- Escapeが履歴や画面階層のない状態で予期しないページ離脱を起こさない。

### Step 4: 実データへの接続

実施内容:

- `content.js` の `PAGES` / `PAGE_ORDER` をadapter経由で2D rendererへ渡し、全10コンテンツとカード相場への導線を維持する。
- `search.html` / `card.html` はまず通常リンクとして維持し、`market.js` やSupabase RPCをプロトタイプへコピーしない。
- About / Privacy / Terms / Contactは独立URLへの通常リンク、`admin.html` は非掲載のまま維持する。
- YouTube APIの成功・未設定・失敗・空結果の各状態を既存表示と比較する。
- 既存ハッシュキーをroute adapterで扱い、直接アクセス、リロード、戻る、進むを維持する。

完了条件:

- `content.js` の全実コンテンツへ到達でき、架空データが表示されない。
- カード検索/詳細、情報ページ、外部リンクのURLと機能が変わらない。
- コンテンツ・navigation・renderer間にデータの複製がない。

### Step 5: レスポンシブ・アクセシビリティ確認

実施内容:

- `>=1024px`、`761–1023px`、`<=760px`、`<=430px` のDesignブレークポイントを基準に確認する。
- 320px、375px、390px、430px級を重点確認し、430px以下では主ナビを4列の下段タブへ変換する。
- タッチ領域44×44px以上、一覧行46px以上、横スクロールなしを目標とする。
- メッセージ窓は `position: static` とし、本文・タブ・広告を塞がない。
- zoom、200%拡大、長い日本語、外部キーボード、focus表示、読み上げ用ラベル、コントラストを確認する。

完了条件:

- PC / tablet / 320〜430pxで主要操作と本文閲覧が可能である。
- 色だけに依存する選択状態がなく、Tabとゲームカーソルが共存する。
- motion削減時に文字送りや画面演出が即時または最小になる。

### Step 6: 広告枠プレースホルダ

実施内容:

- メッセージ窓の直下、端末フレーム内に独立した広告領域を置く。
- 「広告」等の明示ラベル、`border: 1px dashed var(--faint)`、デスクトップ728×90 / モバイル320×100を想定した予約高を持たせる。
- 広告がない状態では主要コンテンツと誤認させず、広告導入時にも操作対象やメッセージ窓を塞がない構造にする。
- AdSense script、slot ID、アカウント設定は追加・変更しない。

完了条件:

- プレースホルダ有無で大きなCLSや横スクロールが発生しない。
- 広告領域がゲーム内ボタンやサイトコンテンツに見えない。

### Step 7: 既存ページとの統合判断（次フェーズ・人間承認後）

本ランでは統合を実施しない。独立プロトタイプがStep 0〜6の完了条件を満たし、回帰確認結果と差分を人間が承認した後に、次のいずれかを選ぶ。

1. `index.html` のshellのみ段階的に2D基盤へ置換し、`content.js` と既存URLを維持する。
2. 新2Dページを別URLで試験運用し、既存 `index.html` をフォールバックとして残す。
3. リスクが解消しない場合は統合を見送り、プロトタイプを公開導線へ接続しない。

統合時も一括全面書き換えは行わない。Lainモードの扱い、テーマ保存キー移行、複数keydownリスナーの統合、ブート演出、音、SEO本文のHTML化は個別の変更単位とし、各単位で回帰確認する。3D本実装は2D安定後の別Phaseとする。

## 5. テスト計画

### 文書・静的チェック（TASK-002）

- Markdownの見出し、表、リンク先パス、文字コード、末尾空白を確認する。
- `PROJECT.md` 最重要ルール、NIGHT_GOAL禁止事項、Design P1〜P6との対応を自己チェックする。
- 計画がコード変更、公開、秘密情報変更、DB変更、実広告導入を要求していないことを確認する。
- 変更ファイルが本書1ファイルのみであることを `git diff --check` と `git status --short` で確認する。

### 後続実装の自動・静的テスト

- JavaScript構文検査と、導入するlintがある場合は対象ファイルのlintを実行する。現時点でpackage manager / lint / typecheck構成はないため、検証目的だけの依存追加はしない。
- HTML validator相当の検査、リンク/ID重複、コンソールエラー、未処理Promise rejectionを確認する。
- CSSは横overflow、focus可視性、Dark / Light、`prefers-reduced-motion` を検査する。

### 後続実装の手動回帰

- URL: ハッシュ直接アクセス、リロード、戻る、進む、Lain往復、検索→詳細→検索復帰。
- 入力: Mouse、Touch、方向キー、Enter、Esc、Tab、フォーム入力、外部リンク。
- viewport: desktop、tablet、430px、390px、375px、320px、200% zoom。
- data/API: YouTube成功/失敗/未設定、Supabase検索/詳細/空結果/通信失敗。管理認証は既存権限の範囲でのみ確認する。
- quality: title/description/robots、見出し、semantic HTML、コントラスト、読み上げ、motion削減、広告予約高、初期表示性能。

## 6. 統合前の承認ゲート

次のすべてを満たすまで `index.html` を置換しない。

- 独立プロトタイプでDesign P1〜P6、三段構成、Dark / Light、常設メッセージ窓、広告枠が確認済み。
- `content.js` の10ページ、カード相場、情報4ページ、Lain往復、既存URLの回帰結果が記録済み。
- 320〜430px、Mouse / Touch / Keyboard / Tab、`prefers-reduced-motion` に重大問題がない。
- 本物の広告、APIキー、Supabase、管理権限、production設定を変更していない。
- Codexレビューで重大問題がなく、人間が統合方法を承認している。

## 7. 停止条件

次の場合は実装を拡大せず、`NIGHT_REPORT.md` に問題・原因・影響・推奨対応・人間の判断事項を記録して停止する。

- 既存主要機能またはURLを安全に維持できない。
- Design正本と既存構造の衝突に、人間のデザイン判断が必要である。
- 既存データだけでは画面を成立させられず、架空コンテンツの追加が必要になる。
- 本番公開、外部publish、APIキー変更、有料サービス、破壊的DB変更、第三者素材のコピーが必要になる。
- 2Dの安定性を損なわなければ3Dを実装できない。

## 8. 自己チェック

- [x] 既存の素のHTML / CSS / JavaScriptを維持し、フレームワーク移行を計画していない。
- [x] `content.js` / `market.js` と既存主要コンテンツ・機能・URLを正本として維持する。
- [x] 大規模な一括書き換えを避け、独立プロトタイプから段階的に進める。
- [x] `common state` / theme / settings / 2D renderer / message window / ad slot / responsiveを分離した。
- [x] Design P1〜P6、Dark / Light、キーボードとTabの共存、motion削減を計画へ反映した。
- [x] Designのダミーコンテンツおよび第三者ゲーム素材を移植しない。
- [x] 2Dを完全なフォールバックとし、3Dを共有stateの将来rendererとして分離した。
- [x] 実広告、公開、秘密情報変更、DB/API変更、有料サービスを計画対象外とした。
- [x] `index.html` の統合は本ランで行わず、次フェーズの人間承認後とした。
