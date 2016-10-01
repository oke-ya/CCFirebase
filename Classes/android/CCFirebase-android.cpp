#include "CCFirebase-android.h"
#include "platform/android/jni/JniHelper.h"
#include "cocos2d.h"

using namespace cocos2d;

namespace oke_ya{


static const std::string helperClassName = "com/oke_ya/ccfirebase/CCFirebase";

Firebase* Firebase::getInstance()
{
    if (s_sharedFirebase == nullptr)
    {
        s_sharedFirebase = new (std::nothrow) FirebaseAndroid();
        if(!s_sharedFirebase->init())
        {
            delete s_sharedFirebase;
            s_sharedFirebase = nullptr;
            CCLOG("ERROR: Could not init CCFirebaseAndroid");
        }
    }
    return s_sharedFirebase;
}

void FirebaseAndroid::usePushNotification()
{
}

void FirebaseAndroid::didReceiveRemoteNotification(void* userInfo)
{
}

void FirebaseAndroid::showAdmobBanner()
{
    JniHelper::callStaticVoidMethod(helperClassName, "showAdmobBanner");
}

void FirebaseAndroid::hideAdmobBanner()
{
    JniHelper::callStaticVoidMethod(helperClassName, "hideAdmobBanner");
}

}
