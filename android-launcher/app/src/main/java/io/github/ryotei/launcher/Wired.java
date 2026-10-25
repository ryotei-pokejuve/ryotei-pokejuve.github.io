package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.function.ToIntFunction;

/**
 * もうひとつの世界「WIRED」。藍色の暗がりの真ん中に古いCRTモニターがあり、そのまわりを
 * 紫のカプセル（お気に入りアプリ）が傾いた楕円軌道でゆっくり回る。選んだものはティール単色でモニターに映る。
 */
final class Wired {
    static final int NODES = Engine.SLOTS;
    static final int ROOT = NODES;
    static final int CYAN = 0xFF7CF4E8, BLUE = 0xFF5A64E0, PURPLE = 0xFF9C7CF0, TEXT = 0xFFE8F8F8, SUB = 0xFF7A86B0,
            LINE = 0xFF3A2C70, VOID = 0xFF07061A, RED = 0xFFFF4868;
    private static final long TURN_MS = 90000;
    private final double[] tilt = {Math.toRadians(-24), Math.toRadians(22)};
    /** レイヤーごとのタイトルの言葉。 */
    static final String[] LAYER_WORDS = {"CONNECT", "SIGNAL", "MEMORY", "DREAM", "ORIGIN"};
    static final int PILL_W = 74, PILL_H = 18, MON_W = 100, MON_H = 76;

    private Bitmap bg;
    private int bgW, bgH;
    private final HashMap<String, Bitmap> mono = new HashMap<>();
    int cx, cy, rx, ry;
    private double spin;
    // リテ（ナビゲーター）。null ならモニターを置く
    private Bitmap rite, riteCyan, riteMag;
    int riteX, riteY, riteW, riteH;

    void layout(int x, int y, int w, int h) {
        cx = x + w / 2;
        cy = y + h / 2;
        rx = Math.max(60, w / 2 - PILL_W / 2 + 4);
        ry = Math.max(30, Math.min(h / 2 - PILL_H, rx * 85 / 100));
    }

    /** レイヤーが変わると、ワイヤー（軌道）の傾きも変わる。 */
    void setLayer(int layer) {
        tilt[0] = Math.toRadians(-24 + layer * 9);
        tilt[1] = Math.toRadians(22 - layer * 7);
        spin = layer * 0.7;
    }

    /** 横にドラッグして軌道を回す。 */
    void spin(int dx) {
        spin += dx * 0.02;
    }

    // ================================================================ 軌道上の位置

    private double angle(int i, long t) {
        int orbit = i % 2, k = i / 2;
        double dir = orbit == 0 ? 1 : -1;
        return Math.PI / 2 + k * 2 * Math.PI / (NODES / 2) + orbit * 0.6 + dir * ((t % TURN_MS) * 2 * Math.PI / TURN_MS + spin);
    }

    /** 奥行き：+1が手前、-1が奥。 */
    double depth(int i, long t) {
        return Math.sin(angle(i, t));
    }

    int nodeX(int i, long t) {
        if (i == ROOT) return cx;
        double a = angle(i, t), ex = Math.cos(a) * rx, ey = Math.sin(a) * ry, tl = tilt[i % 2];
        return cx + (int) Math.round(ex * Math.cos(tl) - ey * Math.sin(tl));
    }

    int nodeY(int i, long t) {
        if (i == ROOT) return cy;
        double a = angle(i, t), ex = Math.cos(a) * rx, ey = Math.sin(a) * ry, tl = tilt[i % 2];
        return cy + (int) Math.round(ex * Math.sin(tl) + ey * Math.cos(tl));
    }

    /** タップ位置のカプセル（手前のものを優先）。モニターならROOT。 */
    int nodeAt(int x, int y, long t) {
        int best = -1;
        double bestDepth = -9;
        for (int i = 0; i < NODES; i++) {
            if (Math.abs(x - nodeX(i, t)) <= PILL_W / 2 + 4 && Math.abs(y - nodeY(i, t)) <= PILL_H / 2 + 6) {
                double d = depth(i, t);
                if (d > bestDepth) {
                    bestDepth = d;
                    best = i;
                }
            }
        }
        boolean onMonitor = rite != null
                ? x >= riteX && x < riteX + riteW && y >= riteY && y < riteY + riteH
                : Math.abs(x - cx) <= MON_W / 2 && Math.abs(y - cy) <= MON_H / 2;
        if (onMonitor && (best < 0 || bestDepth < 0)) return ROOT;
        return best;
    }

