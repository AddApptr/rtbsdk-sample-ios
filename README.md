# RTBSDK iOS sample

Sample app showing how to integrate [RTBSDK](https://aatkit.gitbook.io/rtbsdk-ios-integration) for iOS.

Every ad format has its own screen in the app - pick it from the main menu. On the banner, fullscreen and rewarded video screens you can change the placement ID and the App Store app ID before tapping *Load*; the native ad screen loads its ad automatically.

## Samples

| Sample | Screen | Description | Documentation |
|---|---|---|---|
| Banner | `BannerViewController` | Banner loaded and displayed with `RTBBannerView` | [Banners](https://aatkit.gitbook.io/rtbsdk-ios-integration/formats/banners) |
| Banner provider | `BannerProviderViewController` | Banner bid loaded with `RTBBannerAdProvider`, the banner view is created only after the bid is received | [Banners](https://aatkit.gitbook.io/rtbsdk-ios-integration/formats/banners) |
| Fullscreen | `FullscreenViewController` | Fullscreen (interstitial) ad loaded and presented with `RTBFullscreenAd` | [Fullscreen](https://aatkit.gitbook.io/rtbsdk-ios-integration/formats/fullscreen-interstitial) |
| Rewarded video | `RewardedVideoViewController` | Rewarded video ad loaded and presented with `RTBRewardedVideoAd` | [Rewarded video](https://aatkit.gitbook.io/rtbsdk-ios-integration/formats/rewarded-video) |
| Native ads | `NativeAdViewController` | Native ad loaded with `RTBNativeAdLoader` and rendered in a custom view | [Native ads](https://aatkit.gitbook.io/rtbsdk-ios-integration/formats/native-ads) |

## Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:AddApptr/rtbsdk-sample-ios.git
   ```
2. Open `GraviteRTBSampleApp.xcodeproj` in **Xcode** and wait for Swift Package Manager to resolve the packages.
3. Run the `GraviteRTBSampleApp` scheme on a simulator or a device. To run on a device, select your development team in the target's *Signing & Capabilities* tab.

The sample can also be built from the command line:

```bash
xcodebuild build -project GraviteRTBSampleApp.xcodeproj -scheme GraviteRTBSampleApp -destination 'generic/platform=iOS Simulator'
```

Requirements: Xcode 16 or later and iOS 15.0 or later.

## Project structure

- `GraviteRTBSampleApp.xcodeproj` - the Xcode project; RTBSDK is added as a Swift package from [AddApptr/RTBSDK](https://github.com/AddApptr/RTBSDK)
- `GraviteRTBSampleApp/` - sources of the sample app, one view controller per ad format

### Updating RTBSDK

The package uses the *Up to Next Major Version* rule, so *File > Packages > Update to Latest Package Versions* in Xcode picks up the newest compatible RTBSDK release. To move to a new major version, change the version rule of the `RTBSDK` package in the project's *Package Dependencies* tab.

## Documentation

- Integration guide: [RTBSDK iOS integration](https://aatkit.gitbook.io/rtbsdk-ios-integration)
- API reference: [RTBSDK documentation](https://docs.gravite.net/rtbsdk/ios/docs/documentation/rtbsdk/)
- Release notes: [RTBSDK release notes](https://aatkit.gitbook.io/rtbsdk-release-notes)
