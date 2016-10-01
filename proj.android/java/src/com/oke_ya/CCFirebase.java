package com.oke_ya.ccfirebase;

import org.cocos2dx.lib.Cocos2dxActivity;
import android.util.Log;

public class CCFirebase {
    private static final String TAG = CCFirebase.class.getSimpleName();

    public static void showAdmobBanner() {
        Log.e(CCFirebase.TAG, "show Ads from Java");
    }

    public static void hideAdmobBanner() {
        Log.e(CCFirebase.TAG, "hide Ads from Java");
    }
}
