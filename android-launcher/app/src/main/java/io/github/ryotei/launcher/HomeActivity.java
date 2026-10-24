package io.github.ryotei.launcher;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Typeface;
import android.graphics.drawable.ColorDrawable;
import android.os.BatteryManager;
import android.os.Bundle;

/** ホームアプリとして起動されるActivity。画面は GameView ひとつだけ。 */
public final class HomeActivity extends Activity {
    private AndroidHost host;
    private Engine engine;
    private GameView view;
    private boolean resumed;

    private final BroadcastReceiver batteryReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            int level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
            int scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, 100);
            int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
            host.battery = level < 0 || scale <= 0 ? -1 : level * 100 / scale;
            host.charging = status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL;
        }
    };

    private final BroadcastReceiver packageReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            host.reload();
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setBackgroundDrawable(new ColorDrawable(0xFF000000));
        getWindow().setNavigationBarColor(0xFF000000);
        host = new AndroidHost(this);
        Typeface font = Typeface.createFromAsset(getAssets(), "fonts/DotGothic16-Regular.ttf");
        engine = new Engine(host, new Pix(font));
        view = new GameView(this, engine);
        setContentView(view);

        registerReceiver(batteryReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
        IntentFilter pf = new IntentFilter();
        pf.addAction(Intent.ACTION_PACKAGE_ADDED);
        pf.addAction(Intent.ACTION_PACKAGE_REMOVED);
        pf.addAction(Intent.ACTION_PACKAGE_CHANGED);
        pf.addAction(Intent.ACTION_PACKAGE_REPLACED);
        pf.addDataScheme("package");
        registerReceiver(packageReceiver, pf);
        host.reload();
    }

    @Override
    protected void onResume() {
        super.onResume();
        resumed = true;
        engine.onResume();
        view.setRunning(true);
    }

    @Override
    protected void onPause() {
        resumed = false;
        view.setRunning(false);
        super.onPause();
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (resumed && Intent.ACTION_MAIN.equals(intent.getAction())) engine.homePressed();
    }

    @Override
    @SuppressWarnings("deprecation")
    public void onBackPressed() {
        engine.back();
    }

    @Override
    protected void onDestroy() {
        unregisterReceiver(batteryReceiver);
        unregisterReceiver(packageReceiver);
        view.setRunning(false);
        host.release();
        super.onDestroy();
    }
}
