package com.unity3d.player;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.MessageQueue;
import android.os.Process;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.view.InputEvent;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.widget.FrameLayout;

import java.io.UnsupportedEncodingException;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

public class UnityPlayer extends FrameLayout implements C0046d {
    public static Activity currentActivity = null;

    /* renamed from: r */
    private static boolean f45r;

    /* renamed from: a */
    C0037e f46a = new C0037e(this, (byte) 0);

    /* renamed from: b */
    TextInputDialog f47b = null;
    /* access modifiers changed from: private */

    /* renamed from: c */
    public int currentOrient = -1;
    /* access modifiers changed from: private */

    /* renamed from: d */
    public boolean f49d = false;

    /* renamed from: e */
    private boolean f50e = true;
    /* access modifiers changed from: private */

    /* renamed from: f */
    public C0059l f51f = new C0059l();

    /* renamed from: g */
    private final ConcurrentLinkedQueue f52g = new ConcurrentLinkedQueue();

    /* renamed from: h */
    private BroadcastReceiver f53h = null;

    /* renamed from: i */
    private boolean f54i = false;

    /* renamed from: j */
    private C0035c f55j = new C0035c(this, (byte) 0);

    /* renamed from: k */
    private TelephonyManager f56k;
    /* access modifiers changed from: private */

    /* renamed from: l */
    //public C0055j f57l; splash

    /* renamed from: m */
    private GoogleARProxy f58m = null;

    /* renamed from: n */
    private GoogleARCoreApi f59n = null;

    /* renamed from: o */
    private C0033a f60o = new C0033a();
    /* access modifiers changed from: private */

    /* renamed from: p */
    public Context context;
    /* access modifiers changed from: private */

    /* renamed from: q */
    public SurfaceView f62q;
    /* access modifiers changed from: private */

    /* renamed from: s */
    public boolean f63s;
    /* access modifiers changed from: private */

    /* renamed from: t */
    public C0065o f64t;


    /* renamed from: com.unity3d.player.UnityPlayer$a */
    class C0033a implements SensorEventListener {
        C0033a() {
        }

        public final void onAccuracyChanged(Sensor sensor, int i) {
        }

        public final void onSensorChanged(SensorEvent sensorEvent) {
        }
    }

    /* renamed from: com.unity3d.player.UnityPlayer$c */
    private class C0035c extends PhoneStateListener {
        private C0035c() {
        }

        /* synthetic */ C0035c(UnityPlayer unityPlayer, byte b) {
            this();
        }

        public final void onCallStateChanged(int i, String str) {
            boolean z = true;
            UnityPlayer unityPlayer = UnityPlayer.this;
            if (i != 1) {
                z = false;
            }
            unityPlayer.nativeMuteMasterAudio(z);
        }
    }

    /* renamed from: com.unity3d.player.UnityPlayer$d */
    enum C0036d {
        PAUSE,
        RESUME,
        QUIT,
        SURFACE_LOST,
        SURFACE_ACQUIRED,
        FOCUS_LOST,
        FOCUS_GAINED,
        NEXT_FRAME
    }

    /* renamed from: com.unity3d.player.UnityPlayer$e */
    private class C0037e extends Thread {

        /* renamed from: a */
        Handler f122a;

        /* renamed from: b */
        boolean f123b;

        /* renamed from: c */
        boolean f124c;

        /* renamed from: d */
        int f125d;

        /* renamed from: e */
        int f126e;

        private C0037e() {
            this.f123b = false;
            this.f124c = false;
            //this.f125d = C0034b.f109b;
            this.f126e = 5;
        }

        /* synthetic */ C0037e(UnityPlayer unityPlayer, byte b) {
            this();
        }

        /* renamed from: a */
        private void m87a(C0036d dVar) {
            if (this.f122a != null) {
                Message.obtain(this.f122a, 2269, dVar).sendToTarget();
            }
        }

        /* renamed from: a */
        public final void mo107a() {
            m87a(C0036d.QUIT);
        }

        /* renamed from: a */
        public final void mo108a(Runnable runnable) {
            if (this.f122a != null) {
                m87a(C0036d.PAUSE);
                Message.obtain(this.f122a, runnable).sendToTarget();
            }
        }

        /* renamed from: b */
        public final void mo109b() {
            m87a(C0036d.RESUME);
        }

