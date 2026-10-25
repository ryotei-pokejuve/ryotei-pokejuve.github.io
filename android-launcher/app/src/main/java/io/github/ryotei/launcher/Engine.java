package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 * ランチャー本体。GBAくらいの低解像度キャンバスに全部を描き、タッチを「ゲームの操作」として扱う。
 * 世界は2つ。GBAではホームがRPGのタウンマップ（お気に入りアプリ＝まち）、メニューとアプリ一覧が電脳風のチップフォルダ。
 * WIREDでは真っ暗な虚空のノードマップと、端末風のディレクトリになる。中身（お気に入り・回数）は共通。
 * Android固有の処理は Host 越しに呼ぶので、このクラスは android.graphics 以外に依存しない。
 */
final class Engine {
    static final int BOOT = 0, HOME = 1, APPS = 2;
    /** お気に入りのまちの数（ネットシティは含まない）。 */
    static final int SLOTS = 10;

    private static final int M_APPS = 1, M_SOUND = 3, M_OP = 4, M_HOMESET = 5, M_SETTINGS = 6, M_SAVE = 7,
            M_CLOSE = 8, M_WORLD = 9, M_OTHER_HOME = 10, C_OPEN = 20, C_SWAP = 21, C_REMOVE = 22, C_INFO = 23, C_ADD = 24, C_UNINSTALL = 25,
            C_CANCEL = 26;
    private static final String[] TABS = {"すべて", "よくつかう", "さいきん"};
    private static final String[] WIRED_TABS = {"all", "freq", "recent"};
    private static final String[] WHISPERS = {"…だれか いるの？", "ここは どこ？", "きこえる？", "わたしは ずっと ここに いる",
            "つながっていない ひとなんて いない", "それは ほんとうに あなたの きおく？"};
    private static final String[] WEEK = {"日", "月", "火", "水", "木", "金", "土"};
    private static final long LONG_PRESS = 450;
    private static final long FLY_MS = 700;
    private static final int SLOP = 6;
    private static final int ROW = 20;

    private final Host host;
    private final Pix p;
    private final Scenery scenery = new Scenery();
    private final TownMap map = new TownMap();
    private final Wired net = new Wired();
    private boolean wired;
    private long lastTouch;
    private final Bitmap[][] hero = Sprites.actor(Sprites.HERO);
    private final Bitmap heroHead = Sprites.head(Sprites.HERO);
    private Theme th = Theme.FIELD;
    private int vw = 270, vh = 520;
    int screen;
    private long t;

    // アプリ一覧
    private int seenVersion = -1;
    private List<AppEntry> all = Collections.emptyList();
    private final HashMap<String, AppEntry> byKey = new HashMap<>();
    private List<AppEntry> frequent = Collections.emptyList();
    private List<AppEntry> recent = Collections.emptyList();
    private boolean listsDirty = true;

    // ホーム（タウンマップ）
    private final String[] slots = new String[SLOTS];
    private final AppEntry[] slotApps = new AppEntry[SLOTS];
    private final int[] levels = new int[SLOTS];
    private int cursor;
    private int here;
    private String replaceKey;
    private int flySlot = -1;
    private long flyStart;

    // チップフォルダ
    private int tab = 0;
    private float scroll, scrollVel;
    private int listCursor = 0;
    private int pickSlot = -1;
    // WIREDのディレクトリ：周波数ダイヤル
    private int channel;
    private float dialPos;
    private boolean dialDrag;
    private long tuneStart = -10000;
    private List<AppEntry> filtered = Collections.emptyList();
    private String filteredKey = "";
    private int[] zoomFrom;

    // メニュー
    private static final class Menu {
        boolean context;
        String title;
        String[] labels;
        int[] ids;
        int x, y, w, h;
        int hover = -1;
        AppEntry app;
        int slot = -1;
    }

    private Menu menu;

    // メッセージ
    private String msg = "";
    private long msgStart = -1;
    private boolean msgInstant;

    // タッチ
    private boolean down, dragging, longFired, scrollbarDrag;
    private int axis; // 0=未定 1=縦 2=横
    private int downX, downY, lastX, lastY;
    private long downT, lastT, lastFrame;
    private float vel;

    // 演出
    private int nextScreen = -1;
    private long transStart;
    private AppEntry pendingLaunch;
    private long launchAt;
    private long plugStart = -10000;
    private AppEntry plugApp;
    private int returnMode; // 0=なし 1=まちから 2=チップフォルダから
    private String levelUpMsg;
    private long saveAt = -1;
    private float fade; // 0=なし 1=真っ白
    private int fadeDir; // 1=白くする -1=戻す
    private long fadeStart = -1;

    Engine(Host host, Pix pix) {
        this.host = host;
        this.p = pix;
        for (int i = 0; i < SLOTS; i++) slots[i] = host.getString("slot" + i, "");
        wired = "wired".equals(host.getString("world", "gba"));
        here = Math.max(0, Math.min(TownMap.NET, host.getInt("here", TownMap.NET)));
        cursor = here;
        screen = host.getInt("opening", 1) == 1 ? BOOT : HOME;
        if (screen == HOME) say(greeting(), true);
    }

    void resize(int w, int h) {
        vw = w;
        vh = h;
        int[] f = mapFrame();
        map.layout(f[0] + 6, f[1] + 6, f[2] - 12, f[3] - 12);
        net.layout(6, 104, vw - 12, msgBox()[1] - 70 - 104);
    }

    /** GBAとWIREDで言い回しを変える。 */
    private String w(String gba, String wiredText) {
        return wired ? wiredText : gba;
    }

    // ================================================================ ライフサイクル

    void onResume() {
        menu = null;
        down = false;
        if (returnMode == 0) {
            if (screen == HOME && replaceKey == null && flySlot < 0) describe(cursor, true);
            return;
        }
        if (returnMode == 1 && flySlot >= 0) {
            here = flySlot;
            cursor = flySlot;
            host.putInt("here", here);
            flySlot = -1;
            startFade(-1);
        }
        returnMode = 0;
        screen = HOME;
        nextScreen = -1;
        pickSlot = -1;
        if (levelUpMsg != null) {
            say(levelUpMsg, false);
            host.sfx(Host.SFX_LEVEL);
            levelUpMsg = null;
        } else {
            say(w("おかえり！ RYOTEI。\nつぎは どこへ いく？", "> せつぞくを しゅうりょうした。\n> おかえりなさい、RYOTEI。"), false);
        }
    }

    /** ホーム画面表示中にもう一度ホームボタンが押された。 */
    void homePressed() {
        if (busy()) return;
        menu = null;
        replaceKey = null;
        if (screen == BOOT) {
            screen = HOME;
            say(greeting(), true);
        } else if (screen == APPS) {
            pickSlot = -1;
            host.sfx(Host.SFX_CANCEL);
            go(HOME);
            say(greeting(), true);
        } else {
            cursor = here;
            say(greeting(), true);
        }
    }

    /** 戻る操作。ランチャーなのでアプリは終了しない。 */
    boolean back() {
        if (busy()) return true;
        if (menu != null) {
            closeMenu();
        } else if (screen == APPS) {
            pickSlot = -1;
            host.sfx(Host.SFX_CANCEL);
            go(HOME);
            say(greeting(), true);
        } else if (replaceKey != null) {
            replaceKey = null;
            host.sfx(Host.SFX_CANCEL);
            say(greeting(), true);
        }
        return true;
    }

    private boolean busy() {
        return nextScreen >= 0 || pendingLaunch != null || flySlot >= 0 || fadeStart >= 0 || fade > 0;
    }

    // ================================================================ 1フレーム

    void frame(Canvas canvas, long now) {
        t = now;
        long dt = lastFrame == 0 ? 16 : Math.min(100, now - lastFrame);
        lastFrame = now;
        if (msgStart < 0) msgStart = t;
        if (fadeStart == -2) fadeStart = t;
        p.c = canvas;
        syncApps();
        update(dt);

        if (screen == BOOT) drawBoot();
        else if (screen == HOME) drawHome();
        else drawApps();
        if (menu != null) drawMenu(menu);
        drawEffects();
    }

