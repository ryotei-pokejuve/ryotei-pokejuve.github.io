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
        long end = Long.parseLong(args.length > 2 ? args[2] : "35000");

        // ---- 台本 ----
        tap(2200, 135, 300);                   // PRESS START
        tap(4600, 87, 213);                    // 草むらの方へ歩く
        tap(6800, 207, 130);                   // YouTubeのいえに入る
        evs.add(new Ev(10200, 9, 0, 0));       // ホームに戻ってくる
        evs.add(new Ev(12600, 7, 0, 0));       // 村人に話しかける
        tap(16200, 207, 420);                  // あき地の立て札
        tap(19800, 100, 251);                  // チップを選んでいえを建てる
        swipe(22600, 135, 420, 135, 250, 180); // 上スワイプでチップフォルダ
        swipe(24000, 135, 460, 135, 220, 120); // フリック
        tap(25600, 100, 251);                  // プラグイン
        evs.add(new Ev(27000, 9, 0, 0));       // 戻る
        tap(28800, 236, 17);                   // MENU
        tap(30600, 40, 300);                   // 閉じる
        hold(31600, 63, 130, 700);             // いえを長押し
        tap(33600, 40, 300);                   // 閉じる

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
                else if (e.a == 7) {
                    int[] n = b.npcCenter();
                    b.touch(0, n[0], n[1], et);
                    b.touch(2, n[0], n[1], et + 90);
                    fingerX = n[0];
                    fingerY = n[1];
                    fingerUntil = t + 200;
                } else {
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
