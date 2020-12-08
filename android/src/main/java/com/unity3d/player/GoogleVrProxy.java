package com.unity3d.player;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.Surface;
import android.view.SurfaceView;
import android.view.View;
import com.unity3d.player.GoogleVrVideo;
import java.lang.reflect.Array;
import java.util.Iterator;
import java.util.Vector;
import java.util.concurrent.atomic.AtomicLong;

class GoogleVrProxy extends C0043b implements GoogleVrVideo {

    /* renamed from: f */
    private boolean f9f = false;

    /* renamed from: g */
    private boolean f10g = false;
    /* access modifiers changed from: private */

    /* renamed from: h */
    public Runnable f11h = null;
    /* access modifiers changed from: private */

    /* renamed from: i */
    public Vector f12i = new Vector();

    /* renamed from: j */
    private SurfaceView f13j = null;
    /* access modifiers changed from: private */

    /* renamed from: k */
    public C0009a f14k = new C0009a();

    /* renamed from: l */
    private Thread f15l = null;

    /* renamed from: m */
    private Handler f16m = new Handler(Looper.getMainLooper()) {
        public final void handleMessage(Message message) {
            switch (message.what) {
                case 135711:
                    switch (message.arg1) {
                        case 2147483645:
                            Iterator it = GoogleVrProxy.this.f12i.iterator();
                            while (it.hasNext()) {
                                ((GoogleVrVideo.GoogleVrVideoCallbacks) it.next()).onFrameAvailable();
                            }
                            return;
                        case 2147483646:
                            Surface surface = (Surface) message.obj;
                            Iterator it2 = GoogleVrProxy.this.f12i.iterator();
                            while (it2.hasNext()) {
                                ((GoogleVrVideo.GoogleVrVideoCallbacks) it2.next()).onSurfaceAvailable(surface);
                            }
                            return;
                        default:
                            super.handleMessage(message);
                            return;
                    }
                default:
                    super.handleMessage(message);
                    return;
            }
        }
    };

    /* renamed from: com.unity3d.player.GoogleVrProxy$a */
    class C0009a {

        /* renamed from: a */
        public boolean f28a = false;

        /* renamed from: b */
        public boolean f29b = false;

        /* renamed from: c */
        public boolean f30c = false;

        /* renamed from: d */
        public boolean f31d = false;

        /* renamed from: e */
        public boolean f32e = true;

        /* renamed from: f */
        public boolean f33f = false;

        C0009a() {
        }

        /* renamed from: a */
        public final boolean mo35a() {
            return this.f28a && this.f29b;
        }

        /* renamed from: b */
        public final void mo36b() {
            this.f28a = false;
            this.f29b = false;
            this.f31d = false;
            this.f32e = true;
            this.f33f = false;
        }
    }

    public GoogleVrProxy(C0046d dVar) {
        super("Google VR", dVar);
        initVrJni();
    }

    /* access modifiers changed from: private */
    /* renamed from: a */
    public void m13a(boolean z) {
        this.f14k.f31d = z;
    }

    /* renamed from: a */
    private static boolean m14a(int i) {
        return Build.VERSION.SDK_INT >= i;
    }

    /* renamed from: a */
    private boolean m15a(ClassLoader classLoader) {
        try {
            Class<?> loadClass = classLoader.loadClass("com.unity3d.unitygvr.GoogleVR");
            C0060m mVar = new C0060m(loadClass, loadClass.getConstructor(new Class[0]).newInstance(new Object[0]));
            mVar.mo187a("initialize", new Class[]{Activity.class, Context.class, SurfaceView.class, Boolean.TYPE, Handler.class});
            mVar.mo187a("deinitialize", new Class[0]);
            mVar.mo187a("load", new Class[]{Boolean.TYPE, Boolean.TYPE, Boolean.TYPE, Boolean.TYPE, Boolean.TYPE, Runnable.class});
            mVar.mo187a("enable", new Class[]{Boolean.TYPE});
            mVar.mo187a("unload", new Class[0]);
            mVar.mo187a("pause", new Class[0]);
            mVar.mo187a("resume", new Class[0]);
            mVar.mo187a("getGvrLayout", new Class[0]);
            mVar.mo187a("getVideoSurfaceId", new Class[0]);
            mVar.mo187a("getVideoSurface", new Class[0]);
            this.f143a = mVar;
            return true;
        } catch (Exception e) {
            reportError("Exception initializing GoogleVR from Unity library. " + e.getLocalizedMessage());
            return false;
        }
    }

    /* access modifiers changed from: private */
    /* renamed from: d */
    public boolean m18d() {
        return this.f14k.f31d;
    }

