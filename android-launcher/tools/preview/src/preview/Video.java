package preview;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Typeface;
import io.github.ryotei.launcher.PreviewBridge;

import javax.imageio.ImageIO;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/** 操作の台本どおりにEngineを動かし、30fpsの連番PNGを書き出す（デモ動画用）。指の位置も丸で描く。 */
public final class Video {
    static final int VW = 270, VH = 570, SCALE = 2, FPS = 30;

    static final class Ev {
        final long t; final int a, x, y;
        Ev(long t, int a, int x, int y) { this.t = t; this.a = a; this.x = x; this.y = y; }
    }

    static final List<Ev> evs = new ArrayList<>();

    static void tap(long t, int x, int y) { evs.add(new Ev(t, 0, x, y)); evs.add(new Ev(t + 90, 2, x, y)); }

    static void hold(long t, int x, int y, long ms) { evs.add(new Ev(t, 0, x, y)); evs.add(new Ev(t + ms, 2, x, y)); }

    static void swipe(long t, int x0, int y0, int x1, int y1, long ms) {
        evs.add(new Ev(t, 0, x0, y0));
        int n = (int) (ms / 16);
        for (int i = 1; i <= n; i++) evs.add(new Ev(t + i * 16, 1, x0 + (x1 - x0) * i / n, y0 + (y1 - y0) * i / n));
        evs.add(new Ev(t + n * 16 + 8, 2, x1, y1));
    }

    public static void main(String[] args) throws Exception {
        Typeface tf = Typeface.createFromFile(args[0]);
        File out = new File(args[1]);
        out.mkdirs();
        long end = Long.parseLong(args.length > 2 ? args[2] : "30000");

        // ---- 台本 ----
        tap(2200, 135, 300);                   // PRESS START
        tap(4500, 166, 177);                   // YouTubeタウンにカーソル
        tap(5900, 166, 177);                   // もう一度タップで飛ぶ
        evs.add(new Ev(8400, 9, 0, 0));        // ホームに戻ってくる
        tap(10200, 76, 276);                   // あき地にカーソル
        tap(11600, 76, 276);                   // もう一度タップでまちを作る
        tap(13400, 100, 251);                  // チップを選ぶ
        tap(15600, 121, 285);                  // ネットシティにカーソル
        tap(16900, 121, 285);                  // チップフォルダへ
        swipe(18600, 135, 460, 135, 220, 120); // フリック
        tap(20200, 100, 251);                  // プラグイン
        evs.add(new Ev(21600, 9, 0, 0));       // 戻る
        tap(23400, 192, 53);                   // MENU
        tap(25200, 40, 450);                   // 閉じる
        hold(26200, 76, 159, 700);             // まちを長押し
        tap(28400, 40, 450);                   // 閉じる

        PreviewBridge b = new PreviewBridge(tf, "FIELD", VW, VH);
        Bitmap fb = Bitmap.createBitmap(VW, VH, Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(fb);
        int ei = 0, frame = 0;
        int fingerX = -1, fingerY = -1;
        long fingerUntil = -1;
        for (long t = 0; t <= end; t += 1000 / FPS) {
            while (ei < evs.size() && evs.get(ei).t <= t) {
                Ev e = evs.get(ei++);
                long et = e.t + 1000;
                if (e.a == 8) b.back();
                else if (e.a == 9) b.resume();
                else {
                    b.touch(e.a, e.x, e.y, et);
                    fingerX = e.x;
                    fingerY = e.y;
                    fingerUntil = e.a == 2 ? t + 150 : Long.MAX_VALUE;
                }
            }
            b.frame(c, t + 1000);
            BufferedImage img = new BufferedImage(VW * SCALE, VH * SCALE, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = img.createGraphics();
            g.drawImage(fb.img, 0, 0, VW * SCALE, VH * SCALE, null);
            if (t <= fingerUntil && fingerX >= 0) {
                g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
                int r = 22;
                g.setColor(new Color(255, 255, 255, 110));
                g.fillOval(fingerX * SCALE - r, fingerY * SCALE - r, r * 2, r * 2);
                g.setColor(new Color(40, 40, 40, 160));
                g.setStroke(new BasicStroke(3));
                g.drawOval(fingerX * SCALE - r, fingerY * SCALE - r, r * 2, r * 2);
            }
            g.dispose();
            ImageIO.write(img, "png", new File(out, String.format("f%05d.png", frame++)));
        }
    }
}
