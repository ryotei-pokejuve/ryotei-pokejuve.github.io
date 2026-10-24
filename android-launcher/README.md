# RYOTEI LAUNCHER（Android）

GBAのRPGで遊んでいるような見た目の、Android用ホームアプリ（ランチャー）。

- **FIELD**：草むらのフィールドに白いウィンドウ。お気に入りアプリ6個を「てもち」として並べ、起動回数でLvとEXPが上がる
- **CYBER**：電脳グリッドの背景。アプリ一覧が「チップフォルダ」になり、名前の頭文字がチップコードになる
- 上部は時計と電池残量（HPバー）、下部はメッセージウィンドウ（1文字ずつ出る）
- 効果音は矩形波のピコピコ音（メニューでON/OFF）

画像・フォント以外の素材はすべてコードで描画しており、既存ゲームの画像は使っていない。フォントは [DotGothic16](https://github.com/fontworks-fonts/DotGothic16)（SIL Open Font License、`app/src/main/assets/fonts/OFL.txt`）。

## インストール

1. Androidで https://github.com/ryotei-pokejuve/ryotei-pokejuve.github.io/releases/tag/launcher-latest を開き、`ryotei-launcher.apk` をダウンロード
2. 開いてインストール（「提供元不明のアプリ」の許可を求められたら許可）
3. ホームボタンを押して「RYOTEI LAUNCHER」を選び「常時」。あとからでも、メニューの「ホームアプリ」から切り替えられる

`android-launcher/` 以下を変更してpushすると、GitHub Actionsが自動でAPKをビルドして上のリリースを最新版に置き換える。

## 操作

| 場所 | 操作 | 動き |
| --- | --- | --- |
| ホーム | てもちをタップ | アプリを起動 |
| ホーム | てもちを長押し | ひらく / いれかえる / はずす / アプリじょうほう |
| ホーム | あき枠をタップ | アプリを選んで入れる |
| ホーム | 上にスワイプ・「バッグ」 | アプリ一覧 |
| ホーム | 下にスワイプ | 通知を開く |
| ホーム | 時計をタップ | 時計アプリ |
| ホーム | 「メニュー」・何もない所を長押し | テーマ、サウンド、オープニング、ホームアプリ、端末設定、レポート |
| アプリ一覧 | タップ / 長押し | 起動 / てもちに入れる・アプリ情報・アンインストール |
| アプリ一覧 | 左右スワイプ・タブ | すべて / よくつかう / さいきん |
| アプリ一覧 | 右端をドラッグ | 早送りスクロール |

## 構成

- `Engine.java` … 画面・操作・演出のすべて。約270ドット幅の低解像度キャンバスに描き、整数倍で拡大表示する
- `Scenery.java` / `Theme.java` / `Pix.java` … 背景タイル、配色、ドット描画の道具
- `HomeActivity.java` / `GameView.java` / `AndroidHost.java` / `Sfx.java` / `PixelIcon.java` … Android側（アプリ一覧・起動・電池・効果音・アイコンのドット絵化）
- `tools/preview/` … Android SDKなしで画面をPNGに書き出す確認ツール（`sh tools/preview/run.sh 出力先`）

署名鍵はリポジトリに置いていない。GitHub Actionsが初回ビルドで鍵を作ってキャッシュに保存し、以降はそれで署名する（同じ鍵なので上書き更新できる）。キャッシュは7日間ビルドが無いと消えることがあり、その後のビルドは鍵が変わって「アプリが競合」と出る（いったんアンインストールすれば入る）。確実にしたい場合は自分で鍵を作り、リポジトリの Settings → Secrets に `LAUNCHER_KEYSTORE_B64`（keystoreをbase64にしたもの、エイリアスは `ryotei`）と `LAUNCHER_KEYSTORE_PASSWORD` を登録する。
