# PUSH START 最終実装レビュー

## 目的と経緯

Claudeがsession limitで停止したPUSH START実装を、Copilotが引き継いで補完した。本書は、その最終成果に対してClaudeが独立レビューを行った記録である。実装作業は行わず、working tree / git diff / テスト結果の検証のみを実施した。

レビュー対象コミット時点のブランチ: `ai-night/2026-08-26-1042`
レビュー実施日: 2026-08-26

前提とする承認済み設計:

- `docs/design/2d/TASK-002_PUSH_START_GATE.md`（DOM / ARIA）
- `docs/design/2d/TASK-003_WARP_PUSH_START_CONTROL.md`（warp優先とsessionStorage）
- `docs/design/2d/TASK-004_PUSH_START_KEYBOARD_FOCUS.md`（keyboard遮断とfocus trap）
- `docs/design/2d/TASK-005_PUSH_START_TOUCH_GHOST_CLICK.md`（touchゴーストクリック防止）
- `docs/design/2d/TASK-006_PUSH_START_GATE_TEST_SPEC.md`（回帰テスト仕様）

## Copilot報告の要旨

- IMPLEMENTATION COMPLETE / CLAUDE FINAL REVIEW PENDING
- テスト結果: 23 PASS / 0 FAIL / 0 SKIP
- `git diff --check` PASS
- 主な実装: PUSH START DOM/CSS、warp-entry優先、sessionStorageによる同一セッション制御、keyboard遮断、focus trap、touch ghost-click防止、unmount/remount cleanup、関連テスト更新

## 検証方法

Copilotの報告値をそのまま採用せず、以下を独立に実施した。

1. `git status` / `git diff --stat` / 各ファイルの`git diff`を読み、変更範囲を確認。
2. `git diff --check`を再実行。
3. 変更・新規テストファイルを個別に`node`で実行。
4. `tests/run-2d-mode-final-qa.js`（`tests/*.test.js`を動的列挙する正本のQA runner）を実行し、集計値を再現。
5. 自動テストが直接検証していない項目（ゲート表示中の320px他の横スクロール、focus復帰の実挙動）は、Edge headless + Chrome DevTools Protocolを使った検証用スクリプトをその場で作成し、手動で実測した。

## 変更差分の内容

```
assets/css/preview-2d.css                     |  38 ++++++++++
assets/js/preview-2d.js                       | 102 +++++++++++++++++++++++++-
index.html                                    |   6 ++
tests/preview-2d-viewport.test.js             |   5 ++
tests/task-006-main-link-reachability.test.js |   7 +-
tests/task-008-push-start-gate.test.js        | 新規
```

全ての変更はPUSH START機能に閉じており、無関係な変更の混入は確認されなかった。

## テスト結果の独立検証

`tests/run-2d-mode-final-qa.js`を実行し、`tests/`直下の全`*.test.js`（23ファイル）を再実行した。

```
23/23 checks passed.
```

Copilot報告の「23 PASS / 0 FAIL / 0 SKIP」と一致することを独立に確認した。`git diff --check`も再実行しPASS。

## レビュー項目ごとの確認結果

### 1. TASK-002〜006設計との一致

- `index.html`のDOM/ARIA断片は`TASK-002`のHTML契約と一致（`role="dialog"`、`aria-modal="true"`、`aria-labelledby`、初期`hidden`+`aria-hidden="true"`、native `<button>`一つ）。
- `assets/js/preview-2d.js`の`shouldPlayWarpEntry` / `shouldShowPushStart`分岐は、`TASK-003`が提示した疑似コードとほぼ一致。
- `TASK-004`のkeydown capture位置（`document`のcapture段階、`stopPropagation()`）、focus trapの`focusin` capture listenerによるcontainmentも設計通り。
- `TASK-005`のtouch契約（`touchstart`を`{ passive: false }`で登録し、`preventDefault()` + `stopPropagation()`を同期的に行ってから共通close処理に合流する）も一致。

一点、設計文言との軽微な差異を検出（下記「非ブロッキング指摘」参照）。

### 2〜10, 12. ゲート実装品質 / warp競合 / sessionStorage / Enter・Mouse・Touch / keyboard遮断 / focus trap / ghost-click防止 / 入力貫通なし / unmount・remount cleanup

`tests/task-008-push-start-gate.test.js`を実行しPASSを確認。実測した内容:

