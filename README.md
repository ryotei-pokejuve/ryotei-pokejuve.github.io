# りょていの冒険の書

GBA / RPG風タイトル画面から始まるホームページ。以下のファイルで構成：

- `index.html` … GBA風UI（メインの入口。PRESS STARTから始まる）
- `lain.html` … Lainモード（黒背景+シアン発光の端末風UI）。index.htmlの右上「👁」ボタンからワープ演出付きで移動できる
- `content.js` … **ページの中身（プロフィール・更新履歴・ブログ・SNS・YouTube連携）を管理する共通ファイル**。index.htmlとlain.htmlの両方がこれを読み込んでいるので、中身の編集は1箇所でOK
- `search.html` … ポケカの検索ページ（カード名・番号・レアリティで検索）
- `card.html` … カード詳細ページ（現在価格・価格履歴を表示）
- `market.js` … カード検索・相場機能の共通ロジック（Supabaseへの接続・検索/詳細/価格履歴の呼び出し）。search.html・card.html・admin.htmlが読み込む
- `admin.html` … カード・価格の管理画面（ログイン必須）。サイトのメニューには**あえて表示していない**（URLを直接知っている人だけが開く想定）
- `admin.js` … 管理画面専用のロジック（ログイン・管理者用RPCの呼び出し）。一般公開のmarket.jsとは分離してある
- `assets/` … 画像（起動画面の背景など）
- `supabase/` … カード検索・相場機能のバックエンド（Supabase）関連のSQL・確認ツール一式。サイト本体の配信には使わないが、DB変更時の記録として残している

見た目（UI）は2種類あるが、中身は完全に共通。「Lainモード」はあくまで別デザインの入口であって、別サイトではない。カード検索・相場機能はメニューの「🎴 カード相場」から入る。データはSupabase（外部のデータベースサービス）で管理しており、`market.js`の`SUPABASE_ANON_KEY`は公開しても安全な鍵（読み取り専用）。

カード・価格の登録は`admin.html`（管理画面）から行う。Supabase Authでログインした上で、`public.admin_users`に登録済みのアカウントだけが実際の登録操作を実行できる（この権限チェックはデータベース側で行っており、`admin.html`を開けること自体はセキュリティ境界ではない）。管理者登録の手順は`supabase/restore_runbook.md`の4章を参照。

## ローカルで確認する

`index.html` をダブルクリックしてブラウザで開くだけ。（`lain.html` も同様に単体で開ける）

※ YouTube自動更新はAPIキーの制限上、ローカルの `file://` では動かないことがある。GitHub Pagesに公開したURLで確認すること。

## ページ内容を更新する

1. `content.js` を開く
2. `PAGES` オブジェクト内、該当ページ（`top` / `profile` / `history` / `blog` / `sns` など）の `html: function(){ return '...'; }` の中身を編集
3. 保存してブラウザをリロード（index.html / lain.html どちらでも変更が反映される）

新規ページの追加方法は4箇所編集（`content.js` の `PAGES` と `PAGE_ORDER` に加えて、`index.html` と `lain.html` それぞれのメニューHTML）。詳細は各ファイル内コメント参照。

## GitHubで公開する

`index.html` / `content.js` / `lain.html` / `assets/` は常にセットで動くので、更新したら必ずまとめてpushする。

```bash
git add .
git commit -m "update: ページ内容を更新"
git push
```

初回セットアップは会話ログ、またはGitHubのリポジトリ設定 → Pages で確認。

## Google Analytics

`index.html` と `lain.html` それぞれの末尾にある `GA_MEASUREMENT_ID` に測定ID（`G-XXXXXXXXXX`）を入れるだけで有効化（両方に同じIDを入れる）。

## YouTube導線

`content.js` の `YOUTUBE_CHANNEL_URL` をチャンネルURLに変更。`YOUTUBE_FEATURED_VIDEO_ID` に動画IDを入れるとトップページに埋め込み表示される（index.html / lain.html 共通で反映）。

## 広告（Google AdSense）

AdSense審査通過後、`index.html` と `lain.html` それぞれの末尾にある `ADSENSE_CLIENT`（ca-pub-...）と `ADSENSE_SLOTS`（本文下・フッターの広告スロットID）を入れるだけで有効化（両方に同じ値を入れる）。未設定の間は広告枠自体が非表示。

## Lainモード

index.htmlの右上にある「👁」ボタンを押すと、画面が黒く収縮するようなワープ演出のあと `lain.html` に切り替わる（3Dから2Dに変わるような演出をイメージ）。lain.html側の「← RETURN」ボタンで同じ演出とともにGBA版に戻れる。ページの中身はcontent.jsを共有しているので、どちらから見ても情報は同じ。

## YouTube自動更新の設定（動画一覧 / Shorts / ポケカ動画 / ライブ配信 / 実績）

メニューの5ページは、設定するとYouTubeから自動で最新情報を取得して表示される（未設定なら「未設定です」と表示されるだけで壊れない）。設定は `content.js` に対して行う（index.html / lain.html 共通で反映される）。

**1. APIキーを取得する**

1. [Google Cloud Console](https://console.cloud.google.com/) で新しいプロジェクトを作成
2. 「APIとサービス」→「ライブラリ」から **YouTube Data API v3** を検索して有効化
3. 「認証情報」→「認証情報を作成」→「APIキー」でキーを発行
4. 発行したキーを選択し、「アプリケーションの制限」を **HTTPリファラー** にして、自分のサイトのURL（例: `https://ryotei-pokejuve.github.io/*`）を登録（キーの流出防止のため必須）
5. できたキーを `content.js` の `YOUTUBE_API_KEY` に貼る

**2. チャンネルIDを確認する**

YouTube Studio → 設定 → チャンネル → 詳細設定、または自分のチャンネルページのURLで確認できる（`UC`から始まる文字列）。`content.js` の `YOUTUBE_CHANNEL_ID` に貼る。「動画一覧」ページと「実績」ページ（登録者数・総再生数など）に使われる。

**3. Shorts / ポケカ動画 / ライブ配信用の再生リストを作る**

YouTube Studio上で、動画をジャンルごとに分けた再生リストを3つ作成（例: 「Shorts」「ポケカ動画」「ライブ配信」）。各再生リストのURL（`list=`以降）が再生リストID。それぞれ `content.js` の `YOUTUBE_PLAYLIST_SHORTS` / `YOUTUBE_PLAYLIST_POKECA` / `YOUTUBE_PLAYLIST_LIVE` に貼る。動画を追加すればサイト側も自動で更新される。

**4. 反映**

いつも通り `content.js` を上書きして `git add . && git commit -m "..." && git push`。新しい動画は公開後7日以内なら自動で「NEW」バッジが付く。index.html / lain.html 両方に反映される。
