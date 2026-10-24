package io.github.ryotei.launcher;

import android.graphics.Canvas;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 * ランチャー本体。GBAくらいの低解像度キャンバスに全部を描き、タッチを「ゲームの操作」として扱う。
 * ホームはRPGのフィールド（お気に入りアプリ＝いえ）、メニューとアプリ一覧は電脳風のチップフォルダ。
 * Android固有の処理は Host 越しに呼ぶので、このクラスは android.graphics 以外に依存しない。
 */
final class Engine {
    static final int BOOT = 0, HOME = 1, APPS = 2;
    static final int SLOTS = 6;

    private static final int M_APPS = 1, M_SOUND = 3, M_OP = 4, M_HOMESET = 5, M_SETTINGS = 6, M_SAVE = 7,
            M_CLOSE = 8, C_OPEN = 20, C_SWAP = 21, C_REMOVE = 22, C_INFO = 23, C_ADD = 24, C_UNINSTALL = 25,
            C_CANCEL = 26;
    private static final int ACT_NONE = 0, ACT_ENTER = 1, ACT_LOT = 2, ACT_TALK = 3;
    private static final String[] TABS = {"すべて", "よくつかう", "さいきん"};
    private static final String[] WEEK = {"日", "月", "火", "水", "木", "金", "土"};
    private static final String[] TIPS = {
            "うえに スワイプすると\nチップフォルダが ひらくよ！",
            "いえを ながおしすると\nたてかえたり できるんだって！",
            "あきちの たてふだを しらべると\nあたらしい いえが たつよ！",
            "きみ じしんを タップすると\nメニューが ひらくよ！",
            "したに スワイプすると\nおしらせが みられるよ！",
            "いえに たくさん はいると\nレベルが あがるらしいよ！",
    };
    private static final long LONG_PRESS = 450;
    private static final int SLOP = 6;
    private static final int ROW = 20;

    private final Host host;
    private final Pix p;
    private final Scenery scenery = new Scenery();
    private final Overworld world = new Overworld();
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

    // ホーム（フィールド）
    private final String[] slots = new String[SLOTS];
    private final AppEntry[] slotApps = new AppEntry[SLOTS];
    private int houseHover = -1;
    private String replaceKey;
    private int action = ACT_NONE, actionSlot = -1;
    private int tipIndex;
    private int enterSlot = -1;
    private long enterStart;
    private int openDoor = -1;
    private long doorCloseAt;

    // チップフォルダ
    private int tab = 0;
    private float scroll, scrollVel;
    private int listCursor = 0;
    private int pickSlot = -1;

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
    private int returnMode; // 0=なし 1=いえから 2=チップフォルダから
    private String levelUpMsg;
    private long saveAt = -1;
    private float fade; // 0=なし 1=真っ暗
    private int fadeDir; // 1=暗くする -1=明るくする
    private long fadeStart = -1;

    Engine(Host host, Pix pix) {
        this.host = host;
        this.p = pix;
        for (int i = 0; i < SLOTS; i++) slots[i] = host.getString("slot" + i, "");
        screen = host.getInt("opening", 1) == 1 ? BOOT : HOME;
        if (screen == HOME) say(greeting(), true);
    }

    void resize(int w, int h) {
        vw = w;
        vh = h;
        world.layout(vw, vh, hudBox()[1] + hudBox()[3] + 2, msgBox()[1] - 2);
    }

    // ================================================================ ライフサイクル

    void onResume() {
        menu = null;
        down = false;
        if (returnMode == 0) {
            if (screen == HOME && replaceKey == null && enterSlot < 0) say(greeting(), true);
            return;
        }
        if (returnMode == 1 && enterSlot >= 0) {
            int i = enterSlot;
            world.player.place(world.doorX[i], world.frontY(i), 0);
            world.player.hidden = false;
            openDoor = i;
            doorCloseAt = -1; // 次のフレームで決める
            startFade(-1);
            enterSlot = -1;
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
            say("おかえり！ RYOTEI。\nつぎは どこへ いく？", false);
        }
    }

    /** ホーム画面表示中にもう一度ホームボタンが押された。 */
    void homePressed() {
        if (enterSlot >= 0 || pendingLaunch != null) return;
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
        return nextScreen >= 0 || pendingLaunch != null || enterSlot >= 0 || fadeStart >= 0 || fade > 0;
    }

