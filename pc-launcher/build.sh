#!/bin/sh
# Windows版WIREDランチャーをビルドして pc-launcher/build/jar/wired.jar を作る。
# スマホ版の描画部品（android-launcher）と、android.graphics の代わりのクラス（tools/preview）を一緒にコンパイルする。
set -e
here=$(cd "$(dirname "$0")" && pwd)
root="$here/.."
shim="$root/android-launcher/tools/preview/src/android/graphics"
src="$root/android-launcher/app/src/main/java/io/github/ryotei/launcher"
assets="$root/android-launcher/app/src/main/assets"
out="$here/build"
rm -rf "$out"
mkdir -p "$out/classes" "$out/jar"
javac -encoding UTF-8 --release 21 -nowarn -d "$out/classes" \
  "$shim"/*.java \
  "$src/AppEntry.java" "$src/Host.java" "$src/Theme.java" "$src/Pix.java" "$src/Scenery.java" \
  "$src/TownMap.java" "$src/Wired.java" "$src/Sprites.java" "$src/Engine.java" \
  "$here"/src/io/github/ryotei/launcher/*.java
cp -r "$assets/fonts" "$assets/images" "$out/classes/"
cp "$here/icon.png" "$out/classes/"
jar --create --file "$out/jar/wired.jar" --main-class io.github.ryotei.launcher.PcMain -C "$out/classes" .
echo "built $out/jar/wired.jar"