        /* renamed from: b */
        public final void mo110b(Runnable runnable) {
            if (this.f122a != null) {
                m87a(C0036d.SURFACE_LOST);
                Message.obtain(this.f122a, runnable).sendToTarget();
            }
        }

        /* renamed from: c */
        public final void mo111c() {
            m87a(C0036d.FOCUS_GAINED);
        }

        /* renamed from: c */
        public final void mo112c(Runnable runnable) {
            if (this.f122a != null) {
                Message.obtain(this.f122a, runnable).sendToTarget();
                m87a(C0036d.SURFACE_ACQUIRED);
            }
        }

        /* renamed from: d */
        public final void mo113d() {
            m87a(C0036d.FOCUS_LOST);
        }

        public final void run() {
            setName("UnityMain");
            Looper.prepare();
            this.f122a = new Handler(new Handler.Callback() {
                /* renamed from: a */
                private void m95a() {

                        UnityPlayer.this.nativeFocusChanged(true);
                }

                public final boolean handleMessage(Message message) {
                    if (message.what != 2269) {
                        return false;
                    }
                    C0036d dVar = (C0036d) message.obj;
                    if (dVar == C0036d.NEXT_FRAME) {
                        return true;
                    }
                    if (dVar == C0036d.QUIT) {
                        Looper.myLooper().quit();
                    } else if (dVar == C0036d.RESUME) {
                        C0037e.this.f123b = true;
                    } else if (dVar == C0036d.PAUSE) {
                        C0037e.this.f123b = false;
                    } else if (dVar == C0036d.SURFACE_LOST) {
                        C0037e.this.f124c = false;
                    } else if (dVar == C0036d.SURFACE_ACQUIRED) {
                        C0037e.this.f124c = true;
                        m95a();
                    } else if (dVar == C0036d.FOCUS_LOST) {
                            UnityPlayer.this.nativeFocusChanged(false);
                    } else if (dVar == C0036d.FOCUS_GAINED) {
                        m95a();
                    }
                    return true;
                }
            });
            Looper.myQueue().addIdleHandler(new MessageQueue.IdleHandler() {
                public final boolean queueIdle() {
                    UnityPlayer.this.executeGLThreadJobs();
                    if (C0037e.this.f123b && C0037e.this.f124c) {
                        if (C0037e.this.f126e >= 0) {
                            if (C0037e.this.f126e == 0 && UnityPlayer.this.isSplashEnabled()) {
                                UnityPlayer.this.m38a();
                            }
                            C0037e eVar = C0037e.this;
                            eVar.f126e--;
                        }
                        if (!UnityPlayer.this.isFinishing() && !UnityPlayer.this.nativeRender()) {
                            UnityPlayer.this.m54c();
                        }
                        Message.obtain(C0037e.this.f122a, 2269, C0036d.NEXT_FRAME).sendToTarget();
                    }
                    return true;
                }
            });
            Looper.loop();
        }
    }

    /* renamed from: com.unity3d.player.UnityPlayer$f */
    private abstract class C0040f implements Runnable {
        private C0040f() {
        }

        /* synthetic */ C0040f(UnityPlayer unityPlayer, byte b) {
            this();
        }

        /* renamed from: a */
        public abstract void mo102a();

        public final void run() {
            if (!UnityPlayer.this.isFinishing()) {
                mo102a();
            }
        }
    }

    static {
        new C0058k().mo176a();
        f45r = false;
        f45r = loadLibraryStatic("main");
    }

    public UnityPlayer(Context context) {
        super(context);
        if (context instanceof Activity) {
            currentActivity = (Activity) context;
        }
        m40a(currentActivity);
        this.context = context;
        if (currentActivity != null && isSplashEnabled()) {
            //this.f57l = new C0055j(this.context, C0055j.C0057a.m110a()[getSplashMode()]);
            //addView(this.f57l);
        }
        if (PermissionUtil.f155c) {
            if (currentActivity != null) {
                PermissionUtil.f156d.mo160a(currentActivity, new Runnable() {
                    public final void run() {
                        UnityPlayer.this.mo44a((Runnable) new Runnable() {
                            public final void run() {
                                UnityPlayer.this.f51f.mo181d();
                                UnityPlayer.this.m60f();
                            }
                        });
                    }
                });
            } else {
                this.f51f.mo181d();
            }
        }
        m41a(this.context.getApplicationInfo());
        if (!C0059l.m114c()) {
            AlertDialog create = new AlertDialog.Builder(this.context).setTitle("Failure to initialize!").setPositiveButton("OK", new DialogInterface.OnClickListener() {
                public final void onClick(DialogInterface dialogInterface, int i) {
                    UnityPlayer.this.m54c();
                }
            }).setMessage("Your hardware does not support this application, sorry!").create();
            create.setCancelable(false);
            create.show();
            return;
        }
        initJni(context);
        this.f62q = m49b();
        this.f62q.setContentDescription(m37a(context));
        addView(this.f62q);
        //bringChildToFront(this.f57l);
        this.f63s = false;
        nativeInitWebRequest(UnityWebRequest.class);
        m70k();
        this.f56k = (TelephonyManager) this.context.getSystemService(Context.TELEPHONY_SERVICE);
        this.f46a.start();
    }