    /* renamed from: e */
    private void m20e() {
        Activity activity = (Activity) this.f145c;
        if (this.f10g && !this.f14k.f33f && activity != null) {
            this.f14k.f33f = true;
            Intent intent = new Intent("android.intent.action.MAIN");
            intent.addCategory("android.intent.category.HOME");
            intent.setFlags(268435456);
            activity.startActivity(intent);
        }
    }

    private final native void initVrJni();

    private final native boolean isQuiting();

    private final native void setVrVideoTransform(float[][] fArr);

    /* renamed from: a */
    public final void mo16a(Intent intent) {
        if (intent != null && intent.getBooleanExtra("android.intent.extra.VR_LAUNCH", false)) {
            this.f10g = true;
        }
    }

    /* renamed from: a */
    public final boolean mo17a() {
        return this.f14k.f28a;
    }

    /* renamed from: a */
    public final boolean mo18a(Activity activity, Context context, SurfaceView surfaceView, Runnable runnable) {
        boolean z;
        if (activity == null || context == null || surfaceView == null || runnable == null) {
            reportError("Invalid parameters passed to Google VR initiialization.");
            return false;
        }
        this.f14k.mo36b();
        this.f145c = context;
        this.f11h = runnable;
        if (!m14a(19)) {
            reportError("Google VR requires a device that supports an api version of 19 (KitKat) or better.");
            return false;
        } else if (this.f10g && !m14a(24)) {
            reportError("Daydream requires a device that supports an api version of 24 (Nougat) or better.");
            return false;
        } else if (!m15a(UnityPlayer.class.getClassLoader())) {
            return false;
        } else {
            try {
                z = ((Boolean) this.f143a.mo186a("initialize", activity, context, surfaceView, Boolean.valueOf(this.f10g), this.f16m)).booleanValue();
            } catch (Exception e) {
                reportError("Exception while trying to intialize Unity Google VR Library. " + e.getLocalizedMessage());
                z = false;
            }
            if (!z) {
                reportError("Unable to initialize GoogleVR library.");
                return false;
            }
            this.f13j = surfaceView;
            this.f14k.f28a = true;
            this.f146d = "";
            return true;
        }
    }

    /* renamed from: b */
    public final void mo19b() {
        resumeGvrLayout();
    }

    /* renamed from: c */
    public final void mo20c() {
        if (this.f13j != null) {
            this.f13j.getHolder().setSizeFromLayout();
        }
    }

    public void deregisterGoogleVrVideoListener(GoogleVrVideo.GoogleVrVideoCallbacks googleVrVideoCallbacks) {
        if (this.f12i.contains(googleVrVideoCallbacks)) {
            googleVrVideoCallbacks.onSurfaceUnavailable();
            this.f12i.remove(googleVrVideoCallbacks);
        }
    }

    /* access modifiers changed from: protected */
    public Object getVideoSurface() {
        if (!m18d() || this.f14k.f32e) {
            return null;
        }
        try {
            return this.f143a.mo186a("getVideoSurface", new Object[0]);
        } catch (Exception e) {
            reportError("Exception caught while Getting GoogleVR Video Surface. " + e.getLocalizedMessage());
            return null;
        }
    }

    /* access modifiers changed from: protected */
    public int getVideoSurfaceId() {
        if (!m18d() || this.f14k.f32e) {
            return -1;
        }
        try {
            return ((Integer) this.f143a.mo186a("getVideoSurfaceId", new Object[0])).intValue();
        } catch (Exception e) {
            reportError("Exception caught while getting Video Surface ID from GoogleVR. " + e.getLocalizedMessage());
            return -1;
        }
    }

    /* access modifiers changed from: protected */
    public long loadGoogleVr(boolean z, boolean z2, boolean z3, boolean z4, boolean z5) {
        if (!this.f14k.f28a) {
            return 0;
        }
        final AtomicLong atomicLong = new AtomicLong(0);
        this.f146d = (z || z2) ? "Daydream" : "Cardboard";
        final boolean z6 = z;
        final boolean z7 = z2;
        final boolean z8 = z3;
        final boolean z9 = z4;
        final boolean z10 = z5;
        if (!runOnUiThreadWithSync(new Runnable() {
            public final void run() {
                try {
                    atomicLong.set(((Long) GoogleVrProxy.this.f143a.mo186a("load", Boolean.valueOf(z6), Boolean.valueOf(z7), Boolean.valueOf(z8), Boolean.valueOf(z9), Boolean.valueOf(z10), GoogleVrProxy.this.f11h)).longValue());
                    GoogleVrProxy.this.f14k.f29b = true;
                } catch (Exception e) {
                    GoogleVrProxy.this.reportError("Exception caught while loading GoogleVR. " + e.getLocalizedMessage());
                    atomicLong.set(0);
                }
            }
        }) || atomicLong.longValue() == 0) {
            reportError("Google VR had a fatal issue while loading. VR will not be available.");
        }
        return atomicLong.longValue();
    }

