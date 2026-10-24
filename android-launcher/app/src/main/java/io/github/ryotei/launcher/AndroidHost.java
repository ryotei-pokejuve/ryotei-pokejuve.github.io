package io.github.ryotei.launcher;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.provider.AlarmClock;
import android.provider.Settings;

import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

/** Host の Android 実装。アプリ一覧の読み込み・起動・設定保存・電池残量・効果音。 */
final class AndroidHost implements Host {
    private final Activity activity;
    private final SharedPreferences prefs;
    private final Sfx sfx = new Sfx();
    private volatile List<AppEntry> apps = Collections.emptyList();
    private volatile int version;
    private volatile boolean loading;
    private volatile boolean reloadRequested;
    volatile int battery = -1;
    volatile boolean charging;

    AndroidHost(Activity activity) {
        this.activity = activity;
        this.prefs = activity.getSharedPreferences("launcher", Activity.MODE_PRIVATE);
    }

    /** 別スレッドでアプリ一覧とアイコンを読み直す。 */
    void reload() {
        synchronized (this) {
            if (loading) {
                reloadRequested = true;
                return;
            }
            loading = true;
        }
        new Thread(() -> {
            do {
                reloadRequested = false;
                List<AppEntry> list = load();
                apps = list;
                version++;
            } while (reloadRequested);
            loading = false;
        }, "app-loader").start();
    }

    private List<AppEntry> load() {
        PackageManager pm = activity.getPackageManager();
        Intent main = new Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER);
        List<ResolveInfo> infos = pm.queryIntentActivities(main, 0);
        ArrayList<AppEntry> out = new ArrayList<>();
        String self = activity.getPackageName();
        for (ResolveInfo ri : infos) {
            if (ri.activityInfo == null || self.equals(ri.activityInfo.packageName)) continue;
            try {
                String label = String.valueOf(ri.loadLabel(pm)).trim();
                Drawable d = ri.loadIcon(pm);
                Bitmap big = Bitmap.createBitmap(96, 96, Bitmap.Config.ARGB_8888);
                d.setBounds(0, 0, 96, 96);
                d.draw(new Canvas(big));
                out.add(new AppEntry(ri.activityInfo.packageName, ri.activityInfo.name, label,
                        PixelIcon.make(big, 16), PixelIcon.make(big, 32)));
                big.recycle();
            } catch (RuntimeException ignored) {
            }
        }
        Collator col = Collator.getInstance(Locale.JAPANESE);
        Collections.sort(out, (a, b) -> col.compare(a.label, b.label));
        return out;
    }

    @Override
    public List<AppEntry> apps() {
        return apps;
    }

    @Override
    public int appsVersion() {
        return version;
    }

    @Override
    public boolean appsLoading() {
        return loading;
    }

    @Override
    public boolean launch(AppEntry app) {
        Intent i = new Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER)
                .setComponent(new ComponentName(app.pkg, app.cls))
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED);
        return start(i);
    }

    @Override
    public void appInfo(AppEntry app) {
        start(new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + app.pkg)));
    }

    @Override
    public void uninstall(AppEntry app) {
        start(new Intent(Intent.ACTION_DELETE, Uri.parse("package:" + app.pkg)));
    }

    @Override
    public void openSettings() {
        start(new Intent(Settings.ACTION_SETTINGS));
    }

    @Override
    public void openHomeSettings() {
        if (!start(new Intent(Settings.ACTION_HOME_SETTINGS))) openSettings();
    }

    @Override
    public void openClock() {
        start(new Intent(AlarmClock.ACTION_SHOW_ALARMS));
    }

    private boolean start(Intent i) {
        try {
            activity.startActivity(i);
            return true;
        } catch (ActivityNotFoundException | SecurityException e) {
            return false;
        }
    }

    @Override
    @SuppressWarnings({"WrongConstant", "JavaReflectionMemberAccess"})
    public boolean expandNotifications() {
        try {
            Object sb = activity.getSystemService("statusbar");
            sb.getClass().getMethod("expandNotificationsPanel").invoke(sb);
            return true;
        } catch (Throwable e) {
            return false;
        }
    }

    @Override
    public String getString(String key, String def) {
        return prefs.getString(key, def);
    }

    @Override
    public void putString(String key, String value) {
        prefs.edit().putString(key, value).apply();
    }

    @Override
    public int getInt(String key, int def) {
        return prefs.getInt(key, def);
    }

    @Override
    public void putInt(String key, int value) {
        prefs.edit().putInt(key, value).apply();
    }

    @Override
    public long getLong(String key, long def) {
        return prefs.getLong(key, def);
    }

    @Override
    public void putLong(String key, long value) {
        prefs.edit().putLong(key, value).apply();
    }

    @Override
    public int batteryLevel() {
        return battery;
    }

    @Override
    public boolean charging() {
        return charging;
    }

    @Override
    public long now() {
        return System.currentTimeMillis();
    }

    @Override
    public void sfx(int id) {
        if (prefs.getInt("sound", 1) == 1) sfx.play(id);
    }

    void release() {
        sfx.release();
    }
}