    public static void UnitySendMessage(String str, String str2, String str3) {
        if (!C0059l.m114c()) {
            MyLog.Log(5, "Native libraries not loaded - dropping message for " + str + "." + str2);
            return;
        }
        try {
            nativeUnitySendMessage(str, str2, str3.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
        }
    }

    /* renamed from: a */
    private static String m37a(Context context) {
        return context.getResources().getString(context.getResources().getIdentifier("game_view_content_description", "string", context.getPackageName()));
    }

    /* access modifiers changed from: private */
    /* renamed from: a */
    public void m38a() {
        mo44a((Runnable) new Runnable() {
            public final void run() {
                //UnityPlayer.this.removeView(UnityPlayer.this.f57l);
                //C0055j unused = UnityPlayer.this.f57l = null;
            }
        });
    }

    /* access modifiers changed from: private */
    /* renamed from: a */
    public void m39a(int i, Surface surface) {
        if (!this.f49d) {
            m53b(0, surface);
        }
    }

    /* renamed from: a */
    private static void m40a(Activity activity) {
        View decorView;
        if (activity != null && activity.getIntent().getBooleanExtra("android.intent.extra.VR_LAUNCH", false) && activity.getWindow() != null && (decorView = activity.getWindow().getDecorView()) != null) {
            decorView.setSystemUiVisibility(7);
        }
    }

    /* renamed from: a */
    private static void m41a(ApplicationInfo applicationInfo) {
        if (f45r && NativeLoader.load(applicationInfo.nativeLibraryDir)) {
            C0059l.m112a();
        }
    }

    /* JADX WARNING: type inference failed for: r1v0, types: [android.view.ViewParent] */
    /* JADX WARNING: Multi-variable type inference failed */
    /* JADX WARNING: Unknown variable types count: 1 */
    /* renamed from: a */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void m42a(android.view.View r5, android.view.View r6) {
        /*
            r4 = this;
            r3 = 0
            com.unity3d.player.l r0 = r4.f51f
            boolean r0 = r0.mo182e()
            if (r0 != 0) goto L_0x0045
            r4.pause()
            r0 = 1
            r2 = r0
        L_0x000e:
            if (r5 == 0) goto L_0x002f
            android.view.ViewParent r1 = r5.getParent()
            boolean r0 = r1 instanceof com.unity3d.player.UnityPlayer
            if (r0 == 0) goto L_0x001d
            r0 = r1
            com.unity3d.player.UnityPlayer r0 = (com.unity3d.player.UnityPlayer) r0
            if (r0 == r4) goto L_0x002f
        L_0x001d:
            boolean r0 = r1 instanceof android.view.ViewGroup
            if (r0 == 0) goto L_0x0026
            android.view.ViewGroup r1 = (android.view.ViewGroup) r1
            r1.removeView(r5)
        L_0x0026:
            r4.addView(r5)
            r4.bringChildToFront(r5)
            r5.setVisibility(r3)
        L_0x002f:
            if (r6 == 0) goto L_0x003f
            android.view.ViewParent r0 = r6.getParent()
            if (r0 != r4) goto L_0x003f
            r0 = 8
            r6.setVisibility(r0)
            r4.removeView(r6)
        L_0x003f:
            if (r2 == 0) goto L_0x0044
            r4.resume()
        L_0x0044:
            return
        L_0x0045:
            r2 = r3
            goto L_0x000e
        */
        throw new UnsupportedOperationException("Method not decompiled: com.unity3d.player.UnityPlayer.m42a(android.view.View, android.view.View):void");
    }

    /* renamed from: a */
    private void m43a(C0040f fVar) {
        if (!isFinishing()) {
            m52b((Runnable) fVar);
        }
    }

    /* access modifiers changed from: private */
    /* renamed from: b */
    public SurfaceView m49b() {
        SurfaceView surfaceView = new SurfaceView(this.context);
        surfaceView.getHolder().setFormat(-3);
        surfaceView.getHolder().addCallback(new SurfaceHolder.Callback() {
            public final void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
                UnityPlayer.this.m39a(0, surfaceHolder.getSurface());
            }

            public final void surfaceCreated(SurfaceHolder surfaceHolder) {
                UnityPlayer.this.m39a(0, surfaceHolder.getSurface());
            }

            public final void surfaceDestroyed(SurfaceHolder surfaceHolder) {
                UnityPlayer.this.m39a(0, (Surface) null);
            }
        });
        surfaceView.setFocusable(true);
        surfaceView.setFocusableInTouchMode(true);
        return surfaceView;
    }

