package com.capstones.luaext;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.ActivityManager;
import android.content.Intent;
import android.content.res.Resources;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.provider.Settings;
import android.telephony.TelephonyManager;
import android.util.DisplayMetrics;
import android.view.WindowManager;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@SuppressLint({"NewApi"})
public class EventPlugin {
    public static String CallingCate = BuildConfig.FLAVOR;
    public static final int LETARGS = 0;
    public static final int LETRETS = 1;
    public static Activity mainActivity;

    public static native void GetGlobal(String str);

    public static native long GetLuaState();

    public static native void GetParam(int i, int i2);

    public static native int GetParamCount(int i);

    public static native boolean GetValBool();

    public static native double GetValNum();

    public static native long GetValPtr();

    public static native String GetValStr();

    public static native int NewCallToken();

    public static native int RegHandler(String str, Runnable runnable);

    public static native void SetGlobal(String str);

    public static native void SetParam(int i, int i2);

    public static native void SetParamCount(int i, int i2);

    public static native void SetValBool(boolean z);

    public static native void SetValNum(double d);

    public static native void SetValPtr(long j);

    public static native void SetValStr(String str);

    public static native void TrigEvent(String str, int i);

    public static native void UnregHandler(String str, int i);

    public static native void UnsetVal();

    static {
        System.loadLibrary("EventPlugin");
    }

    public static void Load() {
    }

