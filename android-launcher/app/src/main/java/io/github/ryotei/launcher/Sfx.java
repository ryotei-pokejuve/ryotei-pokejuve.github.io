package io.github.ryotei.launcher;

import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;

/** 矩形波のピコピコ効果音。音声ファイルは使わず、その場で波形を作る。 */
final class Sfx {
    private static final int RATE = 22050;
    private static final int[][][] PATTERNS = {
            {{1568, 25}},                                   // CURSOR
            {{1047, 35}, {1568, 50}},                       // OK
            {{784, 35}, {523, 50}},                         // CANCEL
            {{1319, 30}, {1760, 35}},                       // MENU
            {{523, 40}, {659, 40}, {784, 40}, {1047, 90}},  // LAUNCH
            {{784, 80}, {988, 80}, {1175, 80}, {1568, 180}},// SAVE
            {{659, 60}, {988, 60}, {1319, 140}},            // START
            {{220, 90}, {196, 120}},                        // ERROR
            {{1047, 70}, {1319, 70}, {1568, 70}, {2093, 200}}, // LEVEL
    };

    private final AudioTrack[] tracks = new AudioTrack[PATTERNS.length];

    Sfx() {
        for (int i = 0; i < PATTERNS.length; i++) {
            try {
                tracks[i] = build(PATTERNS[i]);
            } catch (RuntimeException ignored) {
                tracks[i] = null;
            }
        }
    }

    private static AudioTrack build(int[][] notes) {
        int total = 0;
        for (int[] n : notes) total += RATE * n[1] / 1000;
        short[] pcm = new short[total];
        int pos = 0;
        for (int[] n : notes) {
            int len = RATE * n[1] / 1000;
            double period = RATE / (double) n[0];
            for (int i = 0; i < len; i++) {
                double env = 1.0 - 0.6 * i / len;
                boolean high = (i % period) < period / 2;
                pcm[pos++] = (short) ((high ? 1 : -1) * 4200 * env);
            }
        }
        AudioTrack track = new AudioTrack.Builder()
                .setAudioAttributes(new AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_ASSISTANCE_SONIFICATION)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build())
                .setAudioFormat(new AudioFormat.Builder()
                        .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                        .setSampleRate(RATE)
                        .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                        .build())
                .setBufferSizeInBytes(pcm.length * 2)
                .setTransferMode(AudioTrack.MODE_STATIC)
                .build();
        track.write(pcm, 0, pcm.length);
        return track;
    }

    void play(int id) {
        if (id < 0 || id >= tracks.length || tracks[id] == null) return;
        AudioTrack tr = tracks[id];
        try {
            if (tr.getPlayState() == AudioTrack.PLAYSTATE_PLAYING) tr.stop();
            tr.reloadStaticData();
            tr.play();
        } catch (IllegalStateException ignored) {
        }
    }

    void release() {
        for (AudioTrack tr : tracks) if (tr != null) tr.release();
    }
}