    /** 記号みたいな識別子。パッケージ名の末尾3文字と接続した回数。例：You015 */
    static String nodeId(AppEntry a, int count) {
        String pkg = a.pkg;
        String last = pkg.substring(pkg.lastIndexOf('.') + 1).replaceAll("[^A-Za-z]", "");
        if (last.length() < 3) last = last + "xxx";
        String head = Character.toUpperCase(last.charAt(0)) + last.substring(1, 3).toLowerCase();
        int n = Math.min(999, count);
        return head + (n < 10 ? "00" : n < 100 ? "0" : "") + n;
    }

    // ================================================================ 背景

    void background(Pix p, int w, int h, long t) {
        if (bg == null || bgW != w || bgH != h) build(p, w, h);
        p.image(bg, 0, 0, w, h);
        // ゆっくり流れる走査の帯
        long sweep = t % 6000;
        int y = (int) (sweep / 6000f * (h + 60)) - 30;
        for (int i = 0; i < 24; i++) p.rect(0, y + i, w, 1, ((14 - Math.abs(i - 12)) << 24) | 0x7CF4E8);
    }

    private void build(Pix p, int w, int h) {
        bgW = w;
        bgH = h;
        bg = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        Canvas old = p.c;
        p.c = new Canvas(bg);
        for (int y = 0; y < h; y++) {
            float k = y / (float) h;
            float m = k < 0.45f ? k / 0.45f : (1 - k) / 0.55f;
            int r = (int) (7 + 18 * m), g = (int) (6 + 8 * m), b = (int) (26 + 38 * m);
            p.rect(0, y, w, 1, 0xFF000000 | (r << 16) | (g << 8) | b);
        }
        // 奥に積まれた古いモニターの影
        Random rnd = new Random(3301);
        for (int k = 0; k < 9; k++) {
            int mw = 30 + rnd.nextInt(30), mh = mw * 3 / 4;
            int mx = rnd.nextInt(w) - mw / 2, my = rnd.nextInt(h * 2 / 3);
            p.rect(mx, my, mw, mh, 0x50050414);
            p.rect(mx + 3, my + 3, mw - 6, mh - 8, 0x300E4A58);
        }
        // 細かい砂
        for (int i = 0; i < w * h / 40; i++) {
            int g = 30 + rnd.nextInt(60);
            p.rect(rnd.nextInt(w), rnd.nextInt(h), 1, 1, (0x40 << 24) | (g / 2 << 16) | (g << 8) | g);
        }
        // ビネットと走査線
        for (int i = 0; i < 28; i++) {
            int a = (28 - i) * 6;
            p.rect(i, 0, 1, h, a << 24);
            p.rect(w - 1 - i, 0, 1, h, a << 24);
            p.rect(0, h - 1 - i, w, 1, a << 24);
            p.rect(0, i, w, 1, (a / 2) << 24);
        }
        for (int y = 0; y < h; y += 2) p.rect(0, y, w, 1, 0x18000000);
        p.c = old;
    }

    // ================================================================ モニターと軌道

    void drawOrbits(Pix p, long t, AppEntry[] apps, int[] counts, int cursor, int connecting) {
        // 軌道の線
        for (int o = 0; o < 2; o++) {
            double tl = tilt[o];
            for (int s = 0; s < 360; s += 2) {
                double a = Math.toRadians(s), ex = Math.cos(a) * rx, ey = Math.sin(a) * ry;
                int x = cx + (int) Math.round(ex * Math.cos(tl) - ey * Math.sin(tl));
                int y = cy + (int) Math.round(ex * Math.sin(tl) + ey * Math.cos(tl));
                boolean front = Math.sin(a) > 0;
                p.rect(x, y, 1, 1, front ? 0x907CF4E8 : 0x605A64E0);
            }
        }
        // 奥のカプセル → モニター → 手前のカプセル
        for (int pass = 0; pass < 2; pass++) {
            if (pass == 1 && rite != null) figure(p, t, cursor == ROOT);
            else if (pass == 1) monitor(p, t, cursor >= 0 && cursor < NODES ? apps[cursor] : null, cursor == ROOT);
            for (int i = 0; i < NODES; i++) {
                boolean front = depth(i, t) >= 0;
                if (front != (pass == 1)) continue;
                pill(p, i, t, apps[i], counts[i], i == cursor, i == connecting);
            }
        }
    }

