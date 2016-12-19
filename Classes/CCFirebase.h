//
//  CCFirebase.h
//  
//
//  Created by Atsushi Yoshida on 2016/08/23.
//
//

#ifndef CCFirebase_h
#define CCFirebase_h

#include <string>
#include <functional>
#include <iostream>

namespace oke_ya{

class Firebase
{
public:
    static constexpr auto VERSION = "0.5.1";
    using callback = std::function<void(void)>;
    virtual ~Firebase() = default;
    static Firebase* getInstance();
    static Firebase* s_sharedFirebase;
    virtual void usePushNotification() = 0;
    virtual bool init();
    virtual void setAdmobBannerId(const std::string& admobBannerId) = 0;
    virtual void setAdmobInterstitialId(const std::string& admobInterstitialId) = 0;
    virtual void didReceiveRemoteNotification(void* userInfo) = 0;
    virtual void showAdmobBanner() = 0;
    virtual void hideAdmobBanner() = 0;
    virtual void showAdmobInterstitial() = 0;
    virtual bool isInterstitialLoaded() = 0;
    virtual bool requestRewardVideo(const std::string& admobVideoId) = 0;
    virtual void showAdmobVideo() = 0;
    virtual bool isAdmobVideoReady() = 0;
    void callideoAdDidReceiveAdCallback() { _videoAdDidReceiveAdCallback(); }
    void setCallideoAdDidReceiveAdCallback(callback fn) { _videoAdDidReceiveAdCallback = fn; }
protected:
    callback _videoAdDidReceiveAdCallback { [](){ std::cout << "_videoAdDidReceiveAdCallback"; } };
};

}

#endif /* CCFirebase_h */