    /* renamed from: b */
    private void m52b(Runnable runnable) {
        if (C0059l.m114c()) {
            if (Thread.currentThread() == this.f46a) {
                runnable.run();
            } else {
                this.f52g.add(runnable);
            }
        }
    }

    /* renamed from: b */
    private boolean m53b(final int i, final Surface surface) {
        if (!C0059l.m114c()) {
            return false;
        }
        final Semaphore semaphore = new Semaphore(0);
        Runnable r0 = new Runnable() {
            public final void run() {
                UnityPlayer.this.nativeRecreateGfxState(i, surface);
                semaphore.release();
            }
        };
        if (i != 0) {
            r0.run();
        } else if (surface == null) {
            this.f46a.mo110b(r0);
        } else {
            this.f46a.mo112c(r0);
        }
        if (surface == null && i == 0) {
            try {
                if (!semaphore.tryAcquire(4, TimeUnit.SECONDS)) {
                    MyLog.Log(5, "Timeout while trying detaching primary window.");
                }
            } catch (InterruptedException e) {
                MyLog.Log(5, "UI thread got interrupted while trying to detach the primary window from the Unity Engine.");
            }
        }
        return true;
    }

    /* access modifiers changed from: private */
    /* renamed from: c */
    public void m54c() {
        if ((this.context instanceof Activity) && !((Activity) this.context).isFinishing()) {
            ((Activity) this.context).finish();
        }
    }

    /* renamed from: d */
    private void m56d() {
        reportSoftInputStr((String) null, 1, true);
        if (this.f51f.mo184g()) {
            if (C0059l.m114c()) {
                final Semaphore semaphore = new Semaphore(0);
                this.f46a.mo108a(isFinishing() ? new Runnable() {
                    public final void run() {
                        UnityPlayer.this.m59e();
                        semaphore.release();
                    }
                } : new Runnable() {
                    public final void run() {
                        if (UnityPlayer.this.nativePause()) {
                            boolean unused = UnityPlayer.this.f63s = true;
                            UnityPlayer.this.m59e();
                            semaphore.release(2);
                            return;
                        }
                        semaphore.release();
                    }
                });
                try {
                    if (!semaphore.tryAcquire(4, TimeUnit.SECONDS)) {
                        MyLog.Log(5, "Timeout while trying to pause the Unity Engine.");
                    }
                } catch (InterruptedException e) {
                    MyLog.Log(5, "UI thread got interrupted while trying to pause the Unity Engine.");
                }
                if (semaphore.drainPermits() > 0) {
                    quit();
                }
            }
            this.f51f.mo180c(false);
            this.f51f.mo179b(true);
            if (this.f54i) {
                this.f56k.listen(this.f55j, 0);
            }
        }
    }

    /* access modifiers changed from: private */
    /* renamed from: e */
    public void m59e() {
        nativeDone();
    }

    /* access modifiers changed from: private */
    /* renamed from: f */
    public void m60f() {
        if (this.f51f.mo183f()) {
            this.f51f.mo180c(true);
            m52b((Runnable) new Runnable() {
                public final void run() {
                    UnityPlayer.this.nativeResume();
                }
            });
            this.f46a.mo109b();
        }
    }

    /* renamed from: g */
    private static void m63g() {
        if (C0059l.m114c()) {
            if (!NativeLoader.unload()) {
                throw new UnsatisfiedLinkError("Unable to unload libraries from libmain.so");
            }
            C0059l.m113b();
        }
    }

