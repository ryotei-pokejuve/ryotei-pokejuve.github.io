# Preview 3D Manual QA

更新日: 2026-09-03

Unity WebGLの実ブラウザ起動は、headless環境によるfalse failureを避けるため自動QAの必須条件に含めない。公開・push前に、次の手順を人間が実施する。

## 起動手順

```powershell
cd C:\Users\oyasi\Documents\Codex\2026-08-16\claude-code-web-ui-csv-api\ryotei_site
python -m http.server 8000
```

ブラウザで `http://localhost:8000/preview-3d.html` を開く。

## 確認項目

- [ ] loading進捗が0%から100%まで進む
- [ ] CubeとFloorが表示される
- [ ] WASD、Q/E、右ドラッグによる操作が効く
- [ ] console errorまたはuncaught exceptionが発生しない
- [ ] `assets/3d/unity/Build/` を一時的にリネームした状態ではerror UIが表示され、白画面にならない
- [ ] error UI表示中も `preview-2d.html` へのリンクを操作できる
- [ ] `http://localhost:8000/preview-2d.html` が従来どおり動く

## 復旧と注意

- エラー確認後は、リネームした `assets/3d/unity/Build/` を必ず元の名前へ戻す。
- Unity成果物はDecompression Fallbackが有効な `.unityweb` 構成を維持する。
- Unity repo `C:\Users\oyasi\Documents\Codex\ryotei_unity` は参照専用であり、変更しない。
- `.nojekyll` は今夜のスコープでは追加しない。
- meta CSPを将来追加する場合、Unity WebAssemblyのため `script-src` に `wasm-unsafe-eval` が必要になる。