    private void pill(Pix p, int i, long t, AppEntry a, int count, boolean sel, boolean busy) {
        int x = nodeX(i, t) - PILL_W / 2, y = nodeY(i, t) - PILL_H / 2;
        double d = depth(i, t);
        int shade = (int) (60 + 40 * (d + 1) / 2); // 奥ほど暗い
        if (a == null) {
            capsule(p, x, y, PILL_W, PILL_H, 0x403A2C70, 0x80524090, 0);
            p.textCenter("------", x + PILL_W / 2, y + 1, (shade * 2 << 24) | 0x7A86B0, 0);
            return;
        }
        int body = sel ? 0xFFB49CF8 : scale(0xFF7C5CD8, shade), hi = sel ? 0xFFF0E8FF : scale(0xFFB8A0F8, shade);
        int edge = sel || busy ? CYAN : scale(0xFF2A1C58, 100);
        capsule(p, x, y, PILL_W, PILL_H, edge, body, hi);
        int color = sel ? 0xFF140C30 : scale(0xFFF0ECFF, shade + 10);
        int inner = PILL_W - 10;
        if (p.width(a.label) <= inner) p.textCenter(a.label, x + PILL_W / 2, y + 1, color, 0);
        else p.marquee(a.label, x + 5, y + 1, inner, color, 0, t + i * 977L);
        if (sel) {
            // ぼんやり光る
            p.rect(x + 4, y - 2, PILL_W - 8, 1, 0x707CF4E8);
            p.rect(x + 4, y + PILL_H + 1, PILL_W - 8, 1, 0x707CF4E8);
        }
    }

    /** 丸い端のカプセル。hiが0でなければ上に光沢の筋を入れる。 */
    static void capsule(Pix p, int x, int y, int w, int h, int edge, int body, int hi) {
        p.rect(x + 3, y, w - 6, h, edge);
        p.rect(x + 1, y + 1, w - 2, h - 2, edge);
        p.rect(x, y + 3, w, h - 6, edge);
        p.rect(x + 3, y + 1, w - 6, h - 2, body);
        p.rect(x + 1, y + 3, w - 2, h - 6, body);
        p.rect(x + 2, y + 2, w - 4, h - 4, body);
        if (hi != 0) p.rect(x + 5, y + 2, w - 10, 2, hi);
    }

    private static int scale(int c, int pct) {
        int r = Math.min(255, ((c >> 16) & 255) * pct / 100), g = Math.min(255, ((c >> 8) & 255) * pct / 100),
                b = Math.min(255, (c & 255) * pct / 100);
        return (c & 0xFF000000) | (r << 16) | (g << 8) | b;
    }

