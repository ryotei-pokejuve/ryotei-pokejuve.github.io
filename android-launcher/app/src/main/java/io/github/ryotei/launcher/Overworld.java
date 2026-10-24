package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;

import java.util.ArrayDeque;
import java.util.Random;

/**
 * ホーム画面のフィールド。16x16タイルのマップに「いえ」（お気に入りアプリ）を6軒建て、
 * 主人公と村人が歩き回る。どこをタップしたらどこへ歩くか、はここで解く。
 */
final class Overworld {
    static final int T = 16;
    static final int HOUSE = 7;
    static final int SLOTS = Engine.SLOTS;
    private static final int[] ROOF = {0xFFD04838, 0xFF3868C8, 0xFF40A050, 0xFFA050C0, 0xFFE08828, 0xFF30A8A8};

    int cols, rows, offX, offY, rTop, rBot;
    private int[][] map = new int[0][0];
    private int[][] var = new int[0][0];
    final int[] hx = new int[SLOTS], hy = new int[SLOTS], doorX = new int[SLOTS];
    private Bitmap cache0, cache1;
    private int cacheMask = -1;
    final Actor player;
    final Actor npc;
    private final Random rnd = new Random();
    private long npcNext;
    long npcFrozenUntil;

    /** フィールドを歩くキャラクター。座標はタイル単位。 */
    static final class Actor {
        int x, y, fx, fy, dir; // dir: 0=下 1=上 2=左 3=右
        boolean moving, hidden;
        long stepStart;
        int stepMs = 180, steps;
        final ArrayDeque<int[]> path = new ArrayDeque<>();
        final Bitmap[][] frames;

        Actor(Bitmap[][] frames) {
            this.frames = frames;
        }

        boolean busy() {
            return moving || !path.isEmpty();
        }

        void place(int tx, int ty, int d) {
            x = fx = tx;
            y = fy = ty;
            dir = d;
            moving = false;
            path.clear();
        }

        /** 当たり判定を無視して隣のタイルへ1歩動く（いえのドアに入る時など）。 */
        void forceStep(int tx, int ty, long t) {
            path.clear();
            begin(tx, ty, t);
        }

        void begin(int tx, int ty, long t) {
            fx = x;
            fy = y;
            dir = tx < x ? 2 : tx > x ? 3 : ty < y ? 1 : 0;
            x = tx;
            y = ty;
            moving = true;
            stepStart = t;
        }

        float progress(long t) {
            return moving ? Math.min(1f, (t - stepStart) / (float) stepMs) : 1f;
        }

        void face(int tx, int ty) {
            if (tx < x) dir = 2;
            else if (tx > x) dir = 3;
            else if (ty < y) dir = 1;
            else if (ty > y) dir = 0;
        }
    }

    Overworld() {
        player = new Actor(Sprites.actor(Sprites.HERO));
        npc = new Actor(Sprites.actor(Sprites.VILLAGER));
    }

    // ================================================================ マップ生成

