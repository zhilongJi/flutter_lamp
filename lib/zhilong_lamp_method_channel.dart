import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'zhilong_lamp_platform_interface.dart';

/// An implementation of [ZhilongLampPlatform] that uses method channels.
class MethodChannelZhilongLamp extends ZhilongLampPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zhilong_lamp');

  @override
  Future<bool?> init() async {
    final version = await methodChannel.invokeMethod<bool>('init');
    return version;
  }

  @override
  Future<bool?> turnOn() async {
    final version = await methodChannel.invokeMethod<bool>('turnOn');
    return version;
  }

  @override
  Future<bool?> turnOff() async {
    final version = await methodChannel.invokeMethod<bool>('turnOff');
    return version;
  }

  @override
  Future<bool?> toggle() async {
    final version = await methodChannel.invokeMethod<bool>('toggle');
    return version;
  }
}
