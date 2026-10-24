package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.util.Random;

/** 背景の部品。草むらなどの16x16タイル（フィールド用）と、電脳グリッド＋走るパケット（チップフォルダ用）。 */
final class Scenery {
    static final int GRASS = 0, TALL = 1, FLOWER = 2, TREE_TOP = 3, TREE_BOTTOM = 4, PATH = 5, ROCK = 6;

    private Bitmap grid;
    private int builtW, builtH;

    /** 電脳グリッドの背景を描く。 */
    void drawCyber(Pix p, int w, int h, long t) {
        if (grid == null || builtW != w || builtH != h) {
            builtW = w;
            builtH = h;
            grid = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
            Canvas old = p.c;
            p.c = new Canvas(grid);
            grid(p, w, h);
            p.c = old;
        }
        p.image(grid, 0, 0, w, h);
        packets(p, w, h, t);
    }

    // ---- FIELD ----

    private static final int G = 0xFF88D068, GD = 0xFF60A848, GL = 0xFFB0E888;

    private static void grass(Pix p, int x, int y, int v) {
        p.rect(x, y, 16, 16, G);
        int[] tufts = v % 2 == 0 ? new int[]{2, 3, 10, 7, 5, 12} : new int[]{9, 2, 3, 9, 12, 13};
        for (int i = 0; i < tufts.length; i += 2) {
            int tx = x + tufts[i], ty = y + tufts[i + 1];
            p.rect(tx, ty, 1, 1, GD);
            p.rect(tx + 2, ty, 1, 1, GD);
            p.rect(tx + 1, ty + 1, 1, 1, GD);
        }
        p.rect(x + (v * 5 + 6) % 14, y + (v * 3 + 1) % 14, 1, 1, GL);
    }

    static void tile(Pix p, int type, int x, int y, int frame, int v) {
        switch (type) {
            case TALL: {
                p.rect(x, y, 16, 16, 0xFF58A840);
                int s = frame;
                for (int row = 0; row < 2; row++) {
                    for (int col = 0; col < 4; col++) {
                        int bx = x + col * 4 + (row == 1 ? 2 : 0) + (col % 2 == 0 ? s : 0);
                        int by = y + 2 + row * 8;
                        p.rect(bx, by + 1, 1, 5, 0xFF387828);
                        p.rect(bx + 1, by, 1, 6, 0xFF90D860);
                        p.rect(bx + 2, by + 2, 1, 4, 0xFF387828);
                    }
                }
                p.rect(x, y + 15, 16, 1, 0xFF387828);
                break;
            }
            case FLOWER: {
                grass(p, x, y, v);
                int fx = x + 5 + (v % 2) * 3, fy = y + 5;
                int petal = v % 2 == 0 ? 0xFFF8F8F8 : 0xFFF87888;
                if (frame == 0) {
                    p.rect(fx + 1, fy, 2, 1, petal);
                    p.rect(fx, fy + 1, 4, 2, petal);
                    p.rect(fx + 1, fy + 3, 2, 1, petal);
                } else {
                    p.rect(fx, fy, 1, 1, petal);
                    p.rect(fx + 3, fy, 1, 1, petal);
                    p.rect(fx, fy + 3, 1, 1, petal);
                    p.rect(fx + 3, fy + 3, 1, 1, petal);
                    p.rect(fx, fy + 1, 4, 2, petal);
                }
                p.rect(fx + 1, fy + 1, 2, 2, 0xFFF8D030);
                break;
            }
            case ROCK:
                grass(p, x, y, v);
                p.round(x + 4, y + 6, 8, 7, 0xFF686868);
                p.round(x + 5, y + 6, 6, 5, 0xFFB0B0A8);
                p.rect(x + 6, y + 7, 2, 1, 0xFFE0E0D8);
                break;
            case PATH:
                p.rect(x, y, 16, 16, 0xFFE8D498);
                p.rect(x + (v * 4 + 2) % 13, y + 4, 2, 1, 0xFFC8B070);
                p.rect(x + (v * 7 + 9) % 13, y + 11, 2, 1, 0xFFC8B070);
                p.rect(x + 7, y + (v * 3 + 2) % 13, 1, 1, 0xFFF8ECC0);
                break;
            case TREE_TOP:
                grass(p, x, y, v);
                p.round(x + 1, y + 1, 14, 16, 0xFF205028);
                p.round(x + 2, y + 2, 12, 14, 0xFF38883C);
                p.rect(x + 4, y + 4, 4, 2, 0xFF68B858);
                p.rect(x + 9, y + 8, 3, 2, 0xFF68B858);
                p.rect(x + 3, y + 11, 3, 2, 0xFF2C6C30);
                break;
            case TREE_BOTTOM:
                grass(p, x, y, v);
                p.round(x + 1, y - 2, 14, 10, 0xFF205028);
                p.round(x + 2, y - 2, 12, 8, 0xFF38883C);
                p.rect(x + 9, y + 1, 3, 2, 0xFF2C6C30);
                p.rect(x + 6, y + 8, 4, 6, 0xFF603818);
                p.rect(x + 7, y + 8, 2, 5, 0xFF905828);
                p.rect(x + 3, y + 14, 10, 1, 0xFF60A848);
                break;
            default:
                grass(p, x, y, v);
        }
    }

    // ---- CYBER ----

    private static void grid(Pix p, int w, int h) {
        p.rect(0, 0, w, h, 0xFF061428);
        for (int y = 0; y < h; y += 16) p.rect(0, y, w, 1, y % 64 == 0 ? 0xFF14487C : 0xFF0C2C50);
        for (int x = 0; x < w; x += 16) p.rect(x, 0, 1, h, x % 64 == 0 ? 0xFF14487C : 0xFF0C2C50);
        for (int y = 0; y < h; y += 64) {
            for (int x = 0; x < w; x += 64) {
                p.rect(x - 1, y - 1, 3, 3, 0xFF2878B0);
                p.rect(x, y, 1, 1, 0xFF60D8F8);
            }
        }
        // 半透明のパネル模様
        Random r = new Random(7L);
        for (int k = 0; k < w * h / 9000; k++) {
            int px = r.nextInt(Math.max(1, w / 16)) * 16 + 1, py = r.nextInt(Math.max(1, h / 16)) * 16 + 1;
            p.rect(px, py, 15, 15, 0xFF0A2140);
        }
        for (int y = 0; y < h; y += 2) p.rect(0, y, w, 1, 0x22000000);
    }

    private static void packets(Pix p, int w, int h, long t) {
        int rows = Math.max(1, h / 16), cols = Math.max(1, w / 16);
        for (int k = 0; k < 10; k++) {
            int speed = 9 + k % 5 * 3;
            if (k % 2 == 0) {
                int y = (k * 7919 % rows) * 16;
                int span = w + 48;
                int x = (int) ((t / speed + k * 97L) % span) - 24;
                if (k % 4 == 0) x = w - x;
                for (int i = 0; i < 6; i++) p.rect(k % 4 == 0 ? x + i * 2 : x - i * 2, y, 2, 1, i == 0 ? 0xFFB8F8FF : 0x6630C8F0);
            } else {
                int x = (k * 4271 % cols) * 16;
                int span = h + 48;
                int y = (int) ((t / speed + k * 53L) % span) - 24;
                for (int i = 0; i < 6; i++) p.rect(x, y - i * 2, 1, 2, i == 0 ? 0xFFB8F8FF : 0x6630C8F0);
            }
        }
    }
}