    private void update(long dt) {
        if (nextScreen >= 0) {
            float k = (t - transStart) / 300f;
            if (k >= 0.5f && screen != nextScreen) screen = nextScreen;
            if (k >= 1f) nextScreen = -1;
        }
        if (fadeStart >= 0) {
            float k = Math.min(1f, (t - fadeStart) / 300f);
            fade = fadeDir > 0 ? k : 1 - k;
            if (k >= 1f) fadeStart = -1;
        }
        if (flySlot >= 0 && returnMode == 0) {
            long e = t - flyStart;
            if (e >= FLY_MS && fadeDir != 1) startFade(1);
            if (e >= FLY_MS + 330 && pendingLaunch == null) {
                pendingLaunch = slotApps[flySlot];
                launchAt = t;
                returnMode = 1;
            }
        }
        if (pendingLaunch != null && t >= launchAt) {
            AppEntry app = pendingLaunch;
            pendingLaunch = null;
            countLaunch(app);
            if (!host.launch(app)) {
                levelUpMsg = null;
                returnMode = 0;
                host.sfx(Host.SFX_ERROR);
                if (flySlot >= 0) {
                    here = flySlot;
                    flySlot = -1;
                    startFade(-1);
                }
                say("あれ？ その アプリは\nひらけなかった…", false);
            }
        }
        if (saveAt >= 0 && t >= saveAt) {
            saveAt = -1;
            host.sfx(Host.SFX_SAVE);
            say(w("RYOTEIは レポートに\nしっかり かきこんだ！", "> かきこみ かんりょう。\n> あなたの きおくは ここに ある。"), false);
        }
        if (down && !dragging && !longFired && t - downT > LONG_PRESS) {
            longFired = true;
            longPress(downX, downY);
        }
        if (!down && screen == APPS && Math.abs(scrollVel) > 0.01f) {
            scroll += scrollVel * dt;
            scrollVel *= (float) Math.pow(0.996, dt);
            if (scroll < 0 || scroll > maxScroll()) scrollVel = 0;
        }
        scroll = Math.max(0, Math.min(scroll, maxScroll()));
    }

    private void startFade(int dir) {
        fadeDir = dir;
        fadeStart = -2; // 次のフレームの時刻から始める
        fade = dir > 0 ? 0 : 1;
    }

    // ================================================================ アプリ一覧の同期

    private void syncApps() {
        int v = host.appsVersion();
        if (v != seenVersion) {
            seenVersion = v;
            all = host.apps();
            byKey.clear();
            for (AppEntry a : all) byKey.put(a.key, a);
            if (host.getString("slotinit", "").isEmpty() && !all.isEmpty()) defaultSlots();
            listsDirty = true;
        }
        if (listsDirty) rebuildLists();
        for (int i = 0; i < SLOTS; i++) {
            String k = slots[i];
            slotApps[i] = k == null || k.isEmpty() ? null : byKey.get(k);
            levels[i] = slotApps[i] == null ? 0 : level(count(slotApps[i]));
        }
    }

    private void defaultSlots() {
        String[] wanted = {"com.android.chrome", "com.google.android.youtube", "com.google.android.apps.photos",
                "com.google.android.GoogleCamera", "com.sec.android.app.camera", "com.android.camera",
                "com.google.android.gm", "com.google.android.apps.messaging", "com.google.android.dialer",
                "com.android.vending", "com.google.android.apps.maps"};
        int n = 0;
        for (String pkg : wanted) {
            if (n >= SLOTS - 2) break; // いくつかはあき地にしておく
            for (AppEntry a : all) {
                if (a.pkg.equals(pkg)) {
                    slots[n++] = a.key;
                    break;
                }
            }
        }
        for (int i = 0; i < SLOTS; i++) host.putString("slot" + i, slots[i] == null ? "" : slots[i]);
        host.putString("slotinit", "1");
    }

    private void rebuildLists() {
        listsDirty = false;
        ArrayList<AppEntry> f = new ArrayList<>(), r = new ArrayList<>();
        for (AppEntry a : all) {
            if (count(a) > 0) f.add(a);
            if (lastUsed(a) > 0) r.add(a);
        }
        Collections.sort(f, (a, b) -> Integer.compare(count(b), count(a)));
        Collections.sort(r, (a, b) -> Long.compare(lastUsed(b), lastUsed(a)));
        frequent = f;
        recent = r.size() > 40 ? new ArrayList<>(r.subList(0, 40)) : r;
    }

    private List<AppEntry> list() {
        List<AppEntry> base = tab == 1 ? frequent : tab == 2 ? recent : all;
        if (!wired || channel == 0) return base;
        String key = tab + ":" + channel + ":" + seenVersion + ":" + System.identityHashCode(base);
        if (!key.equals(filteredKey)) {
            ArrayList<AppEntry> f = new ArrayList<>();
            for (AppEntry a : base) if (Wired.channelOf(a) == channel) f.add(a);
            filtered = f;
            filteredKey = key;
        }
        return filtered;
    }

    /** チャンネルごとのアプリ数（ダイヤルで空のチャンネルを暗くするため）。 */
    private int[] channelCounts() {
        List<AppEntry> base = tab == 1 ? frequent : tab == 2 ? recent : all;
        int[] c = new int[Wired.CHANNELS.length];
        for (AppEntry a : base) c[Wired.channelOf(a)]++;
        return c;
    }

    private void setChannel(int ch) {
        ch = Math.max(0, Math.min(Wired.CHANNELS.length - 1, ch));
        dialPos = ch;
        if (ch == channel) return;
        channel = ch;
        tuneStart = t;
        scroll = 0;
        scrollVel = 0;
        listCursor = 0;
        host.sfx(Host.SFX_CURSOR);
    }

    private int count(AppEntry a) {
        return host.getInt("n:" + a.key, 0);
    }

    private long lastUsed(AppEntry a) {
        return host.getLong("t:" + a.key, 0);
    }

    static int level(int count) {
        return Math.min(100, (int) Math.sqrt(count) + 1);
    }

    /** まちの名前。よく使うほど「タウン」から「シティ」に育つ。 */
    private String townName(int i, int maxW) {
        if (i == TownMap.NET) return w("ネットシティ", "ROOT");
        AppEntry a = slotApps[i];
        if (a == null) return w("？？？", "------");
        if (wired) return p.fit(a.label, maxW);
        String suffix = levels[i] >= 5 ? "シティ" : "タウン";
        return p.fit(a.label, maxW - p.width(suffix)) + suffix;
    }

    private void countLaunch(AppEntry a) {
        int before = count(a);
        host.putInt("n:" + a.key, before + 1);
        host.putLong("t:" + a.key, host.now());
        listsDirty = true;
        int lv = level(before + 1);
        if (lv > level(before) && lv > 1) {
            String name = p.fit(a.label, 150);
            if (wired) levelUpMsg = "> " + Wired.nodeId(a, before + 1) + " どうきレベル " + lv + "\n> つながりが ふかくなった。";
            else levelUpMsg = lv == 5 && slotOf(a) >= 0 ? name + "タウンが\n" + name + "シティに なった！"
                    : name + "の レベルが\n" + lv + "に あがった！";
        } else {
            levelUpMsg = null;
        }
    }

    private int slotOf(AppEntry a) {
        for (int i = 0; i < SLOTS; i++) if (a.key.equals(slots[i])) return i;
        return -1;
    }

    private void setSlot(int i, String key) {
        slots[i] = key == null ? "" : key;
        host.putString("slot" + i, slots[i]);
        slotApps[i] = slots[i].isEmpty() ? null : byKey.get(slots[i]);
        levels[i] = slotApps[i] == null ? 0 : level(count(slotApps[i]));
    }

    // ================================================================ メッセージ

    void say(String text, boolean instant) {
        msg = text;
        msgStart = -1;
        msgInstant = instant;
    }

    private String greeting() {
        if (wired) return wiredGreeting();
        int lv = host.batteryLevel();
        if (lv >= 0 && lv <= 15 && !host.charging()) return "でんちが のこり すくない！\nはやく じゅうでん しよう！";
        if (host.charging()) return "じゅうでん ちゅう…\nHPが すこしずつ かいふく！";
        int h = hour();
        if (h >= 5 && h <= 10) return "おはよう！ RYOTEI。\nきょうは どこへ いく？";
        if (h >= 11 && h <= 16) return "タウンマップを ひろげた。\nどこへ いこうかな？";
        if (h >= 17 && h <= 20) return "ゆうがたに なってきた。\nどこかに よっていく？";
        return "よふかしは ほどほどに…\nそろそろ やすもう。";
    }

