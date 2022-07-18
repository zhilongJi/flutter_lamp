import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'zhilong_lamp_method_channel.dart';

abstract class ZhilongLampPlatform extends PlatformInterface {
  /// Constructs a ZhilongLampPlatform.
  ZhilongLampPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZhilongLampPlatform _instance = MethodChannelZhilongLamp();

  /// The default instance of [ZhilongLampPlatform] to use.
  ///
  /// Defaults to [MethodChannelZhilongLamp].
  static ZhilongLampPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZhilongLampPlatform] when
  /// they register themselves.
  static set instance(ZhilongLampPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<bool?> turnOn() {
    throw UnimplementedError('turnOn() has not been implemented.');
  }

  Future<bool?> turnOff() {
    throw UnimplementedError('turnOff() has not been implemented.');
  }

  Future<bool?> toggle() {
    throw UnimplementedError('toggle() has not been implemented.');
  }
}
