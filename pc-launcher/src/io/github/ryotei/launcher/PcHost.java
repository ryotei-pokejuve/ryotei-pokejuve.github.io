package io.github.ryotei.launcher;

import java.io.File;
import java.util.List;

/** PcEngine（描画と操作）から見たWindows側の機能。本物とプレビュー用の偽物がある。 */
interface PcHost {
    List<AppEntry> apps();

    int appsVersion();

    boolean appsLoading();

    boolean launch(AppEntry app);

    /** そのアプリ（ファイル）が入っているフォルダを開く。 */
    void showInFolder(AppEntry app);

    /** ドロップされたファイルやフォルダを一覧に足す。足したものを返す。 */
    AppEntry addFile(File file);

    String get(String key, String def);

    void put(String key, String value);

    int getInt(String key, int def);

    void putInt(String key, int value);

    long getLong(String key, long def);

    void putLong(String key, long value);

    long now();

    void sfx(int id);

    /** 検索の文字入力欄（日本語入力用の見えない欄）を出す／しまう。 */
    void searchField(boolean on, String initial);

    void minimize();

    void quit();

    boolean startupEnabled();

    void setStartup(boolean on);
}