    /** 画面サイズに合わせてマップを作り直す。top〜bottom（画面座標）が歩ける範囲。 */
    void layout(int vw, int vh, int top, int bottom) {
        cols = (vw + T - 1) / T;
        rows = (vh + T - 1) / T;
        offX = (vw - cols * T) / 2;
        offY = (vh - rows * T) / 2;
        rTop = Math.max(0, (int) Math.ceil((top - offY) / (double) T));
        rBot = Math.min(rows, (bottom - offY) / T);
        map = new int[rows][cols];
        var = new int[rows][cols];
        Random r = new Random(20261024L);
        for (int y = 0; y < rows; y++)
            for (int x = 0; x < cols; x++) var[y][x] = r.nextInt(4);

        int n = rBot - rTop;
        int band = Math.max(5, n / 3);
        int lx = 2, rx = cols - 6, mid = (lx + 4 + rx - 1) / 2;
        boolean[][] keep = new boolean[rows][cols];
        // 縦の大通り
        for (int y = 0; y < rows; y++) {
            map[y][mid] = Scenery.PATH;
            keep[y][mid] = true;
        }
        for (int b = 0; b < 3; b++) {
            int s = rTop + b * band + Math.max(0, (band - 5) / 2) + 1;
            for (int side = 0; side < 2; side++) {
                int i = b * 2 + side;
                int x0 = side == 0 ? lx : rx;
                hx[i] = x0;
                hy[i] = s;
                doorX[i] = side == 0 ? x0 + 2 : x0 + 1;
                for (int y = s; y < s + 3 && y < rows; y++)
                    for (int x = x0; x < x0 + 4; x++) {
                        map[y][x] = HOUSE;
                        keep[y][x] = true;
                    }
            }
            int front = s + 3;
            if (front < rows) {
                for (int x = lx + 1; x <= rx + 2; x++) {
                    map[front][x] = Scenery.PATH;
                    keep[front][x] = true;
                }
            }
            if (s - 1 >= 0) for (int x = 0; x < cols; x++) keep[s - 1][x] = true;
        }
        // 両端の木
        for (int y = 0; y + 1 < rows; y += 2) {
            for (int x : new int[]{0, cols - 1}) {
                map[y][x] = Scenery.TREE_TOP;
                map[y + 1][x] = Scenery.TREE_BOTTOM;
                keep[y][x] = keep[y + 1][x] = true;
            }
        }
        // 草むらの塊
        for (int k = 0; k < 4; k++) {
            int cx = 1 + r.nextInt(Math.max(1, cols - 4)), cy = rTop + r.nextInt(Math.max(1, n - 2));
            for (int y = cy; y < Math.min(rows, cy + 2); y++)
                for (int x = cx; x < Math.min(cols - 1, cx + 2 + r.nextInt(2)); x++)
                    if (!keep[y][x]) map[y][x] = Scenery.TALL;
        }
        // 花と岩
        for (int y = 0; y < rows; y++) {
            for (int x = 1; x < cols - 1; x++) {
                if (keep[y][x] || map[y][x] != Scenery.GRASS) continue;
                int v = r.nextInt(100);
                if (v < 8) map[y][x] = Scenery.FLOWER;
                else if (v < 10 && y > rTop && y < rBot - 1) map[y][x] = Scenery.ROCK;
            }
        }
        player.place(mid, Math.min(rBot - 1, rTop + n / 2), 0);
        npc.place(lx + 1, Math.min(rBot - 1, hy[4] + 3), 0);
        if (solid(npc.x, npc.y)) npc.place(mid, rTop, 0);
        cacheMask = -1;
    }

    boolean solid(int x, int y) {
        if (x < 0 || y < rTop || x >= cols || y >= rBot) return true;
        int m = map[y][x];
        return m == HOUSE || m == Scenery.ROCK || m == Scenery.TREE_TOP || m == Scenery.TREE_BOTTOM;
    }

    int tileAt(int tx, int ty) {
        if (tx < 0 || ty < 0 || tx >= cols || ty >= rows) return -1;
        return map[ty][tx];
    }

    /** そのタイルが含まれるいえの番号。いえでなければ-1。 */
    int houseAt(int tx, int ty) {
        for (int i = 0; i < SLOTS; i++)
            if (tx >= hx[i] && tx < hx[i] + 4 && ty >= hy[i] && ty < hy[i] + 3) return i;
        return -1;
    }

    int frontY(int i) {
        return hy[i] + 3;
    }

    int toTileX(int sx) {
        return Math.floorDiv(sx - offX, T);
    }

    int toTileY(int sy) {
        return Math.floorDiv(sy - offY, T);
    }

    // ================================================================ 移動

    /** 幅優先探索で道順を作り、主人公に歩かせる。たどり着けなければfalse。 */
    boolean walk(Actor a, int tx, int ty, Actor other) {
        if (a.x == tx && a.y == ty && !a.moving) return true;
        int sx = a.x, sy = a.y;
        if (solid(tx, ty) || (other != null && other.x == tx && other.y == ty)) return false;
        int w = cols, h = rows;
        int[] prev = new int[w * h];
        java.util.Arrays.fill(prev, -2);
        ArrayDeque<Integer> q = new ArrayDeque<>();
        prev[sy * w + sx] = -1;
        q.add(sy * w + sx);
        int[] dx = {0, 0, -1, 1}, dy = {1, -1, 0, 0};
        int goal = ty * w + tx;
        while (!q.isEmpty()) {
            int cur = q.poll();
            if (cur == goal) break;
            int cx = cur % w, cy = cur / w;
            for (int d = 0; d < 4; d++) {
                int nx = cx + dx[d], ny = cy + dy[d];
                if (solid(nx, ny)) continue;
                if (other != null && other.x == nx && other.y == ny) continue;
                int ni = ny * w + nx;
                if (prev[ni] != -2) continue;
                prev[ni] = cur;
                q.add(ni);
            }
        }
        if (prev[goal] == -2) return false;
        ArrayDeque<int[]> steps = new ArrayDeque<>();
        for (int c = goal; c != sy * w + sx; c = prev[c]) steps.addFirst(new int[]{c % w, c / w});
        a.path.clear();
        a.path.addAll(steps);
        a.stepMs = steps.size() > 5 ? 110 : 180; // 遠い時はダッシュ
        return true;
    }

