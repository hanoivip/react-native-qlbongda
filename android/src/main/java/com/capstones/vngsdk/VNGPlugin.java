package com.capstones.vngsdk;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Process;
import android.util.Log;
//import com.appsflyer.AppsFlyerLib;
import com.capstones.luaext.EventPlugin;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;

public class VNGPlugin {
    private static String EventCall = "Call!";
    /* access modifiers changed from: private */
    public static int logoutSuccessListenerHandle = 0;
    public static Activity mainActivity;
    /* access modifiers changed from: private */
    public static boolean sdkReadyToStart = false;
    public static String strSDKReady = "ready";
    public static String strSDKUnReady = "unready";
    /* access modifiers changed from: private */
    public static int trigSDKReadyStartCount = 0;
    
    //hanoivip
    public static String userID = null;
    public static String accessToken = null;
    
    private String path = BuildConfig.FLAVOR;

    public static void OnCreate() {
        InitSDK();
    }

    public static void InitSDK() {
        Log.d("VNGSDK", "\n-------------------InitSDK-------------------\n");
        VNGPlugin.sdkReadyToStart = true;
    }

    public static void OnDestroy() {
    }

    public static void OnResume() {
    }

    public static void OnPause() {
    }

    public static void OnBackPressed() {
    }

    public static Runnable RunOnUIThread(final Runnable raw) {
        return new Runnable() {
            public void run() {
                VNGPlugin.mainActivity.runOnUiThread(raw);
            }
        };
    }

