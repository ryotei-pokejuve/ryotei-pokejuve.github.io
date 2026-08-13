# りょていの冒険の書

GBA / RPG風タイトル画面から始まるホームページ。`index.html` + `assets/`フォルダ（キャラクター画像など）で構成。

## ローカルで確認する

`index.html` をダブルクリックしてブラウザで開くだけ。

## ページ内容を更新する

1. `index.html` を開く
2. `PAGES` オブジェクト内、該当ページ（`top` / `profile` / `history` / `blog` / `contact`）の `html: function(){ return '...'; }` の中身を編集
3. 保存してブラウザをリロード

新規ページの追加方法は3箇所編集（メニューHTML / `PAGE_ORDER` / `PAGES`）。詳細はファイル内コメント参照。

## GitHubで公開する

```bash
git add .
git commit -m "update: ページ内容を更新"
git push
```

初回セットアップは会話ログ、またはGitHubのリポジトリ設定 → Pages で確認。

## Google Analytics

`index.html` 末尾の `GA_MEASUREMENT_ID` に測定ID（`G-XXXXXXXXXX`）を入れるだけで有効化。

## YouTube導線

`YOUTUBE_CHANNEL_URL` をチャンネルURLに変更。`YOUTUBE_FEATURED_VIDEO_ID` に動画IDを入れるとトップページに埋め込み表示される。

## 広告（Google AdSense）

AdSense審査通過後、`index.html` 末尾の `ADSENSE_CLIENT`（ca-pub-...）と `ADSENSE_SLOTS`（本文下・フッターの広告スロットID）を入れるだけで有効化。未設定の間は広告枠自体が非表示。

## YouTube自動更新の設定（動画一覧 / Shorts / ポケカ動画 / おすすめ / 実績）

メニューの5ページは、設定するとYouTubeから自動で最新情報を取得して表示される（未設定なら「未設定です」と表示されるだけで壊れない）。

**1. APIキーを取得する**

1. [Google Cloud Console](https://console.cloud.google.com/) で新しいプロジェクトを作成
2. 「APIとサービス」→「ライブラリ」から **YouTube Data API v3** を検索して有効化
3. 「認証情報」→「認証情報を作成」→「APIキー」でキーを発行
4. 発行したキーを選択し、「アプリケーションの制限」を **HTTPリファラー** にして、自分のサイトのURL（例: `https://ryotei-pokejuve.github.io/*`）を登録（キーの流出防止のため必須）
5. できたキーを `index.html` の `YOUTUBE_API_KEY` に貼る

**2. チャンネルIDを確認する**

YouTube Studio → 設定 → チャンネル → 詳細設定、または自分のチャンネルページのURLで確認できる（`UC`から始まる文字列）。`YOUTUBE_CHANNEL_ID` に貼る。「動画一覧」ページと「実績」ページ（登録者数・総再生数など）に使われる。

**3. Shorts / ポケカ動画 / おすすめ用の再生リストを作る**

YouTube Studio上で、動画をジャンルごとに分けた再生リストを3つ作成（例: 「Shorts」「ポケカ動画」「おすすめ」）。各再生リストのURL（`list=`以降）が再生リストID。それぞれ `YOUTUBE_PLAYLIST_SHORTS` / `YOUTUBE_PLAYLIST_POKECA` / `YOUTUBE_PLAYLIST_RECOMMEND` に貼る。動画を追加すればサイト側も自動で更新される。

**4. 反映**

いつも通り `index.html` を上書きして `git add . && git commit -m "..." && git push`。新しい動画は公開後7日以内なら自動で「NEW」バッジが付く。
