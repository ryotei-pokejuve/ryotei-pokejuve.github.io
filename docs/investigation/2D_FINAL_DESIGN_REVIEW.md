# 2D MODE 最終デザイン資料レビュー

## 目的と対象

この文書は、`docs/design/2d-final/2Dモード UI デザイン比較.zip` の内容と、最終候補 `preview-2d.html` / `assets/css/preview-2d.css` / `assets/js/preview-2d.js` の対応を記録する。レビュー基準は `docs/design/2d/IMPLEMENTATION.md` とし、NIGHT_GOAL の「A案80% + B案20%」方針を追跡可能にする。

ここでいう 80% / 20% はCSSの行数や画面占有率の機械的な比率ではない。端末の第一印象と主要な操作フィードバックをA案で構成し、Webとしての可読性・情報整理に限ってB案の要素を補助的に採用する、というデザイン上の優先度を表す。

## zipの内容

確認日: 2026-08-24

zipには画像や第三者ゲーム素材は含まれず、次の13ファイルが含まれる。

```text
build/
├─ README.md
├─ 2d-mode-A/
│  ├─ index.html
│  ├─ content.js
│  └─ assets/
│     ├─ css/2d-shell.css
│     ├─ css/2d-tokens.css
│     ├─ css/2d-variant-a.css
│     └─ js/2d-shell.js
└─ 2d-mode-B/
   ├─ index.html
   ├─ content.js
   └─ assets/
      ├─ css/2d-shell.css
      ├─ css/2d-tokens.css
      ├─ css/2d-variant-b.css
      └─ js/2d-shell.js
```

A案とB案のHTML、データ、共通CSS、JavaScriptは同一で、差は `2d-variant-a.css` と `2d-variant-b.css` に限定される。A案は太い多重枠、低い角丸、区切られたHUD、全面反転と押し込み感のあるカーソル、斜めタイル、三重枠のメッセージ窓を特徴とする。B案は細い二重枠、大きい角丸、余白と明度差による階層、左レールと淡い選択背景、ドット背景、外側シャドウを特徴とする。

なお、`docs/design/2d/2Dモード UI デザイン比較.zip` と `docs/design/2d-final/2Dモード UI デザイン比較.zip` は同名だがSHA-256が異なる。本レビューではNIGHT_GOALが指定する `2d-final` 側だけを正本として確認した。

## A案80% + B案20%との整合

| 評価軸 | 最終プレビューの実装 | 系統 | 判定 |
|---|---|---|---|
| 端末外周 | 4px外枠、内側リング、低い角丸、斜めタイル | A | 整合 |
| 各ウィンドウ | 3px枠と複数inset、低い角丸 | A | 整合 |
| HUD | 2px罫線のセグメント、角ブラケット、信号ゲージ | A | 整合 |
| メニュー選択 | アクセント色の全面反転、`▶`、押し込み影 | A中心 | 整合 |
| 選択の補助表示 | 左3pxバーを全面反転と併用 | Bの左レールを補助採用 | 整合 |
| MESSAGE | 多重枠、低い角丸、4px下影、ラベルプレート | A | 整合 |
| CONTENT | 情報を小パネル化し、左太線や余白で階層化 | Bを補助採用 | 整合 |
| 可読性 | 実サイト本文は和文ゴシック、コード・ラベルは等幅 | 共通仕様/B寄りの抑制 | 整合 |
| レスポンシブ | 縦積み、2列メニュー、320px下限、44px以上の操作領域 | 共通仕様 | 整合 |

主要なゲーム的シルエットと操作フィードバックはA案で統一されている。一方、B案由来の要素は左レールとコンテンツ内の情報整理に限定され、A案の印象を置き換えていない。このため、定性的な「A案80% + B案20%」方針に整合すると判断する。

## 最終プレビューとの対応

- zipの `status-bar → main-window（menu-pane / detail-pane）→ message-window → ad-reserve` という構造は最終プレビューにも維持されている。
- zipの11項目メニュー構想は、最終プレビューでは既存 `content.js` の `SITE.PAGE_ORDER` と `CARD MARKET` から生成され、デザイン用データの固定配列を本番候補へ持ち込んでいない。
- テーマキー `localStorage['ryotei-2d-theme']`、OSテーマ初期値、`role="listbox"` / `role="option"`、`aria-selected` / `aria-activedescendant`、単一の `keydown` リスナー、文字送りとreduced motion対応を引き継いでいる。
- zipの `screenKey` / `cursor` を別レンダラへ渡す考え方は、最終プレビューの `state = { theme, screen, cursor, message }` に拡張されており、将来の3D rendererと状態を共有できる形を保っている。
- zip内の外部リンクは `https://example.com/market` というプレースホルダーだが、最終プレビューでは既存の `search.html` を利用する。

## ダミーコンテンツの確認

zipの `content.js` には、UI比較用の架空または未検証データが含まれる。例として動画128件、SHORTS 64件、実績42/60、配信予定、架空の日付・記事名・集計値、`example.com` の市場リンクがある。これらはデザイン資料内だけのダミーであり、実コンテンツの根拠として扱わない。

最終プレビューはルートの既存 `content.js` を読み込み、既存ページデータと既存カード検索ページを表示する。zipの固定件数、架空ログ、架空実績、外部プレースホルダーは移植されていない。`RYOTEI INFORMATION TERMINAL`、`MENU`、`CONTENT`、`MESSAGE`、`DATA / LINK` 等はコンテンツではなくUIラベルなので継続使用してよい。

## IMPLEMENTATION.md P1〜P6対応表

| 原則 | 最終プレビューでの対応 | 判定 |
|---|---|---|
| P1 二重縁ウィンドウ | `.terminal-shell` と `.win2` が外枠と複数のinset ringを持つ。主要3領域を影だけに依存せず枠で区切る | 適合 |
| P2 三段構成 | `status-bar`、`main-window`、常設 `message-window` の順で構成し、その直下に `ad-reserve` を置く | 適合 |
| P3 選択状態 | 選択行に背景反転、左3pxバー、`▶`、太字を併用し、色だけに依存しない | 適合 |
| P4 分類色 | 最終プレビューは分類別の本文色を導入していない。DATA/LINK等は限定的なラベル領域で示す | 適合（分類色を使う画面は未実装） |
| P5 数値表示 | 能力値の連続バーは導入していない。HUD信号は装飾的な離散6セグメントで表す | 適合（能力値画面は未実装） |
| P6 六操作 | 方向キーで循環選択、Enterで選択対象を開く、EscでMENUへ戻る。マウス/タッチは同じ選択・遷移関数を使用し、Tabの既定動作は奪わない | 適合 |

## 結論

`docs/design/2d-final` の比較成果物に対し、最終プレビューは主要意匠をA案、補助的な情報整理をB案から採用している。ダミーコンテンツは本番候補へ移植されておらず、`IMPLEMENTATION.md` のP1〜P6にも対応している。したがって、TASK-003の範囲では「A案80% + B案20%」方針との整合を確認できる。
