package io.github.ryotei.launcher;

import android.graphics.Canvas;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 * ランチャー本体。GBAくらいの低解像度キャンバスに全部を描き、タッチを「ゲームの操作」として扱う。
 * Android固有の処理は Host 越しに呼ぶので、このクラスは android.graphics 以外に依存しない。
 */
final class Engine {
    static final int BOOT = 0, HOME = 1, APPS = 2;
    static final int SLOTS = 6;

    private static final int M_APPS = 1, M_THEME = 2, M_SOUND = 3, M_OP = 4, M_HOMESET = 5, M_SETTINGS = 6,
            M_REPORT = 7, M_CLOSE = 8, C_OPEN = 20, C_SWAP = 21, C_REMOVE = 22, C_INFO = 23, C_ADD = 24,
            C_UNINSTALL = 25, C_CANCEL = 26;
    private static final String[] TABS = {"すべて", "よくつかう", "さいきん"};
    private static final String[] WEEK = {"日", "月", "火", "水", "木", "金", "土"};
    private static final long LONG_PRESS = 450;
    private static final int SLOP = 6;
    private static final int ROW = 20;

    private final Host host;
    private final Pix p;
    private final Scenery scenery = new Scenery();
    Theme th;
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

    // ホーム
    private final String[] slots = new String[SLOTS];
    private int homeCursor = 0;
    private String replaceKey;

    // アプリ一覧画面
    private int tab = 0;
    private float scroll, scrollVel;
    private int listCursor = 0;
    private int pickSlot = -1;

    // メニュー
    private static final class Menu {
        boolean context;
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
    private long msgStart;
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
    private long launchAt, flashStart = -10000;
    private boolean returningFromApp;
    private String levelUpMsg;
    private long reportAt = -1;

    Engine(Host host, Pix pix) {
        this.host = host;
        this.p = pix;
        th = Theme.byName(host.getString("theme", "FIELD"));
        for (int i = 0; i < SLOTS; i++) slots[i] = host.getString("slot" + i, "");
        screen = host.getInt("opening", 1) == 1 ? BOOT : HOME;
        if (screen == HOME) say(greeting(), true);
    }

    void resize(int w, int h) {
        vw = w;
        vh = h;
    }

    // ================================================================ ライフサイクル

    void onResume() {
        menu = null;
        down = false;
        if (returningFromApp) {
            returningFromApp = false;
            if (screen == APPS && pickSlot < 0) screen = HOME;
            if (levelUpMsg != null) {
                say(levelUpMsg, false);
                host.sfx(Host.SFX_LEVEL);
                levelUpMsg = null;
            } else {
                say(th.cyber ? "おかえり！ RYOTEIくん。\nつぎは どこへ いく？" : "おかえり！ RYOTEI。\nつぎは なにを する？", false);
            }
        } else if (screen == HOME && replaceKey == null) {
            say(greeting(), true);
        }
    }

    /** ホーム画面表示中にもう一度ホームボタンが押された。 */
    void homePressed() {
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
        }
    }

    /** 戻る操作を処理したらtrue。 */
    boolean back() {
        if (nextScreen >= 0 || pendingLaunch != null) return true;
        if (menu != null) {
            closeMenu();
            return true;
        }
        if (screen == APPS) {
            pickSlot = -1;
            host.sfx(Host.SFX_CANCEL);
            go(HOME);
            say(greeting(), true);
            return true;
        }
        if (replaceKey != null) {
            replaceKey = null;
            host.sfx(Host.SFX_CANCEL);
            say(greeting(), true);
            return true;
        }
        return true;
    }

    // ================================================================ 1フレーム

    void frame(Canvas canvas, long now) {
        t = now;
        long dt = lastFrame == 0 ? 16 : Math.min(100, now - lastFrame);
        lastFrame = now;
        p.c = canvas;
        syncApps();
        update(dt);

        scenery.draw(p, th, vw, vh, t);
        if (screen == BOOT) drawBoot();
        else if (screen == HOME) drawHome();
        else drawApps();
        if (menu != null) drawMenu(menu);
        drawEffects();
    }

