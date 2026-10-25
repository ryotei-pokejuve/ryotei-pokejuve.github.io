package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Typeface;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/** プレビュー用：偽のHostでEngineを組み立て、タッチ操作を流し込む。 */
public final class PreviewBridge implements Host {
    private final Engine engine;
    private final HashMap<String, Object> prefs = new HashMap<>();
    private final List<AppEntry> apps = new ArrayList<>();
    public boolean launched;

    public PreviewBridge(Typeface tf, String theme, int w, int h) {
        prefs.put("theme", theme);
        String[][] list = {
                {"com.android.chrome", "Chrome"}, {"com.google.android.youtube", "YouTube"},
                {"com.google.android.apps.photos", "フォト"}, {"com.google.android.GoogleCamera", "カメラ"},
                {"com.google.android.gm", "Gmail"}, {"x.line", "LINE"}, {"x.pokemon", "Pokémon HOME"},
                {"x.twitter", "X"}, {"x.discord", "Discord"}, {"x.calc", "電卓"}, {"x.clock", "時計"},
                {"x.maps", "マップ"}, {"x.music", "ミュージック"}, {"x.settings", "設定"}, {"x.files", "ファイル"},
                {"x.calendar", "カレンダー"}, {"x.amazon", "Amazonショッピング"}, {"x.mercari", "メルカリ"},
                {"x.paypay", "PayPay"}, {"x.tcg", "ポケカ ライブ"}, {"x.notes", "メモ帳 とても ながい なまえの アプリ"},
        };
        int seed = 0;
        for (String[] a : list) {
            apps.add(new AppEntry(a[0], a[0] + ".Main", a[1], icon(16, seed), icon(32, seed)));
            seed++;
        }
        apps.sort((a, b) -> a.label.compareTo(b.label));
        prefs.put("n:com.android.chrome/com.android.chrome.Main", 42);
        prefs.put("n:com.google.android.youtube/com.google.android.youtube.Main", 15);
        prefs.put("n:x.line/x.line.Main", 3);
        prefs.put("t:x.line/x.line.Main", 5L);
        engine = new Engine(this, new Pix(tf));
        engine.resize(w, h);
    }

    private static Bitmap icon(int size, int seed) {
        int[] colors = {0xFFE04030, 0xFF30A0E0, 0xFF40C060, 0xFFF0C030, 0xFF9050D0, 0xFFF08030, 0xFF30C0B0};
        Bitmap b = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888);
        int c = colors[seed % colors.length];
        double r = size / 2.0 - 0.5;
        for (int y = 0; y < size; y++)
            for (int x = 0; x < size; x++) {
                double dx = x - r, dy = y - r;
                if (dx * dx + dy * dy <= r * r) {
                    boolean edge = dx * dx + dy * dy > (r - 1.5) * (r - 1.5);
                    boolean mark = Math.abs(dx) < size / 6.0 && Math.abs(dy) < size / 4.0;
                    b.setPixel(x, y, edge ? 0xFF202020 : mark ? 0xFFF8F8F8 : c);
                }
            }
        return b;
    }

    public void frame(Canvas c, long t) { engine.frame(c, t); }

    public void tap(int x, int y, long t) { engine.touch(0, x, y, t); engine.touch(2, x, y, t + 50); }

    public void longPress(int x, int y, long t) {
        engine.touch(0, x, y, t);
        Bitmap scratch = Bitmap.createBitmap(270, 570, Bitmap.Config.ARGB_8888);
        engine.frame(new Canvas(scratch), t + 600);
        engine.touch(2, x, y, t + 650);
    }

    public void drag(int x0, int y0, int x1, int y1, long t) {
        engine.touch(0, x0, y0, t);
        for (int i = 1; i <= 10; i++) engine.touch(1, x0 + (x1 - x0) * i / 10, y0 + (y1 - y0) * i / 10, t + i * 16);
        engine.touch(2, x1, y1, t + 400);
    }

    public void touch(int action, int x, int y, long t) { engine.touch(action, x, y, t); }

    public void back() { engine.back(); }

    public void resume() { engine.onResume(); }

    @Override public List<AppEntry> apps() { return apps; }
    @Override public int appsVersion() { return 1; }
    @Override public boolean appsLoading() { return false; }
    @Override public boolean launch(AppEntry app) { launched = true; return true; }
    @Override public void appInfo(AppEntry app) {}
    @Override public void uninstall(AppEntry app) {}
    @Override public void openSettings() {}
    @Override public void openHomeSettings() {}
    @Override public void openClock() {}
    @Override public boolean expandNotifications() { return true; }
    @Override public String getString(String k, String d) { Object v = prefs.get(k); return v == null ? d : (String) v; }
    @Override public void putString(String k, String v) { prefs.put(k, v); }
    @Override public int getInt(String k, int d) { Object v = prefs.get(k); return v == null ? d : (Integer) v; }
    @Override public void putInt(String k, int v) { prefs.put(k, v); }
    @Override public long getLong(String k, long d) { Object v = prefs.get(k); return v == null ? d : (Long) v; }
    @Override public void putLong(String k, long v) { prefs.put(k, v); }
    @Override public int batteryLevel() { return 64; }
    @Override public boolean charging() { return false; }
    @Override public long now() {
        Calendar c = Calendar.getInstance();
        c.set(2026, Calendar.OCTOBER, 24, 14, 37, 0);
        return c.getTimeInMillis();
    }
    @Override public void sfx(int id) {}
}
