# TASK-005 PUSH STARTゲート タッチ解除時のゴーストクリック防止設計

## 目的と変更境界

本書は、後続のPUSH START挙動実装で、タッチ操作によるgate解除直後の合成clickが背後のMENUやCARD MARKETへ着弾しないためのイベント契約を定める。TASK-005では設計だけを確定し、`index.html`、CSS、production JavaScript、既存テストは変更しない。

前段の `TASK-002_PUSH_START_GATE.md`、`TASK-003_WARP_PUSH_START_CONTROL.md`、`TASK-004_PUSH_START_KEYBOARD_FOCUS.md` を前提とする。warpとの排他、keyboard遮断、focus trap、既存MENUのclick動作、URL / history、state store、rendererの `mount()` / `unmount()` 契約は変更しない。

## 採用する入力経路

gateの操作対象は既存のnative `#push-start-button` 一つとし、次の2経路だけを登録する。

| 入力 | listener | 処理 |
|---|---|---|
| touch | buttonの`touchstart` | active中は`preventDefault()`と`stopPropagation()`を同期的に行い、共通close処理を一度だけ呼ぶ |
| mouse / keyboard / stylus由来のactivation | buttonの`click` | active中は`preventDefault()`と`stopPropagation()`を行い、同じ共通close処理を一度だけ呼ぶ |

`touchstart` listenerは、ブラウザが `preventDefault()` を無視しないよう明示的に `{ passive: false }` で登録する。

```js
var touchOptions = { passive: false };
button.addEventListener('touchstart', handlePushStartTouch, touchOptions);
button.addEventListener('click', handlePushStartClick);
```

touch経路では、gateを隠す処理より前に現在の `touchstart` をcancelする。これにより同じ接触から生成される互換mouse event / clickを抑止し、gateが消えた後の同一座標にあるMENU項目へactivationが移ることを防ぐ。`touchend`での解除、遅延timer、座標に基づく背後要素の再dispatchは採用しない。

CSSの `touch-action` だけを抑止根拠にしない。既存のレイアウト・操作領域・`touch-action`指定は変更せず、イベントのcancelを主契約とする。

## 単一close経路と二重発火防止

gate用closureの `active` booleanを、TASK-004と共通の単一判定元として使用する。touchとclickはそれぞれイベント固有の抑止を行った後、同じ `closePushStartGate({ restoreFocus: true })` 相当の処理へ合流する。

共通close処理は最初に `active` を `false` にし、以後の呼出しを何もせず終了させる。最初の一回だけ、次を順に行う。

1. PUSH START消費状態を `sessionStorage[PUSH_START_KEY] = '1'` として安全に保存する。
2. gateへ `aria-hidden="true"` と `hidden` を復元する。
3. gate固有のkeyboard、focus、touch、click listenerを解除する。
4. TASK-004の契約に従ってfocusを一度だけ復帰する。

touch処理では `active` の確認前であっても、登録中に受け取った対象イベントの `preventDefault()` と `stopPropagation()` を先に行う。close途中の再入や、同一イベント伝播中に発生する背後側の処理を許さないためである。想定外に後続clickが発生しても、元のbuttonに登録したclick handlerと `active` guardにより二重保存・二重focus復帰を行わない。ただし、安全性の主根拠は `touchstart.preventDefault()` による合成click自体の抑止とする。

## lifecycle / cleanup契約

- touch listenerの解除には、登録時と同じbutton、handler、capture値を使用する。`passive`値はlistener同一性に影響しないが、可読性のため同じ `touchOptions` を再利用する。
- click listener、touch listener、およびTASK-004のcapture listenerの解除を既存 `disposers` へ統合する。
- closeと`unmount()`のどちらが先でも、listener解除、gate非表示化、消費状態保存、focus復帰が二重実行されないようにする。
- `unmount()`によるcleanupではPUSH STARTを操作完了扱いにせず、消費状態を新規保存しない。また、破棄中のDOMへfocusを戻さない。
- 再mount時はstorageとwarpの表示条件を再評価し、gateが再表示される場合だけ新しいlistenerを一組登録する。
- warp優先、PUSH START消費済み、非production topではtouch / click listenerを登録しない。

## CDP実ブラウザ回帰テスト設計

後続実装で `tests/task-008-push-start-gate.test.js` にChrome DevTools Protocolを使う実ブラウザケースを追加する。`tests/preview-2d-warp-entry.test.js` と同様に、ローカルHTTP server、専用一時profile、headless Chrome / Edge、WebSocket接続を使用し、終了時にprocessと一時profileをcleanupする。

### 事前条件

1. `Emulation.setDeviceMetricsOverride` でmobile相当のviewport（例: 390 x 844、`mobile: true`、`deviceScaleFactor: 1`）を設定する。
2. `Emulation.setTouchEmulationEnabled` でtouch emulationを有効にする。
3. sessionStorageからwarp keyとPUSH START keyを除去してreloadし、gateがvisible、buttonがfocus済みであることを確認する。
4. 操作前のMENU cursor、`aria-selected`、detail、URL、hash、history長をsnapshotする。
5. 背後のMENU項目、CARD MARKET、document clickへ一時的な監視listenerを付け、activation回数を記録する。テスト用listenerはproduction codeへ追加しない。

### 実タッチ入力

`Runtime.evaluate`内の単純な `dispatchEvent()` ではなく、buttonの中央座標を `getBoundingClientRect()` で取得し、CDPの次の順序で同一点へ送信する。

```text
Input.dispatchTouchEvent(type: "touchStart", touchPoints: [{ x, y, id: 1 }])
Input.dispatchTouchEvent(type: "touchEnd", touchPoints: [])
```

ブラウザが互換mouse eventを生成し得る時間を含めて短時間待機した後に結果を取得する。テストからclickを追加dispatchして成功扱いにはしない。

### 必須assertion

- gateは `hidden === true` かつ `aria-hidden === 'true'` となる。
- `sessionStorage[PUSH_START_KEY]` は `'1'` になり、保存処理は一度だけである。
- MENU cursor、`aria-selected`、detail表示が操作前から変化しない。
- `location.href`、hash、history長が変化せず、`search.html`等へ遷移しない。
- 背後のMENU項目とCARD MARKETのclick / activation回数は0のままである。
- documentで観測されるclickに背後要素をtargetとするものがない。
- gate解除後の通常の独立したmouse clickでは既存MENU操作が動作し、入力遮断が残留していない。
- `unmount()`後および再mount後にlistenerが重複せず、一回のtouchでcloseが一回だけ実行される。

DOM harnessでは補助的に、cancelableな`touchstart`をbuttonへ送って `defaultPrevented === true`、背後のbubble listener未到達、close処理一回を確認する。CDPケースをこの単純dispatchテストで置き換えない。

## 既存回帰確認

後続実装時は既存assertionを削除・緩和・skipせず、最低限次を実行する。

1. `tests/task-008-push-start-gate.test.js`
2. `tests/preview-2d-warp-entry.test.js`
3. `tests/task-011-production-feature-regression.test.js`
4. `tests/task-012-seo-a11y-advertisement.test.js`
5. `tests/run-2d-mode-final-qa.js`
6. `git diff --check`

## 対象外

- PUSH START gateのDOM、visual design、文言、CSSの変更
- warpとの排他判定、keyboard / focus契約の変更
- 既存MENU、CARD MARKET、URL / history、state storeの入力仕様変更
- 320px overflowを含む無関係な修正
- pointer eventへの全面移行や入力系の大規模リファクタリング
