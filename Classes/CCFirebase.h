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

namespace oke_ya{

class Firebase
{
public:
    virtual ~Firebase() = default;
    static Firebase* getInstance();
    static Firebase* s_sharedFirebase;
    virtual void usePushNotification() = 0;
    virtual bool init();
    virtual void admobInit(const std::string& admobId) = 0;
    virtual void didReceiveRemoteNotification(void* userInfo) = 0;
    virtual void showAdmobBanner() = 0;
    virtual void hideAdmobBanner() = 0;
};

}

#endif /* CCFirebase_h */