    void update(long t) {
        step(player, npc, t);
        step(npc, player, t);
        if (!npc.busy() && t > npcNext && t > npcFrozenUntil) {
            npcNext = t + 1400 + rnd.nextInt(2400);
            int d = rnd.nextInt(4);
            int nx = npc.x + (d == 2 ? -1 : d == 3 ? 1 : 0), ny = npc.y + (d == 0 ? 1 : d == 1 ? -1 : 0);
            boolean onPlayerWay = false;
            for (int[] s : player.path) if (s[0] == nx && s[1] == ny) onPlayerWay = true;
            if (!solid(nx, ny) && !(player.x == nx && player.y == ny) && !onPlayerWay && map[ny][nx] != Scenery.TALL) {
                npc.stepMs = 260;
                npc.path.add(new int[]{nx, ny});
            } else {
                npc.dir = d;
            }
        }
    }

    private void step(Actor a, Actor other, long t) {
        if (a.moving && t - a.stepStart >= a.stepMs) {
            a.moving = false;
            a.fx = a.x;
            a.fy = a.y;
            a.steps++;
        }
        if (!a.moving && !a.path.isEmpty()) {
            int[] n = a.path.peek();
            if (other.x == n[0] && other.y == n[1]) {
                a.path.clear();
                return;
            }
            a.path.poll();
            a.begin(n[0], n[1], t);
        }
    }

    // ================================================================ 描画

    /** apps: 各いえのアプリ（nullならあき地）。hover: 押されているいえ。openDoor: ドアが開いているいえ。 */
    void draw(Pix p, long t, AppEntry[] apps, int hover, int openDoor) {
        int mask = 0;
        for (int i = 0; i < SLOTS; i++) if (apps[i] != null) mask |= 1 << i;
        if (cache0 == null || cacheMask != mask) build(p, mask);
        p.image((t / 600) % 2 == 0 ? cache0 : cache1, 0, 0, cache0.getWidth(), cache0.getHeight());

        for (int i = 0; i < SLOTS; i++) {
            int x = offX + hx[i] * T, y = offY + hy[i] * T;
            if (apps[i] != null) {
                p.image(apps[i].icon16, x + 24, y + 9, 16, 16);
                if (i == openDoor) {
                    int dx = offX + doorX[i] * T;
                    p.rect(dx + 2, y + 34, 12, 14, 0xFF181010);
                }
            }
            if (i == hover) {
                int bob = (int) ((t / 150) % 2);
                p.arrowDown(x + 28, y - 7 + bob, 0xFFF8F8F8);
                p.arrowDown(x + 28, y - 8 + bob, 0xFF303030);
            }
        }
        Actor first = npc.y <= player.y ? npc : player, second = first == npc ? player : npc;
        drawActor(p, first, t);
        drawActor(p, second, t);
    }

    private void drawActor(Pix p, Actor a, long t) {
        if (a.hidden) return;
        float k = a.progress(t);
        int sx = offX + Math.round((a.fx + (a.x - a.fx) * k) * T);
        int sy = offY + Math.round((a.fy + (a.y - a.fy) * k) * T) - 4;
        int f = 0;
        if (a.moving && k < 0.5f) f = a.steps % 2 == 0 ? 1 : 2;
        if (a.moving && a.stepMs < 150 && k >= 0.5f) f = a.steps % 2 == 0 ? 2 : 1; // ダッシュは足を止めない
        p.image(a.frames[a.dir][f], sx, sy, 16, 20);
        // 草むらの中では足元が隠れる
        int tx = Math.round(a.fx + (a.x - a.fx) * k), ty = Math.round(a.fy + (a.y - a.fy) * k);
        if (tileAt(tx, ty) == Scenery.TALL && (!a.moving || k > 0.3f)) {
            int gx = offX + tx * T, gy = offY + ty * T + 9;
            p.rect(gx, gy, 16, 7, 0xFF58A840);
            for (int i = 0; i < 4; i++) {
                p.rect(gx + i * 4 + 1, gy - 2, 1, 6, 0xFF90D860);
                p.rect(gx + i * 4 + 2, gy, 1, 5, 0xFF387828);
            }
        }
    }