    // ================================================================ 1フレーム

    void frame(Canvas canvas, long now) {
        t = now;
        long dt = lastFrame == 0 ? 16 : Math.min(100, now - lastFrame);
        lastFrame = now;
        if (msgStart < 0) msgStart = t;
        if (fadeStart == -2) fadeStart = t;
        if (openDoor >= 0 && doorCloseAt == -1) doorCloseAt = t + 450;
        p.c = canvas;
        syncApps();
        update(dt);

        if (screen == BOOT) {
            drawBoot();
        } else if (screen == HOME) {
            drawHome();
        } else {
            drawApps();
        }
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
        if (openDoor >= 0 && enterSlot < 0 && doorCloseAt > 0 && t >= doorCloseAt) openDoor = -1;
        if (screen == HOME) {
            world.update(t);
            if (action != ACT_NONE && !world.player.busy()) arrive();
            if (enterSlot >= 0) updateEnter();
        }
        if (pendingLaunch != null && t >= launchAt) {
            AppEntry app = pendingLaunch;
            pendingLaunch = null;
            countLaunch(app);
            if (!host.launch(app)) {
                levelUpMsg = null;
                returnMode = 0;
                host.sfx(Host.SFX_ERROR);
                if (enterSlot >= 0) {
                    world.player.place(world.doorX[enterSlot], world.frontY(enterSlot), 0);
                    world.player.hidden = false;
                    openDoor = enterSlot;
                    doorCloseAt = t + 450;
                    enterSlot = -1;
                    startFade(-1);
                }
                say("あれ？ その アプリは\nひらけなかった…", false);
            }
        }
        if (saveAt >= 0 && t >= saveAt) {
            saveAt = -1;
            host.sfx(Host.SFX_SAVE);
            say("RYOTEIは レポートに\nしっかり かきこんだ！", false);
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
        }
    }

