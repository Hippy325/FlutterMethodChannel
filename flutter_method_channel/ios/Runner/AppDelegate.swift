import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "Channel",
            binaryMessenger: controller.binaryMessenger
        )
        
        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "writeString":
                if let args = call.arguments as? [String: Any],
                   let text = args["text"] as? String {
                    
                    let content = CppWrapper.appendString(text: text)
                    result(content)
                    
                } else {
                    result(FlutterError(code: "BAD_ARGS", message: "missing text", details: nil))
                }
                
            case "readFile":
                let content = CppWrapper.readFile()
                result(content)
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
