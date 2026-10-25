package io.github.ryotei.launcher;

import android.graphics.Bitmap;

/** 主人公のドット絵（16x20、オリジナル）。文字1つが1ドット。タイトル画面とタウンマップのアイコンに使う。 */
final class Sprites {
    private Sprites() {
    }

    /** 色の割り当て：o=線 C=帽子 W=白 H=髪 S=肌 E=目 J=服 P=ズボン B=くつ */
    static final int[] HERO = {0xFF303030, 0xFFF08030, 0xFFF8F8F8, 0xFF583018, 0xFFF8D0A8, 0xFF202020, 0xFF3878D0, 0xFF485060, 0xFFD04030};
    private static final String KEYS = "oCWHSEJPB";

    private static final String[] DOWN = {
            "....oooooooo....",
            "...oCCCCCCCCo...",
            "..oCCCCCCCCCCo..",
            "..oCWWWWWWWWCo..",
            "..oooooooooooo..",
            "..oHSSSSSSSSHo..",
            "..oHSESSSSESHo..",
            "..oHSESSSSESHo..",
            "...oSSSSSSSSo...",
            "...ooSSSSSSoo...",
            "..oJJJJJJJJJJo..",
            ".oSoJJJWWJJJoSo.",
            ".oSoJJJWWJJJoSo.",
            "..ooJJJJJJJJoo..",
    };
    private static final String[] UP = {
            "....oooooooo....",
            "...oCCCCCCCCo...",
            "..oCCCCCCCCCCo..",
            "..oCCCCCCCCCCo..",
            "..oooooooooooo..",
            "..oHHHHHHHHHHo..",
            "..oHHHHHHHHHHo..",
            "..oHHHHHHHHHHo..",
            "...oHHHHHHHHo...",
            "...ooSSSSSSoo...",
            "..oJJJJJJJJJJo..",
            ".oSoJJJJJJJJoSo.",
            ".oSoJJJJJJJJoSo.",
            "..ooJJJJJJJJoo..",
    };
    private static final String[] LEFT = {
            "....oooooooo....",
            "...oCCCCCCCCo...",
            "..oCCCCCCCCCCo..",
            ".oWWWCCCCCCCCo..",
            "oooooooooooooo..",
            "..oSSSHHHHHHHo..",
            "..oESSSHHHHHHo..",
            "..oSSSSHHHHHHo..",
            "...oSSSSHHHHo...",
            "....ooSSSoo.....",
            "...oJJJJJJJo....",
            "...oJJSSJJJo....",
            "...oJJSSJJJo....",
            "...ooJJJJJoo....",
    };
    private static final String[] LEGS_STAND = {
            "...oPPPPPPPPo...",
            "...oPPPooPPPo...",
            "...oPPPooPPPo...",
            "...oBBBooBBBo...",
            "...oooo..oooo...",
            "................",
    };
    private static final String[] LEGS_STEP = {
            "...oPPPPPPPPo...",
            "...oPPPooPPPo...",
            "...oBBBooPPPo...",
            "...ooooo.oBBBo..",
            ".........oooo...",
            "................",
    };
    private static final String[] SIDE_STAND = {
            "....oPPPPPo.....",
            "....oPPPPPo.....",
            "....oPPPPPo.....",
            "....oBBBBBo.....",
            "....ooooooo.....",
            "................",
    };
    private static final String[] SIDE_STEP = {
            "....oPPPPPo.....",
            "...oPPPoPPPo....",
            "..oPPPo.oPPPo...",
            "..oBBBo.oBBBo...",
            "..ooooo.ooooo...",
            "................",
    };

    /** [向き 0=下 1=上 2=左 3=右][コマ 0=立ち 1,2=歩き] */
    static Bitmap[][] actor(int[] pal) {
        Bitmap[][] out = new Bitmap[4][3];
        String[][] bodies = {DOWN, UP, LEFT};
        for (int d = 0; d < 3; d++) {
            boolean side = d == 2;
            out[d][0] = make(bodies[d], side ? SIDE_STAND : LEGS_STAND, pal, false, false);
            out[d][1] = make(bodies[d], side ? SIDE_STEP : LEGS_STEP, pal, false, false);
            out[d][2] = make(bodies[d], side ? SIDE_STEP : LEGS_STEP, pal, false, !side);
        }
        for (int f = 0; f < 3; f++) out[3][f] = make(LEFT, f == 0 ? SIDE_STAND : SIDE_STEP, pal, true, false);
        return out;
    }

    /** タウンマップに置く顔アイコン（16x11、正面の帽子と顔）。 */
    static Bitmap head(int[] pal) {
        Bitmap b = Bitmap.createBitmap(16, 11, Bitmap.Config.ARGB_8888);
        for (int y = 0; y < 11; y++) {
            String row = y < 10 ? DOWN[y] : "....oooooooo....";
            for (int x = 0; x < 16; x++) {
                int k = KEYS.indexOf(row.charAt(x));
                b.setPixel(x, y, k < 0 ? 0 : pal[k]);
            }
        }
        return b;
    }

    private static Bitmap make(String[] body, String[] legs, int[] pal, boolean mirrorAll, boolean mirrorLegs) {
        Bitmap b = Bitmap.createBitmap(16, 20, Bitmap.Config.ARGB_8888);
        for (int y = 0; y < 20; y++) {
            String row = y < body.length ? body[y] : legs[y - body.length];
            boolean mirror = mirrorAll || (mirrorLegs && y >= body.length);
            for (int x = 0; x < 16; x++) {
                char ch = row.charAt(mirror ? 15 - x : x);
                int k = KEYS.indexOf(ch);
                b.setPixel(x, y, k < 0 ? 0 : pal[k]);
            }
        }
        return b;
    }
}
