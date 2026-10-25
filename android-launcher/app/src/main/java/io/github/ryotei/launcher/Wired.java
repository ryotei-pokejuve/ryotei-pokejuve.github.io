package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.util.HashMap;
import java.util.Random;

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
    private static final double[] TILT = {Math.toRadians(-24), Math.toRadians(22)};
    static final int PILL_W = 58, PILL_H = 18, MON_W = 100, MON_H = 76;

    private Bitmap bg;
    private int bgW, bgH;
    private final HashMap<String, Bitmap> mono = new HashMap<>();
    int cx, cy, rx, ry;
    private double spin;

    void layout(int x, int y, int w, int h) {
        cx = x + w / 2;
        cy = y + h / 2;
        rx = Math.max(60, w / 2 - PILL_W / 2 + 4);
        ry = Math.max(30, Math.min(h / 2 - PILL_H, rx * 85 / 100));
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
        double a = angle(i, t), ex = Math.cos(a) * rx, ey = Math.sin(a) * ry, tl = TILT[i % 2];
        return cx + (int) Math.round(ex * Math.cos(tl) - ey * Math.sin(tl));
    }

    int nodeY(int i, long t) {
        if (i == ROOT) return cy;
        double a = angle(i, t), ex = Math.cos(a) * rx, ey = Math.sin(a) * ry, tl = TILT[i % 2];
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
        boolean onMonitor = Math.abs(x - cx) <= MON_W / 2 && Math.abs(y - cy) <= MON_H / 2;
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
            double tl = TILT[o];
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
            if (pass == 1) monitor(p, t, cursor >= 0 && cursor < NODES ? apps[cursor] : null, cursor == ROOT);
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
        String id = nodeId(a, count);
        p.textCenter(id, x + PILL_W / 2, y + 1, sel ? 0xFF140C30 : scale(0xFFF0ECFF, shade + 10), 0);
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

    /** 選んだアプリの大きな名札（ID と英字の名前）。 */
    void label(Pix p, int y, String id, String name, long t) {
        int w = p.bigWidth(id, 2) + 20, x = cx - w / 2;
        capsule(p, x, y, w, 40, CYAN, 0xFF8C6CE8, 0xFFD8C8FF);
        p.big(id, x + 10, y + 2, 2, 0xFFF8F8FF, 0xFF2A1C58);
        String rec = name.toUpperCase() + " REC.";
        int ty = y + 44;
        p.rect(cx - 90, ty + 8, 180, 1, 0x607CF4E8);
        int rw = p.width(rec) + 12;
        p.rect(cx - rw / 2, ty, rw, 16, 0xE007061A);
        p.textCenter(rec, cx, ty, CYAN, 0);
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
}
