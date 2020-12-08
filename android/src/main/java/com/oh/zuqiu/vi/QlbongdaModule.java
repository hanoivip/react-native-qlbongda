package com.oh.zuqiu.vi;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import android.content.Intent;
import com.vng.nsbd.UnityPlayerNativeActivity;

public class QlbongdaModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public QlbongdaModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "Qlbongda";
    }

    @ReactMethod
	public void enterGame(String token, int uid, Callback callback) {
		ReactApplicationContext context = getReactApplicationContext();
		Intent intent = new Intent(context, UnityPlayerNativeActivity.class);
		intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		intent.putExtra("token", token);
		intent.putExtra("uid", uid);
		context.startActivity(intent);
	}
}
