package android.graphics;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.geom.AffineTransform;
import java.util.ArrayDeque;

public final class Canvas {
    private final Graphics2D g;
    private final ArrayDeque<Object[]> stack = new ArrayDeque<>();

    public Canvas(Bitmap b) {
        g = b.img.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_OFF);
        g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_OFF);
        g.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_NEAREST_NEIGHBOR);
        g.setComposite(AlphaComposite.SrcOver);
    }

    private void color(int c) { g.setColor(new Color(c, true)); }

    public void drawColor(int c) { color(c); g.fillRect(-10000, -10000, 30000, 30000); }

    public void drawRect(float l, float t, float r, float b, Paint p) {
        color(p.color);
        g.fillRect(Math.round(l), Math.round(t), Math.round(r) - Math.round(l), Math.round(b) - Math.round(t));
    }

    public void drawText(String s, float x, float y, Paint p) {
        color(p.color);
        g.setFont(p.font());
        g.drawString(s, x, y);
    }

    public void drawBitmap(Bitmap b, Rect src, Rect dst, Paint p) {
        g.drawImage(b.img, dst.left, dst.top, dst.right, dst.bottom, src.left, src.top, src.right, src.bottom, null);
    }

    public boolean clipRect(int l, int t, int r, int b) { g.clipRect(l, t, r - l, b - t); return true; }

    public int save() { stack.push(new Object[]{g.getTransform(), g.getClip()}); return stack.size(); }

    public void restore() {
        Object[] s = stack.pop();
        g.setTransform((AffineTransform) s[0]);
        g.setClip((Shape) s[1]);
    }
}