    private String wiredGreeting() {
        int lv = host.batteryLevel();
        if (lv >= 0 && lv <= 15 && !host.charging()) return "> でんげんが よわっている。\n> このままだと せつだんされる。";
        int h = hour();
        if (h >= 22 || h <= 4) return "> よるの WIRED は しずか。\n> だれかの こえが きこえる きがする。";
        return "> WIRED に せつぞくした。\n> ノードを えらんで。";
    }

    /** カーソルを合わせたまち（ノード）の説明。 */
    private void describe(int i, boolean instant) {
        if (wired) {
            if (i == TownMap.NET) say("> ROOT / すべての いりぐち\n> もういちど タップで ひらく", instant);
            else if (slotApps[i] == null) say("> からっぽの ノード\n> もういちど タップで つなぐ", instant);
            else say("> " + p.fit(slotApps[i].label, 120) + " / " + Wired.nodeId(slotApps[i], count(slotApps[i]))
                    + "\n> もういちど タップで せつぞく", instant);
            return;
        }
        if (i == TownMap.NET) {
            say("でんのうせかいの いりぐち。\nもう いちど タップで はいる", instant);
        } else if (slotApps[i] == null) {
            say("なにも ない ばしょだ。\nもう いちど タップで つくる", instant);
        } else {
            int n = count(slotApps[i]);
            say("Lv" + levels[i] + "・" + n + "かい おとずれた\nもう いちど タップで とぶ", instant);
        }
    }

    private int hour() {
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(host.now());
        return cal.get(Calendar.HOUR_OF_DAY);
    }

    private List<String> wrap(String text, int maxW) {
        ArrayList<String> out = new ArrayList<>();
        for (String seg : text.split("\n", -1)) {
            StringBuilder line = new StringBuilder();
            for (int i = 0; i < seg.length(); i++) {
                line.append(seg.charAt(i));
                if (p.width(line.toString()) > maxW && line.length() > 1) {
                    line.setLength(line.length() - 1);
                    out.add(line.toString());
                    line.setLength(0);
                    line.append(seg.charAt(i));
                }
            }
            out.add(line.toString());
        }
        return out;
    }

    // ================================================================ 画面遷移と起動

    private void go(int s) {
        nextScreen = s;
        transStart = t;
        down = false;
    }

    /** タウンマップで選んだまちへ飛ぶ。主人公のアイコンが空を飛び、白くなってアプリが起動する。 */
    private void fly(int i) {
        AppEntry a = slotApps[i];
        if (a == null) return;
        flySlot = i;
        flyStart = t;
        cursor = i;
        host.sfx(Host.SFX_FLY);
        say(w("RYOTEIは " + townName(i, 130) + "へ\nとんでいった！", "> " + Wired.nodeId(a, count(a)) + " に せつぞくちゅう…\n> うごかないで。"), true);
    }

    /** チップフォルダからの起動。電脳風の演出をはさむ。 */
    private void plugIn(AppEntry a) {
        int idx = list().indexOf(a);
        int[] wb = wallBox();
        zoomFrom = idx >= 0 ? Wired.wallRect(wb[0], wb[1], wb[2], idx, scroll) : new int[]{vw / 2 - 39, vh / 2 - 34, 78, 68};
        host.sfx(Host.SFX_LAUNCH);
        plugApp = a;
        plugStart = t;
        pendingLaunch = a;
        launchAt = t + 520;
        returnMode = 2;
    }

    private void openApps(int pick) {
        pickSlot = pick;
        listCursor = Math.min(listCursor, Math.max(0, list().size() - 1));
        host.sfx(Host.SFX_MENU);
        go(APPS);
    }

    private void addToHome(AppEntry a) {
        for (int i = 0; i < SLOTS; i++) {
            if (slotApps[i] == null) {
                build(i, a);
                return;
            }
        }
        replaceKey = a.key;
        host.sfx(Host.SFX_MENU);
        if (screen == APPS) go(HOME);
        say(w("あきちが ない！\nどの まちと いれかえる？", "> あいている ノードが ない。\n> どれと いれかえる？"), false);
    }

    private void build(int i, AppEntry a) {
        int old = slotOf(a);
        if (old >= 0 && old != i) setSlot(old, slots[i]);
        setSlot(i, a.key);
        cursor = i;
        host.sfx(Host.SFX_LEVEL);
        if (screen == APPS) go(HOME);
        say(w(townName(i, 200) + "が\nタウンマップに のった！", "> あたらしい ノード " + Wired.nodeId(a, count(a)) + "\n> " + p.fit(a.label, 200) + " と つながった。"), false);
    }

    // ================================================================ タッチ

    /** action: 0=down 1=move 2=up 3=cancel。座標は低解像度キャンバス上の値。 */
    void touch(int act, int x, int y, long time) {
        if (busy()) {
            down = false;
            return;
        }
        switch (act) {
            case 0:
                lastTouch = time;
                down = true;
                dragging = false;
                longFired = false;
                scrollbarDrag = false;
                axis = 0;
                downX = lastX = x;
                downY = lastY = y;
                downT = lastT = time;
                vel = 0;
                scrollVel = 0;
                press(x, y);
                break;
            case 1:
                if (!down) return;
                if (menu != null) {
                    menu.hover = menuHit(menu, x, y);
                } else {
                    if (!dragging && (Math.abs(x - downX) > SLOP || Math.abs(y - downY) > SLOP)) {
                        dragging = true;
                        axis = Math.abs(x - downX) > Math.abs(y - downY) ? 2 : 1;
                    }
                    if (dialDrag) {
                        dialPos = Math.max(0, Math.min(Wired.CHANNELS.length - 1, dialPos - (x - lastX) / (float) Wired.DIAL_STEP));
                    } else if (scrollbarDrag) {
                        scrollToBar(y);
                    } else if (dragging && screen == HOME && wired && axis == 2) {
                        net.spin(x - lastX);
                    } else if (dragging && screen == APPS && axis == 1) {
                        scroll -= y - lastY;
                        long dtm = Math.max(1, time - lastT);
                        vel = vel * 0.4f + ((y - lastY) / (float) dtm) * 0.6f;
                    }
                }
                lastX = x;
                lastY = y;
                lastT = time;
                break;
            case 2:
                if (!down) return;
                down = false;
                if (longFired) return;
                if (menu != null) {
                    int hit = menuHit(menu, x, y);
                    if (hit >= 0) menuSelect(menu, menu.ids[hit]);
                    else closeMenu();
                    return;
                }
                if (dialDrag) {
                    dialDrag = false;
                    int[] d = dialBox();
                    setChannel(dragging ? Math.round(dialPos) : Math.round(dialPos + (x - (d[0] + d[2] / 2)) / (float) Wired.DIAL_STEP));
                    return;
                }
                if (scrollbarDrag) {
                    scrollbarDrag = false;
                    return;
                }
                if (dragging) {
                    release(x - downX, y - downY, time);
                    return;
                }
                tap(x, y);
                break;
            default:
                down = false;
                scrollbarDrag = false;
                dialDrag = false;
        }
    }

    private void press(int x, int y) {
        if (menu != null) {
            menu.hover = menuHit(menu, x, y);
            return;
        }
        if (screen == APPS && wired && inside(x, y, dialBox())) {
            dialDrag = true;
            return;
        }
        if (screen == APPS) {
            int[] l = listBox();
            if (!wired && x >= l[0] + l[2] - 16 && y >= l[1] && y < l[1] + l[3] && maxScroll() > 0) {
                scrollbarDrag = true;
                scrollToBar(y);
                return;
            }
            int r = rowHit(x, y);
            if (r >= 0 && r != listCursor) {
                listCursor = r;
                host.sfx(Host.SFX_CURSOR);
            }
        }
    }

