package io.github.ryotei.launcher;

import android.graphics.Bitmap;

/** ホームに並べる1アプリ分の情報。アイコンはGBA風に減色済みのドット絵。 */
final class AppEntry {
    final String key;
    final String pkg;
    final String cls;
    final String label;
    final Bitmap icon16;
    final Bitmap icon32;
    /** チップコード風の1文字（英字は大文字、かなはひらがな、それ以外は*）。 */
    final String code;

    AppEntry(String pkg, String cls, String label, Bitmap icon16, Bitmap icon32) {
        this.pkg = pkg;
        this.cls = cls;
        this.key = pkg + "/" + cls;
        this.label = label;
        this.icon16 = icon16;
        this.icon32 = icon32;
        this.code = codeOf(label);
    }

    static String codeOf(String label) {
        if (label == null || label.isEmpty()) return "*";
        char ch = label.charAt(0);
        if (ch >= 'a' && ch <= 'z') return String.valueOf((char) (ch - 32));
        if ((ch >= 'A' && ch <= 'Z') || (ch >= '0' && ch <= '9')) return String.valueOf(ch);
        if (ch >= 'ァ' && ch <= 'ヶ') ch = (char) (ch - 0x60);
        if (ch >= 'ぁ' && ch <= 'ゖ') return String.valueOf(ch);
        return "*";
    }
}
