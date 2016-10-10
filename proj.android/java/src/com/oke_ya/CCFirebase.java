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
    private static AdView mBannerAdView;
    private static String mAdmobBannerId;
    private static InterstitialAd mInterstitialAd;
    private static String mAdmobInterstitialId;
    private static boolean mInterstitialLoaded = false;

    public static void setAdmobBannerId(String admobBannerId) {
        mAdmobBannerId = admobBannerId;
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Cocos2dxActivity activity = (Cocos2dxActivity)Cocos2dxHelper.getActivity();
                mBannerAdView = new AdView(activity);
                Log.d(CCFirebase.TAG, "Admob: " + mAdmobBannerId);
                mBannerAdView.setAdUnitId(mAdmobBannerId);
                mBannerAdView.setAdSize(AdSize.SMART_BANNER);
                FrameLayout.LayoutParams adParams = new FrameLayout.LayoutParams(
                                                                                 FrameLayout.LayoutParams.WRAP_CONTENT,
                                                                                 FrameLayout.LayoutParams.WRAP_CONTENT);
                adParams.gravity = (Gravity.BOTTOM | Gravity.CENTER);
                activity.addContentView(mBannerAdView, adParams);
            }
        });
    }

    public static void setAdmobInterstitialId(String admobInterstitialId) {
        mAdmobInterstitialId = admobInterstitialId;
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Activity activity = Cocos2dxHelper.getActivity();
                mInterstitialAd = new InterstitialAd(activity);
                mInterstitialAd.setAdUnitId(mAdmobInterstitialId);
                mInterstitialAd.setAdListener(new AdListener() {
                        @Override
                        public void onAdClosed() {
                            mInterstitialLoaded = false;
                            mInterstitialAd.loadAd(createAdRequest());
                        }
                });
                mInterstitialLoaded = false;
                mInterstitialAd.loadAd(createAdRequest());
            }
        });
    }

    public static void showAdmobBanner() {
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                mBannerAdView.setVisibility(View.VISIBLE);
                mBannerAdView.loadAd(createAdRequest());
            }
       });
    }

    public static void hideAdmobBanner() {
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                mBannerAdView.setVisibility(View.GONE);
            }
        });
    }

    public static boolean isInterstitialLoaded() {
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                 mInterstitialLoaded = mInterstitialAd.isLoaded();
            }
        });
        return mInterstitialLoaded;
    }

    public static void showAdmobInterstitial() {
        Cocos2dxHelper.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if(mInterstitialAd.isLoaded()){
                    mInterstitialAd.show();
                }
            }
        });
    }

    private static AdRequest createAdRequest() {
        return new AdRequest.Builder()
            .addTestDevice(AdRequest.DEVICE_ID_EMULATOR)
            .addTestDevice("498CD77074D1A8BCAE37E8DBD006A0B7").build();
    }
}
