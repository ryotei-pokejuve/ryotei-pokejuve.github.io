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

    Font font() {
        Font base = typeface != null ? typeface.font : new Font(Font.MONOSPACED, Font.PLAIN, 12);
        return base.deriveFont(size);
    }

    FontMetrics metrics() {
        SCRATCH.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_OFF);
        SCRATCH.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
        return SCRATCH.getFontMetrics(font());
    }

    public float measureText(String s) { return (float) metrics().getStringBounds(s, SCRATCH).getWidth(); }

    public float ascent() { return -metrics().getAscent(); }
}
