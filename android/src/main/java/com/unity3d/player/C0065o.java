package com.unity3d.player;

import android.app.Activity;
import android.content.Context;

import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/* renamed from: com.unity3d.player.o */
final class C0065o {
    /* access modifiers changed from: private */

    /* renamed from: a */
    public UnityPlayer f216a = null;
    /* access modifiers changed from: private */

    /* renamed from: b */
    public Context f217b = null;

    /* renamed from: c */
    private C0072a f218c;
    /* access modifiers changed from: private */

    /* renamed from: d */
    public final Semaphore f219d = new Semaphore(0);
    /* access modifiers changed from: private */

    /* renamed from: e */
    public final Lock f220e = new ReentrantLock();
    /* access modifiers changed from: private */

    /* renamed from: f */
    public C0062n f221f = null;
    /* access modifiers changed from: private */

    /* renamed from: g */
    public int f222g = 2;

    /* renamed from: h */
    private boolean f223h = false;
    /* access modifiers changed from: private */

    /* renamed from: i */
    public boolean f224i = false;

    /* renamed from: com.unity3d.player.o$a */
    public interface C0072a {
        /* renamed from: a */
        void mo86a();
    }

    C0065o(UnityPlayer unityPlayer) {
        this.f216a = unityPlayer;
    }

    /* access modifiers changed from: private */
    /* renamed from: d */
    public void m140d() {
        if (this.f221f != null) {
            this.f216a.removeViewFromPlayer(this.f221f);
            this.f224i = false;
            this.f221f.destroyPlayer();
            this.f221f = null;
            if (this.f218c != null) {
                this.f218c.mo86a();
            }
        }
    }

    /* renamed from: a */
    public final void mo215a() {
        this.f220e.lock();
        if (this.f221f != null) {
            if (this.f222g == 0) {
                this.f221f.CancelOnPrepare();
            } else if (this.f224i) {
                this.f223h = this.f221f.mo189a();
                if (!this.f223h) {
                    this.f221f.pause();
                }
            }
        }
        this.f220e.unlock();
    }

    /* renamed from: a */
    public final boolean mo216a(Context context, String str, int i, int i2, int i3, boolean z, long j, long j2, C0072a aVar) {
        this.f220e.lock();
        this.f218c = aVar;
        this.f217b = context;
        this.f219d.drainPermits();
        this.f222g = 2;
        final String str2 = str;
        final int i4 = i;
        final int i5 = i2;
        final int i6 = i3;
        final boolean z2 = z;
        final long j3 = j;
        final long j4 = j2;
        runOnUiThread(new Runnable() {
            public final void run() {
                if (C0065o.this.f221f != null) {
                    MyLog.Log(5, "Video already playing");
                    int unused = C0065o.this.f222g = 2;
                    C0065o.this.f219d.release();
                    return;
                }
                C0062n unused2 = C0065o.this.f221f = new C0062n(C0065o.this.f217b, str2, i4, i5, i6, z2, j3, j4, new C0062n.C0063a() {
                    /* renamed from: a */
                    public final void mo212a(int i) {
                        C0065o.this.f220e.lock();
                        int unused = C0065o.this.f222g = i;
                        if (i == 3 && C0065o.this.f224i) {
                            C0065o.this.runOnUiThread(new Runnable() {
                                public final void run() {
                                    C0065o.this.m140d();
                                    C0065o.this.f216a.resume();
                                }
                            });
                        }
                        if (i != 0) {
                            C0065o.this.f219d.release();
                        }
                        C0065o.this.f220e.unlock();
                    }
                });
                if (C0065o.this.f221f != null) {
                    C0065o.this.f216a.addView(C0065o.this.f221f);
                }
            }
        });
        boolean z3 = false;
        try {
            this.f220e.unlock();
            this.f219d.acquire();
            this.f220e.lock();
            z3 = this.f222g != 2;
        } catch (InterruptedException e) {
        }
        runOnUiThread(new Runnable() {
            public final void run() {
                C0065o.this.f216a.pause();
            }
        });
        if (!z3 || this.f222g == 3) {
            runOnUiThread(new Runnable() {
                public final void run() {
                    C0065o.this.m140d();
                    C0065o.this.f216a.resume();
                }
            });
        } else {
            runOnUiThread(new Runnable() {
                public final void run() {
                    if (C0065o.this.f221f != null) {
                        C0065o.this.f216a.addViewToPlayer(C0065o.this.f221f, true);
                        boolean unused = C0065o.this.f224i = true;
                        C0065o.this.f221f.requestFocus();
                    }
                }
            });
        }
        this.f220e.unlock();
        return z3;
    }

    /* renamed from: b */
    public final void mo217b() {
        this.f220e.lock();
        if (this.f221f != null && this.f224i && !this.f223h) {
            this.f221f.start();
        }
        this.f220e.unlock();
    }

    /* renamed from: c */
    public final void mo218c() {
        this.f220e.lock();
        if (this.f221f != null) {
            this.f221f.updateVideoLayout();
        }
        this.f220e.unlock();
    }

    /* access modifiers changed from: protected */
    public final void runOnUiThread(Runnable runnable) {
        if (this.f217b instanceof Activity) {
            ((Activity) this.f217b).runOnUiThread(runnable);
        } else {
            MyLog.Log(5, "Not running from an Activity; Ignoring execution request...");
        }
    }
}
