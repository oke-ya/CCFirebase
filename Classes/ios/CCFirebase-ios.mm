//
//  CCFirebase-ios.m
//  CCFirebase
//
//  Created by Atsushi Yoshida on 2016/08/23.
//
//

#include "CCFirebase-ios.h"
#include <iostream>
#include "EnvPrivate.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#include <CommonCrypto/CommonDigest.h>
#import <AdSupport/ASIdentifierManager.h>

namespace oke_ya{

Firebase* Firebase::getInstance()
{
    if (s_sharedFirebase == nullptr)
    {
        s_sharedFirebase = new (std::nothrow) FirebaseIos();
        if(!s_sharedFirebase->init())
        {
            delete s_sharedFirebase;
            s_sharedFirebase = nullptr;
        }
    }
    return s_sharedFirebase;
}

bool FirebaseIos::init()
{
    [FIRApp configure];
    return true;
}

void FirebaseIos::admobInit(const std::string& admobId)
{
    _admobId = admobId;
}

void FirebaseIos::usePushNotification()
{
    UIUserNotificationType allNotificationTypes =
    (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings =
    [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

void FirebaseIos::didReceiveRemoteNotification(void* ptr)
{
    auto userInfo = (__bridge NSDictionary*)ptr;
    NSLog(@"%@", userInfo);
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:(0)];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = userInfo[@"aps"][@"alert"];
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

void FirebaseIos::showAdmobBanner()
{
    _bannerView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerPortrait];
    _bannerView.adUnitID = [NSString stringWithUTF8String: _admobId.c_str()];;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window == nil) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIViewController *viewController = window.rootViewController;
    _bannerView.rootViewController = viewController;
    [viewController.view addSubview:_bannerView];
    //画面下に配置
    _bannerView.center = CGPointMake(viewController.view.center.x,
                                         viewController.view.frame.size.height - _bannerView.frame.size.height/2);
    GADRequest *request = [GADRequest request];
#if TARGET_IPHONE_SIMULATOR
    request.testDevices = @[ kGADSimulatorID ];
#elif COCOS2D_DEBUG
    request.testDevices = @[ [NSString stringWithUTF8String: getAdmobDeviseId().c_str()] ];
#endif
    [_bannerView loadRequest:request];
}

void FirebaseIos::hideAdmobBanner()
{
    if(_bannerView){
        [_bannerView removeFromSuperview];
    }
    _bannerView = nullptr;
}

const std::string FirebaseIos::getAdmobDeviseId()
{
    NSUUID* adid = [[ASIdentifierManager sharedManager] advertisingIdentifier];
    const char *cStr = [adid.UUIDString UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    std::string str = [output UTF8String];
    return str;
}

}
