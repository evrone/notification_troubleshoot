import Flutter
import UIKit

public class SwiftNotificationTroubleshootPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "notification_troubleshoot", binaryMessenger: registrar.messenger())
    let instance = SwiftNotificationTroubleshootPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