- Arrow4種 + Escapeをdispatchしても、MENU cursor / `aria-selected` / 画面 / URL hashが変化せず、`keydown`のbubble到達回数・`history.pushState`呼出回数はともに0。
- `Tab` / `Shift+Tab`後も`document.activeElement`は常に`#push-start-button`。スクリプトで`#menu-list`へfocusを移そうとしても`focusin` containmentによりbuttonへ戻る。
- Enterでgateが1回だけ閉じ、`sessionStorage['ryotei-push-start-consumed'] === '1'`となり、背後のCARD MARKETは活性化しない（`market === 0`）。
- 390x844 viewport + touch emulationで、実際の`touchStart`/`touchEnd`をボタン中心座標へdispatchしてもゴーストクリックが背後へ着弾しない（`market === 0`、`documentClicks === 0`）。
- `unmount()`直後はgateが非表示に戻り、`ryotei-push-start-consumed`は保存されない（消費済み扱いにしない）。`mount(document)`し直すとgateが再表示され、1入力につき1回だけcloseする。

### 11. 320pxを含むresponsive

自動テスト(`preview-2d-viewport.test.js`経由の`task-005-production-responsive.test.js`)は、ゲートを`sessionStorage`で一旦消費済みにしてからレイアウトを検証する構成になっており、**ゲート表示中そのもの**の横スクロール有無は自動テストでは検証されていなかった。

この欠落を埋めるため、320 / 375 / 390 / 430pxの各幅でゲートを実際に表示させた状態のまま`document.documentElement.scrollWidth`を実測するスクリプトをその場で作成・実行した。全幅で`scrollWidth === innerWidth`（横スクロールなし）を確認した。

### 13. 既存主要機能への回帰

全23テストファイルを個別実行・`run-2d-mode-final-qa.js`経由の集約実行の両方で再実行し、23/23 PASSを再現した。PUSH START機能の対象外である`preview-2d-input.test.js`等は本番トップ(`index.html`)を対象にしておらず、ゲート追加の影響を受けない構成であることも確認した。

### 14. テストを弱体化してPASSさせていないこと

既存2ファイル(`preview-2d-viewport.test.js`、`tests/task-006-main-link-reachability.test.js`)への変更は、assertionの削除・緩和ではなく、新設されたモーダルを`sessionStorage`セット＋`unmount()`/`mount()`で明示的に通過させるsetupの追加のみであった。既存assertionは無傷。

### 15. git diffに不要な変更が混ざっていないこと

diffはCSS/JS/HTML各1ファイルと既存test2ファイル、新規test1ファイルに限定されており、PUSH START機能と無関係な変更は確認されなかった。

## 非ブロッキングの指摘

以下2件は機能的な欠陥ではないが、承認済み設計との整合性・テスト網羅性の観点で記録に残す。

### (a) TASK-004設計文言との軽微な差異

`TASK-004`は「button上のEnter/Spaceでは`preventDefault()`せず、native button activationの既定動作を抑止しない」と明記しているが、実装(`handlePushStartKeydown`)は`preventDefault()`した上で`pushStartButton.click()`を手動で呼び出している。

手動検証の結果、二重発火や機能的な破綻は確認されなかった（Enter/Spaceどちらも単発でgateが閉じ、MENUは活性化しない）。ただし承認済み設計の文言とは異なる実装選択であるため、今後の変更時に注意を要する。

### (b) TASK-006テスト仕様に対するカバレッジ不足

`TASK-006`は次のような網羅的なテストシナリオを要求しているが、`tests/task-008-push-start-gate.test.js`には未実装の項目が複数ある。

- 修飾キー付きArrow/Escape（`altKey`/`ctrlKey`/`metaKey`）の遮断確認
- 補助的なDOM dispatchによる`defaultPrevented === true`の直接確認
- 有効な`previousFocus`（gate外の要素）への復帰と、無効な`previousFocus`（DOM切断済み）時の`#menu-list`フォールバックの、それぞれ独立したシナリオ確認
- warp要求済み＋PUSH START消費済みの組合せ、および「warp要求なし・PUSH START消費済み」の通常起動比較シナリオ
- 多重`mount()`でlistenerが重複登録されないことのcounterによる確認

このうち「有効な`previousFocus`への復帰」については、Edge headless + CDPを使った検証スクリプトをその場で作成し手動で実行、`theme-toggle`へfocusした状態からgateを開いて閉じた際に、正しく`theme-toggle`へfocusが戻ることを確認した。実装自体に欠陥は見つかっていないが、承認済み設計が要求する回帰網羅性には届いていない。

## 総合判定

重大な機能的欠陥・回帰・背後要素への入力貫通・テストの弱体化は確認されなかった。上記(a)(b)は次タスクでの改善事項として記録することを推奨するが、リリースをブロックする理由にはならない。

```
VERDICT: PASS
2D MODE READY FOR HUMAN RELEASE REVIEW
```

本レビューでは commit / push / deploy / main merge は一切行っていない。
