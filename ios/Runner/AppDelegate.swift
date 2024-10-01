import UIKit
import Flutter
import flutter_background_fetch

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Setup background fetch for iOS
    BackgroundFetch.configure(UIApplication.shared)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