    /* renamed from: h */
    private ApplicationInfo m64h() throws PackageManager.NameNotFoundException {
        return this.context.getPackageManager().getApplicationInfo(this.context.getPackageName(), PackageManager.GET_META_DATA);
    }

    /* access modifiers changed from: private */
    /* renamed from: i */
    public boolean isSplashEnabled() {
        try {
            return m64h().metaData.getBoolean("unity.splash-enable");
        } catch (Exception e) {
            return false;
        }
    }

    private final native void initJni(Context context);

    /* renamed from: j */
    private boolean m69j() {
        try {
            return m64h().metaData.getBoolean("unity.tango-enable");
        } catch (Exception e) {
            return false;
        }
    }

    /* renamed from: k */
    private void m70k() {
        if (this.context instanceof Activity) {
            ((Activity) this.context).getWindow().setFlags(1024, 1024);
        }
    }

    protected static boolean loadLibraryStatic(String str) {
        try {
            System.loadLibrary(str);
            return true;
        } catch (UnsatisfiedLinkError e) {
            MyLog.Log(6, "Unable to find " + str);
            return false;
        } catch (Exception e2) {
            MyLog.Log(6, "Unknown error " + e2);
            return false;
        }
    }

    private final native void nativeDone();

    /* access modifiers changed from: private */
    public final native void nativeFocusChanged(boolean z);

    private final native void nativeInitWebRequest(Class cls);

    private final native boolean nativeInjectEvent(InputEvent inputEvent);

    /* access modifiers changed from: private */
    public final native boolean nativeIsAutorotationOn();

    /* access modifiers changed from: private */
    public final native void nativeLowMemory();

    /* access modifiers changed from: private */
    public final native void nativeMuteMasterAudio(boolean z);

    /* access modifiers changed from: private */
    public final native boolean nativePause();

    /* access modifiers changed from: private */
    public final native void nativeRecreateGfxState(int i, Surface surface);

    /* access modifiers changed from: private */
    public final native boolean nativeRender();

    private final native void nativeRestartActivityIndicator();

    /* access modifiers changed from: private */
    public final native void nativeResume();

    /* access modifiers changed from: private */
    public final native void nativeSetInputString(String str);

    /* access modifiers changed from: private */
    public final native void nativeSoftInputCanceled();

    /* access modifiers changed from: private */
    public final native void nativeSoftInputClosed();

    private final native void nativeSoftInputLostFocus();

    private static native void nativeUnitySendMessage(String str, String str2, byte[] bArr);

    /* access modifiers changed from: package-private */
    /* renamed from: a */
    public final void mo44a(Runnable runnable) {
        if (this.context instanceof Activity) {
            ((Activity) this.context).runOnUiThread(runnable);
        } else {
            MyLog.Log(5, "Not running Unity from an Activity; ignored...");
        }
    }

    /* access modifiers changed from: protected */
    public void addPhoneCallListener() {
        this.f54i = true;
        this.f56k.listen(this.f55j, 32);
    }

    public boolean addViewToPlayer(View view, boolean z) {
        boolean z2 = true;
        m42a(view, (View) (z ? this.f62q : null));
        boolean z3 = view.getParent() == this;
        boolean z4 = z && this.f62q.getParent() == null;
        boolean z5 = this.f62q.getParent() == this;
        if (!z3 || (!z4 && !z5)) {
            z2 = false;
        }
        if (!z2) {
            if (!z3) {
                MyLog.Log(6, "addViewToPlayer: Failure adding view to hierarchy");
            }
            if (!z4 && !z5) {
                MyLog.Log(6, "addViewToPlayer: Failure removing old view from hierarchy");
            }
        }
        return z2;
    }

    public void configurationChanged(Configuration configuration) {
        if (this.f62q instanceof SurfaceView) {
            this.f62q.getHolder().setSizeFromLayout();
        }
        if (this.f64t != null) {
            this.f64t.mo218c();
        }
        GoogleVrProxy b = GoogleVrApi.m10b();
        if (b != null) {
            b.mo20c();
        }
    }

    /* access modifiers changed from: protected */
    public void disableLogger() {
        MyLog.f151a = true;
    }

    public boolean displayChanged(int i, Surface surface) {
        if (i == 0) {
            this.f49d = surface != null;
            mo44a((Runnable) new Runnable() {
                public final void run() {
                    if (UnityPlayer.this.f49d) {
                        UnityPlayer.this.removeView(UnityPlayer.this.f62q);
                    } else {
                        UnityPlayer.this.addView(UnityPlayer.this.f62q);
                    }
                }
            });
        }
        return m53b(i, surface);
    }

