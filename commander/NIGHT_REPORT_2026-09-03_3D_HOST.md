# NIGHT REPORT — 3D Host

日付: 2026-09-03

対象: `ryotei_site` のUnity WebGL単独ページ基盤

作業ブランチ: `ai-night/2026-09-03-1323`

作業終了時の判定: **PASS（実ブラウザ手動QAを除く）**

## 結果概要

- Unity WebGL成果物4点をWeb repo内の専用ディレクトリへ配置し、コピー元とサイズ・SHA-256が一致することを確認した。
- `preview-3d.html` は2DのCSS、JavaScript、state、contentに依存しない独立ページになっている。
- `window.RYOTEI_HOST_3D = { mount, unmount, getState }` を実装した。
- Claudeレビューで不足を指摘されたloader `onerror`、loading中unmount、stale instance、Quit失敗の各テストとhost JS静的ガードを追加した。
- 新規4テストはすべてPASS。全体QAは `21/27 PASS` で、追加4テスト分だけPASSが増え、既知6 FAILの件数・テスト名は着手前と同じだった。
- 2Dおよびproduction保護対象ファイルは無変更。Unity repoも無変更。
- commit、push、deployは実施していない。

## Claudeレビュー対応

- loader scriptの`onerror`を発火し、error UI、例外非送出、古いscript除去、fresh retryを検証した。
- loader保留中のunmountと、初期化Promise解決前のunmountを分けて検証した。cancel由来のunhandled rejectionがなく、遅れて得たinstanceを1回だけ`Quit()`して`idle`を維持する。
- `Quit()` rejection時もunmountが解決し、DOM/参照を破棄して警告を1回記録することを検証した。
- host JSに`alert()`、外部URL、別の`RYOTEI_*`グローバル、`unityShowBanner`が混入しない静的ガードを追加した。
- lifecycle harness生成直後の初期`idle`を検証した。
- 2D回帰ガードに`PREVIEW_3D_PROD_BASE_REF`を追加し、commit後も任意baseとの差分を検査できるようにした。`HEAD`を指定した実行もPASSした。
- 初期化中にfatal bannerを受けた`mount()`はinstanceをcleanup用に保持しつつ`null`を返すようにし、その契約をテストした。

## Phase 0との差分

- NIGHT_GOAL §3.6には「現在24個」とあるが、着手前runnerの実測は23テストだった。§7.1の正式ベースライン `17/23 PASS` とは一致する。
- 今回の再開時点ではブランチHEADが `28df854` で、TASK-3D-02/03の成果物は既に存在し、`assets/js/preview-3d-host.js` だけが実装途中の未コミット差分だった。
- そのほか、Unity version、Unity commit、成果物名、loader API、配信パスにNIGHT_GOALとの不一致はなかった。

## Task実行記録

| Task | 目的・変更 | 影響範囲 | リスク | テスト・完了条件 | Rollback |
| --- | --- | --- | --- | --- | --- |
| TASK-3D-01 | baseline固定 | 読み取りのみ | なし | 着手前 `17/23 PASS` を記録 | 不要 |
| TASK-3D-02 | Unity成果物、`.gitattributes`、来歴記録 | `assets/3d/unity/`, `.gitattributes` | binary破損 | 元/先のサイズとSHA-256一致 | 新規assetと属性ファイルを除去 |
| TASK-3D-03 | 独立host page | `preview-3d.html` | 2D依存混入 | static contract PASS | 新規HTMLを除去 |
| TASK-3D-04 | mount/loading/error/unmount | `assets/js/preview-3d-host.js` | stale instance、cleanup順序 | lifecycle test PASS | host JSを直前状態へ戻す |
| TASK-3D-05 | 3D専用responsive UI | `assets/css/preview-3d.css` | 既存CSSへの波及 | 専用CSSのみ参照 | 新規CSSを除去 |
| TASK-3D-06 | crawler除外 | `robots.txt` 末尾2行 | 指定外pathの遮断 | 差分が追記2行のみ | 末尾2行を除去 |
| TASK-3D-07 | 静的・asset・lifecycle・2D回帰ガード | `tests/preview-3d-*.test.js`, manual QA文書 | false positive | 新規4テストPASS | 新規テスト/文書を除去 |
| TASK-3D-08 | 全体QAと証跡 | 本レポート | 既知FAILとの混同 | `21/27 PASS`、diff/status確認 | 本レポートを除去 |

