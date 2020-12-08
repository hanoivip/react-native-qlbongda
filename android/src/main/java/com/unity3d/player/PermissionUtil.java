package com.unity3d.player;

import android.os.Build;

/* renamed from: com.unity3d.player.h */
public final class PermissionUtil {

    /* renamed from: a */
    static final boolean f153a = (Build.VERSION.SDK_INT >= 19);

    /* renamed from: b */
    static final boolean f154b = (Build.VERSION.SDK_INT >= 21);

    /* renamed from: c */
    static final boolean f155c;

    /* renamed from: d */
    static final C0045c f156d;

    static {
        boolean z = true;
        if (Build.VERSION.SDK_INT < 23) {
            z = false;
        }
        f155c = z;
        f156d = z ? new PermissionHelper() : null;
    }
}
