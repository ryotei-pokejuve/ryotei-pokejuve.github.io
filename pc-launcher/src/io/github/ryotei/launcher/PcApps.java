package io.github.ryotei.launcher;

import android.graphics.Bitmap;

import javax.swing.Icon;
import javax.swing.filechooser.FileSystemView;
import java.awt.Color;
import java.awt.Desktop;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

/** Windowsのアプリ一覧（スタートメニュー・デスクトップのショートカット＋ドロップしたもの）と設定の保存。 */
final class PcApps {
    private static final String[] SKIP = {"uninstall", "アンインストール", "readme", "help", "ヘルプ", "website", "web site"};

    private final File settingsFile;
    private final Properties props = new Properties();
    private volatile List<AppEntry> apps = Collections.emptyList();
    private volatile int version;
    private volatile boolean loading;

    PcApps() {
        String appData = System.getenv("APPDATA");
        File dir = appData != null ? new File(appData, "RyoteiWired") : new File(System.getProperty("user.home"), ".ryotei-wired");
        dir.mkdirs();
        settingsFile = new File(dir, "settings.properties");
        try (InputStream in = new FileInputStream(settingsFile)) {
            props.load(new java.io.InputStreamReader(in, StandardCharsets.UTF_8));
        } catch (IOException ignored) {
        }
    }

    // ---- 設定 ----

    synchronized String get(String key, String def) {
        return props.getProperty(key, def);
    }

    synchronized void put(String key, String value) {
        props.setProperty(key, value);
        save();
    }

    private void save() {
        try (OutputStream out = new FileOutputStream(settingsFile)) {
            props.store(new java.io.OutputStreamWriter(out, StandardCharsets.UTF_8), "RYOTEI WIRED");
        } catch (IOException ignored) {
        }
    }

    // ---- アプリ一覧 ----

    List<AppEntry> apps() {
        return apps;
    }

    int version() {
        return version;
    }

    boolean loading() {
        return loading;
    }

    /** 別スレッドでショートカットを集め、アイコンを読む。 */
    void reload() {
        loading = true;
        Thread th = new Thread(() -> {
            List<File> files = new ArrayList<>();
            for (File root : roots()) collect(root, files, 0);
            for (String path : get("custom", "").split("\n")) {
                if (!path.isEmpty() && new File(path).exists()) files.add(new File(path));
            }
            ArrayList<AppEntry> out = new ArrayList<>();
            HashSet<String> seen = new HashSet<>();
            for (File f : files) {
                String label = labelOf(f);
                if (!seen.add(label.toLowerCase(Locale.ROOT))) continue;
                out.add(entry(f, label));
            }
            Collator col = Collator.getInstance(Locale.JAPANESE);
            out.sort((a, b) -> col.compare(a.label, b.label));
            apps = out;
            version++;
            loading = false;
        }, "app-scan");
        th.setDaemon(true);
        th.start();
    }

    private static List<File> roots() {
        List<File> r = new ArrayList<>();
        String programData = System.getenv("ProgramData"), appData = System.getenv("APPDATA");
        String userProfile = System.getenv("USERPROFILE"), publicDir = System.getenv("PUBLIC");
        if (programData != null) r.add(new File(programData, "Microsoft\\Windows\\Start Menu\\Programs"));
        if (appData != null) r.add(new File(appData, "Microsoft\\Windows\\Start Menu\\Programs"));
        if (userProfile != null) r.add(new File(userProfile, "Desktop"));
        if (publicDir != null) r.add(new File(publicDir, "Desktop"));
        return r;
    }

    private static void collect(File dir, List<File> out, int depth) {
        File[] list = dir.listFiles();
        if (list == null || depth > 5) return;
        for (File f : list) {
            String n = f.getName().toLowerCase(Locale.ROOT);
            if (f.isDirectory()) {
                if (!n.equals("startup") && !n.equals("スタートアップ")) collect(f, out, depth + 1);
                continue;
            }
            if (!(n.endsWith(".lnk") || n.endsWith(".url") || n.endsWith(".exe"))) continue;
            boolean skip = false;
            for (String s : SKIP) if (n.contains(s)) skip = true;
            if (!skip) out.add(f);
        }
    }

    private static String labelOf(File f) {
        String n = f.getName();
        int dot = n.lastIndexOf('.');
        return f.isDirectory() || dot <= 0 ? n : n.substring(0, dot);
    }

    private static AppEntry entry(File f, String label) {
        BufferedImage big = icon(f, label);
        return new AppEntry(f.getAbsolutePath(), "", label, scaled(big, 16), scaled(big, 32));
    }

