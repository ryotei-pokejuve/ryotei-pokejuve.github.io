package preview;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Typeface;
import io.github.ryotei.launcher.PreviewBridge;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/** Engineをデスクトップで動かして、主要な画面をPNGに書き出す見た目確認ツール。 */
public final class Main {
    public static void main(String[] args) throws Exception {
        String font = args[0];
        File out = new File(args[1]);
        out.mkdirs();
        int vw = 270, vh = 570;
        for (String theme : new String[]{"FIELD", "CYBER"}) {
            PreviewBridge b = new PreviewBridge(Typeface.createFromFile(font), theme, vw, vh);
            Bitmap fb = Bitmap.createBitmap(vw, vh, Bitmap.Config.ARGB_8888);
            Canvas c = new Canvas(fb);
            b.frame(c, 1000);
            save(fb, new File(out, theme + "-1-boot.png"));
            b.tap(135, 300, 1100);
            for (long t = 1200; t <= 3000; t += 100) b.frame(c, t);
            save(fb, new File(out, theme + "-2-home.png"));
            b.longPress(135, 90, 3100);
            for (long t = 3100; t <= 3800; t += 100) b.frame(c, t);
            save(fb, new File(out, theme + "-3-slotmenu.png"));
            b.back();
            b.tap(200, vh - 72, 4000); // メニュー
            for (long t = 4000; t <= 4800; t += 100) b.frame(c, t);
            save(fb, new File(out, theme + "-4-menu.png"));
            b.back();
            b.tap(60, vh - 72, 5000); // バッグ
            for (long t = 5000; t <= 6000; t += 100) b.frame(c, t);
            b.drag(135, 400, 135, 300, 6100);
            for (long t = 6100; t <= 6500; t += 100) b.frame(c, t);
            b.tap(100, 120, 6600);
            for (long t = 6600; t <= 6620; t += 20) b.frame(c, t);
            b.frame(c, 6700);
            save(fb, new File(out, theme + "-5-apps-launch.png"));
            b.resume();
            for (long t = 7000; t <= 9000; t += 100) b.frame(c, t);
            save(fb, new File(out, theme + "-6-return.png"));
        }
    }

    static void save(Bitmap b, File f) throws Exception {
        int s = 2;
        BufferedImage big = new BufferedImage(b.getWidth() * s, b.getHeight() * s, BufferedImage.TYPE_INT_ARGB);
        java.awt.Graphics2D g = big.createGraphics();
        g.drawImage(b.img, 0, 0, big.getWidth(), big.getHeight(), null);
        ImageIO.write(big, "png", f);
    }
}
