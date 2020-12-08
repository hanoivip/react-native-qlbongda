package com.capstones.luaext;

import android.content.Context;
import android.database.Cursor;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;

public class APNUtil {
    public static final String CMNET = "cmnet";
    public static final String CMWAP = "cmwap";
    public static final String CTNET = "ctnet";
    public static final String CTWAP = "ctwap";
    public static final String NET_3G = "3gnet";
    public static Uri PREFERRED_APN_URI = Uri.parse("content://telephony/carriers/preferapn");
    public static final int TYPE_CM_NET = 10;
    public static final int TYPE_CM_NET_2G = 12;
    private static final int TYPE_CM_NET_4G = 18;
    public static final int TYPE_CM_WAP = 9;
    public static final int TYPE_CM_WAP_2G = 11;
    private static final int TYPE_CM_WAP_4G = 17;
    public static final int TYPE_CT_NET = 6;
    public static final int TYPE_CT_NET_2G = 8;
    private static final int TYPE_CT_NET_4G = 22;
    public static final int TYPE_CT_WAP = 5;
    public static final int TYPE_CT_WAP_2G = 7;
    private static final int TYPE_CT_WAP_4G = 21;
    public static final int TYPE_CU_NET = 14;
    public static final int TYPE_CU_NET_2G = 16;
    private static final int TYPE_CU_NET_4G = 19;
    public static final int TYPE_CU_WAP = 13;
    public static final int TYPE_CU_WAP_2G = 15;
    private static final int TYPE_CU_WAP_4G = 20;
    public static final int TYPE_NET_WORK_DISABLED = 0;
    public static final int TYPE_OTHER = 23;
    public static final int TYPE_WIFI = 4;
    public static final String UNINET = "uninet";
    public static final String UNIWAP = "uniwap";
    public static final String WAP_3G = "3gwap";

    public static boolean isNetworkAvailable(Context context) {
        NetworkInfo info = ((ConnectivityManager) context.getSystemService("connectivity")).getActiveNetworkInfo();
        if (info == null || info.getState() != NetworkInfo.State.CONNECTED) {
            return false;
        }
        return true;
    }

    public static int checkNetworkType(Context mContext) {
        try {
            NetworkInfo mobNetInfoActivity = ((ConnectivityManager) mContext.getSystemService("connectivity")).getActiveNetworkInfo();
            if (mobNetInfoActivity == null || !mobNetInfoActivity.isAvailable()) {
                return 0;
            }
            int netType = mobNetInfoActivity.getType();
            if (netType == 1) {
                return 4;
            }
            if (netType == 0) {
                boolean is4G = is4G(mContext);
                boolean is3G = isFastMobileNetwork(mContext);
                Cursor c = mContext.getContentResolver().query(PREFERRED_APN_URI, (String[]) null, (String) null, (String[]) null, (String) null);
                if (c != null) {
                    c.moveToFirst();
                    String user = c.getString(c.getColumnIndex("user"));
                    if (!TextUtils.isEmpty(user)) {
                        if (user.startsWith(CTWAP)) {
                            if (is3G) {
                                return 5;
                            }
                            if (is4G) {
                                return TYPE_CT_WAP_4G;
                            }
                            return 7;
                        } else if (user.startsWith(CTNET)) {
                            if (is3G) {
                                return 6;
                            }
                            if (is4G) {
                                return TYPE_CT_NET_4G;
                            }
                            return 8;
                        }
                    }
                }
                c.close();
                String netMode = mobNetInfoActivity.getExtraInfo();
                Log.i(BuildConfig.FLAVOR, "==================netmode:" + netMode);
                if (netMode != null) {
                    String netMode2 = netMode.toLowerCase();
                    if (netMode2.equals(CMWAP)) {
                        if (is3G) {
                            return 9;
                        }
                        if (is4G) {
                            return TYPE_CM_WAP_4G;
                        }
                        return 11;
                    } else if (netMode2.equals(CMNET)) {
                        if (is3G) {
                            return 10;
                        }
                        if (is4G) {
                            return TYPE_CM_NET_4G;
                        }
                        return 12;
                    } else if (netMode2.equals(NET_3G) || netMode2.equals(UNINET)) {
                        if (is3G) {
                            return 14;
                        }
                        if (is4G) {
                            return TYPE_CU_NET_4G;
                        }
                        return 16;
                    } else if (netMode2.equals(WAP_3G) || netMode2.equals(UNIWAP)) {
                        if (is3G) {
                            return 13;
                        }
                        if (is4G) {
                            return TYPE_CU_WAP_4G;
                        }
                        return 15;
                    }
                }
            }
            return 23;
        } catch (Exception ex) {
            ex.printStackTrace();
            return 23;
        }
    }

    private static boolean is4G(Context context) {
        if (((TelephonyManager) context.getSystemService("phone")).getNetworkType() == 13) {
            return true;
        }
        return false;
    }

    private static boolean isFastMobileNetwork(Context context) {
        switch (((TelephonyManager) context.getSystemService("phone")).getNetworkType()) {
            case 3:
                return true;
            case TYPE_CT_WAP /*5*/:
                return true;
            case TYPE_CT_NET /*6*/:
                return true;
            case TYPE_CT_NET_2G /*8*/:
                return true;
            case TYPE_CM_WAP /*9*/:
                return true;
            case TYPE_CM_NET /*10*/:
                return true;
            case TYPE_CM_NET_2G /*12*/:
                return true;
            case TYPE_CU_NET /*14*/:
                return true;
            case TYPE_CU_WAP_2G /*15*/:
                return true;
            default:
                return false;
        }
    }

    public static String getNetworkType(Context context) {
        return convert(checkNetworkType(context));
    }

    private static String convert(int type) {
        switch (type) {
            case 0:
                return "no network";
            case TYPE_WIFI /*4*/:
                return "wifi";
            case TYPE_CT_WAP /*5*/:
                return CTWAP;
            case TYPE_CT_NET /*6*/:
                return CTNET;
            case TYPE_CT_WAP_2G /*7*/:
                return "ctwap_2g";
            case TYPE_CT_NET_2G /*8*/:
                return "ctnet_2g";
            case TYPE_CM_WAP /*9*/:
                return CMWAP;
            case TYPE_CM_NET /*10*/:
                return CMNET;
            case TYPE_CM_WAP_2G /*11*/:
                return "cmwap_2g";
            case TYPE_CM_NET_2G /*12*/:
                return "cmnet_2g";
            case TYPE_CU_WAP /*13*/:
                return "cuwap";
            case TYPE_CU_NET /*14*/:
                return "cunet";
            case TYPE_CU_WAP_2G /*15*/:
                return "cuwap_2g";
            case TYPE_CU_NET_2G /*16*/:
                return "cunet_2g";
            case TYPE_CM_WAP_4G /*17*/:
                return "cmwap_4g";
            case TYPE_CM_NET_4G /*18*/:
                return "cmnet_4g";
            case TYPE_CU_NET_4G /*19*/:
                return "cunet_4g";
            case TYPE_CU_WAP_4G /*20*/:
                return "cuwap_4g";
            case TYPE_CT_WAP_4G /*21*/:
                return "ctwap_4g";
            case TYPE_CT_NET_4G /*22*/:
                return "ctnet_4g";
            case TYPE_OTHER /*23*/:
                return "other";
            default:
                return "unknow";
        }
    }
}
