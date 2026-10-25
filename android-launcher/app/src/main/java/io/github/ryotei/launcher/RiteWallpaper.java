package io.github.ryotei.launcher;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.service.wallpaper.WallpaperService;
import android.view.SurfaceHolder;

import java.io.IOException;
import java.io.InputStream;

/** WIREDのライブ壁紙。ランチャーと同じく低解像度に描いて整数倍に拡大する。 */
public final class RiteWallpaper extends WallpaperService {
    @Override
    public WallpaperService.Engine onCreateEngine() {
        return new WiredEngine();
    }

    private final class WiredEngine extends WallpaperService.Engine {
        private static final long FRAME_MS = 66; // 壁紙なので控えめに15fps
        private final Handler handler = new Handler(Looper.getMainLooper());
        private final Paint blit = new Paint();
        private final Rect dst = new Rect();
        private WallpaperScene scene;
        private Bitmap fb;
        private Canvas fbc;
        private boolean visible;
        private final Runnable tick = this::draw;

        WiredEngine() {
            blit.setFilterBitmap(false);
            Typeface font = Typeface.createFromAsset(getAssets(), "fonts/DotGothic16-Regular.ttf");
            Bitmap rite = null;
            try (InputStream in = getAssets().open("images/rite_full.png")) {
                rite = BitmapFactory.decodeStream(in);
            } catch (IOException ignored) {
            }
            scene = new WallpaperScene(new Pix(font), rite);
        }

        @Override
        public void onVisibilityChanged(boolean v) {
            visible = v;
            handler.removeCallbacks(tick);
            if (v) handler.post(tick);
        }

        @Override
        public void onSurfaceChanged(SurfaceHolder holder, int format, int w, int h) {
            super.onSurfaceChanged(holder, format, w, h);
            int scale = Math.max(2, Math.round(w / 270f));
            int vw = w / scale, vh = h / scale;
            fb = Bitmap.createBitmap(vw, vh, Bitmap.Config.ARGB_8888);
            fbc = new Canvas(fb);
            int ox = (w - vw * scale) / 2, oy = (h - vh * scale) / 2;
            dst.set(ox, oy, ox + vw * scale, oy + vh * scale);
            scene.resize(vw, vh);
            handler.removeCallbacks(tick);
            if (visible) handler.post(tick);
        }

        @Override
        public void onSurfaceDestroyed(SurfaceHolder holder) {
            visible = false;
            handler.removeCallbacks(tick);
            super.onSurfaceDestroyed(holder);
        }

        @Override
        public void onDestroy() {
            handler.removeCallbacks(tick);
            super.onDestroy();
        }

        private void draw() {
            if (fb == null) return;
            SurfaceHolder holder = getSurfaceHolder();
            Canvas c = null;
            try {
                c = holder.lockCanvas();
                if (c != null) {
                    scene.frame(fbc, SystemClock.uptimeMillis());
                    c.drawColor(0xFF000000);
                    c.drawBitmap(fb, null, dst, blit);
                }
            } finally {
                if (c != null) holder.unlockCanvasAndPost(c);
            }
            if (visible) handler.postDelayed(tick, FRAME_MS);
        }
    }
}