    private void release(int dx, int dy, long time) {
        if (screen == HOME && axis == 1 && Math.abs(dy) > 40) {
            if (dy < 0) openApps(-1);
            else host.expandNotifications();
        } else if (screen == APPS && axis == 1) {
            scrollVel = time - lastT > 80 ? 0 : -vel;
        } else if (screen == APPS && wired && axis == 2 && Math.abs(dx) > 40) {
            setChannel(channel + (dx < 0 ? 1 : -1));
        } else if (screen == APPS && axis == 2 && Math.abs(dx) > 40) {
            setTab((tab + (dx < 0 ? 1 : TABS.length - 1)) % TABS.length);
        }
    }

    private void tap(int x, int y) {
        if (screen == BOOT) {
            host.sfx(Host.SFX_START);
            go(HOME);
            say(greeting(), false);
            return;
        }
        if (screen == HOME) {
            tapHome(x, y);
            return;
        }
        int[] hd = headerBox();
        if (inside(x, y, hd)) {
            if (y < hd[1] + 24) {
                if (x < hd[0] + 72) back();
            } else {
                int tw = (hd[2] - 16) / TABS.length;
                int ti = (x - hd[0] - 8) / tw;
                if (ti >= 0 && ti < TABS.length && ti != tab) setTab(ti);
            }
            return;
        }
        int r = rowHit(x, y);
        if (r >= 0) rowTap(r);
    }

    private void tapHome(int x, int y) {
        if (inside(x, y, msgBox())) {
            msgInstant = true;
            return;
        }
        int[] b = wired ? wiredButtons() : buttons();
        if (inside(x, y, b[0], b[1], b[2], b[3])) {
            openMenu();
            return;
        }
        if (inside(x, y, b[4], b[5], b[6], b[7])) {
            openApps(-1);
            return;
        }
        if (wired ? y < 22 : inside(x, y, hudBox())) {
            host.sfx(Host.SFX_OK);
            host.openClock();
            return;
        }
        int town = homeHit(x, y);
        if (town < 0) return;
        if (replaceKey != null && town != TownMap.NET) {
            AppEntry a = byKey.get(replaceKey);
            replaceKey = null;
            if (a != null) build(town, a);
            return;
        }
        if (town != cursor) {
            cursor = town;
            host.sfx(Host.SFX_CURSOR);
            describe(town, false);
            return;
        }
        if (town == TownMap.NET) {
            openApps(-1);
        } else if (slotApps[town] == null) {
            host.sfx(Host.SFX_OK);
            openApps(town);
        } else {
            fly(town);
        }
    }

    /** ホームでタップした所にあるまち（ノード）。 */
    private int homeHit(int x, int y) {
        return wired ? net.nodeAt(x, y, t) : map.townAt(x, y);
    }

    private void longPress(int x, int y) {
        if (menu != null) return;
        if (screen == HOME) {
            int town = homeHit(x, y);
            if (town >= 0 && town != TownMap.NET && slotApps[town] != null) {
                cursor = town;
                AppEntry a = slotApps[town];
                Menu m = contextMenu(townName(town, 160), new String[]{w("とぶ", "せつぞく"), w("いれかえる", "つなぎかえる"),
                                w("けす", "きりはなす"), "アプリじょうほう", "やめる"},
                        new int[]{C_OPEN, C_SWAP, C_REMOVE, C_INFO, C_CANCEL});
                m.app = a;
                m.slot = town;
                showMenu(m);
            } else if (town < 0 && !inside(x, y, msgBox())) {
                openMenu();
            }
        } else if (screen == APPS) {
            int r = rowHit(x, y);
            if (r < 0) return;
            listCursor = r;
            AppEntry a = list().get(r);
            boolean onHome = slotOf(a) >= 0;
            Menu m = contextMenu(a.label,
                    new String[]{w("プラグイン", "せつぞく"), onHome ? w("マップから けす", "ノードを きりはなす") : w("マップに のせる", "ノードに つなぐ"),
                            "アプリじょうほう", "アンインストール", "やめる"},
                    new int[]{C_OPEN, onHome ? C_REMOVE : C_ADD, C_INFO, C_UNINSTALL, C_CANCEL});
            m.app = a;
            m.slot = slotOf(a);
            showMenu(m);
        }
    }

    private void rowTap(int r) {
        List<AppEntry> l = list();
        if (r >= l.size()) return;
        AppEntry a = l.get(r);
        listCursor = r;
        if (pickSlot >= 0) {
            int i = pickSlot;
            pickSlot = -1;
            build(i, a);
        } else {
            plugIn(a);
        }
    }

    private void setTab(int i) {
        tab = i;
        scroll = 0;
        scrollVel = 0;
        listCursor = 0;
        host.sfx(Host.SFX_CURSOR);
    }

    private void scrollToBar(int y) {
        int[] l = listBox();
        float k = (y - l[1] - 8) / (float) Math.max(1, l[3] - 16);
        scroll = Math.max(0, Math.min(1, k)) * maxScroll();
    }

    // ================================================================ メニュー（電脳風）

    private void openMenu() {
        String[] labels = {w("チップフォルダ", "ディレクトリ"), "せかい：" + (wired ? "WIRED" : "GBA"), "サウンド：" + (host.getInt("sound", 1) == 1 ? "ON" : "OFF"),
                "オープニング：" + (host.getInt("opening", 1) == 1 ? "ON" : "OFF"), "いつもの ホームへ", "ホームアプリ", "たんまつせってい",
                "レポート", "とじる"};
        int[] ids = {M_APPS, M_WORLD, M_SOUND, M_OP, M_OTHER_HOME, M_HOMESET, M_SETTINGS, M_SAVE, M_CLOSE};
        Menu m = new Menu();
        m.title = w("MENU", "> menu");
        m.labels = labels;
        m.ids = ids;
        m.w = Math.min(vw - 12, 176);
        m.h = labels.length * 18 + 34;
        m.x = vw - 6 - m.w;
        m.y = wired ? 50 : nameBox()[1] + nameBox()[3] + 4;
        m.hover = menu != null && !menu.context ? menu.hover : 0;
        showMenu(m);
    }

    private Menu contextMenu(String title, String[] labels, int[] ids) {
        Menu m = new Menu();
        m.context = true;
        m.labels = labels;
        m.ids = ids;
        int w = 0;
        for (String s : labels) w = Math.max(w, p.width(s));
        m.w = Math.min(vw - 12, Math.max(w + 34, 150));
        m.title = p.fit(title, m.w - 20);
        m.h = labels.length * 18 + 34;
        m.x = vw - 6 - m.w;
        m.y = Math.max(wired ? 50 : nameBox()[1] + nameBox()[3] + 4, msgBox()[1] - 4 - m.h);
        m.hover = 0;
        return m;
    }

    private void showMenu(Menu m) {
        if (menu == null) host.sfx(Host.SFX_MENU);
        menu = m;
    }

    private void closeMenu() {
        menu = null;
        host.sfx(Host.SFX_CANCEL);
    }

    private int menuHit(Menu m, int x, int y) {
        int top = m.y + 27;
        if (x < m.x || x >= m.x + m.w || y < top || y >= top + m.labels.length * 18) return -1;
        return (y - top) / 18;
    }

