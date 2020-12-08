package com.unity3d.player;

import android.util.Log;

/* renamed from: com.unity3d.player.e */
final class MyLog {

    /* renamed from: a */
    protected static boolean f151a = false;

    protected static void Log(int i, String str) {
        if (!f151a) {
            if (i == 6) {
                Log.e("Unity", str);
            }
            if (i == 5) {
                Log.w("Unity", str);
            }
        }
    }
}
