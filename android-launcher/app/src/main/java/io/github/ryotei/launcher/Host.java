package io.github.ryotei.launcher;

import java.util.List;

/** Engine（描画と操作）から見た端末側の機能。Android実装とプレビュー用の偽実装がある。 */
interface Host {
    int SFX_CURSOR = 0;
    int SFX_OK = 1;
    int SFX_CANCEL = 2;
    int SFX_MENU = 3;
    int SFX_LAUNCH = 4;
    int SFX_SAVE = 5;
    int SFX_START = 6;
    int SFX_ERROR = 7;
    int SFX_LEVEL = 8;
    int SFX_FLY = 9;

    /** ラベル順に並んだランチャー対象アプリ。読み込み中は空。 */
    List<AppEntry> apps();

    /** アプリ一覧が入れ替わるたびに増える番号。 */
    int appsVersion();

    boolean appsLoading();

    boolean launch(AppEntry app);

    void appInfo(AppEntry app);

    void uninstall(AppEntry app);

    void openSettings();

    void openHomeSettings();

    /** このランチャーをメインのホームにするようAndroidに頼む（確認画面が出る）。 */
    void requestDefaultHome();

    /** いまメインのホームになっているか。 */
    boolean isDefaultHome();

    /** 標準のホームは変えずに、端末にもとからあるホームアプリをその場で開く。見つからなければfalse。 */
    boolean openOtherHome();

    void openClock();

    boolean expandNotifications();

    String getString(String key, String def);

    void putString(String key, String value);

    int getInt(String key, int def);

    void putInt(String key, int value);

    long getLong(String key, long def);

    void putLong(String key, long value);

    int batteryLevel();

    boolean charging();

    /** 壁時計の現在時刻（ミリ秒）。 */
    long now();

    void sfx(int id);

    /** assets の画像を読む。無ければ null。 */
    android.graphics.Bitmap loadImage(String path);

    /** 検索の文字入力用にキーボードを出す／しまう。入力は Engine.setQuery に届く。 */
    void showKeyboard(boolean show);

    /** 検索の入力欄を空にする。 */
    void clearInput();
}