    private void menuSelect(Menu m, int id) {
        AppEntry a = m.app;
        switch (id) {
            case M_APPS:
                menu = null;
                openApps(-1);
                return;
            case M_WORLD:
                wired = !wired;
                host.putString("world", wired ? "wired" : "gba");
                host.sfx(Host.SFX_OK);
                openMenu();
                say(w("GBA の せかいに もどってきた。\nタウンマップを ひろげた。", "> WIRED に せつぞくした。\n> ここでは なにもかもが つながっている。"), false);
                return;
            case M_SOUND:
                host.putInt("sound", host.getInt("sound", 1) == 1 ? 0 : 1);
                host.sfx(Host.SFX_OK);
                openMenu();
                return;
            case M_OP:
                host.putInt("opening", host.getInt("opening", 1) == 1 ? 0 : 1);
                host.sfx(Host.SFX_OK);
                openMenu();
                return;
            case M_OTHER_HOME:
                menu = null;
                host.sfx(Host.SFX_OK);
                if (!host.openOtherHome()) say(w("ほかの ホームアプリが みつからない…", "> ほかの ホームが みつからない。"), false);
                return;
            case M_HOMESET:
                menu = null;
                host.sfx(Host.SFX_OK);
                host.openHomeSettings();
                return;
            case M_SETTINGS:
                menu = null;
                host.sfx(Host.SFX_OK);
                host.openSettings();
                return;
            case M_SAVE:
                menu = null;
                host.sfx(Host.SFX_OK);
                say(w("レポートを かきこんでいます…\nでんげんを きらないで ください。", "> きおくを かきこんでいる…\n> でんげんを きらないで。"), false);
                saveAt = t + 1400;
                return;
            case C_OPEN:
                menu = null;
                if (screen == APPS) plugIn(a);
                else if (m.slot >= 0) fly(m.slot);
                return;
            case C_SWAP:
                menu = null;
                openApps(m.slot);
                return;
            case C_REMOVE: {
                menu = null;
                String name = m.slot >= 0 ? townName(m.slot, 150) : a.label;
                if (m.slot >= 0) setSlot(m.slot, "");
                host.sfx(Host.SFX_CANCEL);
                if (screen == HOME) say(w(name + "が\nタウンマップから きえた。", "> " + name + " との\n> せつぞくを きりはなした。"), false);
                return;
            }
            case C_ADD:
                menu = null;
                addToHome(a);
                return;
            case C_INFO:
                menu = null;
                host.sfx(Host.SFX_OK);
                host.appInfo(a);
                return;
            case C_UNINSTALL:
                menu = null;
                host.sfx(Host.SFX_OK);
                host.uninstall(a);
                return;
            default:
                closeMenu();
        }
    }

    // ================================================================ レイアウト

    private int[] hudBox() {
        return new int[]{6, 6, vw - 12, 28};
    }

    private int[] nameBox() {
        return new int[]{6, 38, vw - 12 - 100, 30};
    }

    private int[] buttons() {
        int x = vw - 6 - 96;
        return new int[]{x, 40, 46, 26, x + 50, 40, 46, 26};
    }

    private int[] mapFrame() {
        int top = 72, bottom = msgBox()[1] - 4;
        return new int[]{6, top, vw - 12, bottom - top};
    }

    private int[] msgBox() {
        return new int[]{6, vh - 6 - 52, vw - 12, 52};
    }

    private int[] headerBox() {
        return new int[]{6, 6, vw - 12, 48};
    }

    private int[] previewBox() {
        return new int[]{6, 58, vw - 12, 92};
    }

    private int[] listBox() {
        int top = 154;
        return new int[]{6, top, vw - 12, vh - 6 - top};
    }

    private int[] wallBox() {
        int top = 60;
        return new int[]{6, top, vw - 12, dialBox()[1] - 6 - top};
    }

    private int[] dialBox() {
        return new int[]{6, vh - 6 - 62, vw - 12, 62};
    }

    private int listInnerTop() {
        return listBox()[1] + 7;
    }

    private int listInnerH() {
        return listBox()[3] - 14;
    }

    private int maxScroll() {
        if (wired) {
            int rows = (list().size() + Wired.WALL_COLS - 1) / Wired.WALL_COLS;
            return Math.max(0, rows * Wired.CELL_H + 8 - wallBox()[3]);
        }
        return Math.max(0, list().size() * ROW - listInnerH());
    }

    private int rowHit(int x, int y) {
        if (wired) {
            int[] wb = wallBox();
            if (!inside(x, y, wb)) return -1;
            int n = list().size();
            int row = (int) ((y - wb[1] + scroll) / Wired.CELL_H);
            for (int c = 0; c < Wired.WALL_COLS; c++) {
                int i = row * Wired.WALL_COLS + c;
                if (i >= n) break;
                int[] m = Wired.wallRect(wb[0], wb[1], wb[2], i, scroll);
                if (x >= m[0] - 4 && x < m[0] + m[2] + 4) return i;
            }
            return -1;
        }
        int[] l = listBox();
        if (x < l[0] || x >= l[0] + l[2] - 16 || y < listInnerTop() || y >= listInnerTop() + listInnerH()) return -1;
        int r = (int) ((y - listInnerTop() + scroll) / ROW);
        return r >= 0 && r < list().size() ? r : -1;
    }

    private static boolean inside(int x, int y, int[] b) {
        return inside(x, y, b[0], b[1], b[2], b[3]);
    }

    private static boolean inside(int x, int y, int bx, int by, int bw, int bh) {
        return x >= bx && x < bx + bw && y >= by && y < by + bh;
    }

    // ================================================================ 描画：部品

    /** 今の th に合わせたウィンドウ。FIELDは白い角丸、CYBERは角を落とした電脳パネル。 */
    private void window(int x, int y, int w, int h) {
        if (th.wired) {
            p.rect(x, y, w, h, th.winFill);
            Wired.frame(p, x, y, w, h, th.winOuter);
            int l = Math.min(6, Math.min(w, h) / 3);
            p.rect(x, y, l, 1, th.winFrame);
            p.rect(x, y, 1, l, th.winFrame);
            p.rect(x + w - l, y + h - 1, l, 1, th.winFrame);
            p.rect(x + w - 1, y + h - l, 1, l, th.winFrame);
            return;
        }
        if (!th.cyber) {
            p.round(x, y, w, h, th.winOuter);
            p.round(x + 1, y + 1, w - 2, h - 2, th.winFrame);
            p.rect(x + 3, y + 3, w - 6, h - 6, th.winInner);
            p.rect(x + 4, y + 4, w - 8, h - 8, th.winFill);
        } else {
            p.chamfer(x, y, w, h, 5, th.winOuter);
            p.chamfer(x + 1, y + 1, w - 2, h - 2, 4, th.winFill);
            p.rect(x + 8, y + 1, Math.min(36, w - 16), 2, th.winOuter);
            p.rect(x + w - 6 - Math.min(16, w - 16), y + h - 3, Math.min(16, w - 16), 2, th.winFrame);
        }
    }

    private void window(int[] b) {
        window(b[0], b[1], b[2], b[3]);
    }

    private void bar(int x, int y, int w, int h, float frac, int color) {
        p.rect(x, y, w, h, th.barFrame);
        p.rect(x + 1, y + 1, w - 2, h - 2, th.barBack);
        int fw = Math.round((w - 2) * Math.max(0, Math.min(1, frac)));
        p.rect(x + 1, y + 1, fw, h - 2, color);
        if (h > 3) p.rect(x + 1, y + 1, fw, 1, lighten(color));
    }

    private static int lighten(int c) {
        int r = Math.min(255, ((c >> 16) & 255) + 48), g = Math.min(255, ((c >> 8) & 255) + 48), b = Math.min(255, (c & 255) + 48);
        return 0xFF000000 | (r << 16) | (g << 8) | b;
    }

    // ================================================================ 描画：画面

    private void drawBoot() {
        if (wired) {
            drawWiredBoot();
            return;
        }
        th = Theme.FIELD;
        int[] bands = {0xFF0C3020, 0xFF124028, 0xFF185034, 0xFF206440, 0xFF2C784C, 0xFF3A8C5A};
        int bh = Math.max(1, vh / (bands.length * 2));
        for (int i = 0; i < bands.length; i++) p.rect(0, i * bh, vw, bh, bands[i]);
        for (int i = 0; i < bands.length; i++) p.rect(0, vh - (i + 1) * bh, vw, bh, bands[i]);
        p.rect(0, bands.length * bh, vw, vh - 2 * bands.length * bh, 0xFF46A066);
        int cy = vh * 28 / 100;
        int shadow = 0xFF103820;
        String title = "RYOTEI";
        p.big(title, (vw - p.bigWidth(title, 4)) / 2, cy, 4, 0xFFF8F8F8, shadow);
        String sub = "LAUNCHER";
        p.big(sub, (vw - p.bigWidth(sub, 2)) / 2, cy + 76, 2, 0xFFF8D058, shadow);
        for (int k = 0; k < 6; k++) {
            long ph = (t / 120 + k * 5) % 14;
            if (ph > 4) continue;
            int sx = (k * 83 + 17) % (vw - 20) + 10, sy = cy - 14 + (k * 47) % 110;
            int s = ph < 3 ? (int) ph : 4 - (int) ph;
            p.rect(sx - s, sy, s * 2 + 1, 1, 0xFFF8F8F8);
            p.rect(sx, sy - s, 1, s * 2 + 1, 0xFFF8F8F8);
        }
        int f = (int) ((t / 250) % 4);
        p.image(hero[0][f == 1 ? 1 : f == 3 ? 2 : 0], vw / 2 - 16, vh * 50 / 100, 32, 40);
        if ((t / 500) % 2 == 0) {
            String ps = "PRESS START";
            p.big(ps, (vw - p.bigWidth(ps, 2)) / 2, vh * 66 / 100, 2, 0xFFF8F8F8, shadow);
        }
        p.textCenter("©2026 RYOTEI", vw / 2, vh - 30, 0xFFD0F0D8, shadow);
    }