    /** Windowsのアイコンを32x32で取る。取れなければ頭文字の丸いアイコンを作る。 */
    private static BufferedImage icon(File f, String label) {
        BufferedImage img = new BufferedImage(32, 32, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = img.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
        boolean ok = false;
        try {
            Icon ic = FileSystemView.getFileSystemView().getSystemIcon(f, 32, 32);
            if (ic != null && ic.getIconWidth() > 0) {
                if (ic instanceof javax.swing.ImageIcon) {
                    g.drawImage(((javax.swing.ImageIcon) ic).getImage(), 0, 0, 32, 32, null);
                } else {
                    BufferedImage raw = new BufferedImage(ic.getIconWidth(), ic.getIconHeight(), BufferedImage.TYPE_INT_ARGB);
                    Graphics2D rg = raw.createGraphics();
                    ic.paintIcon(null, rg, 0, 0);
                    rg.dispose();
                    g.drawImage(raw, 0, 0, 32, 32, null);
                }
                ok = System.getProperty("os.name", "").toLowerCase(Locale.ROOT).contains("win");
            }
        } catch (RuntimeException ignored) {
        }
        if (!ok) {
            g.setComposite(java.awt.AlphaComposite.Clear);
            g.fillRect(0, 0, 32, 32);
            g.setComposite(java.awt.AlphaComposite.SrcOver);
            float hue = (label.hashCode() & 0xFFFF) / 65535f;
            g.setColor(Color.getHSBColor(hue, 0.5f, 0.85f));
            g.fillOval(2, 2, 28, 28);
            g.setColor(Color.WHITE);
            g.setFont(new java.awt.Font(java.awt.Font.SANS_SERIF, java.awt.Font.BOLD, 16));
            String c = label.isEmpty() ? "?" : label.substring(0, 1).toUpperCase(Locale.ROOT);
            g.drawString(c, 16 - g.getFontMetrics().stringWidth(c) / 2, 22);
        }
        g.dispose();
        return img;
    }

    private static Bitmap scaled(BufferedImage src, int size) {
        BufferedImage out = new BufferedImage(size, size, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = out.createGraphics();
        g.drawImage(src.getScaledInstance(size, size, Image.SCALE_AREA_AVERAGING), 0, 0, null);
        g.dispose();
        return Bitmap.fromImage(out);
    }

    /** ドロップされたファイルを一覧に足して保存する。 */
    synchronized AppEntry add(File f) {
        if (!f.exists()) return null;
        String path = f.getAbsolutePath();
        String custom = get("custom", "");
        if (!("\n" + custom + "\n").contains("\n" + path + "\n")) put("custom", custom.isEmpty() ? path : custom + "\n" + path);
        for (AppEntry a : apps) if (a.pkg.equals(path)) return a;
        AppEntry a = entry(f, labelOf(f));
        ArrayList<AppEntry> next = new ArrayList<>(apps);
        next.add(a);
        Collator col = Collator.getInstance(Locale.JAPANESE);
        next.sort((x, y) -> col.compare(x.label, y.label));
        apps = next;
        version++;
        return a;
    }

    static boolean open(AppEntry a) {
        File f = new File(a.pkg);
        if (!f.exists()) return false;
        try {
            Desktop.getDesktop().open(f);
            return true;
        } catch (IOException | RuntimeException e) {
            return false;
        }
    }

    static void showInFolder(AppEntry a) {
        File f = new File(a.pkg);
        try {
            if (System.getProperty("os.name", "").toLowerCase(Locale.ROOT).contains("win")) {
                new ProcessBuilder("explorer.exe", "/select,", f.getAbsolutePath()).start();
            } else if (f.getParentFile() != null) {
                Desktop.getDesktop().open(f.getParentFile());
            }
        } catch (IOException | RuntimeException ignored) {
        }
    }

    // ---- スタートアップ ----

    private static File startupLink() {
        String appData = System.getenv("APPDATA");
        if (appData == null) return null;
        return new File(appData, "Microsoft\\Windows\\Start Menu\\Programs\\Startup\\RYOTEI WIRED.url");
    }

    static boolean startupEnabled() {
        File f = startupLink();
        return f != null && f.exists();
    }

    /** スタートアップフォルダにショートカット（.url）を置く／消す。 */
    static void setStartup(boolean on) {
        File f = startupLink();
        String exe = System.getProperty("jpackage.app-path");
        if (f == null) return;
        try {
            if (on && exe != null) {
                String url = new File(exe).toURI().toString();
                Files.write(f.toPath(), ("[InternetShortcut]\r\nURL=" + url + "\r\n").getBytes(StandardCharsets.UTF_8));
            } else {
                Files.deleteIfExists(f.toPath());
            }
        } catch (IOException ignored) {
        }
    }
}
