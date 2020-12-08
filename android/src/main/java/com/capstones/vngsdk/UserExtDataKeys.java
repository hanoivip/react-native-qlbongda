package com.capstones.vngsdk;

import java.util.ArrayList;
import java.util.List;

public class UserExtDataKeys {
    public static final String ACTION = "ACTION";
    public static final String ACTION_CREATE_ROLE = "3";
    public static final String ACTION_ENTER_SERVER = "1";
    public static final String ACTION_HOTUPDATE = "hotupdate";
    public static final String ACTION_LEVEL_UP = "2";
    public static final String ACTION_UNCOMPRESS = "uncompress";
    public static final String APP_RES_VERSION = "APP_RES_VERSION";
    public static final String APP_VERSION = "APP_VERSION";
    public static final String BALANCE = "BALANCE";
    public static List<String> BASE_ATION_LIST = new ArrayList<String>() {
        {
            add(UserExtDataKeys.ACTION_ENTER_SERVER);
            add(UserExtDataKeys.ACTION_LEVEL_UP);
            add(UserExtDataKeys.ACTION_CREATE_ROLE);
        }
    };
    public static final String CLASSFIELD = "CLASSFIELD";
    public static final String CUSTOM_KEY = "CUSTOM_KEY";
    public static final String PARTYNAME = "PARTY_NAME";
    public static final String PHYLUM = "PHYLUM";
    public static final String ROLE_CREATE_TIME = "ROLE_CREATE_TIME";
    public static final String ROLE_ID = "ROLE_ID";
    @Deprecated
    public static final String ROLE_LELEVL = "ROLE_LEVEL";
    public static final String ROLE_LEVEL = "ROLE_LEVEL";
    public static final String ROLE_NAME = "ROLE_NAME";
    public static final String SERVER_ID = "SERVER_ID";
    public static final String SERVER_NAME = "SERVER_NAME";
    public static final String VIP = "VIP";
    public static final String ZONE_ID = "ZONE_ID";
    public static final String ZONE_NAME = "ZONE_NAME";
/*
    public enum Action {
        sdk_application_init_failed,
        login_page("15"),
        channel_callback("19"),
        login_channel("20"),
        sdk_pay,
        exit_manual,
        exit_destroy,
        exit_stop,
        exit_crash,
        open_app1;
        
        private String phylum;

        private Action(String phylum2) {
            this.phylum = phylum2;
        }

        public String getPhylum() {
            return this.phylum;
        }
    }*/
}
