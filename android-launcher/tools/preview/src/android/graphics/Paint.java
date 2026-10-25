package android.graphics;

import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;

public final class Paint {
    private static final Graphics2D SCRATCH = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB).createGraphics();
    int color = 0xFF000000;
    int alpha = 255;
    float size = 12;
    Typeface typeface;

    public void setAntiAlias(boolean b) {}

    public void setFilterBitmap(boolean b) {}

    public void setColor(int c) { color = c; }

    public void setAlpha(int a) { alpha = a; }

    public void setTextSize(float s) { size = s; }

    public void setTypeface(Typeface t) { typeface = t; }

    private Font cachedFont;
    private FontMetrics cachedMetrics;
    private Typeface cachedFace;
    private float cachedSize = -1;
    private final java.util.HashMap<String, Float> widths = new java.util.HashMap<>();

    Font font() {
        if (cachedFont == null || cachedFace != typeface || cachedSize != size) {
            Font base = typeface != null ? typeface.font : new Font(Font.MONOSPACED, Font.PLAIN, 12);
            cachedFont = base.deriveFont(size);
            cachedFace = typeface;
            cachedSize = size;
            cachedMetrics = null;
            widths.clear();
        }
        return cachedFont;
    }

    FontMetrics metrics() {
        Font f = font();
        if (cachedMetrics == null) {
            SCRATCH.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_OFF);
            SCRATCH.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
            cachedMetrics = SCRATCH.getFontMetrics(f);
        }
        return cachedMetrics;
    }

    public float measureText(String s) {
        FontMetrics m = metrics();
        Float w = widths.get(s);
        if (w == null) {
            if (widths.size() > 4000) widths.clear();
            w = (float) m.getStringBounds(s, SCRATCH).getWidth();
            widths.put(s, w);
        }
        return w;
    }

    public float ascent() { return -metrics().getAscent(); }
}
