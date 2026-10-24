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

    public int getWidth() { return img.getWidth(); }

    public int getHeight() { return img.getHeight(); }

    public void setPixel(int x, int y, int c) { img.setRGB(x, y, c); }

    public int getPixel(int x, int y) { return img.getRGB(x, y); }
}
