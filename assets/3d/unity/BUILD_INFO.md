# Unity WebGL Build Information

## Provenance

- Source: `C:\Users\oyasi\Documents\Codex\ryotei_unity\Build\WebGL\Build`
- Unity version: `6000.3.23f1`
- Unity repository commit: `fef3926`
- Copied at: `2026-09-03T13:30:01+09:00`
- Decompression Fallback: **ON**

Decompression Fallback must not be disabled. The `.unityweb` artifacts rely on loader-side decompression so they can be served safely by GitHub Pages without custom `Content-Encoding` response headers.

## Files

| File | Size (bytes) | SHA-256 |
| --- | ---: | --- |
| `Build/WebGL.data.unityweb` | 944493 | `CADDCC6DF355004CD1F72CC20FDE660E253A2AB74CE7A85329B3A0CDD5001A37` |
| `Build/WebGL.framework.js.unityweb` | 82806 | `8213F3C010DE3061EF271B0D3D89DC4FF6E275E4006AB5C1779AF4FD9383A8B0` |
| `Build/WebGL.loader.js` | 47867 | `B1479337ECAE2DD48137E75409B629198EE4093ED50D201C4492F07EC87AB4D8` |
| `Build/WebGL.wasm.unityweb` | 4073160 | `F2D7F50D0319C5E8274E99CEF8DB43B9ACB874153CD693D3970B028FED6DD6A2` |

## Packaging notes

- `StreamingAssets` is not used by this build, and no empty `StreamingAssets` directory is included.
- Unity's generated `index.html` and `TemplateData` directory are intentionally not copied; the Web host provides its own page and assets.
- `.nojekyll` is intentionally not added because that would change site-wide GitHub Pages behavior.
- To avoid unnecessary binary history growth, recopy and commit these artifacts only when the approved 3D milestone changes.