    /** 真ん中の古いCRTモニター。選んだアプリがティール単色で映る。何も選んでいなければ砂嵐。 */
    private void monitor(Pix p, long t, AppEntry shown, boolean rootSel) {
        int x = cx - MON_W / 2, y = cy - MON_H / 2;
        p.rect(x - 1, y - 1, MON_W + 2, MON_H + 10, 0xFF050410);
        p.rect(x, y, MON_W, MON_H + 8, 0xFF1C1A2C);
        p.rect(x, y, MON_W, 1, 0xFF3A3850);
        p.rect(x + MON_W / 2 - 10, y + MON_H + 8, 20, 4, 0xFF141220);
        int sx = x + 5, sy = y + 5, sw = MON_W - 10, sh = MON_H - 8;
        p.rect(sx, sy, sw, sh, 0xFF0A3A44);
        Random r = new Random(t / 70);
        if (shown != null) {
            int ox = (t % 3100) < 90 ? r.nextInt(5) - 2 : 0;
            p.image(mono(shown), sx + sw / 2 - 24 + ox + 3, sy + sh / 2 - 23, 48, 48); // ゴースト
            p.image(mono(shown), sx + sw / 2 - 24 + ox, sy + sh / 2 - 24, 48, 48);
        } else {
            for (int i = 0; i < sw * sh / 5; i++) {
                int g = 40 + r.nextInt(150);
                p.rect(sx + r.nextInt(sw), sy + r.nextInt(sh), 1, 1, 0xFF000000 | (g / 4 << 16) | (g << 8) | (g * 9 / 10));
            }
            if (rootSel || (t / 700) % 2 == 0) p.textCenter("ROOT", cx, sy + sh / 2 - 8, CYAN, 0);
        }
        for (int yy = sy; yy < sy + sh; yy += 2) p.rect(sx, yy, sw, 1, 0x40000000);
        int bar = sy + (int) ((t / 30) % sh);
        p.rect(sx, bar, sw, 2, 0x307CF4E8);
        p.rect(x + MON_W - 9, y + MON_H + 2, 3, 2, (t / 400) % 2 == 0 ? 0xFF7CF4E8 : 0xFF2A4A50);
        if (rootSel) brackets(p, cx, cy + 4, MON_W / 2 + 4, t);
    }

    /** 選んだものの大きな名札。title は大きく（入らなければ流して）、sub はその下に小さく。 */
    void label(Pix p, int y, String title, String sub, long t) {
        label(p, cx, y, Math.max(60, rx * 2 + 20), title, sub, t);
    }

    /** 名札を (cx, y) を中心に、幅 maxW までで描く（PCの横長画面用）。 */
    void label(Pix p, int cx, int y, int maxW, String title, String sub, long t) {
        boolean big = p.bigWidth(title, 2) <= maxW;
        int w = (big ? p.bigWidth(title, 2) : Math.min(p.width(title), maxW)) + 20, x = cx - w / 2;
        capsule(p, x, y, w, 40, CYAN, 0xFF8C6CE8, 0xFFD8C8FF);
        if (big) p.big(title, x + 10, y + 2, 2, 0xFFF8F8FF, 0xFF2A1C58);
        else p.marquee(title, x + 10, y + 12, w - 20, 0xFFF8F8FF, 0xFF2A1C58, t);
        String rec = sub.toUpperCase() + " REC.";
        int ty = y + 44;
        p.rect(cx - 90, ty + 8, 180, 1, 0x607CF4E8);
        int rw = Math.min(p.width(rec), maxW) + 12;
        p.rect(cx - rw / 2, ty, rw, 16, 0xE007061A);
        p.marquee(rec, cx - (rw - 12) / 2, ty, maxW, CYAN, 0, t);
    }

    /** 選んでいる印：四隅のかぎかっこが少し呼吸する。 */
    void brackets(Pix p, int x, int y, int half, long t) {
        int s = half + (int) ((t / 160) % 3);
        int l = 6;
        p.rect(x - s, y - s, l, 1, CYAN);
        p.rect(x - s, y - s, 1, l, CYAN);
        p.rect(x + s - l + 1, y - s, l, 1, CYAN);
        p.rect(x + s, y - s, 1, l, CYAN);
        p.rect(x - s, y + s, l, 1, CYAN);
        p.rect(x - s, y + s - l + 1, 1, l, CYAN);
        p.rect(x + s - l + 1, y + s, l, 1, CYAN);
        p.rect(x + s, y + s - l + 1, 1, l, CYAN);
    }

    static void frame(Pix p, int x, int y, int w, int h, int c) {
        p.rect(x, y, w, 1, c);
        p.rect(x, y + h - 1, w, 1, c);
        p.rect(x, y, 1, h, c);
        p.rect(x + w - 1, y, 1, h, c);
    }

    /** ぶれて二重に見える文字。 */
    static void ghost(Pix p, String s, int x, int y, int color) {
        p.text(s, x + 2, y + 1, (0x50 << 24) | (color & 0xFFFFFF), 0);
        p.text(s, x, y, color, 0);
    }

