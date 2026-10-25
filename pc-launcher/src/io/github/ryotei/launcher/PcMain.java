package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Typeface;

import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.Timer;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.datatransfer.DataFlavor;
import java.awt.dnd.DnDConstants;
import java.awt.dnd.DropTarget;
import java.awt.dnd.DropTargetDropEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseWheelEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.io.InputStream;
import java.util.List;

/** Windows版WIREDランチャーの入口。枠なしの全画面ウィンドウに、低解像度で描いて整数倍に拡大する。 */
public final class PcMain implements PcHost {
    private final PcApps apps = new PcApps();
    private final PcSound sound = new PcSound();
    private JFrame frame;
    private JTextField field;
    private Canvas2D view;
    private PcEngine engine;
    private boolean ignoreField;

    public static void main(String[] args) {
        System.setProperty("sun.java2d.uiScale", "1");
        SwingUtilities.invokeLater(() -> new PcMain().start());
    }

    private static Bitmap image(String path) {
        try (InputStream in = PcMain.class.getResourceAsStream("/" + path)) {
            return in == null ? null : Bitmap.fromImage(ImageIO.read(in));
        } catch (Exception e) {
            return null;
        }
    }

    private void start() {
        Typeface font;
        try (InputStream in = PcMain.class.getResourceAsStream("/fonts/DotGothic16-Regular.ttf")) {
            font = Typeface.fromFont(Font.createFont(Font.TRUETYPE_FONT, in));
        } catch (Exception e) {
            font = Typeface.fromFont(new Font(Font.MONOSPACED, Font.PLAIN, 16));
        }
        engine = new PcEngine(this, new Pix(font), image("images/rite_full.png"), image("images/rite_bust.png"));
        apps.reload();

        frame = new JFrame("RYOTEI WIRED");
        frame.setUndecorated(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        try (InputStream in = PcMain.class.getResourceAsStream("/icon.png")) {
            if (in != null) frame.setIconImage(ImageIO.read(in));
        } catch (Exception ignored) {
        }
        Rectangle area = GraphicsEnvironment.getLocalGraphicsEnvironment().getMaximumWindowBounds();
        frame.setBounds(area);
        frame.setLayout(null);

        view = new Canvas2D();
        view.setBounds(0, 0, area.width, area.height);
        field = new JTextField();
        // 左下の目立たない所に細く置いて、日本語入力（変換の候補窓）だけ受け取る。表示はEngineが自前で描く
        field.setBounds(0, area.height - 2, 240, 2);
        field.setBorder(null);
        field.setOpaque(false);
        field.setForeground(new java.awt.Color(0, 0, 0, 0));
        field.setCaretColor(new java.awt.Color(0, 0, 0, 0));
        field.getDocument().addDocumentListener(new DocumentListener() {
            private void changed() {
                if (!ignoreField) engine.setQuery(field.getText());
            }

            @Override
            public void insertUpdate(DocumentEvent e) {
                changed();
            }

            @Override
            public void removeUpdate(DocumentEvent e) {
                changed();
            }

            @Override
            public void changedUpdate(DocumentEvent e) {
                changed();
            }
        });
        field.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_ESCAPE) engine.escape();
                else if (e.getKeyCode() == KeyEvent.VK_ENTER) engine.submitSearch();
            }
        });
        frame.add(field);
        frame.add(view);
        frame.addWindowListener(new WindowAdapter() {
            @Override
            public void windowActivated(WindowEvent e) {
                engine.onResume();
            }

            @Override
            public void windowDeiconified(WindowEvent e) {
                engine.onResume();
            }
        });
        frame.setVisible(true);
        view.requestFocusInWindow();
        new Timer(33, e -> view.repaint()).start();
    }

    /** 描画とマウス・キーボードを受け持つ面。 */
    private final class Canvas2D extends JPanel {
        private Bitmap fb;
        private Canvas fbc;
        private int scale = 3, ox, oy;

        Canvas2D() {
            setFocusable(true);
            setBackground(java.awt.Color.BLACK);
            MouseAdapter m = new MouseAdapter() {
                @Override
                public void mousePressed(MouseEvent e) {
                    requestFocusInWindow();
                    if (SwingUtilities.isRightMouseButton(e)) engine.secondary(vx(e), vy(e));
                    else engine.touch(0, vx(e), vy(e), System.currentTimeMillis());
                }

                @Override
                public void mouseDragged(MouseEvent e) {
                    engine.touch(1, vx(e), vy(e), System.currentTimeMillis());
                }

                @Override
                public void mouseMoved(MouseEvent e) {
                    engine.touch(1, vx(e), vy(e), System.currentTimeMillis());
                }

                @Override
                public void mouseReleased(MouseEvent e) {
                    if (!SwingUtilities.isRightMouseButton(e)) engine.touch(2, vx(e), vy(e), System.currentTimeMillis());
                }

                @Override
                public void mouseWheelMoved(MouseWheelEvent e) {
                    engine.wheel(e.getWheelRotation());
                }
            };
            addMouseListener(m);
            addMouseMotionListener(m);
            addMouseWheelListener(m);
            addKeyListener(new KeyAdapter() {
                @Override
                public void keyPressed(KeyEvent e) {
                    switch (e.getKeyCode()) {
                        case KeyEvent.VK_ESCAPE:
                            engine.escape();
                            break;
                        case KeyEvent.VK_LEFT:
                            engine.arrow(-1);
                            break;
                        case KeyEvent.VK_RIGHT:
                            engine.arrow(1);
                            break;
                        default:
                    }
                }

                @Override
                public void keyTyped(KeyEvent e) {
                    char c = e.getKeyChar();
                    if (c > ' ' && c != KeyEvent.CHAR_UNDEFINED && !e.isControlDown() && !e.isAltDown()) engine.typed(c);
                }
            });
            new DropTarget(this, DnDConstants.ACTION_COPY, null) {
                @Override
                @SuppressWarnings("unchecked")
                public synchronized void drop(DropTargetDropEvent e) {
                    try {
                        e.acceptDrop(DnDConstants.ACTION_COPY);
                        List<File> files = (List<File>) e.getTransferable().getTransferData(DataFlavor.javaFileListFlavor);
                        java.awt.Point pt = e.getLocation();
                        engine.drop(files, (pt.x - ox) / scale, (pt.y - oy) / scale);
                        e.dropComplete(true);
                    } catch (Exception ex) {
                        e.dropComplete(false);
                    }
                }
            };
        }

        private int vx(MouseEvent e) {
            return (e.getX() - ox) / scale;
        }

        private int vy(MouseEvent e) {
            return (e.getY() - oy) / scale;
        }

        @Override
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);
            int w = getWidth(), h = getHeight();
            if (w <= 0 || h <= 0) return;
            int s = Math.max(2, Math.round(h / 360f));
            int vw = w / s, vh = h / s;
            if (fb == null || fb.getWidth() != vw || fb.getHeight() != vh) {
                scale = s;
                fb = Bitmap.createBitmap(vw, vh, Bitmap.Config.ARGB_8888);
                fbc = new Canvas(fb);
                ox = (w - vw * s) / 2;
                oy = (h - vh * s) / 2;
                engine.resize(vw, vh);
            }
            engine.frame(fbc, System.currentTimeMillis());
            Graphics2D g2 = (Graphics2D) g;
            g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_NEAREST_NEIGHBOR);
            g2.drawImage(fb.img, ox, oy, vw * scale, vh * scale, null);
        }
    }

    // ================================================================ PcHost

    @Override
    public List<AppEntry> apps() {
        return apps.apps();
    }

    @Override
    public int appsVersion() {
        return apps.version();
    }

    @Override
    public boolean appsLoading() {
        return apps.loading();
    }

    @Override
    public boolean launch(AppEntry app) {
        return PcApps.open(app);
    }

    @Override
    public void showInFolder(AppEntry app) {
        PcApps.showInFolder(app);
    }

    @Override
    public AppEntry addFile(File file) {
        return apps.add(file);
    }

    @Override
    public String get(String key, String def) {
        return apps.get(key, def);
    }

    @Override
    public void put(String key, String value) {
        apps.put(key, value);
    }

    @Override
    public int getInt(String key, int def) {
        try {
            return Integer.parseInt(apps.get(key, String.valueOf(def)));
        } catch (NumberFormatException e) {
            return def;
        }
    }

    @Override
    public void putInt(String key, int value) {
        apps.put(key, String.valueOf(value));
    }

    @Override
    public long getLong(String key, long def) {
        try {
            return Long.parseLong(apps.get(key, String.valueOf(def)));
        } catch (NumberFormatException e) {
            return def;
        }
    }

    @Override
    public void putLong(String key, long value) {
        apps.put(key, String.valueOf(value));
    }

    @Override
    public long now() {
        return System.currentTimeMillis();
    }

    @Override
    public void sfx(int id) {
        if (getInt("sound", 1) == 1) sound.play(id);
    }

    @Override
    public void searchField(boolean on, String initial) {
        if (on) {
            if (initial != null) {
                ignoreField = true;
                field.setText(initial);
                ignoreField = false;
            }
            field.requestFocusInWindow();
            field.setCaretPosition(field.getText().length());
        } else {
            ignoreField = true;
            field.setText("");
            ignoreField = false;
            view.requestFocusInWindow();
        }
    }

    @Override
    public void minimize() {
        frame.setState(JFrame.ICONIFIED);
    }

    @Override
    public void quit() {
        System.exit(0);
    }

    @Override
    public boolean startupEnabled() {
        return PcApps.startupEnabled();
    }

    @Override
    public void setStartup(boolean on) {
        PcApps.setStartup(on);
    }
}