    private void defaultSlots() {
        String[] wanted = {"com.android.chrome", "com.google.android.youtube", "com.google.android.apps.photos",
                "com.google.android.GoogleCamera", "com.sec.android.app.camera", "com.android.camera",
                "com.google.android.gm", "com.google.android.apps.messaging", "com.google.android.dialer",
                "com.android.vending", "com.google.android.apps.maps"};
        int n = 0;
        for (String pkg : wanted) {
            if (n >= SLOTS - 1) break; // 1軒はあき地にしておく
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

    private void countLaunch(AppEntry a) {
        int before = count(a);
        host.putInt("n:" + a.key, before + 1);
        host.putLong("t:" + a.key, host.now());
        listsDirty = true;
        int lv = level(before + 1);
        levelUpMsg = lv > level(before) && lv > 1 ? p.fit(a.label, 150) + "の レベルが\n" + lv + "に あがった！" : null;
    }

    private int slotOf(AppEntry a) {
        for (int i = 0; i < SLOTS; i++) if (a.key.equals(slots[i])) return i;
        return -1;
    }

    private void setSlot(int i, String key) {
        slots[i] = key == null ? "" : key;
        host.putString("slot" + i, slots[i]);
        slotApps[i] = slots[i].isEmpty() ? null : byKey.get(slots[i]);
    }

    // ================================================================ メッセージ

    void say(String text, boolean instant) {
        msg = text;
        msgStart = -1;
        msgInstant = instant;
    }

    private String greeting() {
        int lv = host.batteryLevel();
        if (lv >= 0 && lv <= 15 && !host.charging()) return "でんちが のこり すくない！\nはやく じゅうでん しよう！";
        if (host.charging()) return "じゅうでん ちゅう…\nHPが すこしずつ かいふく！";
        int h = hour();
        if (h >= 5 && h <= 10) return "おはよう！ RYOTEI。\nきょうは どこへ いく？";
        if (h >= 11 && h <= 16) return "RYOTEIは あたりを\nみわたした。 どこへ いく？";
        if (h >= 17 && h <= 20) return "ゆうがたに なってきた。\nどこかに よっていく？";
        return "よふかしは ほどほどに…\nそろそろ やすもう。";
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

    /** フィールドでいえの前に着いたら、ドアを開けて中に入り、暗転してアプリを起動する。 */
    private void enter(int i) {
        AppEntry a = slotApps[i];
        if (a == null) return;
        enterSlot = i;
        enterStart = t;
        openDoor = i;
        world.player.dir = 1;
        host.sfx(Host.SFX_DOOR);
        say("RYOTEIは\n" + p.fit(a.label, 150) + "に はいった！", true);
    }

    private void updateEnter() {
        long e = t - enterStart;
        Overworld.Actor pl = world.player;
        if (e >= 180 && !pl.moving && pl.y == world.frontY(enterSlot) && !pl.hidden) {
            pl.stepMs = 220;
            pl.forceStep(pl.x, pl.y - 1, t);
        }
        if (e >= 420 && !pl.hidden) {
            pl.hidden = true;
            startFade(1);
        }
        if (e >= 760 && pendingLaunch == null && returnMode == 0) {
            pendingLaunch = slotApps[enterSlot];
            launchAt = t;
            returnMode = 1;
        }
    }

    /** チップフォルダからの起動。電脳風の演出をはさむ。 */
    private void plugIn(AppEntry a) {
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
        say("あきちが ない！\nどの いえと たてかえる？", false);
    }

    private void build(int i, AppEntry a) {
        int old = slotOf(a);
        if (old >= 0 && old != i) setSlot(old, slots[i]);
        setSlot(i, a.key);
        host.sfx(Host.SFX_LEVEL);
        if (screen == APPS) go(HOME);
        say(p.fit(a.label, 150) + "の\nいえが たった！", false);
    }

    /** 主人公が目的地に着いた。 */
    private void arrive() {
        int act = action, i = actionSlot;
        action = ACT_NONE;
        Overworld.Actor pl = world.player;
        if (act == ACT_ENTER || act == ACT_LOT) {
            if (pl.x != world.doorX[i] || pl.y != world.frontY(i)) return;
            pl.dir = 1;
            if (act == ACT_ENTER) {
                enter(i);
            } else {
                host.sfx(Host.SFX_OK);
                say("あきちだ。 たてふだに\n「いえを たてよう！」と ある。", true);
                openApps(i);
            }
        } else if (act == ACT_TALK) {
            Overworld.Actor npc = world.npc;
            if (Math.abs(npc.x - pl.x) + Math.abs(npc.y - pl.y) != 1) return;
            pl.face(npc.x, npc.y);
            npc.face(pl.x, pl.y);
            world.npcFrozenUntil = t + 2500;
            host.sfx(Host.SFX_OK);
            say(TIPS[tipIndex++ % TIPS.length], false);
        }
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
                        houseHover = -1;
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
                houseHover = -1;
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
                houseHover = -1;
        }
    }

    private void press(int x, int y) {
        if (menu != null) {
            menu.hover = menuHit(menu, x, y);
            return;
        }
        if (screen == HOME) {
            houseHover = inMap(y) ? world.houseAt(world.toTileX(x), world.toTileY(y)) : -1;
            if (houseHover >= 0) host.sfx(Host.SFX_CURSOR);
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

    private boolean inMap(int y) {
        return y >= hudBox()[1] + hudBox()[3] && y < msgBox()[1];
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
        int[] b = buttons();
        if (inside(x, y, b[0], b[1], b[2], b[3])) {
            openMenu();
            return;
        }
        if (inside(x, y, b[4], b[5], b[6], b[7])) {
            openApps(-1);
            return;
        }
        if (inside(x, y, hudBox())) {
            host.sfx(Host.SFX_OK);
            host.openClock();
            return;
        }
        if (!inMap(y)) return;
        int tx = world.toTileX(x), ty = world.toTileY(y);
        Overworld.Actor pl = world.player, npc = world.npc;
        int house = world.houseAt(tx, ty);
        if (house >= 0) {
            if (replaceKey != null) {
                AppEntry a = byKey.get(replaceKey);
                replaceKey = null;
                if (a != null) build(house, a);
                return;
            }
            if (goTo(world.doorX[house], world.frontY(house))) {
                action = slotApps[house] != null ? ACT_ENTER : ACT_LOT;
                actionSlot = house;
            }
            return;
        }
        if (tx == pl.x && ty == pl.y && !pl.moving) {
            openMenu();
            return;
        }
        if (tx == npc.x && ty == npc.y) {
            int[][] around = {{npc.x, npc.y + 1}, {npc.x, npc.y - 1}, {npc.x - 1, npc.y}, {npc.x + 1, npc.y}};
            int[] best = null;
            int bestD = Integer.MAX_VALUE;
            for (int[] a : around) {
                if (world.solid(a[0], a[1])) continue;
                int d = Math.abs(a[0] - pl.x) + Math.abs(a[1] - pl.y);
                if (d < bestD) {
                    bestD = d;
                    best = a;
                }
            }
            if (best != null && goTo(best[0], best[1])) {
                action = ACT_TALK;
                world.npcFrozenUntil = t + 4000;
            }
            return;
        }
        int tile = world.tileAt(tx, ty);
        if (tile == Scenery.TREE_TOP || tile == Scenery.TREE_BOTTOM) {
            say("りっぱな きだ。\nかぜで はっぱが ゆれている。", false);
            return;
        }
        if (tile == Scenery.ROCK) {
            say("おおきな いわだ。\nびくとも しない。", false);
            return;
        }
        action = ACT_NONE;
        goTo(tx, ty);
    }

    private boolean goTo(int tx, int ty) {
        Overworld.Actor pl = world.player;
        if (pl.moving) {
            // 歩いている途中なら、いまの1歩を終えてから向かう
            pl.path.clear();
        }
        if (world.walk(pl, tx, ty, world.npc)) return true;
        host.sfx(Host.SFX_ERROR);
        say("そこへは いけない みたいだ。", true);
        return false;
    }

    private void longPress(int x, int y) {
        if (menu != null) return;
        if (screen == HOME) {
            if (!inMap(y)) return;
            int house = world.houseAt(world.toTileX(x), world.toTileY(y));
            houseHover = -1;
            if (house >= 0 && slotApps[house] != null) {
                AppEntry a = slotApps[house];
                Menu m = contextMenu(a.label, new String[]{"はいる", "たてかえる", "とりこわす", "アプリじょうほう", "やめる"},
                        new int[]{C_OPEN, C_SWAP, C_REMOVE, C_INFO, C_CANCEL});
                m.app = a;
                m.slot = house;
                showMenu(m);
            } else if (house < 0) {
                openMenu();
            }
        } else if (screen == APPS) {
            int r = rowHit(x, y);
            if (r < 0) return;
            listCursor = r;
            AppEntry a = list().get(r);
            boolean onHome = slotOf(a) >= 0;
            Menu m = contextMenu(a.label,
                    new String[]{"プラグイン", onHome ? "ホームから はずす" : "ホームに たてる", "アプリじょうほう", "アンインストール", "やめる"},
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
        String[] labels = {"チップフォルダ", "サウンド：" + (host.getInt("sound", 1) == 1 ? "ON" : "OFF"),
                "オープニング：" + (host.getInt("opening", 1) == 1 ? "ON" : "OFF"), "ホームアプリ", "たんまつせってい",
                "レポート", "とじる"};
        int[] ids = {M_APPS, M_SOUND, M_OP, M_HOMESET, M_SETTINGS, M_SAVE, M_CLOSE};
        Menu m = new Menu();
        m.title = "MENU";
        m.labels = labels;
        m.ids = ids;
        m.w = Math.min(vw - 12, 176);
        m.h = labels.length * 18 + 34;
        m.x = vw - 6 - m.w;
        m.y = hudBox()[1] + hudBox()[3] + 6;
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
        m.y = Math.max(hudBox()[1] + hudBox()[3] + 4, msgBox()[1] - 4 - m.h);
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
            case M_SOUND: {
                host.putInt("sound", host.getInt("sound", 1) == 1 ? 0 : 1);
                host.sfx(Host.SFX_OK);
                openMenu();
                return;
            }
            case M_OP: {
                host.putInt("opening", host.getInt("opening", 1) == 1 ? 0 : 1);
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
            case M_SAVE:
                menu = null;
                host.sfx(Host.SFX_OK);
                say("レポートを かきこんでいます…\nでんげんを きらないで ください。", false);
                saveAt = t + 1400;
                return;
            case C_OPEN:
                menu = null;
                if (screen == APPS) plugIn(a);
                else if (m.slot >= 0 && goTo(world.doorX[m.slot], world.frontY(m.slot))) {
                    action = ACT_ENTER;
                    actionSlot = m.slot;
                }
                return;
            case C_SWAP:
                menu = null;
                openApps(m.slot);
                return;
            case C_REMOVE:
                menu = null;
                if (m.slot >= 0) setSlot(m.slot, "");
                host.sfx(Host.SFX_CANCEL);
                if (screen == HOME) say(p.fit(a.label, 150) + "の いえを\nとりこわした。 あきちに なった。", false);
                return;
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
        return new int[]{6, 6, vw - 12 - 60, 46};
    }

    private int[] buttons() {
        int x = vw - 6 - 56;
        return new int[]{x, 6, 56, 22, x, 30, 56, 22};
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

    /** 今の th に合わせたウィンドウ。FIELDは白い角丸、CYBERは角を落とした電脳パネル。 */
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
        // 主人公が足踏みしている
        Overworld.Actor hero = world.player;
        int f = (int) ((t / 250) % 4);
        p.image(hero.frames[0][f == 1 ? 1 : f == 3 ? 2 : 0], vw / 2 - 16, vh * 50 / 100, 32, 40);
        if ((t / 500) % 2 == 0) {
            String ps = "PRESS START";
            p.big(ps, (vw - p.bigWidth(ps, 2)) / 2, vh * 66 / 100, 2, 0xFFF8F8F8, shadow);
        }
        p.textCenter("©2026 RYOTEI", vw / 2, vh - 30, 0xFFD0F0D8, shadow);
    }

    private void drawHome() {
        th = Theme.FIELD;
        world.draw(p, t, slotApps, houseHover, openDoor);
        int h = hour();
        if (h >= 19 || h <= 4) p.rect(0, 0, vw, vh, 0x48101848);
        else if (h >= 17) p.rect(0, 0, vw, vh, 0x30F07830);
        drawHud();
        int[] b = buttons();
        smallButton(b[0], b[1], b[2], b[3], "MENU");
        smallButton(b[4], b[5], b[6], b[7], "APPS");
        drawMessage(msgBox());
    }

    private void smallButton(int x, int y, int w, int h, String label) {
        p.round(x, y, w, h, th.winOuter);
        p.round(x + 1, y + 1, w - 2, h - 2, th.winFill);
        p.rect(x + 2, y + h - 3, w - 4, 1, th.shadow);
        p.textCenter(label, x + w / 2, y + (h - Pix.LINE) / 2, th.text, th.shadow);
    }

    private void drawHud() {
        int[] b = hudBox();
        window(b);
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(host.now());
        int hh = cal.get(Calendar.HOUR_OF_DAY), mm = cal.get(Calendar.MINUTE);
        String clock = (hh < 10 ? "0" : "") + hh + ((t / 500) % 2 == 0 ? ":" : " ") + (mm < 10 ? "0" : "") + mm;
        p.big(clock, b[0] + 9, b[1] + 5, 2, th.text, th.shadow);
        int right = b[0] + b[2] - 8;
        String date = (cal.get(Calendar.MONTH) + 1) + "/" + cal.get(Calendar.DAY_OF_MONTH) + "(" + WEEK[cal.get(Calendar.DAY_OF_WEEK) - 1] + ")";
        p.textRight(date, right, b[1] + 6, th.text, th.shadow);
        int lv = host.batteryLevel();
        int pct = Math.max(0, lv);
        String num = lv < 0 ? "--" : String.valueOf(pct);
        int barRight = right - p.width("100") - 3;
        int labelX = Math.max(b[0] + 96, barRight - 84);
        p.round(labelX, b[1] + 25, 21, 15, th.hpLabel);
        p.text("HP", labelX + 3, b[1] + 25, th.hpLabelText, 0);
        int color = pct > 50 ? th.hpGreen : pct > 20 ? th.hpYellow : th.hpRed;
        bar(labelX + 23, b[1] + 29, barRight - labelX - 23, 6, pct / 100f, color);
        if (host.charging()) {
            int bx = labelX + 24, bw = barRight - labelX - 25;
            int sx = (int) (t / 20 % (bw + 12)) - 6;
            p.rect(bx + Math.max(0, sx), b[1] + 30, Math.max(0, Math.min(4, bw - Math.max(0, sx))), 4, 0xFFF8F8F8);
        }
        p.textRight(num, right, b[1] + 25, th.text, th.shadow);
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
            int bob = (int) ((t / 400) % 2);
            p.arrowDown(b[0] + b[2] - 18, b[1] + b[3] - 13 + bob, th.accent);
        }
    }

    private void drawApps() {
        th = Theme.CYBER;
        scenery.drawCyber(p, vw, vh, t);
        List<AppEntry> l = list();
        int[] hd = headerBox();
        window(hd);
        p.arrowLeft(hd[0] + 10, hd[1] + 12, th.accent);
        p.text("もどる", hd[0] + 18, hd[1] + 8, th.text, th.shadow);
        String title = pickSlot >= 0 ? "どれを たてる？" : "チップフォルダ";
        p.textCenter(title, hd[0] + hd[2] / 2 + 8, hd[1] + 8, th.text, th.shadow);
        p.textRight(String.valueOf(l.size()), hd[0] + hd[2] - 10, hd[1] + 8, th.dim, 0);
        int tw = (hd[2] - 16) / TABS.length;
        for (int i = 0; i < TABS.length; i++) {
            int tx = hd[0] + 8 + i * tw;
            if (i == tab) p.chamfer(tx + 1, hd[1] + 26, tw - 2, 17, 3, th.tabSel);
            p.textCenter(TABS[i], tx + tw / 2, hd[1] + 27, i == tab ? th.tabSelText : th.dim, 0);
        }
        drawPreview(l);

        int[] lb = listBox();
        window(lb);
        int top = listInnerTop(), ih = listInnerH();
        int left = lb[0] + 6, right = lb[0] + lb[2] - 16;
        if (host.appsLoading() && all.isEmpty()) {
            p.textCenter("よみこみちゅう…", vw / 2, top + ih / 2 - 8, th.dim, 0);
        } else if (l.isEmpty()) {
            p.textCenter(tab == 0 ? "チップが みつからない…" : "まだ なにも ない…", vw / 2, top + ih / 2 - 8, th.dim, 0);
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
                p.image(a.icon16, left + 12, y + 2, 16, 16);
                p.text(p.fit(a.label, right - left - 40 - 24), left + 32, y + 2, textColor, shadow);
                p.rect(right - 19, y + 2, 17, 16, th.chip);
                p.textCenter(a.code, right - 10, y + 2, th.chipText, 0);
                if (slotOf(a) >= 0) p.rect(right - 23, y + 8, 2, 4, sel ? th.rowSelText : th.accent);
            }
            p.c.restore();
            int max = maxScroll();
            int sx = lb[0] + lb[2] - 12;
            p.rect(sx, top, 4, ih, 0xFF0A1C34);
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
        String hint = pickSlot >= 0 ? "タップで たてる" : slotOf(a) >= 0 ? "ホームに いえ あり" : "ながおしで メニュー";
        p.text(p.fit(hint, w), tx, cy + 55, th.dim, 0);
    }

    private void drawMenu(Menu m) {
        th = Theme.CYBER;
        window(m.x, m.y, m.w, m.h);
        p.rect(m.x + 6, m.y + 6, m.w - 12, 17, th.winFrame);
        p.text(m.title, m.x + 12, m.y + 6, th.chip, th.shadow);
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
        if (plugApp != null && pl >= 0 && pl < 700) {
            th = Theme.CYBER;
            int a = (int) (200 * Math.max(0, 1 - pl / 700f));
            p.rect(0, 0, vw, vh, (a << 24) | 0x60E0FF);
            for (int y = (int) (pl / 4) % 12; y < vh; y += 12) p.rect(0, y, vw, 2, 0x90FFFFFF);
            int w = vw - 40, h = 52, x = 20, y = vh / 2 - h / 2;
            window(x, y, w, h);
            p.textCenter("プラグイン！", vw / 2, y + 9, th.chip, th.shadow);
            p.textCenter(p.fit(plugApp.label, w - 120) + " トランスミッション！", vw / 2, y + 27, th.text, th.shadow);
        }
        if (fade > 0) p.rect(0, 0, vw, vh, ((int) (255 * Math.min(1, fade)) << 24) | 0x000000);
        if (nextScreen >= 0) {
            float k = (t - transStart) / 300f;
            float cover = k < 0.5f ? k * 2 : (1 - k) * 2;
            int sh = Math.round(8 * Math.max(0, Math.min(1, cover)));
            int color = nextScreen == APPS || screen == APPS ? 0xFF48E0F8 : 0xFF101010;
            for (int y = 0; y < vh; y += 8) p.rect(0, y, vw, sh, color);
        }
    }
}