    /* access modifiers changed from: protected */
    public void executeGLThreadJobs() {
        while (true) {
            Runnable runnable = (Runnable) this.f52g.poll();
            if (runnable != null) {
                runnable.run();
            } else {
                return;
            }
        }
    }

    public Bundle getSettings() {
        return Bundle.EMPTY;
    }

    /* access modifiers changed from: protected */
    public int getSplashMode() {
        try {
            return m64h().metaData.getInt("unity.splash-mode");
        } catch (Exception e) {
            return 0;
        }
    }

    public View getView() {
        return this;
    }

    /* access modifiers changed from: protected */
    public void hideSoftInput() {
        final Runnable r0 = new Runnable() {
            public final void run() {
                if (UnityPlayer.this.f47b != null) {
                    UnityPlayer.this.f47b.dismiss();
                    UnityPlayer.this.f47b = null;
                }
            }
        };
        if (PermissionUtil.f154b) {
            m43a((C0040f) new C0040f() {
                /* renamed from: a */
                public final void mo102a() {
                    UnityPlayer.this.mo44a(r0);
                }
            });
        } else {
            mo44a((Runnable) r0);
        }
    }

    public void init(int i, boolean z) {
    }

    /* access modifiers changed from: protected */
    public boolean initializeGoogleAr() {
        if (this.f58m == null && currentActivity != null && m69j()) {
            if (GoogleARProxy.m1a()) {
                this.f58m = new GoogleARProxy(this);
                this.f58m.mo7a(currentActivity, this.context);
                this.f58m.mo8b();
                if (!this.f51f.mo182e()) {
                    this.f58m.mo10d();
                }
                return this.f58m.mo11e();
            }
            this.f59n = new GoogleARCoreApi();
            this.f59n.initializeARCore(currentActivity);
            if (!this.f51f.mo182e()) {
                this.f59n.resumeARCore();
            }
        }
        return false;
    }

    /* access modifiers changed from: protected */
    public boolean initializeGoogleVr() {
        return false;
    }

    public boolean injectEvent(InputEvent inputEvent) {
        return nativeInjectEvent(inputEvent);
    }

    /* access modifiers changed from: protected */
    public boolean isFinishing() {
        if (!this.f63s) {
            boolean z = (this.context instanceof Activity) && ((Activity) this.context).isFinishing();
            this.f63s = z;
            if (!z) {
                return false;
            }
        }
        return true;
    }

    /* access modifiers changed from: protected */
    public void kill() {
        Process.killProcess(Process.myPid());
    }

    /* access modifiers changed from: protected */
    public boolean loadLibrary(String str) {
        return loadLibraryStatic(str);
    }

    public void lowMemory() {
        m52b((Runnable) new Runnable() {
            public final void run() {
                UnityPlayer.this.nativeLowMemory();
            }
        });
    }

