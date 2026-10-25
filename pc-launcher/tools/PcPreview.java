package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Typeface;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/** PC版の画面を偽のWindowsで動かし、台本どおりの連番PNGを書き出す確認ツール（640x360）。 */
public final class PcPreview implements PcHost {
    private final HashMap<String, String> prefs = new HashMap<>();
    private final List<AppEntry> apps = new ArrayList<>();

    PcPreview() {
        String[] names = {"Chrome", "Discord", "Steam", "Visual Studio Code", "Spotify", "OBS Studio", "メモ帳", "エクスプローラー",
                "LINE", "Photoshop", "VLC", "Blender", "電卓", "設定", "Minecraft", "原神", "Zoom", "Slack", "Notion", "ペイント",
                "ゲームフォルダ", "Excel", "Word", "PowerPoint", "Unity Hub"};
        int i = 0;
        for (String n : names) {
            Bitmap b16 = Bitmap.createBitmap(16, 16, Bitmap.Config.ARGB_8888), b32 = Bitmap.createBitmap(32, 32, Bitmap.Config.ARGB_8888);
            int c = java.awt.Color.HSBtoRGB(i * 0.13f, 0.5f, 0.9f);
            fill(b16, c);
            fill(b32, c);
            apps.add(new AppEntry("C:\\Users\\ryotei\\" + n + ".lnk", "", n, b16, b32));
            i++;
        }
        apps.sort((a, b) -> a.label.compareTo(b.label));
        prefs.put("slot0", "C:\\Users\\ryotei\\Chrome.lnk/");
        prefs.put("slot1", "C:\\Users\\ryotei\\Discord.lnk/");
        prefs.put("slot2", "C:\\Users\\ryotei\\Steam.lnk/");
        prefs.put("slot3", "C:\\Users\\ryotei\\Visual Studio Code.lnk/");
        prefs.put("slot5", "C:\\Users\\ryotei\\Spotify.lnk/");
        prefs.put("n:C:\\Users\\ryotei\\Chrome.lnk/", "42");
    }

    private static void fill(Bitmap b, int c) {
        double r = b.getWidth() / 2.0 - 0.5;
        for (int y = 0; y < b.getHeight(); y++)
            for (int x = 0; x < b.getWidth(); x++)
                if ((x - r) * (x - r) + (y - r) * (y - r) <= r * r) b.setPixel(x, y, Math.abs(x - r) < r / 3 ? 0xFFF8F8F8 : c);
    }

    public static void main(String[] args) throws Exception {
        File assets = new File(args[0]);
        File out = new File(args[1]);
        out.mkdirs();
        Typeface tf = Typeface.createFromFile(new File(assets, "fonts/DotGothic16-Regular.ttf").getPath());
        Bitmap rite = Bitmap.fromImage(ImageIO.read(new File(assets, "images/rite_full.png")));
        Bitmap bust = Bitmap.fromImage(ImageIO.read(new File(assets, "images/rite_bust.png")));
        PcPreview host = new PcPreview();
        PcEngine e = new PcEngine(host, new Pix(tf), rite, bust);
        int w = 640, h = 360;
        e.resize(w, h);
        Bitmap fb = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(fb);
        long[][] script = {
                {3000, 0, 330, 300}, {3090, 2, 330, 300},  // Chromeっぽい所をクリック（選択）
                {6000, 9, 0, 0},                            // ROOT（リテ）を選ぶ
                {7500, 9, 0, 0},                            // もう一度で検索
                {9000, 5, 'c', 0},                          // 文字を打つ
                {12000, 7, 0, 0},                           // Esc
                {13500, 8, 1, 0},                           // → でレイヤー
                {16000, 8, -1, 0},                          // ← で戻る
                {17500, 0, 600, 32}, {17590, 2, 600, 32},   // [DIR]
                {20000, 6, 3, 0},                           // ホイール
                {23000, 7, 0, 0},
        };
        int si = 0, frame = 0;
        long total = 0;
        for (long t = 1000; t <= 25000; t += 33) {
            while (si < script.length && script[si][0] <= t) {
                long[] s = script[si++];
                int a = (int) s[1];
                if (a == 0 || a == 2) e.touch(a, (int) s[2], (int) s[3], t);
                else if (a == 5) {
                    e.typed((char) s[2]);
                    e.setQuery("c");
                } else if (a == 6) e.wheel((int) s[2]);
                else if (a == 7) e.escape();
                else if (a == 8) e.arrow((int) s[2]);
                else if (a == 9) {
                    // リテ（真ん中）をクリック
                    e.touch(0, 230, 200, t);
                    e.touch(2, 230, 200, t + 60);
                }
            }
            long st = System.nanoTime();
            e.frame(c, t);
            total += System.nanoTime() - st;
            if (frame % 2 == 0) {
                BufferedImage big = new BufferedImage(w * 2, h * 2, BufferedImage.TYPE_INT_RGB);
                big.getGraphics().drawImage(fb.img, 0, 0, w * 2, h * 2, null);
                ImageIO.write(big, "png", new File(out, String.format("f%05d.png", frame / 2)));
            }
            frame++;
        }
        System.out.println("avg frame ms: " + (total / frame / 1e6));
    }

    @Override public List<AppEntry> apps() { return apps; }
    @Override public int appsVersion() { return 1; }
    @Override public boolean appsLoading() { return false; }
    @Override public boolean launch(AppEntry app) { return true; }
    @Override public void showInFolder(AppEntry app) {}
    @Override public AppEntry addFile(File file) { return null; }
    @Override public String get(String k, String d) { return prefs.getOrDefault(k, d); }
    @Override public void put(String k, String v) { prefs.put(k, v); }
    @Override public int getInt(String k, int d) { return Integer.parseInt(prefs.getOrDefault(k, String.valueOf(d))); }
    @Override public void putInt(String k, int v) { prefs.put(k, String.valueOf(v)); }
    @Override public long getLong(String k, long d) { return Long.parseLong(prefs.getOrDefault(k, String.valueOf(d))); }
    @Override public void putLong(String k, long v) { prefs.put(k, String.valueOf(v)); }
    @Override public long now() {
        Calendar c = Calendar.getInstance();
        c.set(2026, Calendar.OCTOBER, 25, 21, 4, 9);
        return c.getTimeInMillis();
    }
    @Override public void sfx(int id) {}
    @Override public void searchField(boolean on, String initial) {}
    @Override public void minimize() {}
    @Override public void quit() {}
    @Override public boolean startupEnabled() { return false; }
    @Override public void setStartup(boolean on) {}
}
