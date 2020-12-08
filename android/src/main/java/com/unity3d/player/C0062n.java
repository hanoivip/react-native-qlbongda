package com.unity3d.player;

import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.media.MediaPlayer;
import android.net.Uri;
import android.util.Log;
import android.view.Display;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.MediaController;
import java.io.FileInputStream;
import java.io.IOException;

/* renamed from: com.unity3d.player.n */
public final class C0062n extends FrameLayout implements MediaPlayer.OnBufferingUpdateListener, MediaPlayer.OnCompletionListener, MediaPlayer.OnPreparedListener, MediaPlayer.OnVideoSizeChangedListener, SurfaceHolder.Callback, MediaController.MediaPlayerControl {
    /* access modifiers changed from: private */

    /* renamed from: a */
    public static boolean f187a = false;

    /* renamed from: b */
    private final Context f188b;

    /* renamed from: c */
    private final SurfaceView f189c;

    /* renamed from: d */
    private final SurfaceHolder f190d;

    /* renamed from: e */
    private final String f191e;

    /* renamed from: f */
    private final int f192f;

    /* renamed from: g */
    private final int f193g;

    /* renamed from: h */
    private final boolean f194h;

    /* renamed from: i */
    private final long f195i;

    /* renamed from: j */
    private final long f196j;

    /* renamed from: k */
    private final FrameLayout f197k;

    /* renamed from: l */
    private final Display f198l;

    /* renamed from: m */
    private int f199m;

    /* renamed from: n */
    private int f200n;

    /* renamed from: o */
    private int f201o;

    /* renamed from: p */
    private int f202p;

    /* renamed from: q */
    private MediaPlayer f203q;

    /* renamed from: r */
    private MediaController f204r;

    /* renamed from: s */
    private boolean f205s = false;

    /* renamed from: t */
    private boolean f206t = false;

    /* renamed from: u */
    private int f207u = 0;

    /* renamed from: v */
    private boolean f208v = false;

    /* renamed from: w */
    private boolean f209w = false;

    /* renamed from: x */
    private C0063a f210x;

    /* renamed from: y */
    private C0064b f211y;

    /* renamed from: z */
    private volatile int f212z = 0;

    /* renamed from: com.unity3d.player.n$a */
    public interface C0063a {
        /* renamed from: a */
        void mo212a(int i);
    }

    /* renamed from: com.unity3d.player.n$b */
    public class C0064b implements Runnable {

        /* renamed from: b */
        private C0062n f214b;

        /* renamed from: c */
        private boolean f215c = false;

        public C0064b(C0062n nVar) {
            this.f214b = nVar;
        }

        /* renamed from: a */
        public final void mo213a() {
            this.f215c = true;
        }

        public final void run() {
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
            if (!this.f215c) {
                if (C0062n.f187a) {
                    C0062n.m127b("Stopping the video player due to timeout.");
                }
                this.f214b.CancelOnPrepare();
            }
        }
    }

