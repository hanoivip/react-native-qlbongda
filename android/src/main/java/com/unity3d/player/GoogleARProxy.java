package com.unity3d.player;

import android.app.Activity;
import android.content.Context;
import android.os.IBinder;
import android.util.Log;

class GoogleARProxy extends C0043b {

    /* renamed from: f */
    private boolean f2f = false;

    GoogleARProxy(C0046d dVar) {
        super("Google AR", dVar);
    }

    /* renamed from: a */
    public static boolean m1a() {
        try {
            Class<?> loadClass = UnityPlayer.class.getClassLoader().loadClass("com.unity3d.unitygar.GoogleAR");
            C0060m mVar = new C0060m(loadClass, loadClass.getConstructor(new Class[0]).newInstance(new Object[0]));
            mVar.mo187a("getClassVersion", new Class[0]);
            if (((Number) mVar.mo186a("getClassVersion", new Object[0])).intValue() > 0) {
                Log.d("Unity", "Loading ARCore V1+ path.");
                return false;
            }
            Log.d("Unity", "Loading ARCore Preview path (Version <= 1).");
            return true;
        } catch (Exception e) {
            Log.d("Unity", "Loading ARCore Preview path.");
            return true;
        }
    }

    /* renamed from: a */
    private boolean m2a(ClassLoader classLoader) {
        if (this.f2f) {
            return true;
        }
        try {
            Class<?> loadClass = classLoader.loadClass("com.unity3d.unitygar.GoogleAR");
            C0060m mVar = new C0060m(loadClass, loadClass.getConstructor(new Class[0]).newInstance(new Object[0]));
            mVar.mo187a("initialize", new Class[]{Activity.class});
            mVar.mo187a("create", new Class[0]);
            mVar.mo187a("pause", new Class[0]);
            mVar.mo187a("resume", new Class[0]);
            this.f143a = mVar;
            this.f2f = true;
            return true;
        } catch (Exception e) {
            this.f144b.reportError("Google AR Error", e.toString() + e.getLocalizedMessage());
            return false;
        }
    }

    private final native void tangoOnCreate(Activity activity);

    private final native void tangoOnServiceConnected(IBinder iBinder);

    private final native void tangoOnStop();

    /* access modifiers changed from: package-private */
    /* renamed from: a */
    public final void mo7a(final Activity activity, Context context) {
        if (m2a(UnityPlayer.class.getClassLoader())) {
            this.f145c = context;
            runOnUiThread(new Runnable() {
                public final void run() {
                    try {
                        if (GoogleARProxy.this.f143a != null) {
                            GoogleARProxy.this.f143a.mo186a("initialize", activity);
                        }
                    } catch (Exception e) {
                        GoogleARProxy.this.reportError("Exception creating " + GoogleARProxy.this.f147e + " VR on UI Thread. " + e.getLocalizedMessage());
                    }
                }
            });
        }
    }

    /* access modifiers changed from: package-private */
    /* renamed from: b */
    public final void mo8b() {
        runOnUiThread(new Runnable() {
            public final void run() {
                try {
                    if (GoogleARProxy.this.f143a != null) {
                        GoogleARProxy.this.f143a.mo186a("create", new Object[0]);
                    }
                } catch (Exception e) {
                    GoogleARProxy.this.reportError("Exception creating " + GoogleARProxy.this.f147e + " VR on UI Thread. " + e.getLocalizedMessage());
                }
            }
        });
    }

    /* access modifiers changed from: package-private */
    /* renamed from: c */
    public final void mo9c() {
        runOnUiThread(new Runnable() {
            public final void run() {
                try {
                    if (GoogleARProxy.this.f143a != null) {
                        GoogleARProxy.this.f143a.mo186a("pause", new Object[0]);
                    }
                } catch (Exception e) {
                    GoogleARProxy.this.reportError("Exception pausing " + GoogleARProxy.this.f147e + " VR on UI Thread. " + e.getLocalizedMessage());
                }
            }
        });
    }

    /* access modifiers changed from: package-private */
    /* renamed from: d */
    public final void mo10d() {
        runOnUiThread(new Runnable() {
            public final void run() {
                try {
                    if (GoogleARProxy.this.f143a != null) {
                        GoogleARProxy.this.f143a.mo186a("resume", new Object[0]);
                    }
                } catch (Exception e) {
                    GoogleARProxy.this.reportError("Exception resuming " + GoogleARProxy.this.f147e + " VR on UI Thread. " + e.getLocalizedMessage());
                }
            }
        });
    }

    /* renamed from: e */
    public final boolean mo11e() {
        return this.f2f;
    }
}
