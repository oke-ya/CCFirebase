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

void FirebaseAndroid::setAdmobBannerId(const std::string& admobBannerId)
{
    JniMethodInfo methodInfo;
    if(JniHelper::getStaticMethodInfo(methodInfo, helperClassName.c_str(), "setAdmobBannerId", "(Ljava/lang/String;)V"))
    {
        JNIEnv* env = JniHelper::getEnv();
        jstring admobBannerIdJ = env->NewStringUTF(admobBannerId.c_str());
        methodInfo.env->CallStaticVoidMethod(methodInfo.classID, methodInfo.methodID, admobBannerIdJ);
        methodInfo.env->DeleteLocalRef(methodInfo.classID);
        env->DeleteLocalRef(admobBannerIdJ);
    }
}

void FirebaseAndroid::setAdmobInterstitialId(const std::string& admobInterstitialId)
{
    JniMethodInfo methodInfo;
    if(JniHelper::getStaticMethodInfo(methodInfo, helperClassName.c_str(), "setAdmobInterstitialId", "(Ljava/lang/String;)V"))
    {
        JNIEnv* env = JniHelper::getEnv();
        jstring admobInterstitialIdJ = env->NewStringUTF(admobInterstitialId.c_str());
        methodInfo.env->CallStaticVoidMethod(methodInfo.classID, methodInfo.methodID, admobInterstitialIdJ);
        methodInfo.env->DeleteLocalRef(methodInfo.classID);
        env->DeleteLocalRef(admobInterstitialIdJ);
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

void FirebaseAndroid::showAdmobInterstitial()
{
    JniHelper::callStaticVoidMethod(helperClassName, "showAdmobInterstitial");
}

bool FirebaseAndroid::isInterstitialLoaded()
{
    JniMethodInfo methodInfo;
    if(JniHelper::getStaticMethodInfo(methodInfo, helperClassName.c_str(), "isInterstitialLoaded", "()Z"))
    {
        JNIEnv* env = JniHelper::getEnv();
        jboolean jbool = methodInfo.env->CallBooleanMethod(methodInfo.classID, methodInfo.methodID);
        methodInfo.env->DeleteLocalRef(methodInfo.classID);
        bool b = (jbool == JNI_TRUE);
        return b;
    }
}
}
