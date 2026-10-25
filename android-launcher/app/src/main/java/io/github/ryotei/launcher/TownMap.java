package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

/**
 * ホーム画面のタウンマップ。オリジナルの地方の地図に、お気に入りアプリを「まち」として並べる。
 * 地形は1文字1マスの文字列で描いてある：~=海 :=砂浜 .=草原 T=森 ^=山 o=湖。
 */
final class TownMap {
    static final int TOWNS = Engine.SLOTS;
    /** まち（お気に入り）の位置。最後の1つはチップフォルダへの入口「ネットシティ」。 */
    static final int[][] POS = {{6, 4}, {16, 6}, {2, 11}, {9, 10}, {20, 10}, {6, 17}, {14, 13}, {22, 18}, {3, 30}, {19, 32}, {11, 18}};
    static final int NET = POS.length - 1;
    private static final int[][] ROUTES = {{0, 3}, {0, 1}, {1, 4}, {3, 6}, {4, 6}, {2, 3}, {2, 5}, {5, 10}, {10, 6},
            {10, 7}, {7, 4}, {5, 8}, {7, 9}};
    private static final String[] TERRAIN = {
            "~~~~~~~~~~~~~~~~~~~~~~~~~~",
            "~~~~~~~~~~~~~~~~~~~~~~~~~~",
            "~~~~~~::.....::~~~~~~~~~~~",
            "~~~~:......^^^..:~~~~~~~~~",
            "~~~:......^^^^^...:~~~~~~~",
            "~~:.......^^^^......:~~~~~",
            "~:..TT.....^^........:~~~~",
            ":..TTTT...............:~~~",
            ":..TTTT.......oo.......~~~",
            ":...TT.......oooo......:~~",
            "~:...........oooo.......~~",
            "~:............oo........~~",
            "~~:.....................:~",
            "~~~:.....^^.............~~",
            "~~~~:...^^^^............~~",
            "~~~~:....^^......TTT....:~",
            "~~~:.............TTTT....~",
            "~~:...............TT.....~",
            "~:.......................:",
            "~:.......................:",
            "~~:...::~~~:.............~",
            "~~~::~~~~~~~:...........:~",
            "~~~~~~~~~~~~~:..........:~",
            "~~~~~~~~~~~~~~::.......:~~",
            "~~~~~~~~~~~~~~~~:.....:~~~",
            "~~~~~~~~~~~~~~~~~:...:~~~~",
            "~~~~~~~~~~~~~~~~~~:.:~~~~~",
            "~~~~~~~~~~~~~~~~~~~~~~~~~~",
            "~~:::~~~~~~~~~~~~~~~~~~~~~",
            "~:...:~~~~~~~~~~~~~~~~~~~~",
            ":.....:~~~~~~~~~~~~::~~~~~",
            ":..T..:~~~~~~~~~~~:..:~~~~",
            ":.TTT.:~~~~~~~~~~:....:~~~",
            "~:...:~~~~~~~~~~~:.^^.:~~~",
            "~~:::~~~~~~~~~~~~:....:~~~",
            "~~~~~~~~~~~~~~~~~~:..:~~~~",
            "~~~~~~~~~~~~~~~~~~~::~~~~~",
            "~~~~~~~~~~~~~~~~~~~~~~~~~~",
    };
    static final int GW = 26, GH = TERRAIN.length;

    int cs = 8, mx, my;
    private Bitmap cache0, cache1;
    private int builtCs = -1;

    /** 枠の内側（x,y,w,h）に地図が収まるようにマスの大きさと位置を決める。 */
    void layout(int x, int y, int w, int h) {
        cs = Math.max(4, Math.min(w / GW, h / GH));
        mx = x + (w - cs * GW) / 2;
        my = y + (h - cs * GH) / 2;
    }

    private static char at(int x, int y) {
        if (y < 0 || y >= GH || x < 0 || x >= TERRAIN[y].length()) return '~';
        return TERRAIN[y].charAt(x);
    }

    private static boolean sea(char c) {
        return c == '~';
    }

    int townX(int i) {
        return mx + POS[i][0] * cs + cs / 2;
    }

    int townY(int i) {
        return my + POS[i][1] * cs + cs / 2;
    }

    /** タップ位置にいちばん近いまち。遠すぎれば-1。 */
    int townAt(int x, int y) {
        int best = -1, bestD = Integer.MAX_VALUE, lim = Math.max(14, cs * 2);
        for (int i = 0; i < POS.length; i++) {
            int dx = x - townX(i), dy = y - townY(i), d = dx * dx + dy * dy;
            if (d < bestD && d <= lim * lim) {
                bestD = d;
                best = i;
            }
        }
        return best;
    }

