import Flutter
import AVFoundation
import UIKit

public class SwiftZhilongLampPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "zhilong_lamp", binaryMessenger: registrar.messenger())
        let instance = SwiftZhilongLampPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    //创建Video设备
    var device: AVCaptureDevice?

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        switch call.method {
        case "init":
            device = AVCaptureDevice.default(for: AVMediaType.video);
        case "turnOn":
            do{
                //锁定设备以便进行手电筒状态修改
                try device?.lockForConfiguration()
                //设置手电筒模式为亮灯（On）
                device?.torchMode = AVCaptureDevice.TorchMode.on
                //解锁设备锁定以便其他APP做配置更新
                device?.unlockForConfiguration()
            }catch{
                return
            }
        case "turnOff":
            do{
                //锁定设备以便进行手电筒状态修改
                try device?.lockForConfiguration()

                //设置手电筒模式为关灯（Off）
                device?.torchMode = AVCaptureDevice.TorchMode.off

                //解锁设备锁定以便其他APP做配置更新
                device?.unlockForConfiguration()
            }catch{
                return
            }
        case "toggle":
            do{
                //锁定设备以便进行手电筒状态修改
                try device?.lockForConfiguration()

                //设置手电筒模式为关灯（Off）
                device?.torchMode = device?.torchMode == AVCaptureDevice.TorchMode.on ? AVCaptureDevice.TorchMode.off : AVCaptureDevice.TorchMode.on;

                //解锁设备锁定以便其他APP做配置更新
                device?.unlockForConfiguration()
            }catch{
                return
            }
        default :
            result(device?.torchMode == AVCaptureDevice.TorchMode.on);
        }
        result(device?.torchMode == AVCaptureDevice.TorchMode.on);
    }
}
