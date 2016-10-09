# CCFirebase

Firebase SDK wrapper for cocos2d-x.

## Feature

- Push notification
- Admob

## install

```
$ cd YOUR_APP_ROOT
$ git submodule add git@github.com:oke-ya/CCFirebase.git Vendor/CCFirebase
```

## Settings for ios

1.Download GoogleService-Info.plist from your firebase console to your APP_ROOT.

### cocoa pods

```
$ cd proj.ios_mac
$ pod init
```

Add pods into your Podfile.

```
# Podfile
target 'YOUR_APP-mobile' do
  pod 'Firebase'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Firebase/AdMob'
end
```

And run install.

```
$ pod install
$ open YOUR_APP.xcworkspace
```
Add GoogleService-Info.plist into XCode
Add Vendor/CCFirebase/proj.ios/CCFirebase.xcodeproj

### PATH settings

1. choose source tree root -> TARGET YOUR_APP-mobile -> Build Settings
1. Add  'Header' into search field.
1. Add '$(SRCROOT)/../Vendor/CCFirebase/Classes' into 'Heade Search Paths'.

### link settings

1. choose source tree root -> TARGET YOUR_APP-mobile -> Build Phases -> Link Binary With Libraries
1. Add 'libCCFirebase.a'


## Settings for Android

### Download Firebase settings

on `proj.android-studio/app/google-services.json`

### Edit `proj.android-studio/settings.gradle`

```
include ':libcocos2dx'
project(':libcocos2dx').projectDir = new File(settingsDir, '../cocos2d/cocos/platform/android/libcocos2dx')
include 'firebase'
project(':firebase').projectDir = new File(settingsDir, '../Vendor/CCFirebase/proj.android')
```

### Edit 'proj.android-studio/build.gradle'

```
    dependencies {
        classpath 'com.android.tools.build:gradle:1.3.0'
        classpath 'com.google.gms:google-services:3.0.0'
    }
```

### Edit `proj.android-studio/app/build.gradle`

```
dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    compile project(':libcocos2dx')
    compile project(':firebase')
    compile 'com.google.firebase:firebase-core:9.4.0'
    compile 'com.google.firebase:firebase-messaging:9.4.0'
    compile 'com.google.firebase:firebase-ads:9.4.0'
}

apply plugin: 'com.google.gms.google-services'
```

### Edit `proj.android-studio/app/jni/Android.mk`

```
LOCAL_SRC_FILES := hellocpp/main.cpp
LOCAL_SRC_FILES += $(shell find $(LOCAL_PATH)/../../../Vendor/CCFirebase/Classes -name *.cpp)
LOCAL_SRC_FILES += $(shell find $(LOCAL_PATH)/../../../Vendor/CCFirebase/proj.android -name *.cpp)


LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../Vendor/CCFirebase/Classes
```



## Write Code

```
// AppDelegate.cpp

#include "CCFirebase.h"

bool AppDelegate::applicationDidFinishLaunching() {
    auto firebase = Firebase::getInstance();
    firebase->usePushNotification();
    firebase->admobInit("YOUR_ADMOB_ID");
....
```

```
// HelloWorldScene.cpp

#include "CCFirebase.h"

...
bool HelloWorld::init()
{
   oke_ya::Firebase::getInstance()->showAdmobBanner();
```
