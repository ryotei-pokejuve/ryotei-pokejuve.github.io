package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Typeface;

import java.util.HashMap;

/** 低解像度キャンバスにドット単位で描くための小さな道具箱。アンチエイリアスは常にオフ。 */
final class Pix {
    static final int LINE = 16;

    Canvas c;
    final int ascent;
    private final Paint fill = new Paint();
    private final Paint font = new Paint();
    private final Paint blit = new Paint();
    private final Rect src = new Rect();
    private final Rect dst = new Rect();
    private final HashMap<String, Bitmap> bigCache = new HashMap<>();

    Pix(Typeface typeface) {
        fill.setAntiAlias(false);
        font.setAntiAlias(false);
        font.setTypeface(typeface);
        font.setTextSize(16);
        blit.setFilterBitmap(false);
        // フォントのメトリクスは環境で差が出るので、DotGothic16の設計値（16ドット中14ドット目がベースライン）に固定
        ascent = 13;
    }

    void rect(int x, int y, int w, int h, int color) {
        if (w <= 0 || h <= 0) return;
        fill.setColor(color);
        c.drawRect(x, y, x + w, y + h, fill);
    }

    /** 角を2ドット丸めた四角。 */
    void round(int x, int y, int w, int h, int color) {
        rect(x + 2, y, w - 4, 1, color);
        rect(x + 1, y + 1, w - 2, 1, color);
        rect(x, y + 2, w, h - 4, color);
        rect(x + 1, y + h - 2, w - 2, 1, color);
        rect(x + 2, y + h - 1, w - 4, 1, color);
    }

    /** 角をkドット斜めに落とした四角。 */
    void chamfer(int x, int y, int w, int h, int k, int color) {
        for (int i = 0; i < k; i++) {
            rect(x + k - i, y + i, w - 2 * (k - i), 1, color);
            rect(x + k - i, y + h - 1 - i, w - 2 * (k - i), 1, color);
        }
        rect(x, y + k, w, h - 2 * k, color);
    }

    int width(String s) {
        return (int) Math.ceil(font.measureText(s));
    }

    /** 文字を描く。shadowが0でなければ右・下・右下に影を落とす（GBAのRPGっぽい文字）。 */
    void text(String s, int x, int y, int color, int shadow) {
        int base = y + ascent;
        if (shadow != 0) {
            font.setColor(shadow);
            c.drawText(s, x + 1, base, font);
            c.drawText(s, x, base + 1, font);
            c.drawText(s, x + 1, base + 1, font);
        }
        font.setColor(color);
        c.drawText(s, x, base, font);
    }

    void textRight(String s, int right, int y, int color, int shadow) {
        text(s, right - width(s), y, color, shadow);
    }

    void textCenter(String s, int cx, int y, int color, int shadow) {
        text(s, cx - width(s) / 2, y, color, shadow);
    }

    /** 幅に収まらなければ末尾を…にする。 */
    String fit(String s, int maxW) {
        if (width(s) <= maxW) return s;
        String t = s;
        while (t.length() > 0 && width(t + "…") > maxW) t = t.substring(0, t.length() - 1);
        return t + "…";
    }

    /** 幅に収まらない文字は、少し止まってから横に流して最後まで見せる（選んでいる項目の名前用）。 */
    void marquee(String s, int x, int y, int maxW, int color, int shadow, long t) {
        int w = width(s);
        if (w <= maxW) {
            text(s, x, y, color, shadow);
            return;
        }
        int over = w - maxW, scrollMs = over * 30, period = 1400 + scrollMs + 1400;
        long ph = t % period;
        int off = ph < 1400 ? 0 : ph < 1400 + scrollMs ? (int) ((ph - 1400) / 30) : over;
        c.save();
        c.clipRect(x, y - 2, x + maxW, y + LINE + 3);
        text(s, x - off, y, color, shadow);
        c.restore();
    }

    /** 文字をscale倍のドットで描く（時計やタイトル用）。 */
    void big(String s, int x, int y, int scale, int color, int shadow) {
        String key = s + '|' + color + '|' + shadow;
        Bitmap b = bigCache.get(key);
        if (b == null) {
            if (bigCache.size() > 32) bigCache.clear();
            b = Bitmap.createBitmap(width(s) + 2, LINE + 3, Bitmap.Config.ARGB_8888);
            Canvas old = c;
            c = new Canvas(b);
            text(s, 0, 0, color, shadow);
            c = old;
            bigCache.put(key, b);
        }
        image(b, x, y, b.getWidth() * scale, b.getHeight() * scale);
    }

    int bigWidth(String s, int scale) {
        return (width(s) + 1) * scale;
    }

    void image(Bitmap b, int x, int y, int w, int h) {
        src.set(0, 0, b.getWidth(), b.getHeight());
        dst.set(x, y, x + w, y + h);
        c.drawBitmap(b, src, dst, blit);
    }

    /** 画像の一部（sx,sy,sw,sh）を等倍で (x,y) に描く。alpha は 0〜255。 */
    void imagePart(Bitmap b, int sx, int sy, int sw, int sh, int x, int y, int alpha) {
        src.set(sx, sy, sx + sw, sy + sh);
        dst.set(x, y, x + sw, y + sh);
        blit.setAlpha(alpha);
        c.drawBitmap(b, src, dst, blit);
        blit.setAlpha(255);
    }

    /** ▶ 型のカーソル（幅4・高さ7）。 */
    void arrowRight(int x, int y, int color) {
        for (int i = 0; i < 4; i++) {
            rect(x, y + i, i + 1, 1, color);
            rect(x, y + 6 - i, i + 1, 1, color);
        }
    }

    /** ◀ 型（幅4・高さ7）。 */
    void arrowLeft(int x, int y, int color) {
        for (int i = 0; i < 4; i++) {
            rect(x + 3 - i, y + i, i + 1, 1, color);
            rect(x + 3 - i, y + 6 - i, i + 1, 1, color);
        }
    }

    /** ▼ 型（幅7・高さ4）。 */
    void arrowDown(int x, int y, int color) {
        for (int i = 0; i < 4; i++) rect(x + i, y + i, 7 - 2 * i, 1, color);
    }

    /** ▲ 型（幅7・高さ4）。 */
    void arrowUp(int x, int y, int color) {
        for (int i = 0; i < 4; i++) rect(x + 3 - i, y + i, 2 * i + 1, 1, color);
    }
}
