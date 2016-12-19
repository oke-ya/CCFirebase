Chartboost Ads Mediation Adapter for Google Mobile Ads SDK for iOS

Prerequisites:
- Xcode 5.1 or higher
- iOS Deployment target of 7.0 or higher
- Minimum required Google Mobile Ads SDK 7.10.1
- Minimum required Chartboost SDK 6.5.1

Instructions:
- Add the Google Mobile Ads SDK
- You can find the integration guide at
  https://firebase.google.com/docs/admob/ios/quick-start
- Add or drag the adapter .framework into your Xcode project
- Drag the Chartboost Ads Framework into your Xcode project
- You can find the SDK at
  https://answers.chartboost.com/hc/en-us/articles/201220095
- Enable the Ad network in the Ad Network Mediation UI
- The latest documentation and code samples for the Google Mobile Ads SDK are
  available at https://firebase.google.com/docs/admob/ios/quick-start
- Adapter framework has a GADMChartboostExtras class to provide "framework" and
  "frameworkVersion" parameters. The "framework" and "frameworkVersion" are used
  if you are using any custom framework in your application(for example, Unity).
- If you want to pass a custom CBFramework and frameworkVersion to the adapter,
  you can do this through the GADMChartboostExtras object. Here is an example of
  how to customize the Chartboost location in an ad request:

GADRequest *adRequest = [GADRequest request];
GADMChartboostExtras *cbExtras = [[GADMChartboostExtras alloc] init];
cbExtras.framework = CBFrameworkUnity;
cbExtras.frameworkVersion = @"4.2.0";
[request registerAdNetworkExtras:cbExtras];

Note:
- To import ChartboostAdapter.framework in your project, make sure to set
  "Allow Non-modular Includes in Framework Modules" to YES under
  Build Settings of your target.

The latest documentation and code samples for the Google Mobile Ads SDK are
available at:
https://firebase.google.com/docs/admob/ios/quick-start