    public boolean onGenericMotionEvent(MotionEvent motionEvent) {
        return injectEvent(motionEvent);
    }

    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    public boolean onKeyLongPress(int i, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    public boolean onKeyMultiple(int i, int i2, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        return injectEvent(keyEvent);
    }

    public boolean onTouchEvent(MotionEvent motionEvent) {
        return injectEvent(motionEvent);
    }

    public void pause() {
        if (this.f58m != null) {
            this.f58m.mo9c();
        } else if (this.f59n != null) {
            this.f59n.pauseARCore();
        }
        if (this.f64t != null) {
            this.f64t.mo215a();
        }
        GoogleVrProxy b = GoogleVrApi.m10b();
        if (b != null) {
            b.pauseGvrLayout();
        }
        m56d();
    }

    public void quit() {
        if (GoogleVrApi.m10b() != null) {
            GoogleVrApi.m8a();
        }
        this.f63s = true;
        if (!this.f51f.mo182e()) {
            pause();
        }
        this.f46a.mo107a();
        try {
            this.f46a.join(4000);
        } catch (InterruptedException e) {
            this.f46a.interrupt();
        }
        if (this.f53h != null) {
            this.context.unregisterReceiver(this.f53h);
        }
        this.f53h = null;
        if (C0059l.m114c()) {
            removeAllViews();
        }
        kill();
        m63g();
    }

    public void removeViewFromPlayer(View view) {
        boolean z = true;
        m42a((View) this.f62q, view);
        boolean z2 = view.getParent() == null;
        boolean z3 = this.f62q.getParent() == this;
        if (!z2 || !z3) {
            z = false;
        }
        if (!z) {
            if (!z2) {
                MyLog.Log(6, "removeViewFromPlayer: Failure removing view from hierarchy");
            }
            if (!z3) {
                MyLog.Log(6, "removeVireFromPlayer: Failure agging old view to hierarchy");
            }
        }
    }

    public void reportError(String str, String str2) {
        MyLog.Log(6, str + ": " + str2);
    }

    /* access modifiers changed from: protected */
    public void reportSoftInputStr(final String str, final int i, final boolean z) {
        if (i == 1) {
            hideSoftInput();
        }
        m43a((C0040f) new C0040f() {
            /* renamed from: a */
            public final void mo102a() {
                if (z) {
                    UnityPlayer.this.nativeSoftInputCanceled();
                } else if (str != null) {
                    UnityPlayer.this.nativeSetInputString(str);
                }
                if (i == 1) {
                    UnityPlayer.this.nativeSoftInputClosed();
                }
            }
        });
    }

    public void resume() {
        if (this.f58m != null) {
            this.f58m.mo10d();
        } else if (this.f59n != null) {
            this.f59n.resumeARCore();
        }
        this.f51f.mo179b(false);
        if (this.f64t != null) {
            this.f64t.mo217b();
        }
        m60f();
        nativeRestartActivityIndicator();
        GoogleVrProxy b = GoogleVrApi.m10b();
        if (b != null) {
            b.mo19b();
        }
    }

    /* access modifiers changed from: protected */
    public void setSoftInputStr(final String str) {
        mo44a((Runnable) new Runnable() {
            public final void run() {
                if (UnityPlayer.this.f47b != null && str != null) {
                    UnityPlayer.this.f47b.mo13246a(str);
                }
            }
        });
    }

    /* access modifiers changed from: protected */
    public void showSoftInput(String str, int i, boolean z, boolean z2, boolean z3, boolean z4, String str2) {
        final String str3 = str;
        final int i2 = i;
        final boolean z5 = z;
        final boolean z6 = z2;
        final boolean z7 = z3;
        final boolean z8 = z4;
        final String str4 = str2;
        mo44a((Runnable) new Runnable() {
            public final void run() {
                UnityPlayer.this.f47b = new TextInputDialog(UnityPlayer.this.context, UnityPlayer.this, str3, i2, z5, z6, z7, str4);
                UnityPlayer.this.f47b.show();
            }
        });
    }

    /* access modifiers changed from: protected */
    public boolean showVideoPlayer(String str, int i, int i2, int i3, boolean z, int i4, int i5) {
        if (this.f64t == null) {
            this.f64t = new C0065o(this);
        }
        boolean a = this.f64t.mo216a(this.context, str, i, i2, i3, z, (long) i4, (long) i5, new C0065o.C0072a() {
            /* renamed from: a */
            public final void mo86a() {
                C0065o unused = UnityPlayer.this.f64t = null;
            }
        });
        if (a) {
            mo44a((Runnable) new Runnable() {
                public final void run() {
                    if (UnityPlayer.this.nativeIsAutorotationOn() && (UnityPlayer.this.context instanceof Activity)) {
                        //((Activity) UnityPlayer.this.context).setRequestedOrientation(UnityPlayer.this.currentOrient);
                    }
                }
            });
        }
        return a;
    }

    public void start() {
    }

    public void stop() {
    }

    /* access modifiers changed from: protected */
    public void toggleGyroscopeSensor(boolean z) {
        SensorManager sensorManager = (SensorManager) this.context.getSystemService(Context.SENSOR_SERVICE);
        Sensor defaultSensor = sensorManager.getDefaultSensor(11);
        if (z) {
            sensorManager.registerListener(this.f60o, defaultSensor, 1);
        } else {
            sensorManager.unregisterListener(this.f60o);
        }
    }

    public void windowFocusChanged(boolean z) {
        this.f51f.mo178a(z);
        if (z && this.f47b != null) {
            nativeSoftInputLostFocus();
            reportSoftInputStr((String) null, 1, false);
        }
        if (z) {
            this.f46a.mo111c();
        } else {
            this.f46a.mo113d();
        }
        m60f();
    }
}
