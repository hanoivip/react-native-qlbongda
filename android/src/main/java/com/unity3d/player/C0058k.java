package com.unity3d.player;

import android.os.Build;
import java.lang.Thread;

/* renamed from: com.unity3d.player.k */
final class C0058k implements Thread.UncaughtExceptionHandler {

    /* renamed from: a */
    private volatile Thread.UncaughtExceptionHandler f175a;

    C0058k() {
    }

    /* access modifiers changed from: package-private */
    /* renamed from: a */
    public final synchronized boolean mo176a() {
        boolean z;
        Thread.UncaughtExceptionHandler defaultUncaughtExceptionHandler = Thread.getDefaultUncaughtExceptionHandler();
        if (defaultUncaughtExceptionHandler == this) {
            z = false;
        } else {
            this.f175a = defaultUncaughtExceptionHandler;
            Thread.setDefaultUncaughtExceptionHandler(this);
            z = true;
        }
        return z;
    }

    public final synchronized void uncaughtException(Thread thread, Throwable th) {
        try {
            Error error = new Error(String.format("FATAL EXCEPTION [%s]\n", new Object[]{thread.getName()}) + String.format("Unity version     : %s\n", new Object[]{"2017.4.35f1"}) + String.format("Device model      : %s %s\n", new Object[]{Build.MANUFACTURER, Build.MODEL}) + String.format("Device fingerprint: %s\n", new Object[]{Build.FINGERPRINT}));
            error.setStackTrace(new StackTraceElement[0]);
            error.initCause(th);
            this.f175a.uncaughtException(thread, error);
        } catch (Throwable th2) {
            this.f175a.uncaughtException(thread, th);
        }
        return;
    }
}
