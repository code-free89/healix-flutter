# helix_ai

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

for adding new model and saving it, follow these steps
https://isar.dev/tutorials/quickstart.html

## Flutter commands

```
flutter --version
flutter upgrade
flutter doctor
```

## Setup Android dependencies

Install Android Studio Command Line Tools

```
- Open Android Studio.
- Go to Preferences (on macOS) or Settings (on Windows/Linux).
- Navigate to Appearance & Behavior > System Settings > Android SDK.
- Select the SDK Tools tab.
- Check `Android SDK Command-line Tools (latest)`.
- `flutter doctor --android-licenses`
```

## Setup Xcode dependencies

Follow the steps to install Xcode runtime
```
sudo xcode-select --reset
xcode-select -p
sudo xcodebuild -license accept
xcrun simctl list runtimes
xcodebuild -downloadPlatform iOS
```

## Start Android Studio Emulator

```
Open Android Studio's AVD Manager
Launch Android Studio.
Click on More Actions (on the welcome screen) or go to Tools > Device Manager.
```

Verify the emulator through `flutter devices`
```
➜  HealixFrontend git:(pragad/FixChatScreenMsgAndPaymentYear) ✗ flutter devices

Found 4 connected devices:
  sdk gphone64 arm64 (mobile)     • emulator-5554         • android-arm64  • Android 15 (API 35) (emulator)
```

## Run the app on Android

```
flutter run
```

## Create APK
```
flutter build apk --release
```
