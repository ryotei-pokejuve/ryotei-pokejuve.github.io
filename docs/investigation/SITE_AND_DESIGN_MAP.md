# 既存サイト × Claude Design 対応マップ

作成日: 2026-08-24

対象: TASK-001（調査ドキュメントのみ。既存コード変更なし）

## 1. 調査範囲と前提

- 恒久仕様 `PROJECT.md` と今回目標 `NIGHT_GOAL.md` は、今回の依頼本文で提示された内容を正本として確認した（リポジトリ内には同名ファイルなし）。
- 承認済み2D Design正本として `docs/design/2d/IMPLEMENTATION.md` を確認した。
- Designプロトタイプ `docs/design/2d/2D Mode UI.dc.html` は、仕様の実例とダミーデータの識別にのみ使用した。
- `docs/ui-references/` と `docs/design/2d/uploads/` は参考画像群であり、本番素材として扱わない。
- 現行サイトについて、公開HTML、共通CSS/JavaScript、`assets/`、`supabase/`、`README.md`、`robots.txt`、`ads.txt` を静的に調査した。
- 「正常動作している機能」はコードと既存検証レポートから確認した現行仕様を指す。外部API・認証を伴う実環境の再試験は、本タスクが文書追加のみのため行っていない。

## 2. 現行ディレクトリと役割

| パス | 役割 | 維持すべき内容・注意点 |
|---|---|---|
| `index.html` | 公開トップ。起動画面を持つGBA/RPG風UI | `content.js` の各ページ、カード相場への導線、テーマ、音、Lainワープ、ハッシュ履歴、フッター法務リンク |
| `lain.html` | `index.html` と同じコンテンツを別UIで表示するレトロサイバー系モード | `content.js` 共有、カード相場導線、音、GBA側への復帰、ハッシュ継承。`noindex` |
| `content.js` | `index.html` / `lain.html` の共有コンテンツ・YouTube取得処理 | `PAGES`、`PAGE_ORDER`、プロフィール、更新履歴、レポート、SNS、動画一覧、チャンネル実績。UIから分離済みの主要データ層 |
| `search.html` | カード検索・絞り込み・ページング | カード名/型番、パック、レアリティ検索、検索状態保存。`noindex` |
| `card.html` | カード詳細・現在参考価格・価格履歴 | URLクエリのカードID、検索結果への復帰、画像URLの安全化。`noindex` |
| `market.js` | 公開カード相場の共有ロジック | Supabase公開RPC、表示形式、HTTPS画像URL検証、`sessionStorage` の検索状態 |
| `admin.html` | URLを知る管理者向けのカード・価格管理画面 | サイトメニューには非掲載。ログイン、カード検索/登録/編集、価格登録。`noindex, nofollow` |
| `admin.js` | 管理画面専用ロジック | Supabase Auth、管理者確認、管理RPC。公開読み取り用 `market.js` と意図的に分離 |
| `about.html` | サイト/運営者情報 | 実サイトの目的、掲載内容、価格の注意、運営者・権利表示 |
| `privacy.html` | プライバシーポリシー | Cookie、広告、YouTube/X/Supabase等の外部サービス |
| `terms.html` | 免責事項・利用規約 | 掲載情報、カード価格、損害、禁止事項、権利 |
| `contact.html` | 問い合わせ案内 | Xへの連絡導線、カード情報訂正、個人情報・権利連絡の注意 |
| `info.css` | 上記4情報ページの共有CSS | 二重縁風ウィンドウとモバイル1列化 |
| `assets/` | 現行UI画像 | `boot-bg.jpg`、`character.png`。リニューアル時も権利・出典を確認し、理由なく削除しない |
| `supabase/` | DBスキーマ/パッチ/検証・復元資料 | カード相場DBと公開/管理RPCの正本群。公開サイトUI改修で破壊的変更をしない |
| `robots.txt` | クローラ制御 | `/admin.html`、`/supabase/`、`/lain.html` を拒否 |
| `ads.txt` | 広告事業者宣言 | Google publisher IDを公開する標準ファイル |
| `README.md` | 現行構成・運用説明 | GitHub Pages前提、YouTube設定、Supabase運用、広告/Analyticsの案内。ただし後述の実装差異あり |

`.github/`、GitHub Actions設定、`sitemap.xml` は現時点で存在しない。GitHub Pagesは `README.md` に公開手順と想定URLの記載があるが、リポジトリ内に専用デプロイワークフローはない。

## 3. 現行コンテンツとナビゲーション

### 3.1 共有ページデータ

`content.js` の `PAGE_ORDER` は次の順序で、`index.html` と `lain.html` の双方が利用する。