## Unity成果物

コピー元: `C:\Users\oyasi\Documents\Codex\ryotei_unity\Build\WebGL\Build`

| File | Size (bytes) | SHA-256 |
| --- | ---: | --- |
| `WebGL.data.unityweb` | 944493 | `CADDCC6DF355004CD1F72CC20FDE660E253A2AB74CE7A85329B3A0CDD5001A37` |
| `WebGL.framework.js.unityweb` | 82806 | `8213F3C010DE3061EF271B0D3D89DC4FF6E275E4006AB5C1779AF4FD9383A8B0` |
| `WebGL.loader.js` | 47867 | `B1479337ECAE2DD48137E75409B629198EE4093ED50D201C4492F07EC87AB4D8` |
| `WebGL.wasm.unityweb` | 4073160 | `F2D7F50D0319C5E8274E99CEF8DB43B9ACB874153CD693D3970B028FED6DD6A2` |

2026-09-03の最終照合で4点すべてコピー元と一致した。Decompression FallbackはONで、無効化禁止。詳細な来歴は `assets/3d/unity/BUILD_INFO.md` に記録済み。

## 追加・変更ファイル

今夜の全成果物:

- 新規: `.gitattributes`
- 新規: `preview-3d.html`
- 新規: `assets/css/preview-3d.css`
- 新規: `assets/js/preview-3d-host.js`
- 新規: `assets/3d/unity/Build/WebGL.loader.js`
- 新規: `assets/3d/unity/Build/WebGL.data.unityweb`
- 新規: `assets/3d/unity/Build/WebGL.framework.js.unityweb`
- 新規: `assets/3d/unity/Build/WebGL.wasm.unityweb`
- 新規: `assets/3d/unity/BUILD_INFO.md`
- 新規: `tests/preview-3d-static-contract.test.js`
- 新規: `tests/preview-3d-asset-layout.test.js`
- 新規: `tests/preview-3d-host-lifecycle.test.js`
- 新規: `tests/preview-3d-no-2d-regression.test.js`
- 新規: `docs/investigation/PREVIEW_3D_MANUAL_QA.md`
- 新規: `commander/NIGHT_REPORT_2026-09-03_3D_HOST.md`
- 追記: `robots.txt`

## robots.txt

最終全文:

```text
User-agent: *
Disallow: /admin.html
Disallow: /supabase/
Disallow: /lain.html
Disallow: /preview-2d.html
Disallow: /preview-3d.html
Disallow: /assets/3d/
```

既存4つの`Disallow`は削除・並べ替えせず、末尾2行のみ追加した。

## Host lifecycleと公開API

状態機械:

```text
idle -> loading -> ready
  \        |
   +----> error
```

公開グローバルは `window.RYOTEI_HOST_3D` のみ。

- `mount(root?)`: loader scriptとcanvasを用意し、`window.createUnityInstance` を呼ぶ。二重mountは同じPromise/instanceを返す。
- `unmount()`: `unityInstance.Quit()` のPromiseを待ち、その解決後にcanvas、loader script、listener、参照を破棄して`idle`へ戻す。
- `getState()`: `idle | loading | ready | error` を返す。
- script読込時はdocumentのreadyStateに応じて同期または`DOMContentLoaded`後に自動mountする。この自動mountはhost pageに別bootstrapを置かないための追加契約である。

レビュー修正後は、`error`からの`mount()`が必ず`unmount()`を経由する。fatal bannerや`webglcontextlost`でinstanceが生存していても、古いinstanceを`Quit()`し、古いscript/canvasを破棄してから新しい起動を作る。初期化中のfatal bannerではinstanceをcleanup用に保持しつつ、`mount()`の解決値は成功と誤認されないよう`null`にする。canvas listenerは登録先要素をclosureに保持し、整数化した進捗%が変わらない更新はlive regionへ再書き込みしない。Quit失敗時はcleanupを継続しつつ`console.warn`へ痕跡を残す。