    private void drawHome() {
        if (wired) {
            drawWiredHome();
            return;
        }
        th = Theme.FIELD;
        p.rect(0, 0, vw, vh, 0xFF305878);
        for (int y = 0; y < vh; y += 4) p.rect(0, y, vw, 1, 0xFF28506E);
        drawHud();
        int[] nb = nameBox();
        window(nb);
        p.text(townName(cursor, nb[2] - 22), nb[0] + 10, nb[1] + 7, th.text, th.shadow);
        int[] b = buttons();
        smallButton(b[0], b[1], b[2], b[3], "MENU");
        smallButton(b[4], b[5], b[6], b[7], "APPS");

        int[] f = mapFrame();
        p.round(f[0], f[1], f[2], f[3], 0xFF183048);
        p.round(f[0] + 1, f[1] + 1, f[2] - 2, f[3] - 2, 0xFF58B8D0);
        p.rect(f[0] + 3, f[1] + 3, f[2] - 6, f[3] - 6, 0xFF2C6890);
        p.rect(f[0] + 5, f[1] + 5, f[2] - 10, f[3] - 10, 0xFF4878D8);
        // 主人公アイコン：いる町の上。飛んでいる間は弧を描いて移動する
        int hx = map.townX(here), hy = map.townY(here) - map.cs;
        if (flySlot >= 0) {
            float k = Math.min(1f, (t - flyStart) / (float) FLY_MS);
            float e = k * k * (3 - 2 * k);
            int tx = map.townX(flySlot), ty = map.townY(flySlot) - map.cs;
            hx = Math.round(hx + (tx - hx) * e);
            hy = Math.round(hy + (ty - hy) * e - (float) Math.sin(Math.PI * k) * 40);
        }
        map.draw(p, t, levels, flySlot >= 0 ? flySlot : cursor, heroHead, hx, hy);
        if (replaceKey != null) {
            String s = "いれかえる まちを えらんでね";
            int w = p.width(s) + 16;
            p.round(vw / 2 - w / 2, f[1] + 8, w, 20, 0xE0181818);
            p.textCenter(s, vw / 2, f[1] + 10, 0xFFF8F8F8, 0);
        }
        drawMessage(msgBox());
    }

    private void smallButton(int x, int y, int w, int h, String label) {
        p.round(x, y, w, h, th.winOuter);
        p.round(x + 1, y + 1, w - 2, h - 2, th.winFill);
        p.rect(x + 2, y + h - 3, w - 4, 1, th.shadow);
        p.textCenter(label, x + w / 2, y + (h - Pix.LINE) / 2 - 1, th.text, th.shadow);
    }

    private void drawHud() {
        int[] b = hudBox();
        window(b);
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(host.now());
        int hh = cal.get(Calendar.HOUR_OF_DAY), mm = cal.get(Calendar.MINUTE);
        String date = (cal.get(Calendar.MONTH) + 1) + "/" + cal.get(Calendar.DAY_OF_MONTH) + "(" + WEEK[cal.get(Calendar.DAY_OF_WEEK) - 1] + ")";
        String clock = (hh < 10 ? "0" : "") + hh + ((t / 500) % 2 == 0 ? ":" : " ") + (mm < 10 ? "0" : "") + mm;
        p.text(date + " " + clock, b[0] + 10, b[1] + 6, th.text, th.shadow);
        int right = b[0] + b[2] - 8;
        int lv = host.batteryLevel();
        int pct = Math.max(0, lv);
        String num = lv < 0 ? "--" : String.valueOf(pct);
        int barRight = right - p.width("100") - 3;
        int labelX = barRight - 70;
        p.round(labelX, b[1] + 7, 21, 15, th.hpLabel);
        p.text("HP", labelX + 3, b[1] + 7, th.hpLabelText, 0);
        int color = pct > 50 ? th.hpGreen : pct > 20 ? th.hpYellow : th.hpRed;
        bar(labelX + 23, b[1] + 11, barRight - labelX - 23, 6, pct / 100f, color);
        if (host.charging()) {
            int bx = labelX + 24, bw = barRight - labelX - 25;
            int sx = (int) (t / 20 % (bw + 12)) - 6;
            p.rect(bx + Math.max(0, sx), b[1] + 12, Math.max(0, Math.min(4, bw - Math.max(0, sx))), 4, 0xFFF8F8F8);
        }
        p.textRight(num, right, b[1] + 6, th.text, th.shadow);
    }

    private void drawMessage(int[] b) {
        window(b);
        int maxW = b[2] - 28;
        List<String> lines = wrap(msg, maxW);
        int shown = msgInstant ? Integer.MAX_VALUE : (int) ((t - msgStart) / 18);
        int used = 0, total = 0;
        for (int i = 0; i < Math.min(2, lines.size()); i++) {
            String line = lines.get(i);
            total += line.length();
            int n = Math.max(0, Math.min(line.length(), shown - used));
            used += line.length();
            if (n > 0) p.text(line.substring(0, n), b[0] + 12, b[1] + 9 + i * 18, th.text, th.shadow);
        }
        if (shown >= total) {
            if (th.wired) {
                if ((t / 500) % 2 == 0) p.rect(b[0] + b[2] - 16, b[1] + b[3] - 18, 6, 10, th.accent);
            } else {
                int bob = (int) ((t / 400) % 2);
                p.arrowDown(b[0] + b[2] - 18, b[1] + b[3] - 13 + bob, th.accent);
            }
        }
    }

    // ================================================================ 描画：WIRED

    private int[] wiredButtons() {
        int y = 24;
        return new int[]{vw - 6 - 104, y, 56, 20, vw - 6 - 44, y, 44, 20};
    }

    private void drawWiredBoot() {
        th = Theme.WIRED;
        net.background(p, vw, vh, t);
        String[] log = {"WIRED NAVI  ver.0.98", "", "memory ........ ok", "layer 01 ...... ok", "node map ...... ok",
                "user: RYOTEI", "", "> タップで せつぞく"};
        long e = t - 1000;
        int y = vh * 30 / 100;
        for (int i = 0; i < log.length; i++) {
            long start = i * 380L;
            if (e < start) break;
            int n = Math.min(log[i].length(), (int) ((e - start) / 28));
            int color = i == 0 ? Wired.CYAN : i == log.length - 1 ? Wired.TEXT : Wired.SUB;
            if (i == log.length - 1 && (t / 500) % 2 == 1) color = Wired.LINE;
            p.text(log[i].substring(0, n), 24, y + i * 20, color, 0);
        }
        if ((t / 400) % 2 == 0) p.rect(24, y + log.length * 20 + 4, 7, 12, Wired.CYAN);
        Wired.noise(p, vw, vh, t, 0.04f);
        Wired.glitch(p, vw, vh, t, 0);
        for (int sy = 0; sy < vh; sy += 3) p.rect(0, sy, vw, 1, 0x0C96D2FF);
    }

