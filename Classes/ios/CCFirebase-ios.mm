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
#import <ChartboostAdapter/ChartboostAdapter.h>

@interface FirebaseDelegateBridge : NSObject<GADRewardBasedVideoAdDelegate>
@end

@implementation FirebaseDelegateBridge

#pragma mark - Rewarded Video Delegate Methods

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
     reward.type,
     [reward.amount doubleValue]];
    NSLog(rewardMessage);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    oke_ya::Firebase::getInstance()->callideoAdDidReceiveAdCallback();
    NSLog(@"Reward based video ad is received.");
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}
@end


static FirebaseDelegateBridge* s_pDelegateBridge = nil;

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
        s_pDelegateBridge = [[FirebaseDelegateBridge alloc] init];
    }
    return s_sharedFirebase;
}

bool FirebaseIos::init()
{
    [FIRApp configure];
    return true;
}

void FirebaseIos::setAdmobBannerId(const std::string& admobBannerId)
{
    _admobBannerId = admobBannerId;
}

void FirebaseIos::setAdmobInterstitialId(const std::string& admobInterstitialId)
{
    _admobInterstitialId = admobInterstitialId;
    _interstitial = [[GADInterstitial alloc] initWithAdUnitID:[NSString stringWithUTF8String: _admobInterstitialId.c_str()]];
    GADRequest *request = [GADRequest request];
    setTestDevise(request);
    [_interstitial loadRequest:request];
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
    _bannerView.adUnitID = [NSString stringWithUTF8String: _admobBannerId.c_str()];;
    auto viewController = getRootViewController();
    _bannerView.rootViewController = viewController;
    [viewController.view addSubview:_bannerView];
    //画面下に配置
    _bannerView.center = CGPointMake(viewController.view.center.x,
                                         viewController.view.frame.size.height - _bannerView.frame.size.height/2);
    GADRequest *request = [GADRequest request];
    setTestDevise(request);
    [_bannerView loadRequest:request];
}

void FirebaseIos::setTestDevise(GADRequest* request)
{
//#if TARGET_IPHONE_SIMULATOR
//    request.testDevices = @[ kGADSimulatorID ];
//#elif COCOS2D_DEBUG
//    request.testDevices = @[ [NSString stringWithUTF8String: getAdmobDeviseId().c_str()] ];
//#endif
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

void FirebaseIos::showAdmobInterstitial()
{
    if (isInterstitialLoaded()) {
        auto viewController = getRootViewController();
        [_interstitial presentFromRootViewController:viewController];
        setAdmobInterstitialId(_admobInterstitialId);
    }
}
    
bool FirebaseIos::isInterstitialLoaded()
{
    return [_interstitial isReady];
}
    
UIViewController* FirebaseIos::getRootViewController()
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window == nil) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIViewController *viewController = window.rootViewController;
    return viewController;
}
    
bool FirebaseIos::requestRewardVideo(const std::string& admobVideoId)
{
    [GADRewardBasedVideoAd sharedInstance].delegate = s_pDelegateBridge;
    GADRequest *request = [GADRequest request];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:[NSString stringWithUTF8String: admobVideoId.c_str()]];
    GADMChartboostExtras *cbExtras = [[GADMChartboostExtras alloc] init];
    cbExtras.framework = CBFrameworkUnity;
//    cbExtras.frameworkVersion = @"4.2.0";
    [request registerAdNetworkExtras:cbExtras];

    return true;
}

void FirebaseIos::showAdmobVideo()
{
    if (isAdmobVideoReady()) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:getRootViewController()];
    }
}

bool FirebaseIos::isAdmobVideoReady()
{
    return [[GADRewardBasedVideoAd sharedInstance] isReady];
}

}
