# TASK-006 `task-008-push-start-gate.test.js` 新規テスト仕様設計

## 目的と変更境界

本書は、後続のPUSH START実装を検証する `tests/task-008-push-start-gate.test.js` の回帰テスト契約を定める。TASK-006ではテスト仕様だけを確定し、テストファイル、production HTML / CSS / JavaScript、既存テスト、`tests/run-2d-mode-final-qa.js` は変更しない。

前提仕様は次の承認済み設計とする。

- `TASK-002_PUSH_START_GATE.md`: DOM / ARIA
- `TASK-003_WARP_PUSH_START_CONTROL.md`: warp優先とsessionStorage
- `TASK-004_PUSH_START_KEYBOARD_FOCUS.md`: keyboard遮断とfocus trap
- `TASK-005_PUSH_START_TOUCH_GHOST_CLICK.md`: touchstart cancelとゴーストクリック防止

既存テストのassertionを削除、緩和、skipしてはならない。PUSH START未実装の段階で形式的にPASSさせるsource regexだけの代替テストも作らない。

## テスト構成

テストはNode.jsからローカルHTTP serverとheadless Chrome / Edgeを起動し、Chrome DevTools Protocol（CDP）でproduction topの `index.html` を操作する単一ファイルとする。DOMの静的契約は既存 `task-011-production-feature-regression.test.js` と `task-012-seo-a11y-advertisement.test.js` が担当するため、本テストは実ブラウザ上の表示分岐、event phase、native focus、実タッチ入力を主対象にする。

`preview-2d-warp-entry.test.js` のbrowser探索、空きport取得、CDP接続、server / browser / 一時profile cleanupと同等のutilityを使用する。utility共通化のためだけに既存テストを変更すると本タスクの変更境界を広げるため、初回実装では必要最小限をテストファイル内に複製してよい。後日の共通化は別タスクとする。

各シナリオはstorage、URL、focus、監視counterの状態を明示的に初期化してからreloadする。非同期表示やanimation終了は固定長sleepだけに依存せず、上限付きpollingで期待状態を待つ。失敗時にも `finally` でCDP socket、browser、HTTP server、一時profileをcleanupする。

## シナリオ1: warp-entry優先

事前に `sessionStorage['ryotei-warp-entry'] = '1'` を設定し、`sessionStorage['ryotei-push-start-consumed']` を削除してreloadする。

次をassertする。

1. warp開始中、`#warp-entry-overlay` はactiveで、`#push-start-gate.hidden === true` かつ `aria-hidden === 'true'` である。
2. warp開始中にgate buttonへclick / keyboard eventを送っても、PUSH START消費keyは作成されない。
3. warp終了後、warp overlayはclassを失ってhiddenとなり、warp keyだけが削除される。
4. warp終了後もgateはhiddenのままで、同一ロード中に遅延表示されない。
5. MENU cursor、選択状態、URL / hashはwarp前後で変化しない。

PUSH START keyが事前に`'1'`の組合せも確認し、warp終了後にそのkeyが維持されることをassertする。

### warp要求なし・PUSH START消費済み

通常起動時の回帰として、`sessionStorage['ryotei-warp-entry']` を削除し、`sessionStorage['ryotei-push-start-consumed'] = '1'` を設定してreloadする。比較基準は、gate用listenerを登録しない既存の通常起動で得られるMENU初期選択、focus、URL / hashとし、reload前に監視counterを初期化する。

次をassertする。

1. `#push-start-gate.hidden === true` かつ `aria-hidden === 'true'` で、gateは表示されない。
2. `#warp-entry-overlay` はactiveにならず、warp演出も開始しない。
3. MENU cursorと選択状態、focus、URL / hashは通常起動時の比較基準と同一である。
4. gate用のkeydown、focusin、touch、click listenerによるcancel、focus移動、activationなどの副作用が発生しない。
5. `ryotei-push-start-consumed` は`'1'`のまま維持され、`ryotei-warp-entry` は作成されない。

## シナリオ2: modal表示とkeyboard遮断

両session keyを削除してproduction topをreloadし、gateがvisibleになって `#push-start-button` がactiveElementになるまで待つ。`role="dialog"`、`aria-modal="true"`、label参照などの静的assertionは既存テストへ委ねつつ、表示中の `hidden === false` と `aria-hidden !== 'true'` を確認する。

操作前に次をsnapshot / instrumentする。

- store相当の可視状態: `#screen-name`、`#status-position`、選択されたMENU item、detail title / code
- `location.href`、hash、`history.length`
- `history.pushState`呼出回数
- document bubble段階のkeydown到達回数
- MENU item、CARD MARKET link、document clickのactivation回数

次をassertする。