    /* access modifiers changed from: protected */
    public void pauseGvrLayout() {
        if (this.f14k.mo35a() && !this.f14k.f32e) {
            if (m18d()) {
                Iterator it = this.f12i.iterator();
                while (it.hasNext()) {
                    ((GoogleVrVideo.GoogleVrVideoCallbacks) it.next()).onSurfaceUnavailable();
                }
            }
            if (this.f143a != null) {
                this.f143a.mo186a("pause", new Object[0]);
            }
            this.f14k.f32e = true;
        }
    }

    public void registerGoogleVrVideoListener(GoogleVrVideo.GoogleVrVideoCallbacks googleVrVideoCallbacks) {
        if (!this.f12i.contains(googleVrVideoCallbacks)) {
            this.f12i.add(googleVrVideoCallbacks);
            Surface surface = (Surface) getVideoSurface();
            if (surface != null) {
                googleVrVideoCallbacks.onSurfaceAvailable(surface);
            }
        }
    }

    /* access modifiers changed from: protected */
    public void resumeGvrLayout() {
        if (this.f14k.mo35a() && this.f14k.f32e) {
            if (this.f143a != null) {
                this.f143a.mo186a("resume", new Object[0]);
            }
            this.f14k.f32e = false;
        }
    }

    /* access modifiers changed from: protected */
    public void setGoogleVrModeEnabled(final boolean z) {
        if (this.f14k.mo35a() && this.f144b != null && this.f145c != null) {
            if (!z && isQuiting()) {
                m20e();
            }
            runOnUiThread(new Runnable() {
                public final void run() {
                    if (z != GoogleVrProxy.this.m18d()) {
                        try {
                            if (!z || GoogleVrProxy.this.m18d()) {
                                if (!z && GoogleVrProxy.this.m18d()) {
                                    GoogleVrProxy.this.m13a(false);
                                    if (GoogleVrProxy.this.f143a != null) {
                                        GoogleVrProxy.this.f143a.mo186a("enable", false);
                                    }
                                    if (GoogleVrProxy.this.f143a != null && GoogleVrProxy.this.f144b != null) {
                                        GoogleVrProxy.this.f144b.removeViewFromPlayer((View) GoogleVrProxy.this.f143a.mo186a("getGvrLayout", new Object[0]));
                                    }
                                }
                            } else if (GoogleVrProxy.this.f143a == null || GoogleVrProxy.this.f144b == null || GoogleVrProxy.this.f144b.addViewToPlayer((View) GoogleVrProxy.this.f143a.mo186a("getGvrLayout", new Object[0]), true)) {
                                if (GoogleVrProxy.this.f143a != null) {
                                    GoogleVrProxy.this.f143a.mo186a("enable", true);
                                }
                                GoogleVrProxy.this.m13a(true);
                            } else {
                                GoogleVrProxy.this.reportError("Unable to add Google VR to view hierarchy.");
                            }
                        } catch (Exception e) {
                            GoogleVrProxy.this.reportError("Exception enabling Google VR on UI Thread. " + e.getLocalizedMessage());
                        }
                    }
                }
            });
        }
    }

    public void setVideoLocationTransform(float[] fArr) {
        float[][] fArr2 = (float[][]) Array.newInstance(Float.TYPE, new int[]{4, 4});
        for (int i = 0; i < 4; i++) {
            for (int i2 = 0; i2 < 4; i2++) {
                fArr2[i][i2] = fArr[(i * 4) + i2];
            }
        }
        setVrVideoTransform(fArr2);
    }

    /* access modifiers changed from: protected */
    public void unloadGoogleVr() {
        if (this.f14k.f31d) {
            setGoogleVrModeEnabled(false);
        }
        if (this.f14k.f30c) {
            this.f14k.f30c = false;
        }
        this.f13j = null;
        runOnUiThread(new Runnable() {
            public final void run() {
                try {
                    if (GoogleVrProxy.this.f143a != null) {
                        GoogleVrProxy.this.f143a.mo186a("unload", new Object[0]);
                        GoogleVrProxy.this.f143a.mo186a("deinitialize", new Object[0]);
                        GoogleVrProxy.this.f143a = null;
                    }
                    GoogleVrProxy.this.f14k.f29b = false;
                } catch (Exception e) {
                    GoogleVrProxy.this.reportError("Exception unloading Google VR on UI Thread. " + e.getLocalizedMessage());
                }
            }
        });
    }
}
