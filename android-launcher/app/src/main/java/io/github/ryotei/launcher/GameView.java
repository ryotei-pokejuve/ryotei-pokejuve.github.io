package io.github.ryotei.launcher;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.SystemClock;
import android.view.MotionEvent;
import android.view.View;

/** 低解像度のフレームバッファにEngineを描かせ、整数倍に拡大して画面に出すView。 */
final class GameView extends View {
    private static final long FRAME_MS = 33;

    private final Engine engine;
    private final Paint blit = new Paint();
    private final Rect dst = new Rect();
    private Bitmap fb;
    private Canvas fbc;
    private int scale = 1, offX, offY;
    private boolean running;

    private final Runnable tick = new Runnable() {
        @Override
        public void run() {
            if (!running) return;
            invalidate();
            postDelayed(this, FRAME_MS);
        }
    };

    GameView(Context context, Engine engine) {
        super(context);
        this.engine = engine;
        blit.setFilterBitmap(false);
        blit.setAntiAlias(false);
    }

    void setRunning(boolean run) {
        if (run == running) return;
        running = run;
        removeCallbacks(tick);
        if (run) post(tick);
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        if (w <= 0 || h <= 0) return;
        scale = Math.max(2, Math.round(w / 270f));
        int vw = w / scale, vh = h / scale;
        fb = Bitmap.createBitmap(vw, vh, Bitmap.Config.ARGB_8888);
        fbc = new Canvas(fb);
        offX = (w - vw * scale) / 2;
        offY = (h - vh * scale) / 2;
        dst.set(offX, offY, offX + vw * scale, offY + vh * scale);
        engine.resize(vw, vh);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        if (fb == null) return;
        engine.frame(fbc, SystemClock.uptimeMillis());
        canvas.drawColor(0xFF000000);
        canvas.drawBitmap(fb, null, dst, blit);
    }

    @Override
    public boolean onTouchEvent(MotionEvent e) {
        int action;
        switch (e.getActionMasked()) {
            case MotionEvent.ACTION_DOWN:
                action = 0;
                break;
            case MotionEvent.ACTION_MOVE:
                action = 1;
                break;
            case MotionEvent.ACTION_UP:
                action = 2;
                break;
            case MotionEvent.ACTION_CANCEL:
                action = 3;
                break;
            default:
                return true;
        }
        int x = (int) ((e.getX() - offX) / scale);
        int y = (int) ((e.getY() - offY) / scale);
        engine.touch(action, x, y, e.getEventTime());
        if (!running) invalidate();
        return true;
    }
}