    /* access modifiers changed from: private */
    public static String getMd5ByFile(File file) throws FileNotFoundException {
        System.out.print("getMd5ByFile step 1");
        if (!file.isFile()) {
            return BuildConfig.FLAVOR;
        }
        byte[] buffer = new byte[1024];
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            FileInputStream in = new FileInputStream(file);
            while (true) {
                try {
                    int len = in.read(buffer, 0, 1024);
                    if (len == -1) {
                        break;
                    }
                    digest.update(buffer, 0, len);
                } catch (Exception e) {
                    e = e;
                    FileInputStream fileInputStream = in;
                    e.printStackTrace();
                    return BuildConfig.FLAVOR;
                }
            }
            in.close();
            byte[] md5Bytes = digest.digest();
            StringBuffer hexValue = new StringBuffer();
            for (byte b : md5Bytes) {
                int val = b & 255;
                if (val < 16) {
                    hexValue.append("0");
                }
                hexValue.append(Integer.toHexString(val));
            }
            return hexValue.toString();
        } catch (Exception e2) {
            e2.printStackTrace();
            return BuildConfig.FLAVOR;
        }
    }

    /* access modifiers changed from: private */
    public static String getObbPath() {
        try {
            int code = mainActivity.getPackageManager().getPackageInfo(mainActivity.getPackageName(), 0).versionCode;
            return String.format("%s/main.%d.%s.obb", new Object[]{mainActivity.getObbDir().getAbsolutePath(), Integer.valueOf(code), mainActivity.getPackageName()});
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

    /* access modifiers changed from: private */
    public static void LogInSuccessCall() {
        final String userId = VNGPlugin.userID;//userInfo.userId;
        final String displayName = "";//userInfo.displayName;
        final String sessionId = VNGPlugin.accessToken;//userInfo.sessionId;
        final String loginType = "";//userInfo.getLoginType();
        final String tokenForBusiness = "abcdef123456789";//userInfo.tokenForBusiness;
        final String oauthen = "111";//userInfo.oauthen;
        final String socialId = "222";//userInfo.socialId;
        EventPlugin.RegHandler(EventCall, new Runnable() {
            public void run() {
                int token = EventPlugin.NewCallToken();
                EventPlugin.SetParamCount(token, 9);
                EventPlugin.SetValStr(userId);
                EventPlugin.SetParam(token, 0);
                EventPlugin.SetValStr(displayName);
                EventPlugin.SetParam(token, 1);
                EventPlugin.SetValStr(sessionId);
                EventPlugin.SetParam(token, 2);
                EventPlugin.SetValStr(loginType);
                EventPlugin.SetParam(token, 3);
                EventPlugin.SetValStr("VN");
                EventPlugin.SetParam(token, 4);
                EventPlugin.SetValStr(tokenForBusiness);
                EventPlugin.SetParam(token, 5);
                EventPlugin.SetValStr(oauthen);
                EventPlugin.SetParam(token, 6);
                EventPlugin.SetValStr("GGAuthcode");
                EventPlugin.SetParam(token, 7);
                EventPlugin.SetValStr(socialId);
                EventPlugin.SetParam(token, 8);
                EventPlugin.TrigEvent("Dist_LoginSuccess_VNG", token);
            }
        });
    }

    public static void Init() {
        EventPlugin.RegHandler("SDK_HasAccountSystem", new Runnable() {
            public void run() {
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValBool(true);
                EventPlugin.SetParam(1, 0);
            }
        });
        EventPlugin.RegHandler("SDK_READY_TO_START", new Runnable() {
            public void run() {
                EventPlugin.SetParamCount(1, 1);
                EventPlugin.SetValStr(VNGPlugin.sdkReadyToStart ? VNGPlugin.strSDKReady : VNGPlugin.strSDKUnReady);
                EventPlugin.SetParam(1, 0);
                int unused = VNGPlugin.trigSDKReadyStartCount = VNGPlugin.trigSDKReadyStartCount + 1;
                if (!VNGPlugin.sdkReadyToStart && VNGPlugin.trigSDKReadyStartCount > 150) {
                    Log.d("VNGSDK", "\n-------------------retry init-------------------\n");
                    VNGPlugin.InitSDK();
                    int unused2 = VNGPlugin.trigSDKReadyStartCount = 0;
                }
            }
        });
        EventPlugin.RegHandler("SDK_Login", RunOnUIThread(new Runnable() {
            public void run() {
                Log.d("VNGSDK", "\n-------------------SDK_Login-------------------\n");
                EventPlugin.TrigEvent("Dist_VNGSDK_Close", EventPlugin.NewCallToken());
                //VNGPlugin.userID = "36";//userInfo.userId;
                VNGPlugin.LogInSuccessCall();
                /*
                GTLoginManager.autoLogin(VNGPlugin.mainActivity, new LoginListener() {
                    public void onSuccess(UserInfo userInfo) {
                        Log.d("VNGSDK", "\n-------------------SDK_Login onSuccess-------------------\n");
                        Log.d("VNGSDK", "\n-------------------SDK_Login onSuccess start-------------------\n");
                        Log.d("VNGSDK", "\n" + ("userInfo.userId : " + userInfo.userId + "，" + "displayName : " + userInfo.displayName + "sessionId : " + userInfo.sessionId + "，LoginType : " + userInfo.getLoginType() + "，tokenForBusiness : " + userInfo.tokenForBusiness + "，oauthen : " + userInfo.oauthen + "，socialId : " + userInfo.socialId + "\n") + "\n");
                        Log.d("VNGSDK", "\n-------------------SDK_Login onSuccess end-------------------\n");
                        int unused = VNGPlugin.logoutSuccessListenerHandle = 0;
                        VNGPlugin.userID = userInfo.userId;
                        VNGPlugin.LogInSuccessCall(userInfo);
                    }

                    public void onFail(Error error) {
                        Log.d("VNGSDK", "\n-------------------SDK_Login onFail-------------------\n");
                        EventPlugin.TrigEvent("Dist_LoginFailed", EventPlugin.NewCallToken());
                    }
                });
                 */
            }
        }));
        EventPlugin.RegHandler("SDK_Logout", new Runnable() {
            public void run() {
                Log.d("VNGSDK", "\n-------------------SDK_Logout-------------------\n");
                if (VNGPlugin.logoutSuccessListenerHandle == 0) {
                    int unused = VNGPlugin.logoutSuccessListenerHandle = 1;
                    VNGPlugin.mainActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            //GTLoginManager.logout();
                            Log.d("VNGSDK", "\n-------------------SDK_Logout onComplete-------------------\n");
                            EventPlugin.TrigEvent("Dist_Logout", EventPlugin.NewCallToken());
                        }
                    });
                }
            }
        });
        EventPlugin.RegHandler("SDK_Pay", new Runnable() {
            public void run() {
                Log.d("VNGSDK", "\n-------------------SDK_Pay-------------------\n");
                EventPlugin.GetParam(0, 0);
                final String serverID = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 1);
                final String amount = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 2);
                final String itemID = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 3);
                final String itemName = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 4);
                final String appTransID = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 5);
                final String addInfo = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 6);
                final String roleID = EventPlugin.GetValStr();
                /*
                final PaymentInfo paymentInfo = new PaymentInfo();
                paymentInfo.setUserID(GTSDK.currentUserInfo().userId);
                paymentInfo.setServerID(serverID);
                paymentInfo.setAddInfo(addInfo);
                paymentInfo.setAmount(Double.valueOf(Double.parseDouble(amount)));
                paymentInfo.setAppTransID(appTransID);
                paymentInfo.setItemID(itemID);
                paymentInfo.setRoleID(roleID);
                paymentInfo.setItemDisplayName(roleID);
                VNGPlugin.mainActivity.runOnUiThread(new Runnable() {
                    public void run() {
                        try {
                            Log.d("VNGSDK", "\n-------------------SDK_Pay payStart-------------------\n");
                            Log.d("VNGSDK", "\n-------------------SDK_Pay payInfo start-------------------\n");
                            Log.d("VNGSDK", "\n" + ("VNGPlugin.userID : " + GTSDK.currentUserInfo().userId + "，" + "serverID : " + serverID + "，amount : " + amount + "，itemID : " + itemID + "，itemName : " + itemName + "，appTransID : " + appTransID + "，addInfo : " + addInfo + "，roleID : " + roleID + "\n") + "\n");
                            Log.d("VNGSDK", "\n-------------------SDK_Pay payInfo end-------------------\n");
                            GTPaymentManager.pay(VNGPlugin.mainActivity, paymentInfo, new PaymentListener() {
                                public void onSuccess() {
                                    Log.d("VNGSDK", "\n-------------------SDK_Pay onSuccess-------------------\n");
                                    EventPlugin.TrigEvent("Dist_PaySuccess", EventPlugin.NewCallToken());
                                }

                                public void onProcessing() {
                                    Log.d("VNGSDK", "\n-------------------SDK_Pay onProcessing-------------------\n");
                                }

                                public void onCancel() {
                                    Log.d("VNGSDK", "\n-------------------SDK_Pay onCancel-------------------\n");
                                }

                                public void onFail(String s) {
                                    Log.d("VNGSDK", "\n-------------------SDK_Pay onFail-------------------\n");
                                    EventPlugin.TrigEvent("Dist_PayFail", EventPlugin.NewCallToken());
                                }
                            });
                        } catch (Exception e) {
                            Log.d("VNGSDK", "\n-------------------SDK_Pay error-------------------\n");
                            e.printStackTrace();
                        }
                    }
                });*/
            }
        });
        EventPlugin.RegHandler("SDK_CustomerService", new Runnable() {
            public void run() {
                Log.d("VNGSDK", "\n-------------------SDK_CustomerService-------------------\n");
                EventPlugin.GetParam(0, 0);
                String roleName = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 1);
                String level = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 2);
                String guild = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 3);
                String content = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 4);
                String serverID = EventPlugin.GetValStr();
                /*
                final CustomerSupportInfo info = new CustomerSupportInfo();
                info.setRoleName(roleName);
                info.setLevel(level);
                info.setGuild(guild);
                info.setServerId(serverID);
                info.setContent(content);
                Log.d("VNGSDK", "roleName : " + roleName + "，" + "level : " + level + "guild : " + guild + ", serverID : " + serverID + ", content : " + content + "\n");
                VNGPlugin.mainActivity.runOnUiThread(new Runnable() {
                    public void run() {
                        GTSDK.showCustomerSuppport(VNGPlugin.mainActivity, info, new CustomerSupportListener() {
                            public void onComplete() {
                                Log.d("VNGSDK", "SDK_CustomerService onComplete");
                            }

                            public void onError(Error error) {
                                Log.d("VNGSDK", "SDK_CustomerService onError");
                            }
                        });
                    }
                });*/
            }
        });
        EventPlugin.RegHandler("SDK_FBFriendList", new Runnable() {
            public void run() {
                /*
                GTFacebookSocial.getFriends(VNGPlugin.mainActivity, 0, 200, new SocialListener<SocialUserInfo[]>() {
                    public void onSuccess(SocialUserInfo[] socialUserInfos) {
                        int token = EventPlugin.NewCallToken();
                        EventPlugin.SetParamCount(token, socialUserInfos.length * 3);
                        Log.d("VNGSDK", "\n ---------- SDK_FBFriendList onSuccess-------------\n");
                        int count = 0;
                        for (int i = 0; i < socialUserInfos.length; i++) {
                            try {
                                String id = socialUserInfos[i].userID;
                                EventPlugin.SetValStr(id);
                                EventPlugin.SetParam(token, count);
                                String name = socialUserInfos[i].name;
                                EventPlugin.SetValStr(name);
                                EventPlugin.SetParam(token, count + 1);
                                String picture = socialUserInfos[i].avatarImageURL;
                                EventPlugin.SetValStr(picture);
                                EventPlugin.SetParam(token, count + 2);
                                count += 3;
                                Log.d("VNGSDK", "\n socialUserInfos  id :" + id + " name :" + name + " picture :" + picture + "\n");
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        EventPlugin.TrigEvent("SDK_FBFriendList_OnComplete", token);
                    }

                    public void onFail(String s) {
                        Log.d("VNGSDK", "\n ---------- SDK_FBFriendList onFail -------------\n");
                    }

                    public void onCancel() {
                        Log.d("VNGSDK", "\n ---------- SDK_FBFriendList onCancel -------------\n");
                    }
                });*/
            }
        });
        EventPlugin.RegHandler("SDK_SharePhotoToFacebook", new Runnable() {
            public void run() {
                EventPlugin.GetParam(0, 0);
                String imagePath = EventPlugin.GetValStr();
                Log.d("VNGSDK", "\n ---------- SDK_SharePhotoToFacebook -------------\n");
                Log.d("VNGSDK", "\n imagePath: " + imagePath + "\n");
                /*
                try {
                    final Bitmap imageBitMap = BitmapFactory.decodeStream(new FileInputStream(imagePath));
                    VNGPlugin.mainActivity.runOnUiThread(new Runnable() {
                        public void run() {
                            GTFacebookSocial.sharePhoto(VNGPlugin.mainActivity, imageBitMap, "Hinh dep", new SocialListener<Object>() {
                                public void onSuccess(Object o) {
                                    Log.d("VNGSDK", "\n ---------- SDK_SharePhotoToFacebook onSuccess-------------\n");
                                    EventPlugin.TrigEvent("SDK_ShareImage_OnComplete", EventPlugin.NewCallToken());
                                }

                                public void onFail(String s) {
                                    Log.d("VNGSDK", "\n ---------- SDK_SharePhotoToFacebook onFail-------------\n");
                                    EventPlugin.TrigEvent("SDK_ShareImage_OnError", EventPlugin.NewCallToken());
                                    System.out.println("SDK_ShareImage_OnError...");
                                }

                                public void onCancel() {
                                    Log.d("VNGSDK", "\n ---------- SDK_SharePhotoToFacebook onCancel-------------\n");
                                    EventPlugin.TrigEvent("SDK_ShareImage_OnCancel", EventPlugin.NewCallToken());
                                }
                            });
                        }
                    });
                } catch (IOException e) {
                    Log.d("VNGSDK", "\n ---------- SDK_SharePhotoToFacebook IOException-------------\n");
                    e.printStackTrace();
                }*/
            }
        });
        EventPlugin.RegHandler("SDK_ShareFacebookLink", new Runnable() {
            public void run() {
                EventPlugin.GetParam(0, 0);
                final String contentURL = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 1);
                final String contentTitle = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 2);
                final String imageURL = EventPlugin.GetValStr();
                EventPlugin.GetParam(0, 3);
                final String contentDescription = EventPlugin.GetValStr();
                Log.d("VNGSDK", "\n ---------- SDK_ShareFacebookLink-------------\n");
                Log.d("VNGSDK", "shareLogStr" + (" contentURL: " + contentURL + " contentTitle: " + contentTitle + " imageURL: " + imageURL + " contentDescription: " + contentDescription));
                VNGPlugin.mainActivity.runOnUiThread(new Runnable() {
                    public void run() {
                        /*
                        GTFacebookSocial.shareLink(VNGPlugin.mainActivity, contentURL, imageURL, contentTitle, contentDescription, new SocialListener<Object>() {
                            public void onSuccess(Object o) {
                                Log.d("VNGSDK", "\n ---------- SDK_ShareFacebookLink onSuccess -------------\n");
                            }

                            public void onFail(String s) {
                                Log.d("VNGSDK", "\n ---------- SDK_ShareFacebookLink onFail -------------\n");
                            }

                            public void onCancel() {
                                Log.d("VNGSDK", "\n ---------- SDK_ShareFacebookLink onCancel -------------\n");
                            }
                        });*/
                    }
                });
            }
        });
        EventPlugin.RegHandler("SDK_InviteFriendFB", new Runnable() {
            public void run() {
                EventPlugin.GetParam(0, 0);
                final String message = EventPlugin.GetValStr();
                Log.d("VNGSDK", "\n ---------- SDK_InviteFriendFB -------------\n");
                Log.d("VNGSDK", "message:" + message);
                VNGPlugin.mainActivity.runOnUiThread(new Runnable() {
                    public void run() {
                        Log.d("VNGSDK", "\n ---------- SDK_InviteFriendFB start-------------\n");
                        /*
                        GTFacebookSocial.inviteFriends(VNGPlugin.mainActivity, message, SocialModule.SocialFriendType.APP_NON_USERS, new SocialListener<String[]>() {
                            public void onSuccess(String[] result) {
                                Log.d("VNGSDK", "\n ---------- SDK_InviteFriendFB onSuccess -------------\n");
                                Log.d("VNGSDK", "result:" + result.toString());
                                int token = EventPlugin.NewCallToken();
                                EventPlugin.SetParamCount(token, 1);
                                EventPlugin.SetValStr(result[1]);
                                EventPlugin.SetParam(token, 0);
                                EventPlugin.TrigEvent("SDK_InviteFriendFB_OnSuccess", token);
                            }

                            public void onFail(String s) {
                                Log.d("VNGSDK", "\n ---------- SDK_InviteFriendFB onFail -------------\n");
                                EventPlugin.TrigEvent("SDK_InviteFriendFB_OnError", EventPlugin.NewCallToken());
                                System.out.println("SDK_InviteFriendFB_OnError...");
                            }

                            public void onCancel() {
                                Log.d("VNGSDK", "\n ---------- SDK_InviteFriendFB onCancel -------------\n");
                                EventPlugin.TrigEvent("SDK_InviteFriendFB_OnCancel", EventPlugin.NewCallToken());
                            }
                        });*/
                    }
                });
            }
        });
        EventPlugin.RegHandler("SDK_GetFBProfile", RunOnUIThread(new Runnable() {
            public void run() {
                /*
                GTFacebookSocial.getProfile(VNGPlugin.mainActivity, new SocialListener<SocialUserInfo>() {
                    public void onSuccess(SocialUserInfo socialUserInfo) {
                        String str = "Name: " + socialUserInfo.name + "URL Avatar: " + socialUserInfo.avatarImageURL;
                        Log.d("VNGSDK", "\n ---------- SDK_GetFBProfile onSuccess -------------\n");
                    }

                    public void onFail(String s) {
                        Log.d("VNGSDK", "\n ---------- SDK_GetFBProfile onFailure -------------\n");
                        Log.d("VNGSDK", "onFail:" + s);
                    }

                    public void onCancel() {
                        Log.d("VNGSDK", "\n ---------- SDK_GetFBProfile onCancel -------------\n");
                    }
                });*/
            }
        }));
        EventPlugin.RegHandler("SDK_Report", new Runnable() {
            public void run() {
                Log.d("VNGSDK", "\n ---------- SDK_Report -------------\n");
                EventPlugin.GetParam(0, 0);
                String eventId = EventPlugin.GetValStr();
                Log.d("VNGSDK", "\n DK_Report eventId = " + eventId);
                HashMap hashMap = new HashMap();
                if ("created_role".equals(eventId)) {
                    EventPlugin.GetParam(0, 1);
                    String id = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 2);
                    String name = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 3);
                    String GetValStr = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 4);
                    String serverCode = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 5);
                    String serverName = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 6);
                    String GetValStr2 = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 7);
                    String GetValStr3 = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 8);
                    String roleLvl = EventPlugin.GetValStr();
                    hashMap.put(UserExtDataKeys.ROLE_ID, id);
                    hashMap.put(UserExtDataKeys.ROLE_NAME, name);
                    hashMap.put("ROLE_LEVEL", roleLvl);
                    hashMap.put(UserExtDataKeys.ZONE_ID, serverCode);
                    hashMap.put(UserExtDataKeys.ZONE_NAME, serverName);
                    hashMap.put(UserExtDataKeys.PHYLUM, "37");
                    hashMap.put(UserExtDataKeys.ACTION, UserExtDataKeys.ACTION_CREATE_ROLE);
                } else if ("sdk_login_begin".equals(eventId)) {
                    EventPlugin.GetParam(0, 1);
                    hashMap.put(UserExtDataKeys.CLASSFIELD, EventPlugin.GetValStr());
                    hashMap.put(UserExtDataKeys.PHYLUM, "14");
                    hashMap.put(UserExtDataKeys.ACTION, "sdk_login_begin");
                } else if ("sdk_login_done".equals(eventId)) {
                    EventPlugin.GetParam(0, 1);
                    String GetValStr4 = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 2);
                    String GetValStr5 = EventPlugin.GetValStr();
                    EventPlugin.GetParam(0, 3);
                    hashMap.put(UserExtDataKeys.CLASSFIELD, EventPlugin.GetValStr());
                    hashMap.put(UserExtDataKeys.PHYLUM, "31");
                    hashMap.put(UserExtDataKeys.ACTION, "sdk_login_done");
                } else if (!"enter_server".equals(eventId)) {
                    if ("home_enter".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleId = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleName = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String roleLvl2 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String serverCode2 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String serverName2 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 6);
                        String diamond = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 7);
                        String vipLvl = EventPlugin.GetValStr();
                        hashMap.put(UserExtDataKeys.ROLE_ID, roleId);
                        hashMap.put(UserExtDataKeys.ROLE_NAME, roleName);
                        hashMap.put("ROLE_LEVEL", roleLvl2);
                        hashMap.put(UserExtDataKeys.ZONE_ID, serverCode2);
                        hashMap.put(UserExtDataKeys.ZONE_NAME, serverName2);
                        hashMap.put(UserExtDataKeys.BALANCE, diamond);
                        hashMap.put(UserExtDataKeys.VIP, vipLvl);
                        hashMap.put(UserExtDataKeys.PHYLUM, "39");
                        hashMap.put(UserExtDataKeys.ACTION, "home_enter");
                        Bundle params = new Bundle();
                        params.putString(UserExtDataKeys.ROLE_ID, roleId);
                        params.putString(UserExtDataKeys.ROLE_NAME, roleName);
                        params.putString("ROLE_LEVEL", roleLvl2);
                        params.putString(UserExtDataKeys.ZONE_ID, serverCode2);
                        params.putString(UserExtDataKeys.ZONE_NAME, serverName2);
                        params.putString(UserExtDataKeys.BALANCE, diamond);
                        params.putString(UserExtDataKeys.VIP, vipLvl);
                        //GTAnalytics.sendEvent(VNGPlugin.mainActivity).login(params);
                    } else if ("levelup".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleLvl3 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleId2 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String roleName2 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String serverCode3 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String serverName3 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 6);
                        String rolePower = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 7);
                        String vipLvl2 = EventPlugin.GetValStr();
                        hashMap.put(UserExtDataKeys.ROLE_ID, roleId2);
                        hashMap.put(UserExtDataKeys.ROLE_NAME, roleName2);
                        hashMap.put("ROLE_LEVEL", roleLvl3);
                        hashMap.put(UserExtDataKeys.ZONE_ID, serverCode3);
                        hashMap.put(UserExtDataKeys.ZONE_NAME, serverName3);
                        hashMap.put(UserExtDataKeys.VIP, vipLvl2);
                        hashMap.put(UserExtDataKeys.PHYLUM, "41");
                        hashMap.put(UserExtDataKeys.ACTION, UserExtDataKeys.ACTION_LEVEL_UP);
                        Bundle params2 = new Bundle();
                        params2.putString(UserExtDataKeys.ROLE_ID, roleId2);
                        params2.putString(UserExtDataKeys.ROLE_NAME, roleName2);
                        params2.putString("ROLE_LEVEL", roleLvl3);
                        params2.putString(UserExtDataKeys.ZONE_ID, serverCode3);
                        params2.putString(UserExtDataKeys.ZONE_NAME, serverName3);
                        params2.putString(UserExtDataKeys.VIP, vipLvl2);
                        params2.putString("ROLE_POWER", rolePower);
                        //GTAnalytics.sendEvent(VNGPlugin.mainActivity).levelUp(params2);
                    } else if ("pay_begin".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleId3 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleLvl4 = EventPlugin.GetValStr();
                        hashMap.put(UserExtDataKeys.ROLE_ID, roleId3);
                        hashMap.put("ROLE_LEVEL", roleLvl4);
                        hashMap.put(UserExtDataKeys.ACTION, "pay_begin");
                    } else if ("pay_done".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleId4 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleLvl5 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String price = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String productName = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String productDesc = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 6);
                        String productId = EventPlugin.GetValStr();
                        hashMap.put(UserExtDataKeys.ROLE_ID, roleId4);
                        hashMap.put("ROLE_LEVEL", roleLvl5);
                        hashMap.put("price", price);
                        hashMap.put("productName", productName);
                        hashMap.put("productDesc", productDesc);
                        hashMap.put(UserExtDataKeys.PHYLUM, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, "af_pay_" + productId);
                    } else if ("vip_levelup".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String vipLvl3 = EventPlugin.GetValStr();
                        hashMap.put(UserExtDataKeys.VIP, vipLvl3);
                        hashMap.put(UserExtDataKeys.PHYLUM, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, "af_vip_" + vipLvl3);
                    } else if (UserExtDataKeys.ACTION_UNCOMPRESS.equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "6");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, UserExtDataKeys.ACTION_UNCOMPRESS);
                    } else if ("uncompress_result_success".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "7");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, "ok");
                        hashMap.put(UserExtDataKeys.ACTION, "uncompress_result");
                    } else if ("uncompress_result_fail".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "7");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, "fail");
                        hashMap.put(UserExtDataKeys.ACTION, "uncompress_result");
                    } else if ("update_begin".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "8");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, UserExtDataKeys.ACTION_HOTUPDATE);
                    } else if ("update_done".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "9");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, "ok");
                        hashMap.put(UserExtDataKeys.ACTION, "hotupdate_result");
                    } else if ("unupdate_result_pass".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "9");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, "pass");
                        hashMap.put(UserExtDataKeys.ACTION, "hotupdate_result");
                    } else if ("announcement_open".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "32");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, "announcement_open");
                    } else if ("announcement_close".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "33");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, "announcement_close");
                    } else if ("sample_match_start".equals(eventId)) {
                        hashMap.put(UserExtDataKeys.PHYLUM, "35");
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, "sample_match_start");
                    } else if ("last_chapter_id".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        hashMap.put(UserExtDataKeys.PHYLUM, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, "af_chapter_" + EventPlugin.GetValStr());
                    } else if ("af_guildwar".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        hashMap.put(UserExtDataKeys.PHYLUM, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, "af_guildwar_" + EventPlugin.GetValStr());
                    } else if ("get_assign_card".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String cid = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String quality = EventPlugin.GetValStr();
                        String af_card = BuildConfig.FLAVOR;
                        if (quality.equals("6")) {
                            af_card = "af-getcard_ss_";
                        } else if (quality.equals("7")) {
                            af_card = "af-getcard_sss_";
                        }
                        hashMap.put(UserExtDataKeys.PHYLUM, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.CLASSFIELD, BuildConfig.FLAVOR);
                        hashMap.put(UserExtDataKeys.ACTION, af_card + cid);
                    } else if ("guild_join".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String guildId = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String guildName = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String serverCode4 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String serverName4 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String roleId5 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 6);
                        String roleName3 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 7);
                        String roleLvl6 = EventPlugin.GetValStr();
                        Bundle params3 = new Bundle();
                        params3.putString("GROUP_ID", guildId);
                        params3.putString("GROUP_NAME", guildName);
                        params3.putString(UserExtDataKeys.ZONE_ID, serverCode4);
                        params3.putString(UserExtDataKeys.ZONE_NAME, serverName4);
                        params3.putString(UserExtDataKeys.ROLE_ID, roleId5);
                        params3.putString(UserExtDataKeys.ROLE_NAME, roleName3);
                        params3.putString("ROLE_LEVEL", roleLvl6);
                        //GTAnalytics.sendEvent(VNGPlugin.mainActivity).joinGroup(params3);
                    } else if ("guide_begin".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleId6 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleLvl7 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String roleName4 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String serverCode5 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String serverName5 = EventPlugin.GetValStr();
                        Bundle params4 = new Bundle();
                        params4.putString(UserExtDataKeys.ROLE_ID, roleId6);
                        params4.putString(UserExtDataKeys.ROLE_NAME, roleName4);
                        params4.putString("ROLE_LEVEL", roleLvl7);
                        params4.putString(UserExtDataKeys.ZONE_ID, serverCode5);
                        params4.putString(UserExtDataKeys.ZONE_NAME, serverName5);
                       //GTAnalytics.sendEvent(VNGPlugin.mainActivity).tutorialBegin(params4);
                    } else if ("guide_done".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleId7 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleLvl8 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String roleName5 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String serverCode6 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String serverName6 = EventPlugin.GetValStr();
                        Bundle params5 = new Bundle();
                        params5.putString(UserExtDataKeys.ROLE_ID, roleId7);
                        params5.putString(UserExtDataKeys.ROLE_NAME, roleName5);
                        params5.putString("ROLE_LEVEL", roleLvl8);
                        params5.putString(UserExtDataKeys.ZONE_ID, serverCode6);
                        params5.putString(UserExtDataKeys.ZONE_NAME, serverName6);
                        //GTAnalytics.sendEvent(VNGPlugin.mainActivity).tutorialComplete(params5);
                    } else if ("cost_currency".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleId8 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleLvl9 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String roleName6 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String serverCode7 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String serverName7 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 6);
                        String currencyType = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 7);
                        String costNum = EventPlugin.GetValStr();
                        Bundle params6 = new Bundle();
                        params6.putString(UserExtDataKeys.ROLE_ID, roleId8);
                        params6.putString(UserExtDataKeys.ROLE_NAME, roleName6);
                        params6.putString("ROLE_LEVEL", roleLvl9);
                        params6.putString(UserExtDataKeys.ZONE_ID, serverCode7);
                        params6.putString(UserExtDataKeys.ZONE_NAME, serverName7);
                        params6.putString("CURRENCY_TYPE", currencyType);
                        params6.putString("COST_NUM", costNum);
                        //GTAnalytics.sendEvent(VNGPlugin.mainActivity).spendVirtualCurrency(params6);
                    } else if ("add_currency".equals(eventId)) {
                        EventPlugin.GetParam(0, 1);
                        String roleId9 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 2);
                        String roleLvl10 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 3);
                        String roleName7 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 4);
                        String serverCode8 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 5);
                        String serverName8 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 6);
                        String currencyType2 = EventPlugin.GetValStr();
                        EventPlugin.GetParam(0, 7);
                        String addNum = EventPlugin.GetValStr();
                        Bundle params7 = new Bundle();
                        params7.putString(UserExtDataKeys.ROLE_ID, roleId9);
                        params7.putString(UserExtDataKeys.ROLE_NAME, roleName7);
                        params7.putString("ROLE_LEVEL", roleLvl10);
                        params7.putString(UserExtDataKeys.ZONE_ID, serverCode8);
                        params7.putString(UserExtDataKeys.ZONE_NAME, serverName8);
                        params7.putString("CURRENCY_TYPE", currencyType2);
                        params7.putString("ADD_NUM", addNum);
                        //GTAnalytics.sendEvent(VNGPlugin.mainActivity).earnVirtualCurrency(params7);
                    } else if (eventId != null) {
                        hashMap.put(UserExtDataKeys.ACTION, eventId);
                    }
                }
                //AppsFlyerLib.getInstance().trackEvent(VNGPlugin.mainActivity, eventId, hashMap);
            }
        });
        EventPlugin.RegHandler("GET_MAIN_OBB_PATH", new Runnable() {
            public void run() {
                String result = null;
                try {
                    String isObb = VNGPlugin.mainActivity.getPackageManager().getApplicationInfo(VNGPlugin.mainActivity.getPackageName(), PackageManager.GET_META_DATA).metaData.get("IS_OBB").toString();
                    System.out.println("GET_MAIN_OBB_PATH step 1");
                    if ("true".equals(isObb)) {
                        System.out.println("isObb equals = true");
                        String path = VNGPlugin.getObbPath();
                        result = path;
                        System.out.println("GET_MAIN_OBB_PATH step 2 path = " + path);
                    }
                    EventPlugin.SetParamCount(1, 1);
                    EventPlugin.SetValStr(result);
                    EventPlugin.SetParam(1, 0);
                } catch (PackageManager.NameNotFoundException e) {
                    e.printStackTrace();
                } catch (Exception e2) {
                    e2.printStackTrace();
                }
            }
        });
        EventPlugin.RegHandler("CHECK_MAIN_OBB", new Runnable() {
            public void run() {
                try {
                    String path = VNGPlugin.getObbPath();
                    System.out.println("CHECK_MAIN_OBB step 1 path = " + path);
                    boolean ret = false;
                    File file = new File(path);
                    if (file.exists()) {
                        String md5 = VNGPlugin.mainActivity.getPackageManager().getApplicationInfo(VNGPlugin.mainActivity.getPackageName(), PackageManager.GET_META_DATA).metaData.get("OBB_CHECK_MD5").toString();
                        String fileMd5 = VNGPlugin.getMd5ByFile(file);
                        System.out.println("CHECK_MAIN_OBB step 2 md5 = " + md5 + " fileMd5 = " + fileMd5);
                        if (fileMd5.equals(md5)) {
                            ret = true;
                        }
                    }
                    EventPlugin.SetParamCount(1, 1);
                    EventPlugin.SetValBool(ret);
                    EventPlugin.SetParam(1, 0);
                } catch (PackageManager.NameNotFoundException e) {
                    e.printStackTrace();
                } catch (FileNotFoundException e2) {
                    e2.printStackTrace();
                }
            }
        });
    }
}