    /** アイコンをティール単色にする（WIREDの中では色が抜け落ちる）。 */
    Bitmap mono(AppEntry a) {
        Bitmap b = mono.get(a.key);
        if (b != null) return b;
        int[] ramp = {0xFF0A2A34, 0xFF1C6A70, 0xFF3CB0B0, CYAN, 0xFFE0FFF8};
        Bitmap src = a.icon16;
        b = Bitmap.createBitmap(16, 16, Bitmap.Config.ARGB_8888);
        for (int y = 0; y < 16; y++) {
            for (int x = 0; x < 16; x++) {
                int c = src.getPixel(x * src.getWidth() / 16, y * src.getHeight() / 16);
                if ((c >>> 24) < 128) continue;
                int lum = (((c >> 16) & 255) * 30 + ((c >> 8) & 255) * 59 + (c & 255) * 11) / 100;
                b.setPixel(x, y, ramp[Math.min(4, lum * 5 / 256)]);
            }
        }
        if (mono.size() > 300) mono.clear();
        mono.put(a.key, b);
        return b;
    }

    // ================================================================ 演出

    /** 砂嵐。amount は 0〜1。 */
    static void noise(Pix p, int w, int h, long t, float amount) {
        if (amount <= 0) return;
        Random r = new Random(t / 40);
        int n = (int) (w * h / 6 * amount);
        for (int i = 0; i < n; i++) {
            int g = 40 + r.nextInt(200);
            p.rect(r.nextInt(w), r.nextInt(h), 2, 1, 0xFF000000 | (g / 3 << 16) | (g << 8) | (g * 9 / 10));
        }
        if (amount > 0.5f) {
            for (int i = 0; i < 6; i++) p.rect(0, r.nextInt(h), w, 1 + r.nextInt(3), 0x607CF4E8);
        }
    }

    /** データが壊れたようなブロック状のグリッチ。strength 0〜1（0なら時々だけ小さく出る）。 */
    static void glitch(Pix p, int w, int h, long t, float strength) {
        long ph = t % 5200;
        if (strength <= 0 && ph > 220) return;
        Random r = new Random(t / 60);
        int n = strength > 0 ? (int) (6 + 30 * strength) : 5;
        for (int i = 0; i < n; i++) {
            int bw = 10 + r.nextInt(w / 2), bh = 2 + r.nextInt(8);
            int x = r.nextInt(w) - bw / 3, y = r.nextInt(h);
            int c;
            switch (r.nextInt(4)) {
                case 0: c = 0x707CF4E8; break;
                case 1: c = 0x609C7CF0; break;
                case 2: c = 0x80061A20; break;
                default: c = 0x50E8F8F8;
            }
            p.rect(x, y, bw, bh, c);
        }
    }

    /** 接続中のパネル。progress は 0〜1。 */
    void connecting(Pix p, int w, int h, long t, String id, String name, float progress) {
        int pw = w - 40, ph = 74, x = 20, y = h / 2 - ph / 2;
        p.rect(x, y, pw, ph, 0xF007061A);
        frame(p, x, y, pw, ph, CYAN);
        ghost(p, "> " + id + " : connect_", x + 10, y + 8, CYAN);
        ghost(p, "unpacking data" + "...".substring(0, (int) ((t / 250) % 4)), x + 10, y + 28, TEXT);
        int bx = x + 10, by = y + 54, bw = pw - 20;
        frame(p, bx, by, bw, 8, LINE);
        p.rect(bx + 2, by + 2, Math.round((bw - 4) * progress), 4, progress < 1 ? PURPLE : CYAN);
        glitch(p, w, h, t, progress * 0.6f);
    }

    // ================================================================ ディレクトリ：モニターの壁と周波数ダイヤル

