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
    void FirebaseIos::admobInit(const std::string& admobId) override;
private:
    std::string _admobId;
    const std::string getAdmobDeviseId();
    GADBannerView* _bannerView { nullptr };
};

}

#endif /* CCFirebase_ios_h */