    private void build(Pix p, int mask) {
        cacheMask = mask;
        int vw = cols * T + offX * 2, vh = rows * T + offY * 2;
        cache0 = Bitmap.createBitmap(Math.max(1, vw), Math.max(1, vh), Bitmap.Config.ARGB_8888);
        cache1 = Bitmap.createBitmap(Math.max(1, vw), Math.max(1, vh), Bitmap.Config.ARGB_8888);
        Canvas old = p.c;
        for (int f = 0; f < 2; f++) {
            p.c = new Canvas(f == 0 ? cache0 : cache1);
            for (int y = 0; y < rows; y++) {
                for (int x = 0; x < cols; x++) {
                    int m = map[y][x];
                    Scenery.tile(p, m == HOUSE ? Scenery.GRASS : m, offX + x * T, offY + y * T, f, var[y][x]);
                }
            }
            for (int i = 0; i < SLOTS; i++) {
                if ((mask & (1 << i)) != 0) house(p, i);
                else lot(p, i);
            }
        }
        p.c = old;
    }

    private void house(Pix p, int i) {
        int x = offX + hx[i] * T, y = offY + hy[i] * T;
        int roof = ROOF[i], dark = shade(roof, 60), light = shade(roof, 130);
        // 屋根
        p.rect(x, y + 1, 64, 31, 0xFF383030);
        p.rect(x + 1, y + 2, 62, 28, roof);
        p.rect(x + 1, y + 2, 62, 3, light);
        for (int ry = y + 9; ry < y + 30; ry += 6) p.rect(x + 1, ry, 62, 1, dark);
        p.rect(x + 1, y + 29, 62, 2, dark);
        // 看板（アイコンは毎フレーム上に描く）
        p.rect(x + 21, y + 6, 22, 22, 0xFF383030);
        p.rect(x + 22, y + 7, 20, 20, 0xFFF8F8F0);
        // 壁
        p.rect(x + 3, y + 32, 58, 16, 0xFF504030);
        p.rect(x + 4, y + 32, 56, 15, 0xFFF0E0B8);
        p.rect(x + 4, y + 44, 56, 3, 0xFFD0B888);
        int dx = offX + doorX[i] * T;
        // 窓
        for (int wx : new int[]{x + 6, x + 46}) {
            if (wx + 12 > dx && wx < dx + 16) continue;
            p.rect(wx, y + 35, 12, 8, 0xFF504030);
            p.rect(wx + 1, y + 36, 10, 6, 0xFF88C8F0);
            p.rect(wx + 1, y + 36, 4, 2, 0xFFD8F0F8);
        }
        // ドア
        p.rect(dx + 1, y + 33, 14, 15, 0xFF504030);
        p.rect(dx + 2, y + 34, 12, 14, 0xFF986030);
        p.rect(dx + 2, y + 34, 12, 2, 0xFFB87840);
        p.rect(dx + 11, y + 41, 2, 2, 0xFFF8D030);
    }

    private void lot(Pix p, int i) {
        int x = offX + hx[i] * T, y = offY + hy[i] * T;
        int dx = offX + doorX[i] * T;
        p.rect(x + 2, y + 10, 60, 36, 0xFFD8C090);
        for (int k = 0; k < 6; k++) p.rect(x + 8 + k * 9, y + 16 + (k * 7) % 22, 2, 1, 0xFF98A058);
        // さく
        int post = 0xFF805028, rail = 0xFFB07840;
        p.rect(x + 1, y + 12, 62, 2, rail);
        p.rect(x + 1, y + 40, dx - x - 1, 2, rail);
        p.rect(dx + 16, y + 40, x + 63 - dx - 16, 2, rail);
        p.rect(x + 1, y + 12, 2, 32, rail);
        p.rect(x + 61, y + 12, 2, 32, rail);
        for (int px = x + 1; px < x + 64; px += 10) {
            if (px >= dx && px < dx + 16) continue;
            p.rect(px, y + 10, 3, 6, post);
            p.rect(px, y + 38, 3, 8, post);
        }
        // 立て札
        int sx = dx + 2, sy = y + 18;
        p.rect(sx + 5, sy + 10, 2, 12, post);
        p.rect(sx - 1, sy - 1, 14, 12, 0xFF503018);
        p.rect(sx, sy, 12, 10, 0xFFE0B870);
        p.rect(sx + 4, sy + 2, 4, 1, 0xFF503018);
        p.rect(sx + 7, sy + 3, 1, 2, 0xFF503018);
        p.rect(sx + 5, sy + 5, 2, 1, 0xFF503018);
        p.rect(sx + 5, sy + 7, 2, 1, 0xFF503018);
    }

    private static int shade(int c, int pct) {
        int r = Math.min(255, ((c >> 16) & 255) * pct / 100), g = Math.min(255, ((c >> 8) & 255) * pct / 100),
                b = Math.min(255, (c & 255) * pct / 100);
        return 0xFF000000 | (r << 16) | (g << 8) | b;
    }
}
