package io.github.ryotei.launcher;

/** 2種類の見た目。FIELDは草むらとRPGの白いウィンドウ、CYBERは電脳グリッドと角を落としたパネル。 */
final class Theme {
    final boolean cyber;
    final String name;

    int text, shadow, dim;
    int winOuter, winFrame, winInner, winFill;
    int panelEdge, panelFill, panelHi, panelText, panelShadow;
    int selEdge, selFill, selHi;
    int emptyEdge, emptyFill;
    int cursor, rowSel, rowSelText, tabSel, tabSelText;
    int hpLabel, hpLabelText, barFrame, barBack, hpGreen, hpYellow, hpRed, exp;
    int chip, chipText, accent;

    private Theme(boolean cyber, String name) {
        this.cyber = cyber;
        this.name = name;
    }

    static final Theme FIELD = field();
    static final Theme CYBER = cyber();

    static Theme byName(String name) {
        return "CYBER".equals(name) ? CYBER : FIELD;
    }

    private static Theme field() {
        Theme t = new Theme(false, "FIELD");
        t.text = 0xFF404040;
        t.shadow = 0xFFD0D0C8;
        t.dim = 0xFF8C8C84;
        t.winOuter = 0xFF4C5860;
        t.winFrame = 0xFF78C0D8;
        t.winInner = 0xFF3C88A8;
        t.winFill = 0xFFF8F8F8;
        t.panelEdge = 0xFF284C78;
        t.panelFill = 0xFF4C98D0;
        t.panelHi = 0xFF88C8F0;
        t.panelText = 0xFFF8F8F8;
        t.panelShadow = 0xFF284C78;
        t.selEdge = 0xFF983020;
        t.selFill = 0xFFF07850;
        t.selHi = 0xFFF8B890;
        t.emptyEdge = 0xFF385868;
        t.emptyFill = 0xFF6C9CB0;
        t.cursor = 0xFF404040;
        t.rowSel = 0xFFF8E8B0;
        t.rowSelText = 0xFF404040;
        t.tabSel = 0xFFF8C858;
        t.tabSelText = 0xFF404040;
        t.hpLabel = 0xFF484848;
        t.hpLabelText = 0xFFF8B800;
        t.barFrame = 0xFF484848;
        t.barBack = 0xFF707070;
        t.hpGreen = 0xFF58D080;
        t.hpYellow = 0xFFF8C030;
        t.hpRed = 0xFFF05038;
        t.exp = 0xFF40A8F8;
        t.chip = 0xFFF8D030;
        t.chipText = 0xFF404040;
        t.accent = 0xFFE05030;
        return t;
    }

    private static Theme cyber() {
        Theme t = new Theme(true, "CYBER");
        t.text = 0xFFE8F8FF;
        t.shadow = 0xFF04204A;
        t.dim = 0xFF6CA0C8;
        t.winOuter = 0xFF48E0F8;
        t.winFrame = 0xFF1868A0;
        t.winInner = 0xFF1868A0;
        t.winFill = 0xFF0C2448;
        t.panelEdge = 0xFF30B8E8;
        t.panelFill = 0xFF0E3058;
        t.panelHi = 0xFF1C5890;
        t.panelText = 0xFFE8F8FF;
        t.panelShadow = 0xFF04204A;
        t.selEdge = 0xFFF8A020;
        t.selFill = 0xFF5A3410;
        t.selHi = 0xFFB86818;
        t.emptyEdge = 0xFF1C5070;
        t.emptyFill = 0xFF0A1C34;
        t.cursor = 0xFFF8F8F8;
        t.rowSel = 0xFFF89818;
        t.rowSelText = 0xFF181008;
        t.tabSel = 0xFFF89818;
        t.tabSelText = 0xFF181008;
        t.hpLabel = 0xFF0A1C34;
        t.hpLabelText = 0xFF48E0F8;
        t.barFrame = 0xFF48E0F8;
        t.barBack = 0xFF0A1C34;
        t.hpGreen = 0xFF48F0A0;
        t.hpYellow = 0xFFF8D030;
        t.hpRed = 0xFFF84848;
        t.exp = 0xFF48E0F8;
        t.chip = 0xFFF8D830;
        t.chipText = 0xFF181008;
        t.accent = 0xFFF89818;
        return t;
    }
}
