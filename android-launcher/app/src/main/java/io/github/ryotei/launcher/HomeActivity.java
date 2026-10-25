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
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.FrameLayout;

/** ホームアプリとして起動されるActivity。画面は GameView ひとつだけ。 */
public final class HomeActivity extends Activity {
    private AndroidHost host;
    private Engine engine;
    private GameView view;
    private boolean resumed;
    private EditText input;

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
        // 検索の文字はこの見えない入力欄で受け取り、表示はEngineが自前で描く
        input = new EditText(this);
        input.setAlpha(0f);
        input.setFocusable(true);
        input.setFocusableInTouchMode(true);
        input.setShowSoftInputOnFocus(true);
        input.setSingleLine(true);
        input.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        input.setImeOptions(EditorInfo.IME_ACTION_SEARCH | EditorInfo.IME_FLAG_NO_EXTRACT_UI);
        input.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                engine.setQuery(s.toString());
            }

            @Override
            public void afterTextChanged(Editable s) {
            }
        });
        input.setOnEditorActionListener((v, actionId, event) -> {
            showKeyboard(false);
            return true;
        });
        FrameLayout root = new FrameLayout(this);
        root.addView(view, new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT));
        root.addView(input, new FrameLayout.LayoutParams(4, 4, Gravity.BOTTOM | Gravity.START));
        setContentView(root);
        host.keyboard = new AndroidHost.Keyboard() {
            @Override
            public void show(boolean show) {
                showKeyboard(show);
            }

            @Override
            public void clear() {
                clearInput();
            }
        };

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

    private void clearInput() {
        input.setText("");
    }

    private void showKeyboard(boolean show) {
        InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
        if (show) {
            // 一度閉じたキーボードは控えめな呼び方だと出てこないので、入力欄をつなぎ直してから強めに出す
            input.clearFocus();
            input.requestFocus();
            input.setSelection(input.length());
            imm.restartInput(input);
            input.postDelayed(() -> {
                input.requestFocus();
                if (android.os.Build.VERSION.SDK_INT >= 30 && input.getWindowInsetsController() != null) {
                    input.getWindowInsetsController().show(android.view.WindowInsets.Type.ime());
                }
                imm.showSoftInput(input, InputMethodManager.SHOW_FORCED);
            }, 120);
        } else {
            imm.hideSoftInputFromWindow(input.getWindowToken(), 0);
            input.clearFocus();
            view.requestFocus();
        }
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