    boolean contains(int x, int y) {
        return x >= mx && y >= my && x < mx + cs * GW && y < my + cs * GH;
    }

    // ================================================================ 描画

    /**
     * levels: 各まちのレベル（0ならあき地）。cursor: 選んでいるまち。
     * hero: 主人公アイコン。heroX/heroY: その中心（画面座標）。
     */
    void draw(Pix p, long t, int[] levels, int cursor, Bitmap hero, int heroX, int heroY) {
        if (cache0 == null || builtCs != cs) build(p);
        p.image((t / 700) % 2 == 0 ? cache0 : cache1, mx, my, cs * GW, cs * GH);
        for (int i = 0; i < POS.length; i++) marker(p, i, i == NET ? -1 : levels[i]);
        if (cursor >= 0 && (t / 300) % 3 != 2) {
            int[] r = markerRect(cursor, cursor == NET ? -1 : levels[cursor]);
            int c = 0xFFF83818;
            p.rect(r[0] - 3, r[1] - 3, r[2] + 6, 2, c);
            p.rect(r[0] - 3, r[1] + r[3] + 1, r[2] + 6, 2, c);
            p.rect(r[0] - 3, r[1] - 1, 2, r[3] + 2, c);
            p.rect(r[0] + r[2] + 1, r[1] - 1, 2, r[3] + 2, c);
        }
        if (hero != null) p.image(hero, heroX - 8, heroY - 12, 16, 11);
    }

    /** まちの印の矩形。レベルが上がるほど大きくなる。 */
    private int[] markerRect(int i, int level) {
        int cx = townX(i), cy = townY(i);
        int w, h;
        if (level < 0) {
            w = cs * 2;
            h = cs * 2;
        } else if (level >= 10) {
            w = cs * 2;
            h = cs * 2;
        } else if (level >= 5) {
            w = cs * 2;
            h = cs;
        } else {
            w = cs;
            h = cs;
        }
        return new int[]{cx - w / 2, cy - h / 2, w, h};
    }

    private void marker(Pix p, int i, int level) {
        int[] r = markerRect(i, level);
        int x = r[0], y = r[1], w = r[2], h = r[3];
        if (level < 0) {
            // ネットシティ：電脳の入口
            p.rect(x, y, w, h, 0xFF0C2448);
            p.rect(x + 1, y + 1, w - 2, h - 2, 0xFF48E0F8);
            p.rect(x + 2, y + 2, w - 4, h - 4, 0xFF1868A0);
            p.rect(x + w / 2 - 1, y + 3, 2, h - 6, 0xFFE8F8FF);
            p.rect(x + 3, y + h / 2 - 1, w - 6, 2, 0xFFE8F8FF);
            p.rect(x + w / 2, y - 4, 1, 4, 0xFF0C2448);
            p.rect(x + w / 2 - 1, y - 5, 3, 1, 0xFFF89818);
            return;
        }
        if (level == 0) {
            p.rect(x, y, w, h, 0xFF585858);
            p.rect(x + 1, y + 1, w - 2, h - 2, 0xFFB8B8B0);
            p.rect(x + 1, y + 1, w - 2, 1, 0xFFE0E0D8);
            return;
        }
        int fill = level >= 10 ? 0xFFF8C030 : 0xFFF86848, hi = level >= 10 ? 0xFFF8E890 : 0xFFF8B0A0;
        p.rect(x, y, w, h, 0xFF383030);
        p.rect(x + 1, y + 1, w - 2, h - 2, fill);
        p.rect(x + 1, y + 1, w - 2, 1, hi);
        p.rect(x + 1, y + 1, 1, h - 2, hi);
        if (w > cs) {
            for (int k = x + 3; k < x + w - 3; k += 4) p.rect(k, y + h - 3, 2, 1, 0xFF983020);
        }
    }

    private void build(Pix p) {
        builtCs = cs;
        cache0 = Bitmap.createBitmap(cs * GW, cs * GH, Bitmap.Config.ARGB_8888);
        cache1 = Bitmap.createBitmap(cs * GW, cs * GH, Bitmap.Config.ARGB_8888);
        Canvas old = p.c;
        for (int f = 0; f < 2; f++) {
            p.c = new Canvas(f == 0 ? cache0 : cache1);
            for (int y = 0; y < GH; y++)
                for (int x = 0; x < GW; x++) cell(p, x, y, f);
            for (int pass = 0; pass < 2; pass++)
                for (int[] r : ROUTES) route(p, r[0], r[1], pass);
        }
        p.c = old;
    }

