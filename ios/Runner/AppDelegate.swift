import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let batteryChannel = FlutterMethodChannel(name: "ios/deviceInfo",
                                                    binaryMessenger: controller.binaryMessenger)
          batteryChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
              guard call.method == "getDeviceInfo" else {
                  result(FlutterMethodNotImplemented)
                  return
                }
                self?.receiveBatteryLevel(result: result)
          })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
        let deviceInfo  = Device(modelName: device.model, version: device.systemVersion)
        result(deviceInfo.toDictionary())
      
    }
}


struct Device {
    let modelName: String
    let version: String

    func toDictionary() -> [String: Any] {
        return [
            "modelName": modelName,
            "version": version
        ]
    }
}
