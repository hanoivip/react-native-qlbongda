package com.capstones.luaext;

import android.app.Activity;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import com.capstones.vngsdk.VNGPlugin;

public class DistributePlugin {
    public static Object eventObject;
    public static Activity mainActivity;

    public static void OnCreate() {
        VNGPlugin.mainActivity = mainActivity;
        VNGPlugin.OnCreate();
    }

    public static void OnStop() {
    }

    public static void OnDestroy() {
        VNGPlugin.OnDestroy();
    }

    public static void OnResume() {
        VNGPlugin.OnResume();
    }

    public static void OnPause() {
        VNGPlugin.OnPause();
    }

    public static void OnRestart() {
    }

    public static void OnStart() {
    }

    public static void OnActivityResult(int requestCode, int resultCode, Intent data) {
    }

    public static void OnConfigurationChanged(Configuration newConfig) {
    }

    public static void OnNewIntent(Intent intent) {
    }

    public static void OnSaveInstanceState(Bundle outState) {
    }

    public static void OnBackPressed() {
        VNGPlugin.OnBackPressed();
    }

    public static void Load() {
    }

    public static void Init() {
        VNGPlugin.Init();
    }

    public static void PreInit(String cate, int token) {
    }

    static {
        System.loadLibrary("DistributePlugin");
    }
}