## 新規テスト

| Test | 内容 | 結果 |
| --- | --- | --- |
| `preview-3d-static-contract.test.js` | noindex、canvas、loading/error、相対path、2D資産/外部URL/fallback engine不使用、hostの`alert`/外部URL/別RYOTEIグローバル/既定banner不使用 | PASS |
| `preview-3d-asset-layout.test.js` | 4成果物、`.unityweb`、host config、BUILD_INFO、実サイズ・SHA-256、binary属性 | PASS |
| `preview-3d-host-lifecycle.test.js` | 初期idle、二重mount、loader/init reject、loading中unmount、stale排除、Quit成功/失敗、listener cleanup、remount、fatal errorと進捗抑制 | PASS |
| `preview-3d-no-2d-regression.test.js` | 指定2D/indexファイルのworking tree差分なし。`PREVIEW_3D_PROD_BASE_REF`指定時はcommit後もbaseとの差分を検査 | PASS |

`node --check` はhost JSと新規テスト4本ですべてPASSした。

## 全体QA比較

実行コマンド: `node tests/run-2d-mode-final-qa.js`

| 時点 | PASS | FAIL | 合計 |
| --- | ---: | ---: | ---: |
| 着手前 | 17 | 6 | 23 |
| 修正後 | 21 | 6 | 27 |

修正後も次の既知6 FAILのみだった。

- `task-004-3d-fallback.test.js`
- `task-005-production-responsive.test.js`
- `task-007-production-integration.test.js`
- `task-008-push-start-gate.test.js`
- `task-011-production-feature-regression.test.js`
- `task-012-seo-a11y-advertisement.test.js`

着手前と修正後でテスト名、件数、主要failure内容に悪化はない。今回の3D追加による7件目のFAILは発生していない。

## 2D regression証跡

次のファイルを指定した`git diff --exit-code`はexit 0だった。

```text
preview-2d.html
assets/js/preview-2d.js
assets/js/preview-2d-state.js
assets/css/preview-2d.css
assets/css/2d-tokens.css
index.html
content.js
search.html
card.html
admin.html
admin.js
market.js
lain.html
price.html
```

出力: `PROTECTED_FILES_UNCHANGED`

`git diff --check`はwhitespace errorなし。LF→CRLFのworking-copy警告のみだった。

## Unity repo無変更の証跡

`C:\Users\oyasi\Documents\Codex\ryotei_unity` での結果:

```text
## main
fef3926
```

tracked/untracked差分なし。Unity repoへの書き込みは行っていない。

## 人間確認が必要な項目

実ブラウザのUnity起動QAは未実施。`docs/investigation/PREVIEW_3D_MANUAL_QA.md` に次を残した。

- loading 0%→100%
- Cube/Floor表示
- WASD、Q/E、右ドラッグ
- console/uncaught errorなし
- Build一時リネーム時のerror UI
- error中も2Dリンク利用可能
- 2D previewの従来動作

## Known issues / TODO / BLOCKED

- BLOCKED: なし。
- Known issue: 全体QAの既知6 FAIL。承認済みbaselineであり、今回のスコープでは修正しない。
- TODO: `.nojekyll` は追加していない。本番配信で問題が出た場合のみ別taskで判断する。
- TODO: meta CSPを導入する場合は `script-src` に `wasm-unsafe-eval` が必要。
- TODO: 2D↔3Dのproduction mode統合と `?view=3d` 対応は次回以降。
- TODO: push前に実ブラウザ手動QAを完了する。

## 次回のnext steps

1. 人間がmanual QAを実施し、結果をチェックリストへ記録する。
2. 2D側の`resolveView()`とmode切替を変更する前に、2D↔3D統合の設計レビューを行う。
3. `index.html`のCOMING SOON解除、history/URL、focus、page lifecycleの仕様を個別Phaseへ分ける。
4. GitHub Pages公開前にnoindex/robots、`.unityweb`取得、Decompression Fallbackを実環境で再確認する。

NOXへ直ちに回す必要がある3D host固有問題はない。既知6 FAILを別スコープで原因調査する場合は、まずread-only診断としてNOXへ渡す余地がある。
