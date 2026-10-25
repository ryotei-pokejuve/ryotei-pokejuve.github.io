package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.util.Random;

/**
 * ライブ壁紙の中身。ロック画面やホームの奥で、暗がりの向こうにリテが座っている。
 * 時計や通知はAndroidがこの上に重ねるので、ここでは描かない（リテは下半分に置く）。
 */
final class WallpaperScene {
    private static final String[] WHISPERS = {"…みてる？", "ここに いるよ", "まだ つながってる", "おかえり", "きこえる？", "めを とじないで"};

    private final Pix p;
    private final Wired net = new Wired();
    private final Bitmap rite;
    private int vw, vh;

    WallpaperScene(Pix pix, Bitmap rite) {
        this.p = pix;
        this.rite = rite;
    }

    void resize(int w, int h) {
        vw = w;
        vh = h;
        int top = h * 34 / 100;
        net.layout(6, top, w - 12, h - top - 40);
        net.setFigure(rite, h * 56 / 100);
    }

    void frame(Canvas c, long t) {
        p.c = c;
        net.background(p, vw, vh, t);
        net.drawFigure(p, t);
        // ときどき、どこからか声がする
        long cycle = t / 11000, ph = t % 11000;
        if (ph < 3000) {
            String wsp = WHISPERS[(int) (cycle % WHISPERS.length)];
            Random r = new Random(cycle * 17);
            int a = (int) (130 * Math.sin(Math.PI * ph / 3000.0));
            int x = 12 + r.nextInt(Math.max(1, vw - 24 - p.width(wsp)));
            int y = vh * 40 / 100 + r.nextInt(Math.max(1, vh / 2 - 40));
            p.text(wsp, x + 1, y, (a / 3 << 24) | 0x7CF4E8, 0);
            p.text(wsp, x, y, (a << 24) | 0x9C7CF0, 0);
        }
        p.text("//WIRED", 10, vh - 26, 0x907A86B0, 0);
        String sig = "SIGNAL " + (int) (40 + 30 * Math.abs(Math.sin(t / 2300.0))) + "%";
        p.text(sig, vw - 10 - p.width(sig), vh - 26, 0x907A86B0, 0);
        Wired.glitch(p, vw, vh, t, 0);
    }
}