1. `top`: サイト紹介、注目動画、YouTubeチャンネル導線
2. `videos`: YouTube投稿動画一覧
3. `shorts`: Shorts再生リスト
4. `pokeca`: ポケカ動画再生リスト
5. `live`: ライブ配信再生リスト
6. `achievements`: 登録者数・動画数・総再生数
7. `profile`: りょていのプロフィール
8. `history`: サイト更新履歴
9. `blog`: レポート/記事（現状は準備中）
10. `sns`: X、YouTube等の外部導線

カード相場は `PAGES` 内ではなく、メニューの通常リンクから `search.html` へ遷移する。About / Privacy / Terms / Contact は両モードのフッターから独立HTMLへ遷移する。`admin.html` は公開メニューに載せない。

### 3.2 現行URL状態

- トップ内ページは `index.html#top`、`#videos` 等のハッシュで状態を表し、`history.pushState` と `popstate` によりブラウザ戻る/進むへ対応する。
- `lain.html` も同じハッシュキーを使用し、モード移動時にハッシュを引き継ぐ。
- カード検索は `search.html`、詳細は `card.html?id=...` の独立ページである。
- About等の情報ページも独立URLである。
- Designの理想形である `/specimens/003` のようなパスルートは未実装。GitHub Pagesの静的配信互換性と既存URL維持を考慮し、後続実装で一足飛びに置換しない。

## 4. Claude Designの要点

`docs/design/2d/IMPLEMENTATION.md` が定める必須原則は以下である。

- P1: 外周borderとinsetによる二重縁ウィンドウ
- P2: 状態バー / 操作領域 / 常設メッセージ窓の三段構成
- P3: 選択を背景反転・左バー・`▶` の複数手段で示す
- P4: 分類色をチップ内に限定し、本文色を分類で変えない
- P5: 数値は連続バーでなく10粒の離散ピップ
- P6: 方向キー、Enter、Escで到達可能にし、マウス/タッチも同じ状態遷移を使う

加えて、Dark/LightのCSSトークン、`localStorage['nota.theme']`、和文と数値用フォントの役割分離、430px以下の4列下部タブ、44×44px以上のタッチ領域、画面別カーソル保持、`aria-activedescendant`、Tabを奪わない単一keydownハンドラ、`prefers-reduced-motion`、URL同期、メッセージ窓直下の予約済み広告枠、同一状態を使う将来3Dレンダラと `?view=3d` が指定されている。

## 5. Designルートと実サイトの対応マップ

Designの4ルートは情報構造の型として使い、ダミー名称や架空データは移植しない。実サイトには4分類を超える既存コンテンツがあるため、1対1に削減せず次のように包含する。

| Design上の画面/型 | 対応する実サイト内容 | 実装時の扱い |
|---|---|---|
| `/` / `menu` / `MENU[]` | トップ、動画一覧、Shorts、ポケカ動画、ライブ配信、実績、プロフィール、更新履歴、レポート、SNS、カード相場への入口 | 端末トップ/主ナビとして実メニューを保持する。Designの「4項目」に合わせて既存項目を削除しない。必要なら「動画」「サイト情報」等の親カテゴリを設けるが、全項目へ到達可能にする |
| `/specimens` / `list` / `ITEMS[]` | `search.html` のカード一覧と `card.html` のカード詳細・価格履歴 | 一覧＋詳細ペインというDesign構造と最も整合する。名称は「カード図鑑」「カード検索」等の実サイト語彙を使い、架空標本名・数量・能力値を使わない。価格や履歴はDBの実値のみ表示する |
| `/areas` / `map` / `AREAS[]` | 直接対応する実データなし。候補は「動画」「カード相場」「活動/プロフィール」「記録/SNS」など実コンテンツ群へのカテゴリナビ | 架空区域、調査済/未踏/封鎖状態を作らない。「区域図」の見た目を使う場合も実在コンテンツのカテゴリ/ハブとして再定義する。独立routeが不要なら無理に設置しない |
| `/log` / `log` / `LOGS[]` | `history` の更新履歴、`blog` のレポート、`sns` の活動導線。動画一覧の公開日も日付データとして参照可能 | 更新履歴を主対応とし、レポート/SNSへ分岐可能にする。架空の観測記録や区域コードは使わない。YouTube動画は既存動画画面を維持し、ログへ重複コピーしない |
| `config`（プロトタイプ内メニュー） | テーマ、サウンド、アニメーション/Reduced Motion、将来の2D/3D切替 | コンテンツではなく共通settingsとして分離する。既存テーマ選択を移行し、音はユーザー操作後のみ鳴らす |
| 常設メッセージ窓 | 選択中メニュー/カード/動画/設定の説明、操作ヒント、API状態 | 選択エンティティから文言を導出する。Designの標本説明を流用しない |

### ダミーコンテンツの明確な除外

