package com.vng.nsbd;

import android.app.Activity;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import com.capstones.luaext.DistributePlugin;
import com.capstones.luaext.EventPlugin;
import com.unity3d.player.UnityPlayer;

//hanoivip
import com.capstones.vngsdk.VNGPlugin;

public class UnityPlayerNativeActivity extends Activity {
    private int height;
    protected UnityPlayer mUnityPlayer;
    private int width;

    /* access modifiers changed from: protected */
    public void onCreate(Bundle savedInstanceState) {
        //hanoivip get params
        Intent intent = getIntent();
		int uid = intent.getIntExtra("uid", 0);
		String token = intent.getStringExtra("token");
        VNGPlugin.userID = String.valueOf(uid);
        VNGPlugin.accessToken = token;
        
        //continue..
        EventPlugin.mainActivity = this;
        EventPlugin.Load();
        DistributePlugin.mainActivity = this;
        requestWindowFeature(1);
        super.onCreate(savedInstanceState);
        DistributePlugin.OnCreate();
        getWindow().takeSurface((SurfaceHolder.Callback2) null);
        setTheme(16973831);
        getWindow().setFormat(2);
        this.mUnityPlayer = new UnityPlayer(this);
        if (this.mUnityPlayer.getSettings().getBoolean("hide_status_bar", true)) {
            getWindow().setFlags(1024, 1024);
        }
        setContentView(this.mUnityPlayer);
        this.mUnityPlayer.requestFocus();
        DisplayMetrics dm = getResources().getDisplayMetrics();
        this.width = dm.widthPixels;
        this.height = dm.heightPixels;
    }

    /* access modifiers changed from: protected */
    public void onDestroy() {
        super.onDestroy();
        DistributePlugin.OnDestroy();
        this.mUnityPlayer.quit();
    }

    /* access modifiers changed from: protected */
    public void onPause() {
        super.onPause();
        DistributePlugin.OnPause();
        this.mUnityPlayer.pause();
    }

    /* access modifiers changed from: protected */
    public void onResume() {
        super.onResume();
        DistributePlugin.OnResume();
        this.mUnityPlayer.resume();
    }

    public void onStop() {
        super.onStop();
        DistributePlugin.OnStop();
    }

    public void onRestart() {
        super.onRestart();
        DistributePlugin.OnRestart();
    }

    public void onStart() {
        super.onStart();
        DistributePlugin.OnStart();
        ((NotificationManager) getSystemService("notification")).cancelAll();
    }

    public void onLowMemory() {
        super.onLowMemory();
        this.mUnityPlayer.lowMemory();
    }

    public void onTrimMemory(int level) {
        super.onTrimMemory(level);
        if (level == 15) {
            this.mUnityPlayer.lowMemory();
        }
    }

    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        DistributePlugin.OnConfigurationChanged(newConfig);
        if ((this.mUnityPlayer.getView().getLayoutParams().width < this.mUnityPlayer.getView().getLayoutParams().height || this.width < this.height) && (this.mUnityPlayer.getView().getLayoutParams().width >= this.mUnityPlayer.getView().getLayoutParams().height || this.width >= this.height)) {
            this.mUnityPlayer.getView().getLayoutParams().width = this.height;
            this.mUnityPlayer.getView().getLayoutParams().height = this.width;
        } else {
            this.mUnityPlayer.getView().getLayoutParams().width = this.width;
            this.mUnityPlayer.getView().getLayoutParams().height = this.height;
        }
        this.mUnityPlayer.configurationChanged(newConfig);
    }

    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        this.mUnityPlayer.windowFocusChanged(hasFocus);
    }

    public boolean dispatchKeyEvent(KeyEvent event) {
        if (event.getAction() == 2) {
            return this.mUnityPlayer.injectEvent(event);
        }
        return super.dispatchKeyEvent(event);
    }

    /* access modifiers changed from: protected */
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        DistributePlugin.OnActivityResult(requestCode, resultCode, data);
    }

    /* access modifiers changed from: protected */
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        DistributePlugin.OnNewIntent(intent);
        setIntent(intent);
    }

    /* access modifiers changed from: protected */
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        DistributePlugin.OnSaveInstanceState(outState);
    }

    public void onBackPressed() {
        super.onBackPressed();
        DistributePlugin.OnBackPressed();
    }

    public boolean onKeyUp(int keyCode, KeyEvent event) {
        return this.mUnityPlayer.injectEvent(event);
    }

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return this.mUnityPlayer.injectEvent(event);
    }

    public boolean onTouchEvent(MotionEvent event) {
        return this.mUnityPlayer.injectEvent(event);
    }

    public boolean onGenericMotionEvent(MotionEvent event) {
        return this.mUnityPlayer.injectEvent(event);
    }
}
