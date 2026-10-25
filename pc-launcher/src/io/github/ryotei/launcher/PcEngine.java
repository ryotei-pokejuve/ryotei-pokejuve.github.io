package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

/**
 * Windows版WIREDランチャーの本体。スマホ版と同じ部品（Wired・Pix）で、横長の画面に組み直したもの。
 * ホーム：リテのまわりを回るカプセル（レイヤーごとに10個）。DIR：モニターの壁と周波数ダイヤル。検索：リテが聞いてくる。
 */
final class PcEngine {
    static final int HOME = 0, DIR = 1;
    private static final int SLOTS = Engine.SLOTS, LAYERS = Engine.LAYERS, ROOT = Wired.ROOT;
    private static final String[] TABS = {"all", "freq", "recent"};
    private static final String[] WEEK = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};
    private static final String[] WHISPERS = {"…だれか いるの？", "ここは どこ？", "きこえる？", "わたしは ずっと ここに いる",
            "つながっていない ひとなんて いない", "それは ほんとうに あなたの きおく？"};
    private static final int M_DIR = 1, M_SOUND = 2, M_STARTUP = 3, M_QUIT = 4, M_CLOSE = 5,
            C_OPEN = 10, C_SWAP = 11, C_REMOVE = 12, C_ADD = 13, C_FOLDER = 14, C_CANCEL = 15;
    private static final long LONG_PRESS = 500, FLY_MS = 700;
    private static final int SLOP = 4;

    private final PcHost host;
    private final Pix p;
    private final Wired net = new Wired();
    private final Bitmap riteSrc, riteBustSrc;
    private Bitmap riteBust;
    private int vw = 640, vh = 360;
    private long t, lastFrame, lastTouch;
    int screen = HOME;

    // アプリ
    private int seenVersion = -1;
    private List<AppEntry> all = Collections.emptyList(), frequent = Collections.emptyList(), recent = Collections.emptyList();
    private final HashMap<String, AppEntry> byKey = new HashMap<>();
    private boolean listsDirty = true;
    private List<AppEntry> filtered = Collections.emptyList();
    private String filteredKey = "";

    // ホーム
    private int layer;
    private final String[] slots = new String[SLOTS];
    private final AppEntry[] slotApps = new AppEntry[SLOTS];
    private int cursor = ROOT, flySlot = -1;
    private long flyStart, layerFx = -10000;
    private String replaceKey;

    // DIR
    private int tab, channel, listCursor, pickSlot = -1;
    private float scroll, scrollVel, dialPos, vel;
    private boolean dialDrag;
    private long tuneStart = -10000;
    private boolean searchMode;
    private String query = "";

    // メニュー
    private static final class Menu {
        String title;
        String[] labels;
        int[] ids;
        int x, y, w, h, hover;
        AppEntry app;
        int slot = -1;
    }

    private Menu menu;

    // メッセージ
    private String msg = "";
    private long msgStart = -1;
    private boolean msgInstant;
    private int msgPage;

    // マウス
    private boolean down, dragging, longFired;
    private int axis, downX, downY, lastX, lastY;
    private long downT, lastT;

    // 演出
    private int nextScreen = -1;
    private long transStart, plugStart = -10000;
    private AppEntry plugApp, pendingLaunch;
    private long launchAt;
    private int[] zoomFrom;
    private boolean returning;
    private float fade;
    private long fadeStart = -1;
    private int fadeDir;

    PcEngine(PcHost host, Pix pix, Bitmap rite, Bitmap riteBust) {
        this.host = host;
        this.p = pix;
        this.riteSrc = rite;
        this.riteBustSrc = riteBust;
        layer = Math.max(0, Math.min(LAYERS - 1, host.getInt("layer", 0)));
        net.setLayer(layer);
        loadSlots();
        say("> リテ「…おかえり。」\n> きょうは どこに つなぐ？", false);
    }

    void resize(int w, int h) {
        vw = w;
        vh = h;
        int[] o = orbitBox();
        net.layout(o[0] + 40, o[1], o[2] - 80, o[3]); // 傾いた軌道のカプセルが画面からはみ出さないように内側で回す
        net.setFigure(riteSrc, Math.max(80, Math.min(o[3] + 40, vh - 100)));
        net.wallCols = Math.max(3, (vw - 12) / 100);
        if (riteBustSrc != null) {
            int bh = 86, bw = riteBustSrc.getWidth() * bh / riteBustSrc.getHeight();
            riteBust = Bitmap.createScaledBitmap(riteBustSrc, bw, bh, true);
        }
    }

    // ================================================================ 保存場所

    private String slotKey(int i) {
        return layer == 0 ? "slot" + i : "L" + layer + "slot" + i;
    }

    private void loadSlots() {
        for (int i = 0; i < SLOTS; i++) {
            slots[i] = host.get(slotKey(i), "");
            slotApps[i] = slots[i].isEmpty() ? null : byKey.get(slots[i]);
        }
    }

    private void setSlot(int i, String key) {
        slots[i] = key == null ? "" : key;
        host.put(slotKey(i), slots[i]);
        slotApps[i] = slots[i].isEmpty() ? null : byKey.get(slots[i]);
    }

    private int slotOf(AppEntry a) {
        for (int i = 0; i < SLOTS; i++) if (a.key.equals(slots[i])) return i;
        return -1;
    }

    private int count(AppEntry a) {
        return host.getInt("n:" + a.key, 0);
    }

    private long lastUsed(AppEntry a) {
        return host.getLong("t:" + a.key, 0);
    }

    // ================================================================ ライフサイクル

    /** ウィンドウが前に戻ってきた。 */
    void onResume() {
        menu = null;
        down = false;
        if (!returning) return;
        returning = false;
        if (fade > 0) startFade(-1);
        flySlot = -1;
        nextScreen = -1;
        if (screen == DIR && pickSlot < 0) {
            closeSearch();
            screen = HOME;
        }
        say("> せつぞくを しゅうりょうした。\n> おかえりなさい、RYOTEI。", false);
    }

    private boolean busy() {
        return nextScreen >= 0 || pendingLaunch != null || flySlot >= 0 || fadeStart >= 0 || fade > 0;
    }

    void frame(Canvas canvas, long now) {
        t = now;
        long dt = lastFrame == 0 ? 16 : Math.min(100, now - lastFrame);
        lastFrame = now;
        if (msgStart < 0) msgStart = t;
        if (fadeStart == -2) fadeStart = t;
        p.c = canvas;
        sync();
        update(dt);
        if (screen == HOME) drawHome();
        else drawDir();
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
        if (flySlot >= 0 && pendingLaunch == null && !returning) {
            long e = t - flyStart;
            if (e >= FLY_MS && fadeDir != 1) startFade(1);
            if (e >= FLY_MS + 330) {
                pendingLaunch = slotApps[flySlot];
                launchAt = t;
            }
        }
        if (pendingLaunch != null && t >= launchAt) {
            AppEntry a = pendingLaunch;
            pendingLaunch = null;
            host.putInt("n:" + a.key, count(a) + 1);
            host.putLong("t:" + a.key, host.now());
            listsDirty = true;
            if (host.launch(a)) {
                returning = true;
                host.minimize();
            } else {
                host.sfx(Host.SFX_ERROR);
                flySlot = -1;
                if (fade > 0) startFade(-1);
                say("> つながらなかった…\n> ファイルが みつからない みたい。", false);
            }
        }
        if (down && !dragging && !longFired && t - downT > LONG_PRESS) {
            longFired = true;
            secondary(downX, downY);
        }
        if (!down && screen == DIR && Math.abs(scrollVel) > 0.01f) {
            scroll += scrollVel * dt;
            scrollVel *= (float) Math.pow(0.995, dt);
            if (scroll < 0 || scroll > maxScroll()) scrollVel = 0;
        }
        scroll = Math.max(0, Math.min(scroll, maxScroll()));
    }

    private void startFade(int dir) {
        fadeDir = dir;
        fadeStart = -2;
        fade = dir > 0 ? 0 : 1;
    }

    // ================================================================ アプリ一覧

    private void sync() {
        int v = host.appsVersion();
        if (v != seenVersion) {
            seenVersion = v;
            all = host.apps();
            byKey.clear();
            for (AppEntry a : all) byKey.put(a.key, a);
            listsDirty = true;
        }
        if (listsDirty) {
            listsDirty = false;
            ArrayList<AppEntry> f = new ArrayList<>(), r = new ArrayList<>();
            for (AppEntry a : all) {
                if (count(a) > 0) f.add(a);
                if (lastUsed(a) > 0) r.add(a);
            }
            f.sort((a, b) -> Integer.compare(count(b), count(a)));
            r.sort((a, b) -> Long.compare(lastUsed(b), lastUsed(a)));
            frequent = f;
            recent = r.size() > 60 ? new ArrayList<>(r.subList(0, 60)) : r;
            filteredKey = "";
        }
        for (int i = 0; i < SLOTS; i++) slotApps[i] = slots[i].isEmpty() ? null : byKey.get(slots[i]);
    }

    private List<AppEntry> base() {
        return tab == 1 ? frequent : tab == 2 ? recent : all;
    }

    private List<AppEntry> list() {
        List<AppEntry> base = base();
        boolean searching = searchMode && !query.isEmpty();
        if ((channel == 0 && !searching) || (searchMode && !searching)) return base;
        String key = tab + ":" + (searching ? "q" + query : String.valueOf(channel)) + ":" + seenVersion + ":" + System.identityHashCode(base);
        if (!key.equals(filteredKey)) {
            ArrayList<AppEntry> f = new ArrayList<>();
            String q = norm(query);
            for (AppEntry a : base) {
                if (searching ? norm(a.label).contains(q) : Wired.channelOf(a) == channel) f.add(a);
            }
            filtered = f;
            filteredKey = key;
        }
        return filtered;
    }

    private int[] channelCounts() {
        int[] c = new int[Wired.CHANNELS.length];
        for (AppEntry a : base()) c[Wired.channelOf(a)]++;
        return c;
    }

    private static String norm(String s) {
        StringBuilder b = new StringBuilder();
        for (char c : s.toLowerCase(Locale.ROOT).toCharArray()) {
            if (c >= 'ァ' && c <= 'ヶ') c = (char) (c - 0x60);
            if (c != ' ' && c != '　') b.append(c);
        }
        return b.toString();
    }

    // ================================================================ メッセージ

    void say(String text, boolean instant) {
        msg = text;
        msgStart = -1;
        msgInstant = instant;
        msgPage = 0;
    }

    private void describe(int i) {
        if (i == ROOT) say("> リテ「…よんだ？」\n> もういちど クリックで さがす", false);
        else if (slotApps[i] == null) say("> からっぽの ノード\n> もういちど クリックで つなぐ", false);
        else say("> " + slotApps[i].label + "  Lv" + Engine.level(count(slotApps[i])) + "・" + count(slotApps[i]) + "かい\n> もういちど クリックで せつぞく", false);
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

    // ================================================================ 画面遷移・接続

    private void go(int s) {
        nextScreen = s;
        transStart = t;
        down = false;
    }

    private void fly(int i) {
        AppEntry a = slotApps[i];
        if (a == null) return;
        flySlot = i;
        flyStart = t;
        host.sfx(Host.SFX_FLY);
        say("> " + a.label + " に せつぞくちゅう…\n> うごかないで。", true);
    }

    private void plugIn(AppEntry a) {
        int idx = list().indexOf(a);
        int[] wb = wallBox();
        zoomFrom = idx >= 0 ? Wired.wallRect(wb[0], wb[1], wb[2], idx, scroll, net.wallCols) : new int[]{vw / 2 - 39, vh / 2 - 34, 78, 68};
        if (searchMode) host.searchField(false, null);
        host.sfx(Host.SFX_LAUNCH);
        plugApp = a;
        plugStart = t;
        pendingLaunch = a;
        launchAt = t + 520;
    }

    private void openDir(int pick) {
        closeSearch();
        pickSlot = pick;
        listCursor = 0;
        host.sfx(Host.SFX_MENU);
        go(DIR);
    }

    private void openSearch(String initial) {
        searchMode = true;
        query = initial == null ? "" : initial;
        pickSlot = -1;
        tab = 0;
        listCursor = 0;
        scroll = 0;
        if (screen != DIR) go(DIR);
        host.sfx(Host.SFX_MENU);
        host.searchField(true, query);
    }

    private void closeSearch() {
        if (!searchMode) return;
        searchMode = false;
        query = "";
        host.searchField(false, null);
    }

    /** 検索の入力が変わった（見えない入力欄から届く）。 */
    void setQuery(String q) {
        query = q == null ? "" : q;
        scroll = 0;
        listCursor = 0;
    }

    /** 検索中にEnterが押された：いちばん上の結果に接続する。 */
    void submitSearch() {
        List<AppEntry> l = list();
        if (searchMode && !query.isEmpty() && !l.isEmpty()) plugIn(l.get(Math.min(listCursor, l.size() - 1)));
    }

    private void build(int i, AppEntry a) {
        int old = slotOf(a);
        if (old >= 0 && old != i) setSlot(old, slots[i]);
        setSlot(i, a.key);
        cursor = i;
        host.sfx(Host.SFX_LEVEL);
        if (screen == DIR) go(HOME);
        closeSearch();
        say("> LAYER 0" + (layer + 1) + " に\n> " + a.label + " が つながった。", false);
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
        if (screen == DIR) go(HOME);
        say("> あいている ノードが ない。\n> どれと いれかえる？", false);
    }

    private void changeLayer(int d) {
        layer = (layer + d + LAYERS) % LAYERS;
        host.putInt("layer", layer);
        net.setLayer(layer);
        loadSlots();
        cursor = ROOT;
        replaceKey = null;
        layerFx = t;
        host.sfx(Host.SFX_MENU);
        say("> LAYER 0" + (layer + 1) + "「" + Wired.LAYER_WORDS[layer] + "」\n> ここにも アプリを つなげる。", false);
    }

    private void setChannel(int ch) {
        ch = Math.max(0, Math.min(Wired.CHANNELS.length - 1, ch));
        dialPos = ch;
        if (ch == channel) return;
        channel = ch;
        tuneStart = t;
        scroll = 0;
        listCursor = 0;
        host.sfx(Host.SFX_CURSOR);
    }

    /** ファイルやフォルダがドロップされた。カプセルの上ならそこにつなぐ。 */
    void drop(List<File> files, int x, int y) {
        AppEntry last = null;
        for (File f : files) {
            AppEntry a = host.addFile(f);
            if (a != null) last = a;
        }
        if (last == null) return;
        sync();
        int node = screen == HOME ? net.nodeAt(x, y, t) : -1;
        if (node >= 0 && node < SLOTS) build(node, last);
        else {
            host.sfx(Host.SFX_OK);
            say("> " + last.label + " を\n> ディレクトリに とりこんだ。", false);
        }
    }

    // ================================================================ 入力

    /** act: 0=押した 1=動かした 2=離した 3=取り消し。右クリックは secondary。 */
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
                axis = 0;
                downX = lastX = x;
                downY = lastY = y;
                downT = lastT = time;
                vel = 0;
                scrollVel = 0;
                if (menu != null) menu.hover = menuHit(menu, x, y);
                else if (screen == DIR && !searchMode && inside(x, y, dialBox())) dialDrag = true;
                else if (screen == DIR) {
                    int r = wallHit(x, y);
                    if (r >= 0 && r != listCursor) {
                        listCursor = r;
                        host.sfx(Host.SFX_CURSOR);
                    }
                }
                break;
            case 1:
                if (!down) {
                    hover(x, y);
                    return;
                }
                if (menu != null) {
                    menu.hover = menuHit(menu, x, y);
                } else {
                    if (!dragging && (Math.abs(x - downX) > SLOP || Math.abs(y - downY) > SLOP)) {
                        dragging = true;
                        axis = Math.abs(x - downX) > Math.abs(y - downY) ? 2 : 1;
                    }
                    if (dialDrag) {
                        dialPos = Math.max(0, Math.min(Wired.CHANNELS.length - 1, dialPos - (x - lastX) / (float) Wired.DIAL_STEP));
                    } else if (dragging && screen == HOME && axis == 2) {
                        net.spin(x - lastX);
                    } else if (dragging && screen == DIR && axis == 1) {
                        scroll -= y - lastY;
                        vel = vel * 0.4f + ((y - lastY) / (float) Math.max(1, time - lastT)) * 0.6f;
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
                if (dragging) {
                    if (screen == DIR && axis == 1) scrollVel = time - lastT > 80 ? 0 : -vel;
                    else if (screen == DIR && !searchMode && axis == 2 && Math.abs(x - downX) > 40) setChannel(channel + (x < downX ? 1 : -1));
                    return;
                }
                click(x, y);
                break;
            default:
                down = false;
                dialDrag = false;
        }
    }

    /** マウスを動かしただけ（押していない）。メニューの選択を追いかける。 */
    private void hover(int x, int y) {
        if (menu != null) {
            int h = menuHit(menu, x, y);
            if (h >= 0) menu.hover = h;
        }
    }

    /** ホイール。ホームでは軌道を回し、DIRでは壁を送る。 */
    void wheel(int notches) {
        if (busy() || menu != null) return;
        if (screen == HOME) net.spin(-notches * 12);
        else scroll += notches * 40;
    }

    /** Escや戻るボタン。 */
    void escape() {
        if (busy()) return;
        if (menu != null) {
            closeMenu();
        } else if (screen == DIR) {
            pickSlot = -1;
            closeSearch();
            host.sfx(Host.SFX_CANCEL);
            go(HOME);
        } else if (replaceKey != null) {
            replaceKey = null;
            host.sfx(Host.SFX_CANCEL);
        } else {
            host.minimize();
        }
    }

    /** ← →（ホームではレイヤー、DIRではチャンネル）。 */
    void arrow(int d) {
        if (busy() || menu != null) return;
        if (screen == HOME) changeLayer(d);
        else if (!searchMode) setChannel(channel + d);
    }

    /** ふつうの文字が打たれた：検索を始める。 */
    void typed(char c) {
        if (busy() || menu != null || searchMode) return;
        openSearch(String.valueOf(c));
    }

    private void click(int x, int y) {
        if (screen == HOME) {
            clickHome(x, y);
            return;
        }
        if (searchMode && inside(x, y, searchBox())) {
            host.searchField(true, query);
            return;
        }
        int[] hd = headerBox();
        if (inside(x, y, hd)) {
            if (y < hd[1] + 24) {
                if (x < hd[0] + 72) escape();
            } else {
                int tw = (hd[2] - 16) / TABS.length, ti = (x - hd[0] - 8) / tw;
                if (ti >= 0 && ti < TABS.length && ti != tab) {
                    tab = ti;
                    scroll = 0;
                    listCursor = 0;
                    host.sfx(Host.SFX_CURSOR);
                }
            }
            return;
        }
        int r = wallHit(x, y);
        if (r < 0) return;
        AppEntry a = list().get(r);
        listCursor = r;
        if (pickSlot >= 0) {
            int i = pickSlot;
            pickSlot = -1;
            build(i, a);
        } else {
            plugIn(a);
        }
    }

    private void clickHome(int x, int y) {
        if (inside(x, y, msgBox())) {
            int[] b = msgBox();
            List<String> lines = wrap(msg, b[2] - 28);
            int pages = (lines.size() + 1) / 2;
            if (!msgInstant && (int) ((t - msgStart) / 18) < pageChars(lines)) msgInstant = true;
            else if (msgPage + 1 < pages) {
                msgPage++;
                msgStart = -1;
                msgInstant = false;
            } else if (pages > 1) {
                msgPage = 0;
                msgStart = -1;
                msgInstant = false;
            }
            return;
        }
        int[] b = buttons();
        if (inside(x, y, b[0], b[1], b[2], b[3])) {
            openMenu();
            return;
        }
        if (inside(x, y, b[4], b[5], b[6], b[7])) {
            openDir(-1);
            return;
        }
        int ocx = orbitCx();
        if (y >= 26 && y < 92 && Math.abs(x - ocx) > 40) {
            changeLayer(x < ocx ? -1 : 1);
            return;
        }
        int node = net.nodeAt(x, y, t);
        if (node < 0) return;
        if (replaceKey != null && node != ROOT) {
            AppEntry a = byKey.get(replaceKey);
            replaceKey = null;
            if (a != null) build(node, a);
            return;
        }
        if (node != cursor) {
            cursor = node;
            host.sfx(Host.SFX_CURSOR);
            describe(node);
            return;
        }
        if (node == ROOT) openSearch("");
        else if (slotApps[node] == null) {
            host.sfx(Host.SFX_OK);
            openDir(node);
        } else fly(node);
    }

    /** 右クリック（長押し）：その場のメニュー。 */
    void secondary(int x, int y) {
        if (busy() || menu != null) return;
        down = false;
        if (screen == HOME) {
            int node = net.nodeAt(x, y, t);
            if (node >= 0 && node < SLOTS && slotApps[node] != null) {
                cursor = node;
                Menu m = contextMenu(slotApps[node].label, new String[]{"せつぞく", "つなぎかえる", "きりはなす", "ファイルの ばしょ", "やめる"},
                        new int[]{C_OPEN, C_SWAP, C_REMOVE, C_FOLDER, C_CANCEL}, x, y);
                m.app = slotApps[node];
                m.slot = node;
                showMenu(m);
            } else if (node < 0) {
                openMenu();
            }
        } else {
            int r = wallHit(x, y);
            if (r < 0) return;
            listCursor = r;
            AppEntry a = list().get(r);
            boolean on = slotOf(a) >= 0;
            Menu m = contextMenu(a.label, new String[]{"せつぞく", on ? "ノードを きりはなす" : "ノードに つなぐ", "ファイルの ばしょ", "やめる"},
                    new int[]{C_OPEN, on ? C_REMOVE : C_ADD, C_FOLDER, C_CANCEL}, x, y);
            m.app = a;
            m.slot = slotOf(a);
            showMenu(m);
        }
    }

    // ================================================================ メニュー

    private void openMenu() {
        Menu m = new Menu();
        m.title = "> menu";
        m.labels = new String[]{"ディレクトリ", "サウンド：" + (host.getInt("sound", 1) == 1 ? "ON" : "OFF"),
                "スタートアップ：" + (host.startupEnabled() ? "ON" : "OFF"), "しゅうりょう", "とじる"};
        m.ids = new int[]{M_DIR, M_SOUND, M_STARTUP, M_QUIT, M_CLOSE};
        m.w = 190;
        m.h = m.labels.length * 18 + 34;
        int[] b = buttons();
        m.x = vw - 6 - m.w;
        m.y = b[1] + b[3] + 4;
        m.hover = menu != null ? menu.hover : 0;
        showMenu(m);
    }

    private Menu contextMenu(String title, String[] labels, int[] ids, int x, int y) {
        Menu m = new Menu();
        m.labels = labels;
        m.ids = ids;
        int w = 0;
        for (String s : labels) w = Math.max(w, p.width(s));
        m.w = Math.max(w + 34, 150);
        m.title = p.fit(title, m.w - 20);
        m.h = labels.length * 18 + 34;
        m.x = Math.max(6, Math.min(vw - 6 - m.w, x - m.w / 2));
        m.y = Math.max(6, Math.min(vh - 6 - m.h, y + 10));
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
            case M_DIR:
                menu = null;
                openDir(-1);
                return;
            case M_SOUND:
                host.putInt("sound", host.getInt("sound", 1) == 1 ? 0 : 1);
                host.sfx(Host.SFX_OK);
                openMenu();
                return;
            case M_STARTUP:
                host.setStartup(!host.startupEnabled());
                host.sfx(Host.SFX_OK);
                openMenu();
                say(host.startupEnabled() ? "> PCを つけたら\n> ここに つながるように した。" : "> スタートアップを やめた。", false);
                return;
            case M_QUIT:
                host.quit();
                return;
            case C_OPEN:
                menu = null;
                if (screen == DIR) plugIn(a);
                else if (m.slot >= 0) fly(m.slot);
                return;
            case C_SWAP:
                menu = null;
                openDir(m.slot);
                return;
            case C_REMOVE:
                menu = null;
                if (m.slot >= 0) setSlot(m.slot, "");
                host.sfx(Host.SFX_CANCEL);
                say("> " + a.label + " との\n> せつぞくを きりはなした。", false);
                return;
            case C_ADD:
                menu = null;
                addToHome(a);
                return;
            case C_FOLDER:
                menu = null;
                host.sfx(Host.SFX_OK);
                host.showInFolder(a);
                return;
            default:
                closeMenu();
        }
    }

    // ================================================================ レイアウト

    private int orbitCx() {
        int[] o = orbitBox();
        return o[0] + o[2] / 2;
    }

    private int[] orbitBox() {
        int top = 96;
        return new int[]{10, top, vw - 210, msgBox()[1] - 8 - top};
    }

    private int[] sideBox() {
        return new int[]{vw - 196, 96, 190, msgBox()[1] - 8 - 96};
    }

    private int[] buttons() {
        int y = 22;
        return new int[]{vw - 6 - 104, y, 56, 20, vw - 6 - 44, y, 44, 20};
    }

    private int[] msgBox() {
        return new int[]{6, vh - 6 - 46, vw - 12, 46};
    }

    private int[] headerBox() {
        return new int[]{6, 6, vw - 12, 48};
    }

    private int[] searchBox() {
        return new int[]{6, 58, vw - 12, 96};
    }

    private int[] dialBox() {
        return new int[]{6, vh - 6 - 62, vw - 12, 62};
    }

    private int[] wallBox() {
        if (searchMode) return new int[]{6, 158, vw - 12, vh - 6 - 158};
        return new int[]{6, 60, vw - 12, dialBox()[1] - 6 - 60};
    }

    private int maxScroll() {
        int rows = (list().size() + net.wallCols - 1) / net.wallCols;
        return Math.max(0, rows * Wired.CELL_H + 8 - wallBox()[3]);
    }

    private int wallHit(int x, int y) {
        int[] wb = wallBox();
        if (!inside(x, y, wb)) return -1;
        int n = list().size(), cols = net.wallCols;
        int row = (int) ((y - wb[1] + scroll) / Wired.CELL_H);
        for (int c = 0; c < cols; c++) {
            int i = row * cols + c;
            if (i >= n) break;
            int[] m = Wired.wallRect(wb[0], wb[1], wb[2], i, scroll, cols);
            if (x >= m[0] - 4 && x < m[0] + m[2] + 4) return i;
        }
        return -1;
    }

    private static boolean inside(int x, int y, int[] b) {
        return inside(x, y, b[0], b[1], b[2], b[3]);
    }

    private static boolean inside(int x, int y, int bx, int by, int bw, int bh) {
        return x >= bx && x < bx + bw && y >= by && y < by + bh;
    }

    // ================================================================ 描画

    private void window(int x, int y, int w, int h) {
        Theme th = Theme.WIRED;
        p.rect(x, y, w, h, th.winFill);
        Wired.frame(p, x, y, w, h, th.winOuter);
        int l = Math.min(6, Math.min(w, h) / 3);
        p.rect(x, y, l, 1, th.winFrame);
        p.rect(x, y, 1, l, th.winFrame);
        p.rect(x + w - l, y + h - 1, l, 1, th.winFrame);
        p.rect(x + w - 1, y + h - l, 1, l, th.winFrame);
    }

    private void window(int[] b) {
        window(b[0], b[1], b[2], b[3]);
    }

    private void drawHome() {
        net.background(p, vw, vh, t);
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(host.now());
        int hh = cal.get(Calendar.HOUR_OF_DAY), mm = cal.get(Calendar.MINUTE), ss = cal.get(Calendar.SECOND);
        String clock = (cal.get(Calendar.MONTH) + 1) + "." + cal.get(Calendar.DAY_OF_MONTH) + " " + WEEK[cal.get(Calendar.DAY_OF_WEEK) - 1] + "  "
                + (hh < 10 ? "0" : "") + hh + ":" + (mm < 10 ? "0" : "") + mm + ":" + (ss < 10 ? "0" : "") + ss;
        p.text("//WIRED", 8, 4, Wired.SUB, 0);
        p.text(host.appsLoading() ? "loading..." : all.size() + " nodes", 8, 22, Wired.LINE | 0xFF000000, 0);
        Wired.ghost(p, clock, vw - 8 - p.width(clock), 4, Wired.TEXT);
        int[] b = buttons();
        p.text("[MENU]", b[0], b[1] + 2, Wired.CYAN, 0);
        p.text("[DIR]", b[4], b[5] + 2, Wired.CYAN, 0);

        int ocx = orbitCx();
        String layerText = "LAYER 0" + (layer + 1) + ":";
        Wired.ghost(p, layerText, ocx - p.width(layerText) / 2, 30, Wired.CYAN);
        String word = Wired.LAYER_WORDS[layer];
        int bw = p.bigWidth(word + "_", 2);
        p.big(word, ocx - bw / 2 + 2, 47, 2, 0x507CF4E8, 0);
        p.big(word, ocx - bw / 2, 46, 2, 0xFFD8FFF8, 0);
        if ((t / 500) % 2 == 0) p.big("_", ocx - bw / 2 + p.bigWidth(word, 2) - 4, 46, 2, 0xFFD8FFF8, 0);
        int bob = (int) ((t / 400) % 2);
        p.big("<", ocx - bw / 2 - 40 - bob, 46, 2, Wired.PURPLE, 0x502A1C58);
        p.big(">", ocx + bw / 2 + 24 + bob, 46, 2, Wired.PURPLE, 0x502A1C58);
        for (int i = 0; i < LAYERS; i++) p.rect(ocx - LAYERS * 4 + i * 8, 86, 5, 2, i == layer ? Wired.CYAN : Wired.LINE);

        int[] counts = new int[SLOTS];
        for (int i = 0; i < SLOTS; i++) counts[i] = slotApps[i] == null ? 0 : count(slotApps[i]);
        int sel = flySlot >= 0 ? flySlot : cursor;
        net.drawOrbits(p, t, slotApps, counts, sel, flySlot);

        // 右の欄：名札と操作のヒント
        int[] sb = sideBox();
        int scx = sb[0] + sb[2] / 2;
        if (sel >= 0 && sel < SLOTS && slotApps[sel] != null) {
            net.label(p, scx, sb[1] + 30, sb[2] - 10, slotApps[sel].label, "Lv" + Engine.level(counts[sel]) + " / access " + counts[sel], t);
        } else if (sel == ROOT && net.hasFigure()) {
            net.label(p, scx, sb[1] + 30, sb[2] - 10, "RITE", "navigator", t);
        } else if (sel >= 0 && sel < SLOTS) {
            net.label(p, scx, sb[1] + 30, sb[2] - 10, "------", "empty node", t);
        }
        String[] hints = {"クリック : えらぶ", "2かいめ : せつぞく", "右クリック : メニュー", "ホイール : まわす", "← → : レイヤー", "もじを うつ : さがす", "ドロップ : とりこむ", "Esc : もどる"};
        int hy = sb[1] + 104;
        for (String h : hints) {
            if (hy > sb[1] + sb[3] - 14) break;
            p.text(h, sb[0] + 8, hy, 0x907A86B0, 0);
            hy += 17;
        }
        if (replaceKey != null) p.textCenter("> つなぎかえる ものを えらんで", ocx, 98, Wired.PURPLE, 0);

        if (t - lastTouch > 8000 && menu == null && flySlot < 0) {
            long cycle = t / 9000, ph = t % 9000;
            if (ph < 2600) {
                String wsp = WHISPERS[(int) (cycle % WHISPERS.length)];
                java.util.Random r = new java.util.Random(cycle * 31);
                int a = (int) (150 * Math.sin(Math.PI * ph / 2600.0));
                int[] o = orbitBox();
                int x = o[0] + r.nextInt(Math.max(1, o[2] - p.width(wsp)));
                int y = o[1] + r.nextInt(Math.max(1, o[3] - 16));
                p.text(wsp, x + 1, y, (a / 3 << 24) | 0x7CF4E8, 0);
                p.text(wsp, x, y, (a << 24) | 0x9C7CF0, 0);
            }
        }
        Wired.glitch(p, vw, vh, t, 0);
        if (t - layerFx < 450) {
            float k = 1 - (t - layerFx) / 450f;
            Wired.noise(p, vw, vh, t, k * 0.7f);
            Wired.glitch(p, vw, vh, t, k);
        }
        if (flySlot >= 0 && slotApps[flySlot] != null) {
            float k = Math.min(1f, (t - flyStart) / (float) FLY_MS);
            net.connecting(p, vw, vh, t, "L0" + (layer + 1), slotApps[flySlot].label, k);
        }
        drawMessage(msgBox());
    }

    private int pageChars(List<String> lines) {
        int n = 0;
        for (int i = msgPage * 2; i < Math.min(lines.size(), msgPage * 2 + 2); i++) n += lines.get(i).length();
        return n;
    }

    private void drawMessage(int[] b) {
        window(b);
        List<String> lines = wrap(msg, b[2] - 28);
        int pages = Math.max(1, (lines.size() + 1) / 2);
        if (msgPage >= pages) msgPage = 0;
        int shown = msgInstant ? Integer.MAX_VALUE : (int) ((t - msgStart) / 18);
        int used = 0;
        for (int i = 0; i < 2; i++) {
            int li = msgPage * 2 + i;
            if (li >= lines.size()) break;
            String line = lines.get(li);
            int n = Math.max(0, Math.min(line.length(), shown - used));
            used += line.length();
            if (n > 0) p.text(line.substring(0, n), b[0] + 12, b[1] + 6 + i * 18, Wired.TEXT, 0);
        }
        if (shown < pageChars(lines)) return;
        if (msgPage + 1 < pages) p.arrowDown(b[0] + b[2] - 18, b[1] + b[3] - 12 + (int) ((t / 400) % 2), Wired.PURPLE);
        else if ((t / 500) % 2 == 0) p.rect(b[0] + b[2] - 16, b[1] + b[3] - 16, 6, 10, Wired.CYAN);
    }

    private void drawDir() {
        Theme th = Theme.WIRED;
        net.background(p, vw, vh, t);
        List<AppEntry> l = list();
        int[] hd = headerBox();
        window(hd);
        p.arrowLeft(hd[0] + 10, hd[1] + 12, th.accent);
        p.text("もどる", hd[0] + 18, hd[1] + 8, th.text, 0);
        String title = searchMode ? "> search" : pickSlot >= 0 ? "> select node" : "/wired/" + (channel == 0 ? "root" : "ch" + (channel < 10 ? "0" : "") + channel);
        p.textCenter(title, hd[0] + hd[2] / 2, hd[1] + 8, th.text, 0);
        p.textRight(String.valueOf(l.size()), hd[0] + hd[2] - 10, hd[1] + 8, th.dim, 0);
        int tw = (hd[2] - 16) / TABS.length;
        for (int i = 0; i < TABS.length; i++) {
            int tx = hd[0] + 8 + i * tw;
            if (i == tab) p.rect(tx + 1, hd[1] + 26, tw - 2, 17, th.tabSel);
            p.textCenter(TABS[i], tx + tw / 2, hd[1] + 27, i == tab ? th.tabSelText : th.dim, 0);
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
        if (searchMode) {
            drawSearchPanel(l);
        } else {
            if (!dialDrag) dialPos += (channel - dialPos) * 0.35f;
            int[] d = dialBox();
            net.drawDial(p, d[0], d[1], d[2], d[3], dialPos, channelCounts(), base().size(), t);
        }
        Wired.glitch(p, vw, vh, t, 0);
    }

    private void drawSearchPanel(List<AppEntry> l) {
        int[] b = searchBox();
        window(b);
        int bx = b[0] + 6, by = b[1] + 5;
        if (riteBust != null) {
            net.bust(p, riteBust, bx, by, riteBust.getWidth(), riteBust.getHeight(), t);
            bx += riteBust.getWidth() + 10;
        }
        int w = b[0] + b[2] - 10 - bx;
        String mark = (t / 500) % 2 == 0 ? "_" : " ";
        Wired.ghost(p, p.fit("> " + query, w - 10) + mark, bx, by + 2, Wired.CYAN);
        String line1, line2;
        if (query.isEmpty()) {
            line1 = "…なにを さがすの？";
            line2 = "なまえを うって（Enterで せつぞく）";
        } else if (l.isEmpty()) {
            line1 = "…ない。";
            line2 = "べつの ことばで ためして";
        } else {
            line1 = l.size() + "こ みつけた。";
            line2 = "クリックか Enterで せつぞく";
        }
        p.text(p.fit(line1, w), bx, by + 30, Wired.TEXT, 0);
        p.text(p.fit(line2, w), bx, by + 50, Wired.SUB, 0);
        p.text("RITE", b[0] + b[2] - 10 - p.width("RITE"), by + 68, Wired.PURPLE, 0);
    }

    private void drawMenu(Menu m) {
        Theme th = Theme.WIRED;
        window(m.x, m.y, m.w, m.h);
        p.rect(m.x + 6, m.y + 22, m.w - 12, 1, th.winOuter);
        p.text(m.title, m.x + 10, m.y + 5, th.accent, 0);
        for (int i = 0; i < m.labels.length; i++) {
            int y = m.y + 27 + i * 18;
            boolean sel = i == m.hover;
            if (sel) {
                p.rect(m.x + 4, y, m.w - 8, 18, th.rowSel);
                p.arrowRight(m.x + 9, y + 5, th.rowSelText);
            }
            p.text(m.labels[i], m.x + 18, y + 1, sel ? th.rowSelText : th.text, 0);
        }
    }

    private void drawEffects() {
        long pl = t - plugStart;
        if (plugApp != null && pl >= 0 && pl < 700 && screen == DIR && zoomFrom != null) {
            net.zoom(p, vw, vh, zoomFrom, plugApp, Math.min(1f, pl / 520f), t);
        }
        if (fade > 0) {
            p.rect(0, 0, vw, vh, ((int) (255 * Math.min(1, fade)) << 24) | 0x030408);
            Wired.noise(p, vw, vh, t, fade * 0.8f);
        }
        if (nextScreen >= 0) {
            float k = (t - transStart) / 300f;
            float cover = k < 0.5f ? k * 2 : (1 - k) * 2;
            int sh = Math.round(8 * Math.max(0, Math.min(1, cover)));
            for (int y = 0; y < vh; y += 8) p.rect(0, y, vw, sh, 0xFF030408);
        }
    }
}