    private void drawWiredHome() {
        th = Theme.WIRED;
        net.background(p, vw, vh, t);
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(host.now());
        int hh = cal.get(Calendar.HOUR_OF_DAY), mm = cal.get(Calendar.MINUTE), ss = cal.get(Calendar.SECOND);
        String clock = (hh < 10 ? "0" : "") + hh + ":" + (mm < 10 ? "0" : "") + mm + ":" + (ss < 10 ? "0" : "") + ss;
        int lv = host.batteryLevel(), pct = Math.max(0, lv);
        p.text("PWR", 8, 4, Wired.SUB, 0);
        int segX = 8 + p.width("PWR "), segs = 10;
        for (int i = 0; i < segs; i++) {
            boolean on = pct > i * 10;
            int c = !on ? Wired.LINE : pct <= 20 ? Wired.RED : host.charging() && i == (t / 150) % segs ? Wired.TEXT : Wired.CYAN;
            p.rect(segX + i * 5, 8, 3, 9, c);
        }
        p.text((lv < 0 ? "--" : String.valueOf(pct)) + "%", segX + segs * 5 + 4, 4, Wired.TEXT, 0);
        Wired.ghost(p, clock, vw - 8 - p.width(clock), 4, Wired.TEXT);
        int[] b = wiredButtons();
        p.text("//WIRED", 8, 26, Wired.SUB, 0);
        p.text("[MENU]", b[0], b[1] + 2, Wired.CYAN, 0);
        p.text("[DIR]", b[4], b[5] + 2, Wired.CYAN, 0);
        // タイトル：LAYER 01: CONNECT_
        Wired.ghost(p, "LAYER 01:", vw / 2 - p.width("LAYER 01:") / 2, 50, Wired.CYAN);
        String word = "CONNECT";
        int bw = p.bigWidth(word + "_", 2);
        p.big(word, vw / 2 - bw / 2 + 2, 67, 2, 0x507CF4E8, 0);
        p.big(word, vw / 2 - bw / 2, 66, 2, 0xFFD8FFF8, 0);
        if ((t / 500) % 2 == 0) p.big("_", vw / 2 - bw / 2 + p.bigWidth(word, 2) - 4, 66, 2, 0xFFD8FFF8, 0);

        int[] counts = new int[SLOTS];
        for (int i = 0; i < SLOTS; i++) counts[i] = slotApps[i] == null ? 0 : count(slotApps[i]);
        int sel = flySlot >= 0 ? flySlot : cursor;
        net.drawOrbits(p, t, slotApps, counts, sel, flySlot);
        int labelY = msgBox()[1] - 66;
        if (sel >= 0 && sel < SLOTS && slotApps[sel] != null) {
            net.label(p, labelY, Wired.nodeId(slotApps[sel], counts[sel]), slotApps[sel].label, t);
        } else if (sel == Wired.ROOT) {
            net.label(p, labelY, "Root000", "ALL NODES", t);
        }
        // しばらく触らないと、どこからか声がする
        if (t - lastTouch > 8000 && menu == null && flySlot < 0) {
            long cycle = t / 9000, ph = t % 9000;
            if (ph < 2600) {
                String wsp = WHISPERS[(int) (cycle % WHISPERS.length)];
                java.util.Random r = new java.util.Random(cycle * 31);
                int a = (int) (150 * Math.sin(Math.PI * ph / 2600.0));
                int x = 10 + r.nextInt(Math.max(1, vw - 20 - p.width(wsp)));
                int y = 110 + r.nextInt(Math.max(1, msgBox()[1] - 200));
                p.text(wsp, x + 1, y, (a / 3 << 24) | 0x7CF4E8, 0);
                p.text(wsp, x, y, (a << 24) | 0x9C7CF0, 0);
            }
        }
        if (replaceKey != null) p.textCenter("> つなぎかえる ものを えらんで", vw / 2, 92, Wired.PURPLE, 0);
        Wired.glitch(p, vw, vh, t, 0);
        if (flySlot >= 0) {
            AppEntry a = slotApps[flySlot];
            float k = Math.min(1f, (t - flyStart) / (float) FLY_MS);
            if (a != null) net.connecting(p, vw, vh, t, Wired.nodeId(a, count(a)), a.label, k);
        }
        drawMessage(msgBox());
    }

    private void drawWiredPreview(List<AppEntry> l, int[] b) {
        int cx = b[0] + 10, cy = b[1] + 9;
        Wired.frame(p, cx, cy, 62, 74, th.winOuter);
        net.brackets(p, cx + 31, cy + 31, 27, 0);
        if (l.isEmpty() || listCursor >= l.size()) {
            p.text("> ながおしで メニュー", cx + 72, cy + 2, th.dim, 0);
            return;
        }
        AppEntry a = l.get(listCursor);
        p.image(net.mono(a), cx + 7, cy + 7, 48, 48);
        int n = count(a);
        String id = Wired.nodeId(a, n);
        p.textCenter(id, cx + 31, cy + 56, Wired.CYAN, 0);
        int tx = cx + 72, w = b[0] + b[2] - 10 - tx;
        p.text(p.fit(a.label, w), tx, cy + 1, th.text, 0);
        p.text("access " + n, tx, cy + 19, Wired.PURPLE, 0);
        p.text(p.fit(a.pkg, w), tx, cy + 37, th.dim, 0);
        String hint = pickSlot >= 0 ? "> タップで つなぐ" : slotOf(a) >= 0 ? "> ノード せつぞくずみ" : "> ながおしで メニュー";
        p.text(p.fit(hint, w), tx, cy + 55, th.dim, 0);
    }

    private void drawWiredApps() {
        th = Theme.WIRED;
        net.background(p, vw, vh, t);
        List<AppEntry> l = list();
        int[] hd = headerBox();
        window(hd);
        p.arrowLeft(hd[0] + 10, hd[1] + 12, th.accent);
        p.text("もどる", hd[0] + 18, hd[1] + 8, th.text, 0);
        String title = pickSlot >= 0 ? "> select node" : "/wired/" + (channel == 0 ? "root" : "ch" + (channel < 10 ? "0" : "") + channel);
        p.textCenter(title, hd[0] + hd[2] / 2 + 12, hd[1] + 8, th.text, 0);
        p.textRight(String.valueOf(l.size()), hd[0] + hd[2] - 10, hd[1] + 8, th.dim, 0);
        int tw = (hd[2] - 16) / WIRED_TABS.length;
        for (int i = 0; i < WIRED_TABS.length; i++) {
            int tx = hd[0] + 8 + i * tw;
            if (i == tab) p.rect(tx + 1, hd[1] + 26, tw - 2, 17, th.tabSel);
            p.textCenter(WIRED_TABS[i], tx + tw / 2, hd[1] + 27, i == tab ? th.tabSelText : th.dim, 0);
        }
        int[] wb = wallBox();
        if (host.appsLoading() && all.isEmpty()) {
            Wired.ghost(p, "> loading...", wb[0] + 20, wb[1] + wb[3] / 2, th.dim);
        } else if (l.isEmpty()) {
            Wired.noise(p, vw, vh, t, 0.08f);
            String ns = "- no signal -";
            Wired.ghost(p, ns, vw / 2 - p.width(ns) / 2, wb[1] + wb[3] / 2 - 8, Wired.RED);
        } else {
            net.drawWall(p, wb[0], wb[1], wb[2], wb[3], l, scroll, listCursor, t, tuneStart, this::count);
            int max = maxScroll();
            if (max > 0) {
                int sx = wb[0] + wb[2] - 3, thumb = Math.max(14, wb[3] * wb[3] / (wb[3] + max));
                p.rect(sx, wb[1], 2, wb[3], 0xFF0A1020);
                p.rect(sx, wb[1] + Math.round((wb[3] - thumb) * (scroll / max)), 2, thumb, th.accent);
            }
        }
        if (dialDrag) {
            float settle = dialPos;
            int[] d = dialBox();
            net.drawDial(p, d[0], d[1], d[2], d[3], settle, channelCounts(), list().size(), t);
        } else {
            dialPos += (channel - dialPos) * 0.35f;
            int[] d = dialBox();
            net.drawDial(p, d[0], d[1], d[2], d[3], dialPos, channelCounts(), (tab == 1 ? frequent : tab == 2 ? recent : all).size(), t);
        }
        Wired.glitch(p, vw, vh, t, 0);
    }