1. ArrowUp / ArrowDown / ArrowLeft / ArrowRight / Escapeを一つずつCDP `Input.dispatchKeyEvent`で送っても、全snapshotとpushState回数が変化しない。
2. 各対象keyはcapture listenerでcancelされ、背後のbubble listenerへ到達しない。補助的なDOM eventでは`defaultPrevented === true`も確認する。
3. 修飾付きArrow / Escapeも同様に遮断される。
4. TabとShift+Tabを送ってもactiveElementは常に`#push-start-button`である。
5. scriptでskip linkまたはMENUへfocusを移しても、focusin containmentによりbuttonへ戻る。
6. Escapeではgateが閉じず、PUSH START消費keyも作成されない。
7. button上のEnterまたはSpaceはnative click経路でgateだけを一度閉じ、背後MENUをactivateしない。
8. 有効な `previousFocus` のケースでは、gate表示前にMENU項目などgate外のfocus可能要素へfocusし、その要素がdocumentへ接続されたままの状態でgateを開く。button上のEnterまたはSpaceでgateを閉じた後、`document.activeElement` が保存した元の要素へ戻る。
9. 無効な `previousFocus` のケースでは、gate表示前にfocusした要素をgate表示中にDOMから切り離す（またはpreviousFocusに該当する接続済み要素がない状態を作る）。button上のEnterまたはSpaceでgateを閉じた後、`document.activeElement` が既存 `#menu-list` へ戻る。
10. gate解除後は独立したArrow / Escape操作が既存MENU handlerへ届き、従来操作が復帰する。

EnterとSpaceは同じsessionで連続実行せず、storageを初期化した独立reloadで各経路を確認する。focus復帰の有効・無効ケースも独立reloadとし、各close assertionより前にgateがvisibleかつbuttonがfocus済みであること、および保存対象の接続状態を確認する。

## シナリオ3: CDP実タッチとゴーストクリック防止

`Emulation.setDeviceMetricsOverride`で390 x 844、mobile、deviceScaleFactor 1を設定し、`Emulation.setTouchEmulationEnabled`でtouchを有効にする。両session keyを削除してreloadし、gate表示とbutton focusを確認する。

buttonの中央座標を`getBoundingClientRect()`から取得し、同一点へ次を送る。

1. `Input.dispatchTouchEvent`の`touchStart`（touch point id 1）
2. `Input.dispatchTouchEvent`の`touchEnd`（touch pointsなし）

テストから合成clickを追加dispatchしない。ブラウザがcompatibility mouse eventを生成し得る時間を上限付きpollingに含め、次をassertする。

1. gateはhiddenかつ`aria-hidden === 'true'`になる。
2. PUSH START消費keyは`'1'`となり、storage保存とcloseは一度だけである。
3. MENU cursor、`aria-selected`、detail title / codeは操作前から変化しない。
4. `location.href`、hash、history length、pushState回数は変化せず、`search.html`へ遷移しない。
5. 背後のMENU item、CARD MARKET、documentで背後要素をtargetとするclick / activation回数は0である。
6. 補助的にcancelableな`touchstart`をbuttonへdispatchした場合、`defaultPrevented === true`でbubble listenerへ到達しない。
7. gate解除後の独立したmouse clickでは既存MENU操作が動き、遮断listenerが残っていない。

## lifecycle追加確認

表示中に `window.RYOTEI_RENDERER_2D.unmount()` を呼び、次を確認する。

- gateはhidden / `aria-hidden="true"`へ戻る。
- unmountだけではPUSH START消費keyを保存しない。
- 破棄中のDOMへfocusを戻さない。
- 旧keydown、focusin、touch、click listenerは反応しない。

その後 `mount(document)` し直し、一回の入力につきclose / storage保存が一回だけであることを確認する。多重`mount()`でもlistener重複がないことをcounterで保証する。

## 受け入れ基準と実行順

PUSH START本体実装と本テスト追加を行う後続タスクでは、次を順に実行してすべてPASSさせる。

```text
node tests/task-008-push-start-gate.test.js
node tests/preview-2d-warp-entry.test.js
node tests/task-011-production-feature-regression.test.js
node tests/task-012-seo-a11y-advertisement.test.js
node tests/run-2d-mode-final-qa.js
git diff --check
git status --short
git diff
```

`run-2d-mode-final-qa.js` は `tests`直下の `*.test.js` を動的列挙するため、`task-008-push-start-gate.test.js` の追加だけで集約QAへ含まれる。QA runner自体は変更しない。単体実行と集約実行の双方でPASSすることを受け入れ条件とする。

## 対象外

- PUSH STARTのproduction実装
- DOM、visual design、文言、CSSの変更
- warp animation、MENU、URL / history、state storeの仕様変更
- CDP utility共通化を目的とした既存テストのリファクタリング
- 320px overflowを含む無関係なCSS変更
