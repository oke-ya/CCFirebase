//
//  CCFirebase-ios.m
//  CCFirebase
//
//  Created by Atsushi Yoshida on 2016/08/23.
//
//

#import <Foundation/Foundation.h>

#include "CCFirebase-ios.h"

#include "cocos2d.h"
using namespace cocos2d;

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
            CCLOG("ERROR: Could not init CCFirebaseIos");
        }
    }
    return s_sharedFirebase;
}

void FirebaseIos::showAds() const
{
    log("Firebase::showAds()");
}

}
