package com.unity3d.player;

import android.app.Activity;
import android.content.Context;
import android.os.Looper;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

/* renamed from: com.unity3d.player.b */
class C0043b {

    /* renamed from: a */
    protected C0060m f143a = null;

    /* renamed from: b */
    protected C0046d f144b = null;

    /* renamed from: c */
    protected Context f145c = null;

    /* renamed from: d */
    protected String f146d = null;

    /* renamed from: e */
    protected String f147e = "";

    C0043b(String str, C0046d dVar) {
        this.f147e = str;
        this.f144b = dVar;
    }

    /* access modifiers changed from: protected */
    public void reportError(String str) {
        if (this.f144b != null) {
            this.f144b.reportError(this.f147e + " Error [" + this.f146d + "]", str);
        } else {
            MyLog.Log(6, this.f147e + " Error [" + this.f146d + "]: " + str);
        }
    }

    /* access modifiers changed from: protected */
    public void runOnUiThread(Runnable runnable) {
        if (this.f145c instanceof Activity) {
            ((Activity) this.f145c).runOnUiThread(runnable);
        } else {
            MyLog.Log(5, "Not running " + this.f147e + " from an Activity; Ignoring execution request...");
        }
    }

    /* access modifiers changed from: protected */
    public boolean runOnUiThreadWithSync(final Runnable runnable) {
        boolean z = false;
        if (Looper.getMainLooper().getThread() == Thread.currentThread()) {
            runnable.run();
            return true;
        }
        final Semaphore semaphore = new Semaphore(0);
        runOnUiThread(new Runnable() {
            public final void run() {
                try {
                    runnable.run();
                } catch (Exception e) {
                    C0043b.this.reportError("Exception unloading Google VR on UI Thread. " + e.getLocalizedMessage());
                } finally {
                    semaphore.release();
                }
            }
        });
        try {
            if (!semaphore.tryAcquire(4, TimeUnit.SECONDS)) {
                reportError("Timeout waiting for vr state change!");
            } else {
                z = true;
            }
        } catch (InterruptedException e) {
            reportError("Interrupted while trying to acquire sync lock. " + e.getLocalizedMessage());
        }
        return z;
    }
}
