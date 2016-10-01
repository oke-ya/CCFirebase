#include "CCFirebase-android.h"
#include "platform/android/jni/JniHelper.h"
#include "cocos2d.h"
#include <string>

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

void FirebaseAndroid::admobInit(const std::string& admobId)
{
    JniMethodInfo methodInfo;
    if(JniHelper::getStaticMethodInfo(methodInfo, helperClassName.c_str(), "admobInit", "(Ljava/lang/String;)V"))
    {
        JNIEnv* env = JniHelper::getEnv();
        jstring admobIdJ = env->NewStringUTF(admobId.c_str());
        methodInfo.env->CallStaticVoidMethod(methodInfo.classID, methodInfo.methodID, admobIdJ);
        methodInfo.env->DeleteLocalRef(methodInfo.classID);
        env->DeleteLocalRef(admobIdJ);
    }
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
