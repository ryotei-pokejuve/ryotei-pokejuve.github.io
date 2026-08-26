# TASK-003 warp-entry優先とPUSH STARTゲート表示制御ロジック設計

## 目的と変更境界

本書は、後続のPUSH START挙動実装で `assets/js/preview-2d.js` の `mount()` に追加する表示分岐を定める。TASK-003では設計だけを確定し、production JavaScript、HTML、CSS、既存テストは変更しない。

前段の `TASK-002_PUSH_START_GATE.md` で定めたDOM / ARIA契約を前提とし、既存のwarp-entry演出、rendererの `mount()` / `unmount()` 契約、sessionStorageの既存キーを維持する。keyboard、focus、touchの詳細なイベント実装は後続タスクの責務とする。

## sessionStorage契約

| 用途 | キー | 値と意味 |
|---|---|---|
| Lainから戻った直後のwarp演出 | `ryotei-warp-entry`（既存 `WARP_ENTRY_KEY`） | `'1'` の場合に今回のロードでwarpを優先する |
| PUSH STARTのセッション内消費状態 | `ryotei-push-start-consumed`（新規 `PUSH_START_KEY`） | `'1'` の場合にgateを再表示しない |

- `PUSH_START_KEY` は `WARP_ENTRY_KEY` と異なる固定文字列として宣言する。
- warp要求をPUSH START消費済みとして記録しない。warp終了後の同一ロードでgateを遅延表示することもしない。
- sessionStorageの読み書きが例外になる環境ではページ本体を壊さない。warpキーを安全に読めない場合は既存 `playWarpEntry()` と同様にwarp要求なしとして扱い、PUSH START消費状態を安全に読めない場合はgateを表示する側へ倒す。

## `mount()` の排他分岐

表示判断はproduction top判定後、gateのlistener登録や表示より前に一度行う。判定順は次のとおりとする。

```text
isProductionTop でない
  -> warpもPUSH START gateも開始しない

isProductionTop かつ WARP_ENTRY_KEY === '1'
  -> PUSH START gateを初期状態（hidden / aria-hidden="true"）のまま維持
  -> playWarpEntry(doc)だけを実行
  -> このロードではwarp完了後もgateを表示しない

isProductionTop かつwarp要求なし かつ PUSH_START_KEY !== '1'
  -> PUSH START gateを表示する

isProductionTop かつwarp要求なし かつ PUSH_START_KEY === '1'
  -> どちらも表示しない
```

後続実装では、例えば `shouldPlayWarpEntry` と `shouldShowPushStart` を同じstorage snapshotから導出し、次の排他条件を保つ。

```js
var shouldPlayWarpEntry = isProductionTop && warpEntryRequested;
var shouldShowPushStart = isProductionTop && !shouldPlayWarpEntry && !pushStartConsumed;

if (shouldPlayWarpEntry) playWarpEntry(doc);
else if (shouldShowPushStart) mountPushStartGate(doc);
```

`playWarpEntry()` 内の既存キー確認とcleanupは防御的ガードとして維持してよい。ただし、gateを先に表示してからwarp判定で閉じる順序にはしない。初期マークアップの `hidden` と `aria-hidden="true"` を維持したまま分岐し、同一フレームで両overlayが露出することを防ぐ。

## lifecycle契約

- gateが登録するclick、touch、keydown等のlistenerと、gateが所有する保留timerは既存 `disposers` 配列へ解除処理を登録する。
- `unmount()` は表示中のgateを閉じ、`hidden` と `aria-hidden="true"` を復元し、再 `mount()` 可能な状態にする。
- warp側は既存 `finishWarpEntry` disposerを維持し、overlay class、`hidden`、listener、timer、`WARP_ENTRY_KEY`を従来どおりcleanupする。
- 多重 `mount()` は既存 `activeInstance` ガードに従い、warpまたはgateのlistenerを重複登録しない。
- warp優先ロードでも、PUSH START用listenerやtimerを登録しない。

## 後続実装のテストシナリオ

同一の実ブラウザ相当ページロードで、最低限次を保証する。既存assertionの削除、緩和、skipは行わない。

| production top | warp key | PUSH START key | 期待する初期動作 | ロード後の期待 |
|---|---:|---:|---|---|
| yes | `'1'` | なし | warpのみactive、gateはhidden | warp終了時にwarp keyだけ削除され、gateは表示されない |
| yes | `'1'` | `'1'` | warpのみactive、gateはhidden | warp終了時もgateは表示されず、PUSH START keyは維持される |
| yes | なし | なし | gateのみ表示 | 操作完了時にPUSH START keyが`'1'`となり、warpは開始しない |
| yes | なし | `'1'` | overlayを表示しない | MENUの既存初期状態を維持する |
| no | `'1'` | なし | overlayを表示しない | preview等の非productionページ挙動を変更しない |

追加の回帰確認:

1. `tests/preview-2d-warp-entry.test.js` の既存warp cleanup assertionがそのままPASSする。
2. PUSH START専用テストで、warp keyを設定してreloadした際に `#push-start-gate.hidden === true` かつ `aria-hidden === 'true'` をwarp開始中と終了後の両方で確認する。
3. PUSH START専用テストで、warp優先ロード中にgate用listenerが反応せず、PUSH START keyが書き換わらないことを確認する。
4. `unmount()` 後にwarp / gate双方のlistener、class、timerが残らず、再mountで判定が一度だけ行われることを確認する。
5. `tests/task-011-production-feature-regression.test.js` で2つのsession keyが別文字列であることを維持する。

## 対象外

- PUSH START gateのvisual design変更
- keyboard遮断、focus containment、touchゴーストクリック防止の具体実装
- warp animationの時間、見た目、cleanup仕様の変更
- 320px overflowを含む無関係なCSS変更