    protected C0062n(Context context, String str, int i, int i2, int i3, boolean z, long j, long j2, C0063a aVar) {
        super(context);
        this.f210x = aVar;
        this.f188b = context;
        this.f197k = this;
        this.f189c = new SurfaceView(context);
        this.f190d = this.f189c.getHolder();
        this.f190d.addCallback(this);
        this.f190d.setType(3);
        this.f197k.setBackgroundColor(i);
        this.f197k.addView(this.f189c);
        this.f198l = ((WindowManager) this.f188b.getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay();
        this.f191e = str;
        this.f192f = i2;
        this.f193g = i3;
        this.f194h = z;
        this.f195i = j;
        this.f196j = j2;
        if (f187a) {
            m127b("fileName: " + this.f191e);
        }
        if (f187a) {
            m127b("backgroundColor: " + i);
        }
        if (f187a) {
            m127b("controlMode: " + this.f192f);
        }
        if (f187a) {
            m127b("scalingMode: " + this.f193g);
        }
        if (f187a) {
            m127b("isURL: " + this.f194h);
        }
        if (f187a) {
            m127b("videoOffset: " + this.f195i);
        }
        if (f187a) {
            m127b("videoLength: " + this.f196j);
        }
        setFocusable(true);
        setFocusableInTouchMode(true);
    }

    /* renamed from: a */
    private void m125a(int i) {
        this.f212z = i;
        if (this.f210x != null) {
            this.f210x.mo212a(this.f212z);
        }
    }

    /* access modifiers changed from: private */
    /* renamed from: b */
    public static void m127b(String str) {
        Log.i("Video", "VideoPlayer: " + str);
    }

    /* renamed from: c */
    private void m129c() {
        if (this.f203q != null) {
            this.f203q.setDisplay(this.f190d);
            if (!this.f208v) {
                if (f187a) {
                    m127b("Resuming playback");
                }
                this.f203q.start();
                return;
            }
            return;
        }
        m125a(0);
        doCleanUp();
        try {
            this.f203q = new MediaPlayer();
            if (this.f194h) {
                this.f203q.setDataSource(this.f188b, Uri.parse(this.f191e));
            } else if (this.f196j != 0) {
                FileInputStream fileInputStream = new FileInputStream(this.f191e);
                this.f203q.setDataSource(fileInputStream.getFD(), this.f195i, this.f196j);
                fileInputStream.close();
            } else {
                try {
                    AssetFileDescriptor openFd = getResources().getAssets().openFd(this.f191e);
                    this.f203q.setDataSource(openFd.getFileDescriptor(), openFd.getStartOffset(), openFd.getLength());
                    openFd.close();
                } catch (IOException e) {
                    FileInputStream fileInputStream2 = new FileInputStream(this.f191e);
                    this.f203q.setDataSource(fileInputStream2.getFD());
                    fileInputStream2.close();
                }
            }
            this.f203q.setDisplay(this.f190d);
            this.f203q.setScreenOnWhilePlaying(true);
            this.f203q.setOnBufferingUpdateListener(this);
            this.f203q.setOnCompletionListener(this);
            this.f203q.setOnPreparedListener(this);
            this.f203q.setOnVideoSizeChangedListener(this);
            this.f203q.setAudioStreamType(3);
            this.f203q.prepareAsync();
            this.f211y = new C0064b(this);
            new Thread(this.f211y).start();
        } catch (Exception e2) {
            if (f187a) {
                m127b("error: " + e2.getMessage() + e2);
            }
            m125a(2);
        }
    }

    /* renamed from: d */
    private void m130d() {
        if (!isPlaying()) {
            m125a(1);
            if (f187a) {
                m127b("startVideoPlayback");
            }
            updateVideoLayout();
            if (!this.f208v) {
                start();
            }
        }
    }

    public final void CancelOnPrepare() {
        m125a(2);
    }

    /* access modifiers changed from: package-private */
    /* renamed from: a */
    public final boolean mo189a() {
        return this.f208v;
    }

    public final boolean canPause() {
        return true;
    }

    public final boolean canSeekBackward() {
        return true;
    }

    public final boolean canSeekForward() {
        return true;
    }

    @Override
    public int getAudioSessionId() {
        return 0;
    }

    /* access modifiers changed from: protected */
    public final void destroyPlayer() {
        if (f187a) {
            m127b("destroyPlayer");
        }
        if (!this.f208v) {
            pause();
        }
        doCleanUp();
    }

    /* access modifiers changed from: protected */
    public final void doCleanUp() {
        if (this.f211y != null) {
            this.f211y.mo213a();
            this.f211y = null;
        }
        if (this.f203q != null) {
            this.f203q.release();
            this.f203q = null;
        }
        this.f201o = 0;
        this.f202p = 0;
        this.f206t = false;
        this.f205s = false;
    }

    public final int getBufferPercentage() {
        if (this.f194h) {
            return this.f207u;
        }
        return 100;
    }

    public final int getCurrentPosition() {
        if (this.f203q == null) {
            return 0;
        }
        return this.f203q.getCurrentPosition();
    }

    public final int getDuration() {
        if (this.f203q == null) {
            return 0;
        }
        return this.f203q.getDuration();
    }

    public final boolean isPlaying() {
        boolean z = this.f206t && this.f205s;
        return this.f203q == null ? !z : this.f203q.isPlaying() || !z;
    }

    public final void onBufferingUpdate(MediaPlayer mediaPlayer, int i) {
        if (f187a) {
            m127b("onBufferingUpdate percent:" + i);
        }
        this.f207u = i;
    }

    public final void onCompletion(MediaPlayer mediaPlayer) {
        if (f187a) {
            m127b("onCompletion called");
        }
        destroyPlayer();
        m125a(3);
    }

    public final boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 4 && (this.f192f != 2 || i == 0 || keyEvent.isSystem())) {
            return this.f204r != null ? this.f204r.onKeyDown(i, keyEvent) : super.onKeyDown(i, keyEvent);
        }
        destroyPlayer();
        m125a(3);
        return true;
    }

    public final void onPrepared(MediaPlayer mediaPlayer) {
        if (f187a) {
            m127b("onPrepared called");
        }
        if (this.f211y != null) {
            this.f211y.mo213a();
            this.f211y = null;
        }
        if (this.f192f == 0 || this.f192f == 1) {
            this.f204r = new MediaController(this.f188b);
            this.f204r.setMediaPlayer(this);
            this.f204r.setAnchorView(this);
            this.f204r.setEnabled(true);
            this.f204r.show();
        }
        this.f206t = true;
        if (this.f206t && this.f205s) {
            m130d();
        }
    }

    public final boolean onTouchEvent(MotionEvent motionEvent) {
        int action = motionEvent.getAction() & 255;
        if (this.f192f != 2 || action != 0) {
            return this.f204r != null ? this.f204r.onTouchEvent(motionEvent) : super.onTouchEvent(motionEvent);
        }
        destroyPlayer();
        m125a(3);
        return true;
    }

    public final void onVideoSizeChanged(MediaPlayer mediaPlayer, int i, int i2) {
        if (f187a) {
            m127b("onVideoSizeChanged called " + i + "x" + i2);
        }
        if (i != 0 && i2 != 0) {
            this.f205s = true;
            this.f201o = i;
            this.f202p = i2;
            if (this.f206t && this.f205s) {
                m130d();
            }
        } else if (f187a) {
            m127b("invalid video width(" + i + ") or height(" + i2 + ")");
        }
    }

    public final void pause() {
        if (this.f203q != null) {
            if (this.f209w) {
                this.f203q.pause();
            }
            this.f208v = true;
        }
    }

    public final void seekTo(int i) {
        if (this.f203q != null) {
            this.f203q.seekTo(i);
        }
    }

    public final void start() {
        if (f187a) {
            m127b("Start");
        }
        if (this.f203q != null) {
            if (this.f209w) {
                this.f203q.start();
            }
            this.f208v = false;
        }
    }

    public final void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
        if (f187a) {
            m127b("surfaceChanged called " + i + " " + i2 + "x" + i3);
        }
        if (this.f199m != i2 || this.f200n != i3) {
            this.f199m = i2;
            this.f200n = i3;
            if (this.f209w) {
                updateVideoLayout();
            }
        }
    }

    public final void surfaceCreated(SurfaceHolder surfaceHolder) {
        if (f187a) {
            m127b("surfaceCreated called");
        }
        this.f209w = true;
        m129c();
    }

    public final void surfaceDestroyed(SurfaceHolder surfaceHolder) {
        if (f187a) {
            m127b("surfaceDestroyed called");
        }
        this.f209w = false;
    }

    /* access modifiers changed from: protected */
    public final void updateVideoLayout() {
        if (f187a) {
            m127b("updateVideoLayout");
        }
        if (this.f203q != null) {
            if (this.f199m == 0 || this.f200n == 0) {
                WindowManager windowManager = (WindowManager) this.f188b.getSystemService(Context.WINDOW_SERVICE);
                this.f199m = windowManager.getDefaultDisplay().getWidth();
                this.f200n = windowManager.getDefaultDisplay().getHeight();
            }
            int i = this.f199m;
            int i2 = this.f200n;
            if (this.f205s) {
                float f = ((float) this.f201o) / ((float) this.f202p);
                float f2 = ((float) this.f199m) / ((float) this.f200n);
                if (this.f193g == 1) {
                    if (f2 <= f) {
                        i2 = (int) (((float) this.f199m) / f);
                    } else {
                        i = (int) (((float) this.f200n) * f);
                    }
                } else if (this.f193g == 2) {
                    if (f2 >= f) {
                        i2 = (int) (((float) this.f199m) / f);
                    } else {
                        i = (int) (((float) this.f200n) * f);
                    }
                } else if (this.f193g == 0) {
                    i = this.f201o;
                    i2 = this.f202p;
                }
            } else if (f187a) {
                m127b("updateVideoLayout: Video size is not known yet");
            }
            if (this.f199m != i || this.f200n != i2) {
                if (f187a) {
                    m127b("frameWidth = " + i + "; frameHeight = " + i2);
                }
                this.f197k.updateViewLayout(this.f189c, new FrameLayout.LayoutParams(i, i2, 17));
            }
        }
    }
}
