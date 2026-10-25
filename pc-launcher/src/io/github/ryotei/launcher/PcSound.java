package io.github.ryotei.launcher;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;

/** スマホ版と同じ矩形波のピコピコ音（javax.sound で鳴らす）。 */
final class PcSound {
    private static final int RATE = 22050;
    private static final int[][][] PATTERNS = {
            {{1568, 25}},
            {{1047, 35}, {1568, 50}},
            {{784, 35}, {523, 50}},
            {{1319, 30}, {1760, 35}},
            {{523, 40}, {659, 40}, {784, 40}, {1047, 90}},
            {{784, 80}, {988, 80}, {1175, 80}, {1568, 180}},
            {{659, 60}, {988, 60}, {1319, 140}},
            {{220, 90}, {196, 120}},
            {{1047, 70}, {1319, 70}, {1568, 70}, {2093, 200}},
            {{523, 35}, {698, 35}, {880, 35}, {1175, 35}, {1397, 50}, {1760, 90}},
    };
    private final Clip[] clips = new Clip[PATTERNS.length];

    PcSound() {
        for (int i = 0; i < PATTERNS.length; i++) {
            try {
                byte[] pcm = pcm(PATTERNS[i]);
                Clip c = AudioSystem.getClip();
                c.open(new AudioFormat(RATE, 16, 1, true, false), pcm, 0, pcm.length);
                clips[i] = c;
            } catch (Exception | LinkageError e) {
                clips[i] = null;
            }
        }
    }

    private static byte[] pcm(int[][] notes) {
        int total = 0;
        for (int[] n : notes) total += RATE * n[1] / 1000;
        byte[] out = new byte[total * 2];
        int pos = 0;
        for (int[] n : notes) {
            int len = RATE * n[1] / 1000;
            double period = RATE / (double) n[0];
            for (int i = 0; i < len; i++) {
                double env = 1.0 - 0.6 * i / len;
                short v = (short) (((i % period) < period / 2 ? 1 : -1) * 3600 * env);
                out[pos++] = (byte) v;
                out[pos++] = (byte) (v >> 8);
            }
        }
        return out;
    }

    void play(int id) {
        if (id < 0 || id >= clips.length || clips[id] == null) return;
        Clip c = clips[id];
        c.stop();
        c.setFramePosition(0);
        c.start();
    }
}