    private void cell(Pix p, int gx, int gy, int frame) {
        char c = at(gx, gy);
        int x = gx * cs, y = gy * cs, s = cs;
        switch (c) {
            case '~':
            case 'o': {
                p.rect(x, y, s, s, c == 'o' ? 0xFF58A0F0 : 0xFF4878D8);
                int k = (gx * 3 + gy * 5 + frame) % 6;
                if (k == 0) p.rect(x + s / 4, y + s / 2, s / 2, 1, 0xFF88B8F8);
                if (c == '~' && k == 3) p.rect(x + s / 2, y + s / 4, s / 3, 1, 0xFF6898E8);
                break;
            }
            case ':':
                p.rect(x, y, s, s, 0xFFF0E0A0);
                if ((gx + gy) % 2 == 0) p.rect(x + s / 3, y + s / 3, 1, 1, 0xFFD0B870);
                break;
            case 'T':
                p.rect(x, y, s, s, 0xFF70C058);
                p.rect(x + 1, y + 1, s - 2, s - 2, 0xFF2C7838);
                p.rect(x + 2, y + 2, s / 3, s / 3, 0xFF58A848);
                p.rect(x + s / 2, y + s / 2, s / 3, s / 4, 0xFF205828);
                break;
            case '^':
                p.rect(x, y, s, s, 0xFF70C058);
                for (int i = 0; i < s; i++) {
                    int half = (i + 1) / 2;
                    p.rect(x + s / 2 - half, y + i, half * 2, 1, i < s / 3 ? 0xFFF8F8F0 : 0xFFB08850);
                }
                p.rect(x + s / 2, y + s / 3, Math.max(1, s / 4), s - s / 3, 0xFF886030);
                break;
            default:
                p.rect(x, y, s, s, 0xFF70C058);
                if ((gx * 7 + gy * 3) % 5 == 0) p.rect(x + s / 2, y + s / 2, 1, 1, 0xFF98D878);
        }
        // 海岸線
        if (!sea(c)) {
            int coast = 0xFF305828;
            if (sea(at(gx, gy - 1))) p.rect(x, y, s, 1, coast);
            if (sea(at(gx, gy + 1))) p.rect(x, y + s - 1, s, 1, coast);
            if (sea(at(gx - 1, gy))) p.rect(x, y, 1, s, coast);
            if (sea(at(gx + 1, gy))) p.rect(x + s - 1, y, 1, s, coast);
        }
    }

    /** まち同士を、横→縦のL字の道でつなぐ。海の上は点線（水上の道）。 */
    private void route(Pix p, int a, int b, int pass) {
        int x0 = POS[a][0], y0 = POS[a][1], x1 = POS[b][0], y1 = POS[b][1];
        int w = Math.max(2, cs / 3);
        int off = (cs - w) / 2;
        int step = x1 > x0 ? 1 : -1;
        for (int x = x0; x != x1; x += step) segment(p, x, y0, x + step, y0, w, off, pass);
        step = y1 > y0 ? 1 : -1;
        for (int y = y0; y != y1; y += step) segment(p, x1, y, x1, y + step, w, off, pass);
    }

    /** pass 0 で道のふち、pass 1 で道そのものを描く（交差しても線が途切れないように）。 */
    private void segment(Pix p, int ax, int ay, int bx, int by, int w, int off, int pass) {
        boolean water = sea(at(ax, ay)) || sea(at(bx, by));
        int color = water ? 0xFFB8D8F8 : 0xFFF8E8A0;
        int edge = water ? 0xFF3868C0 : 0xFFA88848;
        int x = Math.min(ax, bx) * cs + off, y = Math.min(ay, by) * cs + off;
        int len = cs + w;
        boolean horizontal = ay == by;
        if (water) {
            if (pass == 1) {
                for (int k = 0; k < len; k += 3) {
                    if (horizontal) p.rect(x + k, y, Math.min(2, len - k), w, color);
                    else p.rect(x, y + k, w, Math.min(2, len - k), color);
                }
            }
        } else if (pass == 0) {
            if (horizontal) p.rect(x - 1, y - 1, len + 2, w + 2, edge);
            else p.rect(x - 1, y - 1, w + 2, len + 2, edge);
        } else {
            if (horizontal) p.rect(x, y, len, w, color);
            else p.rect(x, y, w, len, color);
        }
    }
}
