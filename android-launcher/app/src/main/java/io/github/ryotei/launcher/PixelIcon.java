package io.github.ryotei.launcher;

import android.graphics.Bitmap;

/** アプリのアイコンをGBA風のドット絵にする：縮小→透明度を二値化→15bitカラーに減色→暗い縁取り。 */
final class PixelIcon {
    private PixelIcon() {
    }

    static Bitmap make(Bitmap src, int size) {
        Bitmap small = Bitmap.createScaledBitmap(src, size, size, true);
        int[] px = new int[size * size];
        small.getPixels(px, 0, size, 0, 0, size, size);
        if (small != src) small.recycle();
        boolean[] solid = new boolean[px.length];
        for (int i = 0; i < px.length; i++) {
            int c = px[i];
            solid[i] = (c >>> 24) >= 110;
            if (!solid[i]) {
                px[i] = 0;
                continue;
            }
            int r = (c >> 16) & 255, g = (c >> 8) & 255, b = c & 255;
            r = (r >> 3) << 3 | (r >> 5);
            g = (g >> 3) << 3 | (g >> 5);
            b = (b >> 3) << 3 | (b >> 5);
            px[i] = 0xFF000000 | (r << 16) | (g << 8) | b;
        }
        int[] out = px.clone();
        for (int y = 0; y < size; y++) {
            for (int x = 0; x < size; x++) {
                int i = y * size + x;
                if (solid[i]) {
                    boolean edge = x == 0 || y == 0 || x == size - 1 || y == size - 1
                            || !solid[i - 1] || !solid[i + 1] || !solid[i - size] || !solid[i + size];
                    if (edge && size >= 32) out[i] = darken(px[i]);
                }
            }
        }
        Bitmap result = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888);
        result.setPixels(out, 0, size, 0, 0, size, size);
        return result;
    }

    private static int darken(int c) {
        int r = ((c >> 16) & 255) * 45 / 100, g = ((c >> 8) & 255) * 45 / 100, b = (c & 255) * 45 / 100;
        return 0xFF000000 | (r << 16) | (g << 8) | b;
    }
}
