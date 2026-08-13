# りょていの冒険の書

GBA / RPG風タイトル画面から始まるホームページ。`index.html` 1ファイルで完結（外部ライブラリ・画像アセットなし）。

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