    public static void Init() {
        RegHandler("GetUDID", new Runnable() {
            public void run() {
                String udid = EventPlugin.GetUDID();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(udid);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetPhoneTime", new Runnable() {
            public void run() {
                String str = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()));
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(str);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetSysVersionNum", new Runnable() {
            public void run() {
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(Build.VERSION.RELEASE + BuildConfig.FLAVOR);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetPhoneType", new Runnable() {
            public void run() {
                String phoneType = Build.MODEL;
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(phoneType);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetNetOperName", new Runnable() {
            public void run() {
                String netOperName = ((TelephonyManager) EventPlugin.mainActivity.getSystemService("phone")).getNetworkOperatorName();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(netOperName);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetNetType", new Runnable() {
            public void run() {
                String netType = APNUtil.getNetworkType(EventPlugin.mainActivity);
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(netType);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetRatio", new Runnable() {
            public void run() {
                DisplayMetrics dm = new DisplayMetrics();
                ((WindowManager) EventPlugin.mainActivity.getSystemService("window")).getDefaultDisplay().getMetrics(dm);
                int width = dm.widthPixels;
                int height = dm.heightPixels;
                EventPlugin.SetParamCount(1, 2);
                EventPlugin.SetValNum((double) width);
                EventPlugin.SetParam(1, 0);
                EventPlugin.SetValNum((double) height);
                EventPlugin.SetParam(1, 1);
            }
        });
        RegHandler("GetMacAddr", new Runnable() {
            public void run() {
                WifiInfo connectionInfo = ((WifiManager) EventPlugin.mainActivity.getApplicationContext().getSystemService("wifi")).getConnectionInfo();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(BuildConfig.FLAVOR);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetImei", new Runnable() {
            public void run() {
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(BuildConfig.FLAVOR);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("SDK_GetChannel", new Runnable() {
            public void run() {
                try {
                    Object val = EventPlugin.mainActivity.getPackageManager().getApplicationInfo(EventPlugin.mainActivity.getPackageName(), 128).metaData.get("DISTRIBUTE_CHANNEL");
                    if (val != null) {
                        EventPlugin.SetParamCount(1, 1);
                        EventPlugin.SetValStr(val.toString());
                        EventPlugin.SetParam(1, 0);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        RegHandler("SDK_GetMetaData", new Runnable() {
            public void run() {
                EventPlugin.GetParam(0, 0);
                try {
                    Object val = EventPlugin.mainActivity.getPackageManager().getApplicationInfo(EventPlugin.mainActivity.getPackageName(), 128).metaData.get(EventPlugin.GetValStr());
                    if (val != null) {
                        EventPlugin.SetParamCount(1, 1);
                        EventPlugin.SetValStr(val.toString());
                        EventPlugin.SetParam(1, 0);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        RegHandler("SDK_GetAppId", new Runnable() {
            public void run() {
                try {
                    String name = EventPlugin.mainActivity.getPackageName();
                    EventPlugin.SetParamCount(1, 1);
                    EventPlugin.SetValStr(name);
                    EventPlugin.SetParam(1, 0);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        RegHandler("SDK_GetAppName", new Runnable() {
            public void run() {
                try {
                    EventPlugin.SetParamCount(1, 1);
                    EventPlugin.SetValStr((String) EventPlugin.mainActivity.getPackageManager().getApplicationLabel(EventPlugin.mainActivity.getApplicationInfo()));
                    EventPlugin.SetParam(1, 0);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        RegHandler("SDK_GetAppVerName", new Runnable() {
            public void run() {
                try {
                    String name = EventPlugin.mainActivity.getPackageManager().getPackageInfo(EventPlugin.mainActivity.getPackageName(), 0).versionName;
                    EventPlugin.SetParamCount(1, 1);
                    EventPlugin.SetValStr(name);
                    EventPlugin.SetParam(1, 0);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        RegHandler("SDK_GetAppVerCode", new Runnable() {
            public void run() {
                try {
                    int code = EventPlugin.mainActivity.getPackageManager().getPackageInfo(EventPlugin.mainActivity.getPackageName(), 0).versionCode;
                    EventPlugin.SetParamCount(1, 1);
                    EventPlugin.SetValNum((double) code);
                    EventPlugin.SetParam(1, 0);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        RegHandler("GetMemTotal", new Runnable() {
            public void run() {
                double totalMem = AndroidDeviceInfo.GetMemTotal();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValNum(totalMem);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetMemAvail", new Runnable() {
            public void run() {
                ActivityManager.MemoryInfo meminfo = new ActivityManager.MemoryInfo();
                ((ActivityManager) EventPlugin.mainActivity.getSystemService("activity")).getMemoryInfo(meminfo);
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValNum((double) (meminfo.availMem >> 10));
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetCpuName", new Runnable() {
            public void run() {
                String name = AndroidDeviceInfo.GetCpuName();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(name);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetMaxCpuFreq", new Runnable() {
            public void run() {
                String maxCpuFreq = AndroidDeviceInfo.GetMaxCpuFreq();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(maxCpuFreq);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetMinCpuFreq", new Runnable() {
            public void run() {
                String minCpuFreq = AndroidDeviceInfo.GetMinCpuFreq();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(minCpuFreq);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetCurCpuFreq", new Runnable() {
            public void run() {
                String curCpuFreq = AndroidDeviceInfo.GetCurCpuFreq();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(curCpuFreq);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetCpuKernel", new Runnable() {
            public void run() {
                int cpuKernal = AndroidDeviceInfo.GetCpuKernel();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValNum((double) cpuKernal);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("GetCpuCoresNum", new Runnable() {
            public void run() {
                int cpuCores = AndroidDeviceInfo.GetCpuCoresNum();
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValNum((double) cpuCores);
                EventPlugin.SetParam(1, 0);
            }
        });
        RegHandler("SDK_OpenWebView", new Runnable() {
            public void run() {
                Intent intent = new Intent(EventPlugin.mainActivity, WebViewActivity.class);
                EventPlugin.GetParam(0, 0);
                String url = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 1);
                String userAgentAppend = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 2);
                int excnt = (int) EventPlugin.GetValNum();
                for (int i = 1; i <= excnt; i++) {
                    EventPlugin.GetParam(0, (i * 2) + 1);
                    String key = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, (i * 2) + 2);
                    String val = EventPlugin.GetValStr();
                    intent.putExtra("httpHeadersKey" + i, key);
                    intent.putExtra("httpHeadersVal" + i, val);
                }
                intent.putExtra("url", url);
                intent.putExtra("userAgentAppend", userAgentAppend);
                EventPlugin.mainActivity.startActivity(intent);
            }
        });
        RegHandler("GetLang", new Runnable() {
            public void run() {
                Locale locale;
                Resources res = EventPlugin.mainActivity.getResources();
                if (Build.VERSION.SDK_INT >= 24) {
                    locale = res.getConfiguration().getLocales().get(0);
                } else {
                    locale = res.getConfiguration().locale;
                }
                String language = locale.getLanguage();
                String countryCode = locale.getCountry();
                EventPlugin.SetParamCount(1, 2);
                EventPlugin.SetValStr(language);
                EventPlugin.SetParam(1, 0);
                EventPlugin.SetValStr(countryCode);
                EventPlugin.SetParam(1, 1);
            }
        });
    }

    public static String GetUDID() {
        String uuid = Settings.Secure.getString(mainActivity.getContentResolver(), "android_id");
        if (uuid == null || uuid.equals(BuildConfig.FLAVOR) || "9774d56d682e549c".equals(uuid)) {
            try {
                uuid = ((TelephonyManager) mainActivity.getSystemService("phone")).getDeviceId();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return uuid == null ? BuildConfig.FLAVOR : uuid;
    }

    public static void SetCallingCate(String cate) {
        CallingCate = cate;
    }

    private static int TrigJavaEvent(String cate, Object... args) {
        int token = NewCallToken();
        int argcnt = args == null ? 0 : args.length;
        SetParamCount(token, argcnt);
        for (int i = 0; i < argcnt; i++) {
            Object arg = args[i];
            if (arg instanceof Boolean) {
                SetValBool(((Boolean) arg).booleanValue());
            } else if (arg instanceof Double) {
                SetValNum(((Double) arg).doubleValue());
            } else if (arg instanceof Long) {
                SetValPtr(((Long) arg).longValue());
            } else if (arg instanceof String) {
                SetValStr((String) arg);
            } else {
                UnsetVal();
            }
            SetParam(token, i);
        }
        TrigEvent(cate, token);
        return token;
    }

    public static boolean TrigJavaEventBool(String cate, Object... args) {
        GetParam(TrigJavaEvent(cate, args), 0);
        return GetValBool();
    }

    public static double TrigJavaEventNum(String cate, Object... args) {
        GetParam(TrigJavaEvent(cate, args), 0);
        return GetValNum();
    }

    public static long TrigJavaEventPtr(String cate, Object... args) {
        GetParam(TrigJavaEvent(cate, args), 0);
        return GetValPtr();
    }

    public static String TrigJavaEventStr(String cate, Object... args) {
        GetParam(TrigJavaEvent(cate, args), 0);
        return GetValStr();
    }
}
