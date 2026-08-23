# NOTA-II 2Dモード UI ─ 実装仕様

参考資料からは意匠を一切引用せず、以下の構造原則のみを抽出して設計している。
実装対象は「サイト全体を架空の観測端末として操作する」公開Webサイト。

## 1. 設計原則（この6つを崩さない）

| # | 原則 | 実装上の帰結 |
|---|---|---|
| P1 | 窓は二重の縁で立ち上げる | 外周 `border`（ライト 2px / ダーク 1px）＋内側 `box-shadow: inset 0 0 0 2px` の二層。影による立体表現は使わない |
| P2 | 三段構成を固定 | 上段 = 状態バー（端末名・画面名・カウンタ・テーマ/モード切替）、中段 = 操作領域、下段 = 常設メッセージ窓。下段は全画面で必ず存在する |
| P3 | 選択は二重に示す | 塗りの反転 ＋ 左3pxバー ＋ `▶` 記号。色覚に依存させない |
| P4 | 分類色はチップ内に限定 | 本文色は分類で変えない。分類色は `padding: 2px 7px` の小チップのみに許可 |
| P5 | 数値は離散 | 連続バー禁止。10粒のピップで表現（`0–10` に正規化） |
| P6 | 六操作で全要素に到達 | `↑ ↓ ← → Enter Esc` のみで全画面到達可能。マウス／タッチは同じ状態遷移を叩くだけ |

## 2. 情報構造

```
route            screen key   一覧の実体
/                menu         MENU[]      端末トップ（4項目）
/specimens       list         ITEMS[]     一覧 + 詳細ペイン
/areas           map          AREAS[]     4/3/2列グリッド
/log             log          LOGS[]      日付降順
```

同じデータ構造を 3Dモードでも使う想定なので、**画面ごとのデータではなくエンティティ単位で持つ**。

```ts
type Specimen = { no: string; name: string; cat: CatKey; qty: number;
                  stats: [number, number, number]; tags: CatKey[]; desc: string; areaCode: string };
type Area     = { code: string; name: string; state: '調査済' | '未踏' | '封鎖' };
type LogEntry = { date: string; areaCode: string; text: string };
```

`cat` / `state` は必ずキーで持ち、色は表引き（下記トークン）。DBやCMSに色を入れない。

## 3. カラートークン

CSS カスタムプロパティで持ち、`data-theme` 属性で差し替える。JSでの色計算は禁止。

```css
:root[data-theme="dark"] {
  --bg:#171c24; --deep:#10141a; --card:#1b212a;
  --edge:#2c3644; --line:#212936; --bw:1px;
  --text:#e6ecf3; --dim:#7c8b9c; --faint:#4d5b6c;
  --accent:#7fd4c1; --accent-ink:#0e1116;
  --sel-bg:rgba(127,212,193,.12); --sel-ink:#eaf7f3;
  --bar-bg:#10141a; --bar-ink:#e6ecf3; --bar-dim:#7c8b9c;
  --pip-off:#263040; --chip-ink:#0e1116;
  --ring:inset 0 0 0 1px var(--edge); --lift:none;
  --msg-ring:inset 0 0 0 1px var(--edge);
}
:root[data-theme="light"] {
  --bg:#efe9db; --deep:#e5dcc8; --card:#fdfaf1;
  --edge:#241f19; --line:#e0d7c0; --bw:2px;
  --text:#241f19; --dim:#7a7157; --faint:#a1977c;
  --accent:#2f6f5e; --accent-ink:#f6f2e8;
  --sel-bg:#f0d79a; --sel-ink:#241f19;
  --bar-bg:#2f6f5e; --bar-ink:#f6f2e8; --bar-dim:#cfe3da;
  --pip-off:#ddd4bc; --chip-ink:#fdfaf1;
  --ring:inset 0 0 0 2px #e6dec7; --lift:0 3px 0 rgba(36,31,25,.3);
  --msg-ring:inset 0 0 0 3px #9cc0b4;
}
```

分類色（テーマ非依存・固定）。**文字色は背景ごとに固定し、テーマで切り替えない。**
チップ文字は 10.5px の小文字なので全ペアで 4.5:1 以上を満たすこと。

| 分類 | 背景 | 文字 | 比 |
|---|---|---|---|
| 鉱 | `#6d5fb8` | `#fdfaf1` | 5.2 |
| 植 | `#327049` | `#fdfaf1` | 5.6 |
| 水 | `#336c96` | `#fdfaf1` | 5.2 |
| 火 | `#a94f2d` | `#fdfaf1` | 5.2 |
| 風 | `#3a7276` | `#fdfaf1` | 5.0 |
| 土 | `#7d6231` | `#fdfaf1` | 5.6 |
| 光 | `#d9b455` | `#241f19` | 8.0 |
| 闇 | `#56596e` | `#fdfaf1` | 6.6 |

