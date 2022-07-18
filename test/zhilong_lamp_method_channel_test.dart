import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhilong_lamp/zhilong_lamp_method_channel.dart';

void main() {
  MethodChannelZhilongLamp platform = MethodChannelZhilongLamp();
  const MethodChannel channel = MethodChannel('zhilong_lamp');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
