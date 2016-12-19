Unity Ads Mediation Adapter for Google Mobile Ads SDK for iOS

Prerequisites:
- Xcode 5.1 or higher
- Deployment target of 6.0 or higher
- Google Mobile Ads SDK 7.10.1 or higher
- Unity Ads SDK 2.0.4

Instructions:
- Add the AdMob SDK. Find the integration guide in the following link:
  https://firebase.google.com/docs/admob/ios/quick-start
- Add or drag the adapter .a into your Xcode project.
- Drag the Unity Ads Framework into your Xcode project.
- You can find the SDK at https://github.com/Unity-Technologies/unity-ads-ios

Caveats:
- The Unity Ads SDK does not provide specific reward values for its rewarded
  video ads, so the adapter defaults to a reward of type "" with value 1. Please
  override the reward value in the AdMob console.
  For more information on setting reward values for AdMob ad units, see this
  Help Center article: https://support.google.com/admob/answer/3052638

The latest documentation and code samples for the Google Mobile Ads SDK are
available at https://firebase.google.com/docs/admob/ios/quick-start.
