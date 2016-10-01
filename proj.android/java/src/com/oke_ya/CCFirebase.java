package com.oke_ya.ccfirebase;

import java.lang.String;
import org.cocos2dx.lib.*;
import com.google.android.gms.ads.*;
import android.util.Log;
import android.app.Activity;
import android.view.ViewGroup.LayoutParams;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.RelativeLayout;
import android.view.SurfaceView;
import android.widget.FrameLayout;

public class CCFirebase {
    private static final String TAG = CCFirebase.class.getSimpleName();
    private static AdView adView;
    private static String admobId;

    public static void admobInit(String _admobId) {
        admobId = _admobId;
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Cocos2dxActivity activity = (Cocos2dxActivity)Cocos2dxHelper.getActivity();
                adView = new AdView(activity);
                Log.d(CCFirebase.TAG, "Admob: " + admobId);
                adView.setAdUnitId(admobId);
                adView.setAdSize(AdSize.SMART_BANNER);
                FrameLayout.LayoutParams adParams = new FrameLayout.LayoutParams(
                                                                                 FrameLayout.LayoutParams.WRAP_CONTENT,
                                                                                 FrameLayout.LayoutParams.WRAP_CONTENT);
                adParams.gravity = (Gravity.BOTTOM | Gravity.CENTER);
                activity.addContentView(adView, adParams);
            }
        });
    }

    public static void showAdmobBanner() {
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                adView.setVisibility(View.VISIBLE);
                adView.loadAd(new AdRequest.Builder()
                              .addTestDevice(AdRequest.DEVICE_ID_EMULATOR)
                              .addTestDevice("498CD77074D1A8BCAE37E8DBD006A0B7").build());
            }
       });
    }

    public static void hideAdmobBanner() {
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                adView.setVisibility(View.GONE);
            }
        });
    }
}