    /** ダイヤルのチャンネル。0は全部、最後は頭文字が英字・かな以外のもの。 */
    static final String[] CHANNELS = {"ALL", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
            "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "あ", "か", "さ", "た", "な", "は", "ま", "や", "ら", "わ", "#"};
    private static final String[] KANA_ROWS = {"ぁあぃいぅうぇえぉおゔ", "かがきぎくぐけげこごゕゖ", "さざしじすずせぜそぞ",
            "ただちぢっつづてでとど", "なにぬねの", "はばぱひびぴふぶぷへべぺほぼぽ", "まみむめも", "ゃやゅゆょよ", "らりるれろ", "ゎわゐゑをん"};
    static final int WALL_COLS = 3, CELL_H = 98, DIAL_STEP = 26;
    /** モニターの壁の列数（スマホは3、PCの横長画面ではもっと多い）。 */
    int wallCols = WALL_COLS;

    static int channelOf(AppEntry a) {
        String c = a.code;
        char ch = c.isEmpty() ? '*' : c.charAt(0);
        if (ch >= 'A' && ch <= 'Z') return 1 + (ch - 'A');
        for (int i = 0; i < KANA_ROWS.length; i++) if (KANA_ROWS[i].indexOf(ch) >= 0) return 27 + i;
        return CHANNELS.length - 1;
    }

    /** チャンネル番号を周波数っぽく見せる。 */
    static String frequency(int ch) {
        int f = 760 + ch * 5;
        return (f / 10) + "." + (f % 10) + "MHz";
    }

    /** 古いモニターが3列に積まれた壁。画面の中央に近いほど映りがはっきりする。 */
    void drawWall(Pix p, int x, int y, int w, int h, List<AppEntry> l, float scroll, int cursor, long t, long tuneStart,
                  ToIntFunction<AppEntry> count) {
        int cols = wallCols, cellW = w / cols;
        int first = Math.max(0, (int) (scroll / CELL_H) * cols);
        int last = Math.min(l.size() - 1, (int) ((scroll + h) / CELL_H + 1) * cols + cols - 1);
        p.c.save();
        p.c.clipRect(x, y, x + w, y + h);
        for (int i = first; i <= last; i++) {
            int col = i % cols, row = i / cols;
            int mx = x + col * cellW + (cellW - 78) / 2, my = y + row * CELL_H - Math.round(scroll) + 6;
            float centre = Math.abs(my + 34 - (y + h / 2f)) / (h / 2f);
            float fuzz = Math.min(0.9f, Math.max(0, centre - 0.25f));
            long tune = t - tuneStart;
            if (tune < 420) fuzz = Math.max(fuzz, 1f - tune / 420f + (i % 5) * 0.05f);
            if (i == cursor) fuzz = 0;
            wallMonitor(p, mx, my, l.get(i), i == cursor, fuzz, t + i * 131L, count.applyAsInt(l.get(i)));
        }
        p.c.restore();
    }

    /** 壁のモニターの位置（タップ判定とズーム演出用）。 */
    static int[] wallRect(int x, int y, int w, int index, float scroll) {
        return wallRect(x, y, w, index, scroll, WALL_COLS);
    }

    static int[] wallRect(int x, int y, int w, int index, float scroll, int cols) {
        int cellW = w / cols;
        int col = index % cols, row = index / cols;
        return new int[]{x + col * cellW + (cellW - 78) / 2, y + row * CELL_H - Math.round(scroll) + 6, 78, 68};
    }

    private void wallMonitor(Pix p, int x, int y, AppEntry a, boolean sel, float fuzz, long t, int count) {
        p.rect(x - 1, y - 1, 80, 70, 0xFF050410);
        p.rect(x, y, 78, 68, sel ? 0xFF2A2840 : 0xFF181626);
        p.rect(x, y, 78, 1, 0xFF3A3850);
        int sx = x + 6, sy = y + 5, sw = 66, sh = 44;
        p.rect(sx, sy, sw, sh, 0xFF082E36);
        p.image(mono(a), sx + sw / 2 - 16, sy + sh / 2 - 16, 32, 32);
        for (int yy = sy; yy < sy + sh; yy += 2) p.rect(sx, yy, sw, 1, 0x38000000);
        if (fuzz > 0) {
            Random r = new Random(t / 70);
            int n = (int) (sw * sh / 3 * fuzz);
            for (int i = 0; i < n; i++) {
                int g = 30 + r.nextInt(170);
                p.rect(sx + r.nextInt(sw - 1), sy + r.nextInt(sh), 2, 1, 0xFF000000 | (g / 4 << 16) | (g << 8) | (g * 9 / 10));
            }
        }
        p.rect(sx, sy + (int) ((t / 40) % sh), sw, 1, 0x407CF4E8);
        p.text("Lv" + Engine.level(count), x + 6, y + 50, sel ? CYAN : 0xFF4A4868, 0);
        p.rect(x + 70, y + 56, 3, 2, sel || (t / 500) % 2 == 0 ? CYAN : 0xFF2A4A50);
        if (sel) p.marquee(a.label, x + 39 - Math.min(42, p.width(a.label) / 2), y + 71, 84, TEXT, 0, t);
        else p.textCenter(p.fit(a.label, 84), x + 39, y + 71, SUB, 0);
        if (sel) brackets(p, x + 39, y + 34, 40, t);
    }

    /** ラジオのような周波数ダイヤル。pos は中央に来ているチャンネル（小数で途中も表す）。 */
    void drawDial(Pix p, int x, int y, int w, int h, float pos, int[] counts, int total, long t) {
        p.rect(x, y, w, h, 0xE007061A);
        frame(p, x, y, w, h, LINE);
        int cx = x + w / 2;
        p.c.save();
        p.c.clipRect(x + 2, y + 2, x + w - 2, y + h - 2);
        for (int i = 0; i < CHANNELS.length; i++) {
            float off = (i - pos) * DIAL_STEP;
            int lx = cx + Math.round(off);
            if (lx < x - 20 || lx > x + w + 20) continue;
            float near = 1 - Math.min(1, Math.abs(off) / (w / 2f));
            boolean empty = i > 0 && counts[i] == 0;
            int a = empty ? 50 : (int) (70 + 185 * near);
            int color = Math.abs(off) < DIAL_STEP / 2f ? CYAN : (a << 24) | (empty ? 0x3A2C70 : 0xE8F8F8);
            p.rect(lx, y + 6, 1, Math.abs(off) < DIAL_STEP / 2f ? 8 : 5, (a << 24) | 0x7CF4E8);
            p.rect(lx + DIAL_STEP / 2, y + 6, 1, 3, 0x407CF4E8);
            String s = CHANNELS[i];
            p.text(s, lx - p.width(s) / 2, y + 16, color, 0);
        }
        p.c.restore();
        p.arrowDown(cx - 3, y + 2, CYAN);
        int ch = Math.max(0, Math.min(CHANNELS.length - 1, Math.round(pos)));
        String info = "CH" + (ch < 10 ? "0" : "") + ch + "  " + frequency(ch);
        p.text(info, x + 8, y + 40, SUB, 0);
        String n = (ch == 0 ? total : counts[ch]) + " nodes";
        p.text(n, x + w - 8 - p.width(n), y + 40, ch > 0 && counts[ch] == 0 ? RED : CYAN, 0);
    }

    /** モニターに吸い込まれていく演出。k は 0〜1。 */
    void zoom(Pix p, int vw, int vh, int[] from, AppEntry a, float k, long t) {
        float e = k * k;
        int x = Math.round(from[0] + (0 - from[0]) * e), y = Math.round(from[1] + (0 - from[1]) * e);
        int w = Math.round(from[2] + (vw - from[2]) * e), h = Math.round(from[3] + (vh - from[3]) * e);
        p.rect(x, y, w, h, 0xFF082E36);
        int size = Math.max(32, Math.min(w, h) / 2);
        p.image(mono(a), x + w / 2 - size / 2, y + h / 2 - size / 2, size, size);
        for (int yy = y; yy < y + h; yy += 3) p.rect(x, yy, w, 1, 0x40000000);
        frame(p, x, y, w, h, CYAN);
        if (k > 0.5f) noise(p, vw, vh, t, (k - 0.5f) * 2);
        glitch(p, vw, vh, t, k);
    }

    // ================================================================ リテ

    /** 真ん中に立つリテの絵を、軌道の大きさに合わせて用意する。色ずれ用に青緑と赤紫の影も作っておく。 */
    void setFigure(Bitmap full) {
        setFigure(full, Math.max(80, Math.min(ry * 2 + 90, 330)));
    }

    /** 高さを指定して用意する（ライブ壁紙では大きめに置く）。 */
    void setFigure(Bitmap full, int height) {
        if (full == null) {
            rite = null;
            return;
        }
        riteH = height;
        riteW = Math.max(1, full.getWidth() * riteH / full.getHeight());
        riteX = cx - riteW / 2;
        riteY = cy - riteH / 2 + 4;
        rite = Bitmap.createScaledBitmap(full, riteW, riteH, true);
        riteCyan = Bitmap.createBitmap(riteW, riteH, Bitmap.Config.ARGB_8888);
        riteMag = Bitmap.createBitmap(riteW, riteH, Bitmap.Config.ARGB_8888);
        for (int y = 0; y < riteH; y++) {
            for (int x = 0; x < riteW; x++) {
                int a = rite.getPixel(x, y) >>> 24;
                if (a < 40) continue;
                riteCyan.setPixel(x, y, ((a * 6 / 10) << 24) | 0x40F0E8);
                riteMag.setPixel(x, y, ((a * 6 / 10) << 24) | 0xF040B0);
            }
        }
    }

    /** 選択の印なしでリテだけを描く（ライブ壁紙用）。 */
    void drawFigure(Pix p, long t) {
        if (rite != null) figure(p, t, false);
    }

    boolean hasFigure() {
        return rite != null;
    }

    /** 画面の向こう側にいるように見せる：走査線・横ずれ・色のにじみ・ときどき途切れる。 */
    private void figure(Pix p, long t, boolean sel) {
        int x = riteX, y = riteY, w = riteW, h = riteH;
        // うしろの淡い光
        for (int i = 0; i < 6; i++) {
            int pad = 6 + i * 6;
            p.rect(x - pad / 2, y + h / 6 - pad / 3, w + pad, h - h / 4, (6 << 24) | 0x40F0E8);
        }
        long g = t % 3700;
        boolean glitch = g < 200;
        boolean flicker = (t % 4300) < 160 && ((t / 40) % 2 == 0);
        int alpha = flicker ? 110 : 235;
        int chroma = glitch ? 4 : 1 + (int) ((t / 900) % 2);
        Random r = new Random(t / 50);
        int tear = (int) ((t / 25) % (h + 40)) - 20; // ゆっくり下りていく裂け目
        for (int sy = 0; sy < h; sy += 3) {
            int sh = Math.min(3, h - sy);
            int off = Math.abs(sy - tear) < 6 ? 2 : 0;
            if (glitch && r.nextInt(5) == 0) off = r.nextInt(13) - 6;
            if (glitch && r.nextInt(14) == 0) continue; // 一瞬消える行
            p.imagePart(riteMag, 0, sy, w, sh, x + off - chroma, y + sy, alpha / 3);
            p.imagePart(riteCyan, 0, sy, w, sh, x + off + chroma, y + sy, alpha / 3);
            p.imagePart(rite, 0, sy, w, sh, x + off, y + sy, alpha);
        }
        for (int yy = y; yy < y + h; yy += 2) p.rect(x - 6, yy, w + 12, 1, 0x26000000);
        if (glitch) {
            for (int i = 0; i < 3; i++) {
                int by = y + r.nextInt(h);
                p.rect(x - 8 + r.nextInt(10), by, w / 2 + r.nextInt(w), 1 + r.nextInt(3), r.nextBoolean() ? 0x707CF4E8 : 0x60F040B0);
            }
        }
        if (sel) brackets(p, cx, y + h / 2, Math.max(w, h) / 2 + 6, t);
    }

    /** 検索画面で話しかけてくるリテ（胸から上）。 */
    void bust(Pix p, Bitmap img, int x, int y, int w, int h, long t) {
        long g = t % 4100;
        boolean glitch = g < 180;
        Random r = new Random(t / 50);
        int alpha = (t % 5300) < 140 && ((t / 40) % 2 == 0) ? 120 : 240;
        for (int sy = 0; sy < h; sy += 3) {
            int sh = Math.min(3, h - sy);
            int off = glitch && r.nextInt(4) == 0 ? r.nextInt(9) - 4 : 0;
            p.imagePart(img, 0, sy, w, sh, x + off, y + sy, alpha);
        }
        for (int yy = y; yy < y + h; yy += 2) p.rect(x, yy, w, 1, 0x30000000);
    }
}
