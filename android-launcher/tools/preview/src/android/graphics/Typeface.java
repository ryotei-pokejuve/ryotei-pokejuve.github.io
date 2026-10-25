package android.graphics;

import java.awt.Font;
import java.io.File;

public final class Typeface {
    public final Font font;

    private Typeface(Font f) { font = f; }

    public static Typeface fromFont(Font f) {
        return new Typeface(f);
    }

    public static Typeface createFromFile(String path) {
        try {
            return new Typeface(Font.createFont(Font.TRUETYPE_FONT, new File(path)));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