    private void update(long dt) {
        if (nextScreen >= 0) {
            float k = (t - transStart) / 260f;
            if (k >= 0.5f && screen != nextScreen) screen = nextScreen;
            if (k >= 1f) nextScreen = -1;
        }
        if (pendingLaunch != null && t >= launchAt) {
            AppEntry app = pendingLaunch;
            pendingLaunch = null;
            countLaunch(app);
            if (host.launch(app)) {
                returningFromApp = true;
            } else {
                levelUpMsg = null;
                host.sfx(Host.SFX_ERROR);
                say("あれ？ その アプリは\nひらけなかった…", false);
            }
        }
        if (reportAt >= 0 && t >= reportAt) {
            reportAt = -1;
            host.sfx(Host.SFX_SAVE);
            say(th.cyber ? "データの バックアップ\nかんりょう！" : "RYOTEIは レポートに\nしっかり かきこんだ！", false);
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

    // ================================================================ アプリ一覧の同期

    private void syncApps() {
        int v = host.appsVersion();
        if (v == seenVersion) {
            if (listsDirty) rebuildLists();
            return;
        }
        seenVersion = v;
        all = host.apps();
        byKey.clear();
        for (AppEntry a : all) byKey.put(a.key, a);
        if (host.getString("slotinit", "").isEmpty() && !all.isEmpty()) defaultSlots();
        listsDirty = true;
        rebuildLists();
    }

    private void defaultSlots() {
        String[] wanted = {"com.android.chrome", "com.google.android.youtube", "com.google.android.apps.photos",
                "com.google.android.GoogleCamera", "com.sec.android.app.camera", "com.android.camera",
                "com.google.android.gm", "com.google.android.apps.messaging", "com.google.android.dialer",
                "com.android.vending", "com.google.android.apps.maps"};
        int n = 0;
        for (String pkg : wanted) {
            if (n >= SLOTS) break;
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
        return tab == 1 ? frequent : tab == 2 ? recent : all;
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

    static float expFraction(int count) {
        int lv = level(count);
        if (lv >= 100) return 1f;
        int lo = (lv - 1) * (lv - 1), hi = lv * lv;
        return (count - lo) / (float) (hi - lo);
    }

    private void countLaunch(AppEntry a) {
        int before = count(a);
        host.putInt("n:" + a.key, before + 1);
        host.putLong("t:" + a.key, host.now());
        listsDirty = true;
        int lv = level(before + 1);
        if (lv > level(before) && lv > 1) {
            String name = p.fit(a.label, 150);
            levelUpMsg = th.cyber ? name + "の レベルが\n" + lv + "に アップ！" : name + "の レベルが\n" + lv + "に あがった！";
        } else {
            levelUpMsg = null;
        }
    }

    private AppEntry slotApp(int i) {
        String k = slots[i];
        return k == null || k.isEmpty() ? null : byKey.get(k);
    }

    private int slotOf(AppEntry a) {
        for (int i = 0; i < SLOTS; i++) if (a.key.equals(slots[i])) return i;
        return -1;
    }

    private void setSlot(int i, String key) {
        slots[i] = key == null ? "" : key;
        host.putString("slot" + i, slots[i]);
    }

    // ================================================================ メッセージ

    void say(String text, boolean instant) {
        msg = text;
        msgStart = t;
        msgInstant = instant;
    }

    private String greeting() {
        int lv = host.batteryLevel();
        if (lv >= 0 && lv <= 15 && !host.charging())
            return th.cyber ? "けいこく！ バッテリーが\nのこり わずか！" : "でんちが のこり すくない！\nはやく じゅうでん しよう！";
        if (host.charging())
            return th.cyber ? "じゅうでん ちゅう…\nエネルギー チャージ！" : "じゅうでん ちゅう…\nHPが すこしずつ かいふく！";
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(host.now());
        int h = cal.get(Calendar.HOUR_OF_DAY);
        if (h >= 5 && h <= 10)
            return th.cyber ? "おはよう、RYOTEIくん！\nきょうも ネットに ダイブだ！" : "おはよう！ RYOTEI。\nきょうは なにを する？";
        if (h >= 11 && h <= 16)
            return th.cyber ? "システム オールグリーン！\nどこに プラグインする？" : "RYOTEIは あたりを\nみわたした。 なにを する？";
        if (h >= 17 && h <= 21)
            return th.cyber ? "こんばんは、RYOTEIくん！\nネットの パトロールに いこう！" : "こんばんは！ RYOTEI。\nきょうも おつかれさま！";
        return th.cyber ? "もう こんな じかん…\nはやく ねないと だめだよ！" : "よふかしは ほどほどに…\nそろそろ やすもう。";
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

    private void launch(AppEntry a) {
        host.sfx(Host.SFX_LAUNCH);
        String name = p.fit(a.label, th.cyber ? 140 : 160);
        say(th.cyber ? "プラグイン！\n" + name + " トランスミッション！" : "RYOTEIは\n" + name + "を つかった！", true);
        pendingLaunch = a;
        launchAt = t + 280;
        flashStart = t;
    }

    private void openApps(int pick) {
        pickSlot = pick;
        listCursor = Math.min(listCursor, Math.max(0, list().size() - 1));
        host.sfx(Host.SFX_MENU);
        go(APPS);
    }

    private void addToParty(AppEntry a) {
        for (int i = 0; i < SLOTS; i++) {
            if (slotApp(i) == null) {
                setSlot(i, a.key);
                host.sfx(Host.SFX_OK);
                if (screen == APPS) go(HOME);
                homeCursor = i;
                say(p.fit(a.label, 150) + "を\nてもちに くわえた！", false);
                return;
            }
        }
        replaceKey = a.key;
        host.sfx(Host.SFX_MENU);
        if (screen == APPS) go(HOME);
        say("てもちが いっぱいだ！\nどれと いれかえる？", false);
    }

    // ================================================================ タッチ

    /** action: 0=down 1=move 2=up 3=cancel。座標は低解像度キャンバス上の値。 */
    void touch(int action, int x, int y, long time) {
        if (nextScreen >= 0 || pendingLaunch != null) {
            down = false;
            return;
        }
        switch (action) {
            case 0:
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
                    if (scrollbarDrag) {
                        scrollToBar(y);
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
        }
    }

    private void press(int x, int y) {
        if (menu != null) {
            menu.hover = menuHit(menu, x, y);
            return;
        }
        if (screen == HOME) {
            int s = slotHit(x, y);
            if (s >= 0 && s != homeCursor) {
                homeCursor = s;
                host.sfx(Host.SFX_CURSOR);
            }
        } else if (screen == APPS) {
            int[] l = listBox();
            if (x >= l[0] + l[2] - 16 && y >= l[1] && y < l[1] + l[3] && maxScroll() > 0) {
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
            int[] m = msgBox();
            if (inside(x, y, m)) {
                msgInstant = true;
                return;
            }
            int s = slotHit(x, y);
            if (s >= 0) {
                slotTap(s);
                return;
            }
            int[] b = buttons();
            if (inside(x, y, b[0], b[1], b[2], b[3])) {
                openApps(-1);
            } else if (inside(x, y, b[4], b[5], b[6], b[7])) {
                openMenu();
            } else if (inside(x, y, hudBox())) {
                host.sfx(Host.SFX_OK);
                host.openClock();
            }
            return;
        }
        // APPS
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

    private void longPress(int x, int y) {
        if (menu != null) return;
        if (screen == HOME) {
            int s = slotHit(x, y);
            if (s >= 0) {
                AppEntry a = slotApp(s);
                if (a == null) return;
                homeCursor = s;
                Menu m = contextMenu(new String[]{"ひらく", "いれかえる", "はずす", "アプリじょうほう", "やめる"},
                        new int[]{C_OPEN, C_SWAP, C_REMOVE, C_INFO, C_CANCEL});
                m.app = a;
                m.slot = s;
                showMenu(m);
                say(p.fit(a.label, 150) + "を\nどうする？", true);
            } else if (!inside(x, y, msgBox())) {
                openMenu();
            }
        } else if (screen == APPS) {
            int r = rowHit(x, y);
            if (r < 0) return;
            listCursor = r;
            AppEntry a = list().get(r);
            boolean inParty = slotOf(a) >= 0;
            Menu m = contextMenu(
                    new String[]{"ひらく", inParty ? "てもちから はずす" : "てもちに いれる", "アプリじょうほう", "アンインストール", "やめる"},
                    new int[]{C_OPEN, inParty ? C_REMOVE : C_ADD, C_INFO, C_UNINSTALL, C_CANCEL});
            m.app = a;
            m.slot = slotOf(a);
            showMenu(m);
        }
    }

    private void slotTap(int i) {
        if (replaceKey != null) {
            AppEntry a = byKey.get(replaceKey);
            int old = -1;
            for (int k = 0; k < SLOTS; k++) if (replaceKey.equals(slots[k])) old = k;
            if (old >= 0) setSlot(old, slots[i]);
            setSlot(i, replaceKey);
            replaceKey = null;
            homeCursor = i;
            host.sfx(Host.SFX_OK);
            say((a == null ? "アプリ" : p.fit(a.label, 150)) + "を\nてもちに くわえた！", false);
            return;
        }
        AppEntry a = slotApp(i);
        if (a == null) {
            openApps(i);
        } else {
            launch(a);
        }
    }

    private void rowTap(int r) {
        List<AppEntry> l = list();
        if (r >= l.size()) return;
        AppEntry a = l.get(r);
        listCursor = r;
        if (pickSlot >= 0) {
            int old = slotOf(a);
            if (old >= 0 && old != pickSlot) setSlot(old, slots[pickSlot]);
            setSlot(pickSlot, a.key);
            homeCursor = pickSlot;
            pickSlot = -1;
            host.sfx(Host.SFX_OK);
            go(HOME);
            say(p.fit(a.label, 150) + "を\nてもちに くわえた！", false);
        } else {
            launch(a);
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

    // ================================================================ メニュー

    private void openMenu() {
        String[] labels = {"アプリ", "テーマ：" + th.name, "サウンド：" + (host.getInt("sound", 1) == 1 ? "ON" : "OFF"),
                "オープニング：" + (host.getInt("opening", 1) == 1 ? "ON" : "OFF"), "ホームアプリ", "たんまつせってい",
                th.cyber ? "バックアップ" : "レポート", "とじる"};
        int[] ids = {M_APPS, M_THEME, M_SOUND, M_OP, M_HOMESET, M_SETTINGS, M_REPORT, M_CLOSE};
        Menu m = new Menu();
        m.labels = labels;
        m.ids = ids;
        m.w = Math.min(vw - 12, 172);
        m.h = labels.length * 18 + 14;
        m.x = vw - 6 - m.w;
        m.y = 70;
        boolean reopen = menu != null && !menu.context;
        m.hover = reopen ? menu.hover : 0;
        showMenu(m);
        if (!reopen) say(th.cyber ? "コマンドを えらんでね。" : "メニューを ひらいた。", true);
    }

    private Menu contextMenu(String[] labels, int[] ids) {
        Menu m = new Menu();
        m.context = true;
        m.labels = labels;
        m.ids = ids;
        int w = 0;
        for (String s : labels) w = Math.max(w, p.width(s));
        m.w = Math.min(vw - 12, w + 34);
        m.h = labels.length * 18 + 14;
        m.x = vw - 6 - m.w;
        m.y = msgBox()[1] - 4 - m.h;
        m.hover = 0;
        return m;
    }

    private void showMenu(Menu m) {
        if (menu == null) host.sfx(Host.SFX_MENU);
        menu = m;
    }

    private void closeMenu() {
        boolean context = menu != null && menu.context;
        menu = null;
        host.sfx(Host.SFX_CANCEL);
        if (screen == HOME && context) say(greeting(), true);
        else if (screen == HOME) say(greeting(), true);
    }

    private int menuHit(Menu m, int x, int y) {
        if (x < m.x || x >= m.x + m.w || y < m.y + 7 || y >= m.y + 7 + m.labels.length * 18) return -1;
        return (y - m.y - 7) / 18;
    }

    private void menuSelect(Menu m, int id) {
        AppEntry a = m.app;
        switch (id) {
            case M_APPS:
                menu = null;
                openApps(-1);
                return;
            case M_THEME:
                th = th.cyber ? Theme.FIELD : Theme.CYBER;
                host.putString("theme", th.name);
                host.sfx(Host.SFX_OK);
                openMenu();
                say(th.cyber ? "CYBER モードに きりかえ！" : "FIELD モードに きりかえた！", false);
                return;
            case M_SOUND: {
                int on = host.getInt("sound", 1) == 1 ? 0 : 1;
                host.putInt("sound", on);
                host.sfx(Host.SFX_OK);
                openMenu();
                return;
            }
            case M_OP: {
                int on = host.getInt("opening", 1) == 1 ? 0 : 1;
                host.putInt("opening", on);
                host.sfx(Host.SFX_OK);
                openMenu();
                return;
            }
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
            case M_REPORT:
                menu = null;
                host.sfx(Host.SFX_OK);
                say(th.cyber ? "データを バックアップ ちゅう…\nでんげんを きらないでね。" : "レポートを かきこんでいます…\nでんげんを きらないで ください。", false);
                reportAt = t + 1400;
                return;
            case C_OPEN:
                menu = null;
                launch(a);
                return;
            case C_SWAP:
                menu = null;
                openApps(m.slot);
                return;
            case C_REMOVE:
                menu = null;
                if (m.slot >= 0) setSlot(m.slot, "");
                host.sfx(Host.SFX_CANCEL);
                say(p.fit(a.label, 150) + "を\nてもちから はずした。", false);
                return;
            case C_ADD:
                menu = null;
                addToParty(a);
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
        return new int[]{6, 6, vw - 12, 58};
    }

    private int[] msgBox() {
        return new int[]{6, vh - 6 - 52, vw - 12, 52};
    }

    private int[] buttons() {
        int y = msgBox()[1] - 30, w = (vw - 18) / 2;
        return new int[]{6, y, w, 24, 12 + w, y, vw - 18 - w, 24};
    }

    private int slotH() {
        int top = 70, bottom = buttons()[1] - 6;
        return Math.max(30, Math.min(52, (bottom - top - 4 * (SLOTS - 1)) / SLOTS));
    }

    private int slotY(int i) {
        return 70 + i * (slotH() + 4);
    }

    private int slotHit(int x, int y) {
        if (x < 6 || x >= vw - 6) return -1;
        int h = slotH();
        for (int i = 0; i < SLOTS; i++) if (y >= slotY(i) && y < slotY(i) + h) return i;
        return -1;
    }

    private int[] headerBox() {
        return new int[]{6, 6, vw - 12, 48};
    }

    private int[] descBox() {
        return new int[]{6, vh - 6 - 52, vw - 12, 52};
    }

    private int[] listBox() {
        int top = 60, bottom = descBox()[1] - 6;
        return new int[]{6, top, vw - 12, bottom - top};
    }

    private int listInnerTop() {
        return listBox()[1] + 7;
    }

    private int listInnerH() {
        return listBox()[3] - 14;
    }

    private int maxScroll() {
        return Math.max(0, list().size() * ROW - listInnerH());
    }

    private int rowHit(int x, int y) {
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

    private void window(int x, int y, int w, int h) {
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

    private void panel(int x, int y, int w, int h, boolean sel, boolean empty) {
        int edge = sel ? th.selEdge : empty ? th.emptyEdge : th.panelEdge;
        int fill = sel ? th.selFill : empty ? th.emptyFill : th.panelFill;
        int hi = sel ? th.selHi : empty ? th.emptyFill : th.panelHi;
        if (!th.cyber) {
            p.round(x, y, w, h, edge);
            p.round(x + 1, y + 1, w - 2, h - 2, fill);
            p.rect(x + 3, y + 2, w - 6, 1, hi);
        } else {
            p.chamfer(x, y, w, h, 4, edge);
            p.chamfer(x + 1, y + 1, w - 2, h - 2, 3, fill);
            p.rect(x + 2, y + 5, 2, h - 10, edge);
            if (!empty) p.rect(x + w - 30, y + 2, 22, 1, hi);
        }
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

    private void blinkDown(int x, int y, int color) {
        if ((t / 400) % 2 == 0) p.arrowDown(x, y, color);
        else p.arrowDown(x, y + 1, color);
    }

    // ================================================================ 描画：画面

    private void drawBoot() {
        if (!th.cyber) {
            int[] bands = {0xFF0C3020, 0xFF124028, 0xFF185034, 0xFF206440, 0xFF2C784C, 0xFF3A8C5A};
            int bh = Math.max(1, vh / (bands.length * 2));
            for (int i = 0; i < bands.length; i++) p.rect(0, i * bh, vw, bh, bands[i]);
            for (int i = 0; i < bands.length; i++) p.rect(0, vh - (i + 1) * bh, vw, bh, bands[i]);
            p.rect(0, bands.length * bh, vw, vh - 2 * bands.length * bh, 0xFF46A066);
        } else {
            p.rect(0, 0, vw, vh, 0x99000814);
        }
        int cy = vh * 28 / 100;
        int logo = th.cyber ? 0xFF48E0F8 : 0xFFF8F8F8, logoShadow = th.cyber ? 0xFF0C3868 : 0xFF103820;
        int jitter = th.cyber && (t / 90) % 23 == 0 ? 2 : 0;
        String title = "RYOTEI";
        p.big(title, (vw - p.bigWidth(title, 4)) / 2 + jitter, cy, 4, logo, logoShadow);
        String sub = th.cyber ? "NET LAUNCHER" : "LAUNCHER";
        p.big(sub, (vw - p.bigWidth(sub, 2)) / 2, cy + 76, 2, th.cyber ? 0xFFF8D030 : 0xFFF8D058, logoShadow);
        // きらきら
        for (int k = 0; k < 6; k++) {
            long ph = (t / 120 + k * 5) % 14;
            if (ph > 4) continue;
            int sx = (k * 83 + 17) % (vw - 20) + 10, sy = cy - 14 + (k * 47) % 110;
            int s = ph < 3 ? (int) ph : 4 - (int) ph;
            p.rect(sx - s, sy, s * 2 + 1, 1, 0xFFF8F8F8);
            p.rect(sx, sy - s, 1, s * 2 + 1, 0xFFF8F8F8);
        }
        if ((t / 500) % 2 == 0) {
            String ps = "PRESS START";
            p.big(ps, (vw - p.bigWidth(ps, 2)) / 2, vh * 64 / 100, 2, 0xFFF8F8F8, logoShadow);
        }
        p.textCenter("©2026 RYOTEI", vw / 2, vh - 30, th.cyber ? 0xFF6CA0C8 : 0xFFD0F0D8, logoShadow);
    }

    private void drawHome() {
        drawHud();
        int h = slotH();
        int iconSize = h >= 44 ? 32 : 16;
        for (int i = 0; i < SLOTS; i++) {
            int y = slotY(i), x = 6, w = vw - 12;
            AppEntry a = slotApp(i);
            boolean sel = i == homeCursor;
            panel(x, y, w, h, sel, a == null);
            if (a == null) {
                String s = replaceKey != null ? "－ ここに いれる －" : "－ あき －";
                p.textCenter(s, x + w / 2, y + (h - Pix.LINE) / 2, th.panelText & 0xB0FFFFFF, 0);
                if (sel && replaceKey != null) p.arrowRight(x + 8, y + h / 2 - 3, th.panelText);
                continue;
            }
            int n = count(a), lv = level(n);
            int ix = x + 8, iy = y + (h - iconSize) / 2;
            if (th.cyber) {
                p.rect(ix - 2, iy - 2, iconSize + 4, iconSize + 4, th.panelEdge);
                p.rect(ix - 1, iy - 1, iconSize + 2, iconSize + 2, 0xFF061428);
            }
            p.image(iconSize == 32 ? a.icon32 : a.icon16, ix, iy, iconSize, iconSize);
            int tx = ix + iconSize + 8;
            String lvText = "Lv" + lv;
            int lvW = p.width(lvText);
            int nameY = h >= 44 ? y + 6 : y + (h - Pix.LINE) / 2 - 2;
            p.text(p.fit(a.label, w - (tx - x) - lvW - 14), tx, nameY, th.panelText, th.panelShadow);
            p.text(lvText, x + w - 8 - lvW, nameY, th.cyber ? th.chip : th.panelText, th.panelShadow);
            int barY = h >= 44 ? y + h - 13 : y + h - 6;
            int barW = x + w - 10 - tx;
            if (h >= 44) {
                p.text(th.cyber ? "DL" : "EXP", tx, barY - 4, th.cyber ? th.hpLabelText : th.hpLabelText, th.panelShadow);
                int lw = p.width(th.cyber ? "DL" : "EXP") + 4;
                bar(tx + lw, barY + 1, barW - lw, 5, expFraction(n), th.exp);
            } else {
                bar(tx, barY, barW, 3, expFraction(n), th.exp);
            }
            if (replaceKey != null && sel) p.arrowRight(x + 2, y + h / 2 - 3, th.panelText);
        }
        int[] b = buttons();
        button(b[0], b[1], b[2], b[3], th.cyber ? "チップフォルダ" : "バッグ", true);
        button(b[4], b[5], b[6], b[7], th.cyber ? "コマンド" : "メニュー", false);
        drawMessage(msgBox());
    }

    private void button(int x, int y, int w, int h, String label, boolean up) {
        if (!th.cyber) {
            p.round(x, y, w, h, th.winOuter);
            p.round(x + 1, y + 1, w - 2, h - 2, th.winFill);
            p.rect(x + 2, y + h - 3, w - 4, 1, th.shadow);
        } else {
            p.chamfer(x, y, w, h, 4, th.winOuter);
            p.chamfer(x + 1, y + 1, w - 2, h - 2, 3, th.winFill);
        }
        int tw = p.width(label) + 10;
        int tx = x + (w - tw) / 2;
        if (up) p.arrowUp(tx, y + h / 2 - 2, th.cyber ? th.accent : th.accent);
        else {
            p.rect(tx, y + h / 2 - 3, 7, 1, th.cyber ? th.accent : th.accent);
            p.rect(tx, y + h / 2, 7, 1, th.cyber ? th.accent : th.accent);
            p.rect(tx, y + h / 2 + 3, 7, 1, th.cyber ? th.accent : th.accent);
        }
        p.text(label, tx + 10, y + (h - Pix.LINE) / 2, th.text, th.shadow);
    }

    private void drawHud() {
        int[] b = hudBox();
        window(b);
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(host.now());
        int hh = cal.get(Calendar.HOUR_OF_DAY), mm = cal.get(Calendar.MINUTE);
        String clock = (hh < 10 ? "0" : "") + hh + ((t / 500) % 2 == 0 ? ":" : " ") + (mm < 10 ? "0" : "") + mm;
        p.big(clock, b[0] + 12, b[1] + 10, 2, th.text, th.shadow);
        int right = b[0] + b[2] - 10;
        String date = (cal.get(Calendar.MONTH) + 1) + "/" + cal.get(Calendar.DAY_OF_MONTH) + "(" + WEEK[cal.get(Calendar.DAY_OF_WEEK) - 1] + ")";
        p.textRight(date, right, b[1] + 8, th.text, th.shadow);
        int lv = host.batteryLevel();
        boolean charging = host.charging();
        int pct = Math.max(0, lv);
        String num = lv < 0 ? "--" : String.valueOf(pct);
        int numW = p.width("100");
        int barRight = right - numW - 4;
        int labelX = Math.max(b[0] + 104, barRight - 96);
        // HPラベル（黒地に黄色の文字）
        p.round(labelX, b[1] + 31, 21, 15, th.hpLabel);
        p.text("HP", labelX + 3, b[1] + 31, th.hpLabelText, 0);
        int color = pct > 50 ? th.hpGreen : pct > 20 ? th.hpYellow : th.hpRed;
        float frac = pct / 100f;
        bar(labelX + 24, b[1] + 35, barRight - labelX - 24, 6, frac, color);
        if (charging) {
            int bx = labelX + 25, bw = barRight - labelX - 26;
            int sx = (int) (t / 20 % (bw + 12)) - 6;
            p.rect(bx + Math.max(0, sx), b[1] + 36, Math.max(0, Math.min(4, bw - Math.max(0, sx))), 4, 0xFFF8F8F8);
        }
        p.textRight(num, right, b[1] + 30, th.text, th.shadow);
    }

    private void drawMessage(int[] b) {
        window(b);
        int maxW = b[2] - 28;
        List<String> lines = wrap(msg, maxW);
        int shown = msgInstant ? Integer.MAX_VALUE : (int) ((t - msgStart) / 18);
        int used = 0;
        for (int i = 0; i < Math.min(2, lines.size()); i++) {
            String line = lines.get(i);
            int n = Math.max(0, Math.min(line.length(), shown - used));
            used += line.length();
            if (n > 0) p.text(line.substring(0, n), b[0] + 12, b[1] + 9 + i * 18, th.text, th.shadow);
        }
        int total = 0;
        for (int i = 0; i < Math.min(2, lines.size()); i++) total += lines.get(i).length();
        if (shown >= total) blinkDown(b[0] + b[2] - 18, b[1] + b[3] - 13, th.cyber ? th.accent : th.accent);
    }

    private void drawApps() {
        List<AppEntry> l = list();
        int[] hd = headerBox();
        window(hd);
        p.arrowLeft(hd[0] + 10, hd[1] + 12, th.accent);
        p.text("もどる", hd[0] + 18, hd[1] + 8, th.text, th.shadow);
        String title = pickSlot >= 0 ? "どれを いれる？" : th.cyber ? "チップフォルダ" : "バッグ";
        p.textCenter(title, hd[0] + hd[2] / 2 + 8, hd[1] + 8, th.text, th.shadow);
        p.textRight(String.valueOf(l.size()), hd[0] + hd[2] - 10, hd[1] + 8, th.dim, th.cyber ? 0 : th.shadow);
        int tw = (hd[2] - 16) / TABS.length;
        for (int i = 0; i < TABS.length; i++) {
            int tx = hd[0] + 8 + i * tw;
            if (i == tab) {
                if (th.cyber) p.chamfer(tx + 1, hd[1] + 26, tw - 2, 17, 3, th.tabSel);
                else p.round(tx + 1, hd[1] + 26, tw - 2, 17, th.tabSel);
            }
            p.textCenter(TABS[i], tx + tw / 2, hd[1] + 27, i == tab ? th.tabSelText : th.dim, i == tab || th.cyber ? 0 : th.shadow);
        }

        int[] lb = listBox();
        window(lb);
        int top = listInnerTop(), ih = listInnerH();
        int left = lb[0] + 6, right = lb[0] + lb[2] - 16;
        if (host.appsLoading() && all.isEmpty()) {
            p.textCenter("よみこみちゅう…", vw / 2, top + ih / 2 - 8, th.dim, 0);
        } else if (l.isEmpty()) {
            p.textCenter(tab == 0 ? "アプリが みつからない…" : "まだ なにも ない…", vw / 2, top + ih / 2 - 8, th.dim, 0);
        } else {
            p.c.save();
            p.c.clipRect(left, top, right, top + ih);
            int first = Math.max(0, (int) (scroll / ROW));
            int last = Math.min(l.size() - 1, (int) ((scroll + ih) / ROW));
            for (int i = first; i <= last; i++) {
                AppEntry a = l.get(i);
                int y = top + i * ROW - Math.round(scroll);
                boolean sel = i == listCursor;
                int textColor = th.text, shadow = th.shadow;
                if (sel) {
                    if (th.cyber) {
                        p.rect(left, y, right - left, ROW, th.rowSel);
                        textColor = th.rowSelText;
                        shadow = 0;
                    } else {
                        p.rect(left + 1, y + 1, right - left - 2, ROW - 2, th.rowSel);
                    }
                    p.arrowRight(left + 3, y + 7, th.cyber ? th.rowSelText : th.cursor);
                }
                p.image(a.icon16, left + 12, y + 2, 16, 16);
                int n = count(a);
                String tail;
                int tailW;
                if (th.cyber) {
                    tail = a.code;
                    tailW = 16;
                } else {
                    tail = (slotOf(a) >= 0 ? "★" : "") + (n > 0 ? "×" + n : "");
                    tailW = p.width(tail);
                }
                p.text(p.fit(a.label, right - left - 40 - tailW - 6), left + 32, y + 2, textColor, shadow);
                if (th.cyber) {
                    p.rect(right - 19, y + 2, 17, 16, th.chip);
                    p.textCenter(tail, right - 10, y + 2, th.chipText, 0);
                    if (slotOf(a) >= 0) p.rect(right - 22, y + 8, 2, 4, sel ? th.rowSelText : th.accent);
                } else if (!tail.isEmpty()) {
                    p.textRight(tail, right - 4, y + 2, textColor, shadow);
                }
            }
            p.c.restore();
            // スクロールバー
            int max = maxScroll();
            int sx = lb[0] + lb[2] - 12, sy = top, sh = ih;
            p.rect(sx, sy, 4, sh, th.cyber ? 0xFF0A1C34 : 0xFFD8D8D0);
            if (max > 0) {
                int thumb = Math.max(14, sh * ih / (l.size() * ROW));
                int ty = sy + Math.round((sh - thumb) * (scroll / max));
                p.rect(sx, ty, 4, thumb, th.accent);
            }
        }

        int[] db = descBox();
        window(db);
        if (!l.isEmpty() && listCursor < l.size()) {
            AppEntry a = l.get(listCursor);
            int n = count(a);
            p.text(p.fit(a.label, db[2] - 24), db[0] + 12, db[1] + 9, th.text, th.shadow);
            String info;
            if (pickSlot >= 0) info = "タップで てもちに いれる";
            else if (th.cyber) info = "CODE " + a.code + "・Lv" + level(n) + "・" + n + "かい";
            else info = n == 0 ? "まだ つかったことがない" : "Lv" + level(n) + "・" + n + "かい つかった";
            p.text(p.fit(info, db[2] - 24), db[0] + 12, db[1] + 27, th.dim, th.cyber ? 0 : th.shadow);
        } else {
            p.text("ながおしで メニュー", db[0] + 12, db[1] + 9, th.dim, 0);
        }
    }

    private void drawMenu(Menu m) {
        window(m.x, m.y, m.w, m.h);
        for (int i = 0; i < m.labels.length; i++) {
            int y = m.y + 7 + i * 18;
            if (i == m.hover) {
                if (th.cyber) p.rect(m.x + 4, y, m.w - 8, 18, th.rowSel);
                p.arrowRight(m.x + 9, y + 5, th.cyber ? th.rowSelText : th.cursor);
            }
            boolean selCyber = th.cyber && i == m.hover;
            p.text(m.labels[i], m.x + 18, y + 1, selCyber ? th.rowSelText : th.text, selCyber ? 0 : th.shadow);
        }
    }

    private void drawEffects() {
        long fl = t - flashStart;
        if (fl >= 0 && fl < 360) {
            int a = (int) (255 * (1 - fl / 360f) * 0.85f);
            int base = th.cyber ? 0x60E0FF : 0xFFFFFF;
            p.rect(0, 0, vw, vh, (a << 24) | base);
            if (th.cyber) {
                for (int y = (int) (fl / 4) % 12; y < vh; y += 12) p.rect(0, y, vw, 2, 0xC0FFFFFF);
            }
        }
        if (nextScreen >= 0) {
            float k = (t - transStart) / 260f;
            float cover = k < 0.5f ? k * 2 : (1 - k) * 2;
            int sh = Math.round(8 * Math.max(0, Math.min(1, cover)));
            int color = th.cyber ? 0xFF020814 : 0xFF101010;
            for (int y = 0; y < vh; y += 8) p.rect(0, y, vw, sh, color);
        }
    }
}
