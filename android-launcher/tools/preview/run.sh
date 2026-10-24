#!/bin/sh
# Engineの描画をデスクトップのJavaで動かし、台本どおりに操作した30fpsの連番PNGを書き出す（Android SDK不要）。
# 使い方: sh tools/preview/run.sh 出力先ディレクトリ
# 動画にする: ffmpeg -framerate 30.3 -i 出力先/f%05d.png -vf scale=540:-2:flags=neighbor -pix_fmt yuv420p demo.mp4
set -e
here=$(cd "$(dirname "$0")" && pwd)
app="$here/../../app/src/main"
out=${1:-"$here/out"}
cls=$(mktemp -d)
src="$app/java/io/github/ryotei/launcher"
javac -encoding UTF-8 -d "$cls" \
  $(find "$here/src" -name '*.java') \
  "$src/AppEntry.java" "$src/Host.java" "$src/Theme.java" "$src/Pix.java" "$src/Scenery.java" "$src/Overworld.java" "$src/Sprites.java" "$src/Engine.java"
java -Djava.awt.headless=true -cp "$cls" preview.Main "$app/assets/fonts/DotGothic16-Regular.ttf" "$out"
rm -rf "$cls"
echo "wrote $out"
