# CCFirebase


## setup

```
$ cd YOUR_APP_ROOT
$ git submodule add git@github.com:oke-ya/CCFirebase.git Vendor/CCFirebase
```

## ios

1.Download GoogleService-Info.plist from your firebase console to your APP_ROOT.

### cocoa pods

```
$ cd proj.ios_mac
$ pod init
```

Add pods into your Podfile.

```
\# Podfile
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


## Write Code

```
// AppDelegate.cpp
\
#include "CCFirebase.h"
\
bool AppDelegate::applicationDidFinishLaunching() {
    auto firebase = Firebase::getInstance();
    firebase->usePushNotification();
    firebase->admobInit("YOUR_ADMOB_ID");
....
```

```
// HelloWorldScene.cpp
\
#include "CCFirebase.h"
\
...
bool HelloWorld::init()
{
   oke_ya::Firebase::getInstance()->showAdmobBanner();
```
