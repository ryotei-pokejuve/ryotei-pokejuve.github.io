package android.graphics;

import java.awt.image.BufferedImage;

/** プレビュー専用：android.graphics.Bitmap の必要最小限をjava.awtで再現。 */
public final class Bitmap {
    public enum Config { ARGB_8888 }

    public final BufferedImage img;

    private Bitmap(int w, int h) {
        img = new BufferedImage(w, h, BufferedImage.TYPE_INT_ARGB);
    }

    public static Bitmap createBitmap(int w, int h, Config c) {
        return new Bitmap(w, h);
    }

    public static Bitmap fromImage(BufferedImage src) {
        Bitmap b = new Bitmap(src.getWidth(), src.getHeight());
        b.img.getGraphics().drawImage(src, 0, 0, null);
        return b;
    }

    public static Bitmap createScaledBitmap(Bitmap src, int w, int h, boolean filter) {
        Bitmap b = new Bitmap(w, h);
        java.awt.Graphics2D g = b.img.createGraphics();
        g.setRenderingHint(java.awt.RenderingHints.KEY_INTERPOLATION, filter
                ? java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC : java.awt.RenderingHints.VALUE_INTERPOLATION_NEAREST_NEIGHBOR);
        g.drawImage(src.img.getScaledInstance(w, h, filter ? java.awt.Image.SCALE_AREA_AVERAGING : java.awt.Image.SCALE_FAST), 0, 0, null);
        g.dispose();
        return b;
    }

    public int getWidth() { return img.getWidth(); }

    public int getHeight() { return img.getHeight(); }

    public void setPixel(int x, int y, int c) { img.setRGB(x, y, c); }

    public int getPixel(int x, int y) { return img.getRGB(x, y); }
}