プロトタイプ内の `NOTA-II`、`SPECIMENS`、`AREAS`、`LOG`、霜結晶・灯苔等の標本、灯台岬等の区域、区域コード、調査状態、架空観測ログはデザイン検証用である。本番へデータ、名称、説明文、世界設定として移植しない。利用できるのは、一覧＋詳細、グリッド、時系列、設定画面という抽象的な情報構造だけである。

## 6. 現在の主要機能

| 機能 | 実装箇所 | 現状 |
|---|---|---|
| ブート演出 | `index.html` | クリック、Enter、Spaceで開始し、遅延後に本体を表示 |
| コンテンツ切替 | `index.html` / `lain.html` + `content.js` | 共通 `PAGES` を描画し、URLハッシュを更新 |
| キーボード選択 | `index.html` / `lain.html` | 方向キーで巡回選択。現状は選択と同時にページ描画され、Enter決定/Esc戻る、フォーム除外、単一keydownというDesign仕様には未統合 |
| マウス/タッチ | 各HTML | メニュー項目やボタンのclickで操作可能。専用touch処理に依存しない |
| テーマ切替 | `index.html` | `gba` / `dark` を切替し `localStorage['ryotei-theme']` に保存。Design指定のLight/Darkトークンとキー名には未移行 |
| サウンド | `index.html` / `lain.html` | Web Audio APIで操作音を生成しON/OFF可能。設定は永続化しない |
| Lainワープ | `index.html` ↔ `lain.html` | 演出付きで往復しハッシュを維持。復帰演出を `sessionStorage` で連携 |
| YouTube表示 | `content.js` | Data API v3でチャンネル統計、アップロード/再生リストを取得。12件ずつ追加表示し、失敗時は空/案内へフォールバック |
| カード検索 | `search.html` + `market.js` | クエリ、パック、レアリティ、ページング。Supabase公開RPCのみ使用 |
| 検索状態復元 | `market.js` / `search.html` / `card.html` | `sessionStorage['market-search-state']` と履歴で条件・位置を復元 |
| カード詳細/価格履歴 | `card.html` + `market.js` | 詳細、参考価格、直近履歴を取得。HTTPS以外の画像URLは拒否 |
| 管理画面ログイン/更新 | `admin.html` + `admin.js` | Supabase Auth後に管理者RPCで権限確認し、カード・価格を管理。DB側 `is_admin()` が実際の境界 |
| 情報/法務ページ | `about.html` 等 + `info.css` | 独立HTMLで通常リンク可能。SEO/広告審査上の基礎ページ |

## 7. 外部依存と鍵の扱い

| 外部サービス/依存 | 用途 | 現行の扱い | 鍵・安全上の区分 |
|---|---|---|---|
| YouTube Data API v3 | 動画/再生リスト/統計 | `content.js` からbrowser fetch | APIキーはクライアントに露出する公開前提の識別子。秘密鍵としては扱えないため、Google Cloud側でHTTP referrerとAPIを制限し、クォータを監視する。権限を持つ秘密情報は置かない |
| YouTube iframe / YouTubeリンク | 注目動画と外部視聴 | `youtube.com/embed`、通常リンク | 埋め込みは遅延読込。外部リンクは `noopener noreferrer` |
| Supabase | カード検索、価格履歴、管理認証/RPC | `supabase-js@2.112.3` をjsDelivr CDNから固定版+SRIで読込 | `sb_publishable_...` は公開用キー。安全性はRLS/権限/RPCで担保する。`service_role`、DBパスワード、管理者メール/パスワード、JWTは絶対にリポジトリへ置かない |
| Google Fonts | DotGothic16、Press Start 2P、LainのみShare Tech Mono | `fonts.googleapis.com` / `fonts.gstatic.com` | 鍵なし。Design指定フォントへ移行する場合もフォールバックと表示性能を維持する |
| Google AdSense | 将来広告 | `index.html` / `lain.html` にアカウントmeta、`ads.txt` にpublisher ID | publisher IDは公開情報。本物の広告スクリプト/slot IDは未導入。人間承認なしに追加しない |
| Google Analytics | 将来アクセス解析 | 両モードにローダーコードはあるが `GA_MEASUREMENT_ID` は空 | 測定ID自体は公開識別子だが、現状無効。人間承認なしに設定しない |
| X | SNS、問い合わせ | 外部リンク | 鍵/APIなし。外部リンクに `noopener noreferrer` |

### 秘密情報に関する境界

- 公開可能: Supabase publishable/anon key、AdSense publisher ID、Analytics測定ID、用途と参照元を制限したブラウザ用YouTube APIキー。
- 非公開必須: Supabase `service_role`、DB接続パスワード、管理者資格情報、アクセストークン/JWT、Google Cloudのサーバー用秘密情報。
- 公開可能なキーでも無権限という意味ではない。バックエンド側の最小権限、RLS/RPC、利用元制限が必須であり、リニューアルで既存境界を緩めない。

## 8. 広告、SEO、アクセシビリティ、レスポンシブの現状

