# TASK-004 PUSH STARTゲート keyboard遮断 / focus trap設計

## 目的と変更境界

本書は、後続のPUSH START挙動実装でgate表示中のkeyboard入力を背後の2D MENUへ漏らさず、modalのfocus契約を維持するための実装契約を定める。TASK-004では設計だけを確定し、`index.html`、CSS、JavaScript、既存テストは変更しない。

前段の `TASK-002_PUSH_START_GATE.md` が定めたDOM / ARIAと、`TASK-003_WARP_PUSH_START_CONTROL.md` が定めたwarpとの排他表示を前提とする。既存の `handleKeydown()`、URL / history、state store、`mount()` / `unmount()` の挙動はgateがactiveでない間は変更しない。touchゴーストクリック対策は後続タスクの責務とする。

## active状態

keyboard遮断とfocus trapは、PUSH START gateを表示する分岐でlistenerを登録してから、gateを閉じるまでの間だけ有効にする。DOMの見た目から毎回推測せず、gate用closure内の `active` booleanを単一の判定元とする。

- `active = true` にしてlistenerを登録した後、`hidden` と `aria-hidden` を解除し、`#push-start-button` へfocusを移す。
- gateを閉じる処理は一度だけ実行できるようにし、最初に `active = false` とする。
- warp優先、PUSH START消費済み、非production topではgate用listenerを登録しない。
- gateを閉じた後や `unmount()` 後は、既存の `handleKeydown()` が従来どおり動作する。

## keydownの遮断位置

gate用 `keydown` listenerは `document` のcapture段階へ登録する。

```js
doc.addEventListener('keydown', handlePushStartKeydown, true);
```

既存の `handleKeydown` は `document` のbubble listenerであるため、capture段階でgate入力を処理し、`stopPropagation()` を呼ぶことで既存handler、MENU要素、URL / history、state更新へ到達させない。解除時は同じlistener、同じcapture指定で削除する。

```js
doc.removeEventListener('keydown', handlePushStartKeydown, true);
```

gateがactiveでない場合、gate用handlerは何も行わない。既存 `handleKeydown()` 自体へgate固有の分岐を混在させない。

## キー別契約

| 入力 | gate用handler | 期待結果 |
|---|---|---|
| `Tab` / `Shift+Tab` | `preventDefault()` と `stopPropagation()` の後、`#push-start-button.focus()` | 唯一のfocus可能要素上で自己ループし、skip link、MENU、theme / sound toggle等へ移動しない |
| `ArrowUp` / `ArrowDown` / `ArrowLeft` / `ArrowRight` | `preventDefault()` と `stopPropagation()` | MENU選択、focus、hash、history、stateを変更しない |
| `Escape` | `preventDefault()` と `stopPropagation()` | gateを解除せず、背後の `resetToMenu()` を呼ばない |
| button上の `Enter` / `Space` | `stopPropagation()`。native button activationに必要な既定動作は抑止しない | buttonの既存click経路を一度だけ使用してgateを解除する。MENUのEnter処理へは到達しない |
| その他のkeydown | `stopPropagation()` | modal表示中の入力を背後のアプリへ渡さない。文字入力等の新機能は追加しない |

`altKey`、`ctrlKey`、`metaKey` の有無を理由にgate遮断を迂回しない。modalがactiveな間は修飾付きArrow / Escape等も同じく背後へ伝播させない。

## focus契約

### 表示時

gateを開く直前に `doc.activeElement` を `previousFocus` として保存する。gateをvisibleかつアクセシビリティツリー上でactiveにしてから `#push-start-button.focus()` を呼ぶ。これによりfocusが一瞬 `hidden` 要素へ移る順序を避ける。

### 表示中

keydownによるfocus移動は常にbuttonへ戻す。加えて、scriptやブラウザ動作でfocusがgate外へ移った場合に備え、gateがactiveな間だけdocument capture段階の `focusin` listenerを登録する。event targetがgate自身またはgateの子孫でなければ、buttonへfocusを戻す。`gate.contains(event.target)` を使用し、後続でgate内のfocus可能要素が増えても内側のfocusを不要に奪わない。

### 解除時

gateを閉じ、`hidden` と `aria-hidden="true"` を復元した後にfocusを返す。`previousFocus` がgate外にあり、documentへ接続されたfocus可能要素ならそこへ戻す。該当しない場合は既存 `#menu-list` へ戻す。focus復帰はgateの消費状態保存やclick処理から一度だけ呼ぶ共通close経路に置き、keyboardとpointerで差を作らない。

`unmount()` はページ遷移相当のcleanupであるため、gateを非表示にしてlistenerを解除するが、破棄中のDOMへ新たなfocus移動は行わない。再mount時は新しい `previousFocus` を取得する。

## lifecycle / cleanup契約

- `keydown` と `focusin` のcapture listener解除を既存 `disposers` に登録する。
- close処理とdisposerのどちらが先でも二重解除、二重focus復帰、例外を起こさない。
- 多重 `mount()` は既存 `activeInstance` guardに従い、gate listenerを重複登録しない。
- gate解除後に保留callbackがある場合も `active` guardによりfocusやstateを書き換えない。
- previewなど非productionページのdocument listener数と既存lifecycle testの契約を変更しない。

## 回帰テスト設計

後続実装で `tests/task-008-push-start-gate.test.js` に少なくとも次を追加する。既存assertionの削除、緩和、skipは行わない。

1. gate表示中にArrow 4種とEscapeをそれぞれdispatchし、MENU cursor、`aria-selected`、detail、URL hash、`history.pushState` 呼出回数が変化しないことを確認する。
2. Arrow / Escape eventで `defaultPrevented` がtrueになり、背後のbubble listenerが呼ばれないことを確認する。
3. `Tab` と `Shift+Tab` の双方でactiveElementが `#push-start-button` のままになり、gate外へfocusしないことを確認する。
4. gate外要素へfocusを移す操作を模擬し、`focusin` containmentによりbuttonへ戻ることを確認する。
5. button上のEnterとSpaceが背後のMENUをactivateせず、native click経路でgateだけを一度解除することを確認する。
6. gate解除後はArrow / Escapeが既存 `handleKeydown()` へ届き、従来のMENU操作が復帰することを確認する。
7. 解除時に有効な `previousFocus`、無効な `previousFocus` の各ケースで、保存要素または `#menu-list` へfocusが戻ることを確認する。
8. `unmount()` 後にgateのkeydown / focusin listenerが反応せず、再mountで各listenerが一つだけ登録されることを確認する。
9. gate表示中の各操作で `window.location.href` が `search.html` 等へ変化しないことを確認する。

実ブラウザテストでは、Playwright等のkeyboard APIで `Tab`、`Shift+Tab`、Arrow 4種、Escape、Enter、Spaceを送信し、DOM harnessだけでなく実際のevent phaseとnative button activationも確認する。

## 対象外

- PUSH START gateのDOM、visual design、文言の変更
- warpとの排他判定の変更
- touchstart後の合成click抑止方式
- 320px overflowを含む無関係なCSS変更
- 既存MENU keyboard仕様、URL / history仕様、state storeの変更
