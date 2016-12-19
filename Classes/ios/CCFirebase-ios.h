//
//  CCFirebase-ios.h
//  CCFirebase
//
//  Created by Atsushi Yoshida on 2016/08/23.
//
//

#ifndef CCFirebase_ios_h
#define CCFirebase_ios_h

#include <memory>
#include <string>
#include <vector>

#include "CCFirebase.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

namespace oke_ya{

class FirebaseIos : public Firebase
{
public:
    virtual void usePushNotification() override;
    void didReceiveRemoteNotification(void* userInfo) override;
    bool init() override;
    void showAdmobBanner() override;
    void hideAdmobBanner() override;
    void setAdmobBannerId(const std::string& admobBannerId) override;
    void setAdmobInterstitialId(const std::string& admobInterstitialId) override;
    void showAdmobInterstitial() override;
    bool isInterstitialLoaded() override;
    bool requestRewardVideo(const std::string& admobVideoId) override;
    void showAdmobVideo() override;
    bool isAdmobVideoReady() override;
private:
    UIViewController* getRootViewController();
    void setTestDevise(GADRequest* request);
    GADInterstitial* _interstitial;
    std::string _admobBannerId;
    std::string _admobInterstitialId;
    const std::string getAdmobDeviseId();
    GADBannerView* _bannerView { nullptr };
};

}

#endif /* CCFirebase_ios_h */