### 広告

- `index.html` / `lain.html` に非表示の `.ad-slot` CSSとAdSenseアカウントmetaがあり、`ads.txt` も存在する。
- ただし現コードには `.ad-slot` の実DOM、`adsbygoogle`、`ADSENSE_CLIENT` / `ADSENSE_SLOTS` 変数が見当たらない。READMEの「変数を入れるだけ」という説明とは差異がある。
- 後続実装ではDesignどおり「常設メッセージ窓の直下、端末フレーム内」に広告ラベル付きの予約領域を設ける。本物の広告コードは追加しない。

### SEO/URL

- 全HTMLにtitleがあり、公開主要ページにはdescriptionがある。About等はセマンティックな見出しと通常HTML本文を持つ。
- `search.html` / `card.html` は `noindex, follow`、`lain.html` は `noindex, follow`、`admin.html` は `noindex, nofollow`。主要インデックス対象は `index.html` と情報ページである。
- canonical、OGP、構造化データ、`sitemap.xml` は未確認（現行ファイルにはない）。後続改善候補だがTASK-001では変更しない。
- ハッシュ内コンテンツはクライアント描画であり、重要情報をJSだけに閉じ込めないという完成要件に対して将来の検討が必要。既存URLとブラウザ履歴は維持する。

### アクセシビリティ/操作

- viewport、見出し、nav、button、aria-label、通常リンク等の基礎はある。
- カード系ページには `prefers-reduced-motion` がある一方、`index.html` / `lain.html` の主要演出には同等指定が見当たらない。
- 現行方向キー処理は入力要素の除外や `preventDefault` の限定、`aria-activedescendant`、Enter/Escの共通状態遷移が未統合である。Tabキー自体を捕捉するコードはない。
- Design実装時はdocumentのゲームカーソル用keydownを1つに集約し、input/textarea/select/contenteditableでは無効化する。ネイティブTab順と見えるfocusを維持する。

### レスポンシブ

- 全ページにviewportがある。`index.html` は720px、`lain.html` は640px、情報ページは600px、検索系は560px等でレイアウトを調整する。
- `index.html` は狭幅でメニューを横スクロール化し、検索/管理系の主要ボタンには44pxの高さが設定されている。
- Design正本の430px以下4列下部タブ、全主要ターゲット44×44px、常設メッセージ窓のstatic配置はまだ未実装。後続Phaseで320～430pxを重点確認する。

## 9. 2D共通基盤へ引き継ぐ境界

既存機能を壊さず将来3Dへ拡張するため、後続実装では次の責務分離を基準とする。

| 層 | 既存資産 | 引継ぎ方針 |
|---|---|---|
| content/data | `content.js`、Supabase公開RPC | 実データを唯一の正本にし、2D/3D別コピーを作らない |
| navigation | `PAGE_ORDER`、カード/情報ページの通常リンク、ハッシュ履歴 | 共通route/stateへ包み、既存URLと外部リンクを維持する |
| common state | 現行ハッシュ、テーマ、検索session state | `{theme, screen, cursor, message, view}` に整理し、カーソルは画面別保持 |
| settings | テーマ/サウンドボタン | 保存方針を共通化し、animation/reduced motion/viewを追加可能にする |
| 2D renderer | `index.html` の既存UI + Design正本 | 二重縁、三段、選択表現、メッセージ窓、レスポンシブを実装する |
| future 3D renderer | 現行 `lain.html` は別UIの先行例 | 同じcontent/state/navigationを受ける別rendererへ整理し、必要時のみ遅延ロードする。RUN 01では本格3D不要 |
| message window | 現行は常設共通窓なし | 選択中エンティティから純関数で説明/ヒントを導出する |
| ad slot | 非表示CSSのみ | メッセージ窓直下にラベルと予約高を持つ独立領域を設ける。広告コードは入れない |

## 10. 実装前に守る結論

1. `content.js` の10ページ、カード相場、4情報ページ、非公開管理画面を既存主要機能として維持する。
2. Designの4画面は情報構造として利用し、4項目へ既存メニューを削減しない。
3. `SPECIMENS` はカード一覧/詳細の構造へ、`LOG` は実際の更新履歴等へ対応させる。`AREAS` に対応する実データはないため捏造しない。
4. `NOTA-II` を含むDesign内の名称・標本・区域・観測ログは本番へ移植しない。
5. `content.js` / `market.js` / `admin.js` の現在の分離と、Supabaseの公開/管理権限境界を維持する。
6. 2Dを完全なフォールバックとし、3Dは同じデータ・route・cursorを受ける遅延rendererとして後付けする。
7. URL、ブラウザ履歴、マウス、タッチ、Tab、フォーム入力をゲーム操作のために壊さない。
8. 広告は予約領域までとし、実広告・アカウント設定・公開作業は行わない。
