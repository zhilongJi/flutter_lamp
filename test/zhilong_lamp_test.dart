import 'package:flutter_test/flutter_test.dart';
import 'package:zhilong_lamp/zhilong_lamp.dart';
import 'package:zhilong_lamp/zhilong_lamp_platform_interface.dart';
import 'package:zhilong_lamp/zhilong_lamp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZhilongLampPlatform 
    with MockPlatformInterfaceMixin
    implements ZhilongLampPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ZhilongLampPlatform initialPlatform = ZhilongLampPlatform.instance;

  test('$MethodChannelZhilongLamp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZhilongLamp>());
  });

  test('getPlatformVersion', () async {
    ZhilongLamp zhilongLampPlugin = ZhilongLamp();
    MockZhilongLampPlatform fakePlatform = MockZhilongLampPlatform();
    ZhilongLampPlatform.instance = fakePlatform;
  
    expect(await zhilongLampPlugin.getPlatformVersion(), '42');
  });
}