    private void drawApps() {
        if (wired) {
            drawWiredApps();
            return;
        }
        th = wired ? Theme.WIRED : Theme.CYBER;
        if (wired) net.background(p, vw, vh, t);
        else scenery.drawCyber(p, vw, vh, t);
        String[] tabs = wired ? WIRED_TABS : TABS;
        List<AppEntry> l = list();
        int[] hd = headerBox();
        window(hd);
        p.arrowLeft(hd[0] + 10, hd[1] + 12, th.accent);
        p.text("もどる", hd[0] + 18, hd[1] + 8, th.text, th.shadow);
        String title = pickSlot >= 0 ? w("どれを のせる？", "> select node") : w("チップフォルダ", "/wired/root");
        p.textCenter(title, hd[0] + hd[2] / 2 + 8, hd[1] + 8, th.text, th.shadow);
        p.textRight(String.valueOf(l.size()), hd[0] + hd[2] - 10, hd[1] + 8, th.dim, 0);
        int tw = (hd[2] - 16) / TABS.length;
        for (int i = 0; i < TABS.length; i++) {
            int tx = hd[0] + 8 + i * tw;
            if (i == tab && th.wired) p.rect(tx + 1, hd[1] + 26, tw - 2, 17, th.tabSel);
            else if (i == tab) p.chamfer(tx + 1, hd[1] + 26, tw - 2, 17, 3, th.tabSel);
            p.textCenter(tabs[i], tx + tw / 2, hd[1] + 27, i == tab ? th.tabSelText : th.dim, 0);
        }
        drawPreview(l);

        int[] lb = listBox();
        window(lb);
        int top = listInnerTop(), ih = listInnerH();
        int left = lb[0] + 6, right = lb[0] + lb[2] - 16;
        if (host.appsLoading() && all.isEmpty()) {
            p.textCenter("よみこみちゅう…", vw / 2, top + ih / 2 - 8, th.dim, 0);
        } else if (l.isEmpty()) {
            p.textCenter(tab == 0 ? w("チップが みつからない…", "> no node") : w("まだ なにも ない…", "> empty"), vw / 2, top + ih / 2 - 8, th.dim, 0);
        } else {
            p.c.save();
            p.c.clipRect(left, top, right, top + ih);
            int first = Math.max(0, (int) (scroll / ROW));
            int last = Math.min(l.size() - 1, (int) ((scroll + ih) / ROW));
            for (int i = first; i <= last; i++) {
                AppEntry a = l.get(i);
                int y = top + i * ROW - Math.round(scroll);
                boolean sel = i == listCursor;
                int textColor = sel ? th.rowSelText : th.text, shadow = sel ? 0 : th.shadow;
                if (sel) {
                    p.rect(left, y, right - left, ROW, th.rowSel);
                    p.arrowRight(left + 3, y + 7, th.rowSelText);
                }
                if (th.wired) {
                    String id = Wired.nodeId(a, count(a));
                    int idW = p.width(id);
                    p.image(net.mono(a), left + 12, y + 2, 16, 16);
                    p.text(p.fit(a.label, right - left - 40 - idW - 6), left + 32, y + 2, textColor, 0);
                    p.text(id, right - 2 - idW, y + 2, sel ? th.rowSelText : th.dim, 0);
                } else {
                    p.image(a.icon16, left + 12, y + 2, 16, 16);
                    p.text(p.fit(a.label, right - left - 40 - 24), left + 32, y + 2, textColor, shadow);
                    p.rect(right - 19, y + 2, 17, 16, th.chip);
                    p.textCenter(a.code, right - 10, y + 2, th.chipText, 0);
                }
                if (slotOf(a) >= 0 && !th.wired) p.rect(right - 23, y + 8, 2, 4, sel ? th.rowSelText : th.accent);
                if (slotOf(a) >= 0 && th.wired) p.rect(left + 8, y + 9, 2, 2, sel ? th.rowSelText : Wired.PURPLE);
            }
            p.c.restore();
            int max = maxScroll();
            int sx = lb[0] + lb[2] - 12;
            p.rect(sx, top, 4, ih, th.wired ? 0xFF0A1020 : 0xFF0A1C34);
            if (max > 0) {
                int thumb = Math.max(14, ih * ih / (l.size() * ROW));
                p.rect(sx, top + Math.round((ih - thumb) * (scroll / max)), 4, thumb, th.accent);
            }
        }
    }

    /** 選んでいるアプリを大きなチップのカードで見せる。 */
    private void drawPreview(List<AppEntry> l) {
        int[] b = previewBox();
        window(b);
        if (th.wired) {
            drawWiredPreview(l, b);
            return;
        }
        int cx = b[0] + 10, cy = b[1] + 9;
        p.chamfer(cx, cy, 62, 74, 4, th.chip);
        p.chamfer(cx + 2, cy + 2, 58, 70, 3, 0xFF183868);
        p.rect(cx + 6, cy + 5, 50, 50, 0xFF061428);
        if (l.isEmpty() || listCursor >= l.size()) {
            p.text("ながおしで メニュー", cx + 72, cy + 2, th.dim, 0);
            return;
        }
        AppEntry a = l.get(listCursor);
        p.image(a.icon16, cx + 7, cy + 6, 48, 48);
        p.rect(cx + 4, cy + 57, 16, 15, th.chip);
        p.textCenter(a.code, cx + 12, cy + 56, th.chipText, 0);
        int n = count(a);
        int tx = cx + 72, w = b[0] + b[2] - 10 - tx;
        p.text(p.fit(a.label, w), tx, cy + 1, th.text, th.shadow);
        p.text("CODE " + a.code + "  Lv" + level(n), tx, cy + 19, th.chip, th.shadow);
        p.text(n + "かい プラグイン", tx, cy + 37, th.dim, 0);
        String hint = pickSlot >= 0 ? "タップで のせる" : slotOf(a) >= 0 ? "マップに のっている" : "ながおしで メニュー";
        p.text(p.fit(hint, w), tx, cy + 55, th.dim, 0);
    }

    private void drawMenu(Menu m) {
        th = wired ? Theme.WIRED : Theme.CYBER;
        window(m.x, m.y, m.w, m.h);
        if (th.wired) {
            p.rect(m.x + 6, m.y + 22, m.w - 12, 1, th.winOuter);
            p.text(m.title, m.x + 10, m.y + 5, th.accent, 0);
        } else {
            p.rect(m.x + 6, m.y + 6, m.w - 12, 17, th.winFrame);
            p.text(m.title, m.x + 12, m.y + 6, th.chip, th.shadow);
        }
        for (int i = 0; i < m.labels.length; i++) {
            int y = m.y + 27 + i * 18;
            boolean sel = i == m.hover;
            if (sel) {
                p.rect(m.x + 4, y, m.w - 8, 18, th.rowSel);
                p.arrowRight(m.x + 9, y + 5, th.rowSelText);
            }
            p.text(m.labels[i], m.x + 18, y + 1, sel ? th.rowSelText : th.text, sel ? 0 : th.shadow);
        }
    }

    private void drawEffects() {
        long pl = t - plugStart;
        if (wired && plugApp != null && pl >= 0 && pl < 700 && screen == APPS) {
            net.zoom(p, vw, vh, zoomFrom, plugApp, Math.min(1f, pl / 520f), t);
        } else if (plugApp != null && pl >= 0 && pl < 700) {
            th = Theme.CYBER;
            int a = (int) (200 * Math.max(0, 1 - pl / 700f));
            p.rect(0, 0, vw, vh, (a << 24) | 0x60E0FF);
            for (int y = (int) (pl / 4) % 12; y < vh; y += 12) p.rect(0, y, vw, 2, 0x90FFFFFF);
            int w = vw - 40, h = 52, x = 20, y = vh / 2 - h / 2;
            window(x, y, w, h);
            p.textCenter("プラグイン！", vw / 2, y + 9, th.chip, th.shadow);
            p.textCenter(p.fit(plugApp.label, w - 120) + " トランスミッション！", vw / 2, y + 27, th.text, th.shadow);
        }
        if (fade > 0) {
            p.rect(0, 0, vw, vh, ((int) (255 * Math.min(1, fade)) << 24) | (wired ? 0x030408 : 0xF8F8F8));
            if (wired) Wired.noise(p, vw, vh, t, fade * 0.8f);
        }
        if (nextScreen >= 0) {
            float k = (t - transStart) / 300f;
            float cover = k < 0.5f ? k * 2 : (1 - k) * 2;
            int sh = Math.round(8 * Math.max(0, Math.min(1, cover)));
            int color = wired ? 0xFF030408 : nextScreen == APPS || screen == APPS ? 0xFF48E0F8 : 0xFF101010;
            for (int y = 0; y < vh; y += 8) p.rect(0, y, vw, sh, color);
        }
    }
}