状態色: 調査済 `#327049` / 未踏 `#336c96` / 封鎖 `#8e4444`（いずれも文字 `#fdfaf1`）

> 分類コードはチップの文字だけが担っている（P4）ため、明度が足りない背景に一律の文字色を当てると情報が消える。`{ bg, ink }` の対で持つこと。

初期値は `prefers-color-scheme` に従い、ユーザー選択は `localStorage['nota.theme']` に保存。
ダークモードは既定として扱えるだけの明度差（本文コントラスト比 7:1 以上）を確保済み。

## 4. タイポグラフィ

- 和文・UI本文: **Zen Kaku Gothic New**（400 / 500 / 700）
- 数値・コード・ラベル: **IBM Plex Mono**（400 / 500 / 600）
- 等幅は「数字が縦に揃うこと」が目的。和文には使わない
- `letter-spacing` は和文見出し `.08em` / モノラベル `.14–.2em` の2系統のみ
- 最小サイズ: 本文 12.5px、モノラベル 9.5px（装飾用途に限る）
- `font-display: swap`、可変フォントは使わずサブセット配信

## 5. レイアウトとブレークポイント

```
>= 1024px   ナビ = 左レール 130px ／ 一覧 310px + 詳細ペイン横並び ／ 区域図 4列
761–1023px  ナビ = 左レール 112px ／ 一覧と詳細を縦積み ／ 区域図 3列
<= 760px    同上（コンテンツ幅いっぱい）
<= 430px    ナビ = 下段タブバー（grid 4列）／ 縦積み ／ 区域図 2列 ／ 行高 46px 以上
```

- CSS Grid + `gap` のみ。マージンで間隔をつくらない
- 下段メッセージ窓はモバイルでも `position: static`（固定オーバーレイにしない。広告枠と競合するため）
- タッチターゲットは最小 44×44px。`<=430px` では一覧行の `padding` を `13px 10px` に拡張

## 6. キーボード / 十字キー

```js
const H = {
  ArrowUp:    () => move(-step()),
  ArrowDown:  () => move(+step()),
  ArrowLeft:  () => move(-1),
  ArrowRight: () => move(+1),
  Enter:      () => enter(),
  Escape:     () => back(),
};
// step() は区域図（グリッド）のとき列数、それ以外は 1
```

- `keydown` は document に1つだけ。`e.preventDefault()` は上記キーのみ
- インデックスは巡回（末尾 → 先頭）。`aria-activedescendant` で読み上げ位置を同期
- Tab は奪わない。ネイティブのフォーカス順は維持し、方向キーは「カーソル」として別レイヤーで扱う
- モバイルではハンドラを無効化せず、単に発火しないだけ（外部キーボード接続時に効く）

## 7. 状態

```js
state = { theme, screen, cursor: { menu, list, map }, message }
```

- カーソルは画面ごとに独立して保持（戻ったとき位置が復元される）
- メッセージ窓の文字列は「現在のカーソルが指すもの」から純関数で導出する。手で書き換えない
- 文字送り（タイプライタ）は 20ms/文字。`prefers-reduced-motion: reduce` では即時全表示
- URL は screen と選択中IDを反映（`/specimens/003`）。リロードで同じカーソル位置に戻る

## 8. 広告枠

- 位置は**メッセージ窓の直下、端末フレーム内**に固定。中段のコンテンツには挿し込まない
- デスクトップ 728×90 / モバイル 320×100、高さ 60–100px を予約して CLS を出さない
- 枠は `border: 1px dashed var(--faint)` の端末部品として扱い、広告であることを明示するラベルを置く

## 9. 3Dモードへの拡張

- 状態バーの `2D / 3D` トグルは**同じルート・同じ状態を別レンダラで描く**スイッチ。URLは変えず `?view=3d`
- 3D側が必要とするのは `screen` と `cursor` のみ。UIコンポーネントに3D固有の情報を持たせない
- 2Dの下段メッセージ窓は 3D でもそのまま画面下部に残す（操作の連続性の担保）
- 初回は 3D を遅延ロード。2Dは3Dのフォールバックとして常に完全に機能させる

## 10. 実装順

1. トークン（CSS変数）＋テーマ切替＋タイポグラフィの土台
2. 端末シェル（状態バー / 中段スロット / メッセージ窓 / 広告枠）
3. データ層とルーティング（4画面、URL同期）
4. カーソル層（マウス・タッチ・方向キーを同一の move/enter/back に集約）
5. 各画面（menu → list → map → log）
6. レスポンシブ分岐 → a11y（コントラスト・読み上げ・reduced motion）
7. 3Dモードのスイッチだけ先に用意し、レンダラは後付け
