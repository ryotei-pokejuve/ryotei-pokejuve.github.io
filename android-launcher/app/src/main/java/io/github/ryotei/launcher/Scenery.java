package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.util.Random;

/** チップフォルダの背景。電脳グリッド＋走るパケット。 */
final class Scenery {
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
