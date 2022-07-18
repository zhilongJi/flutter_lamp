import 'zhilong_lamp_platform_interface.dart';

class ZhilongLamp {
  ZhilongLamp() {
    ZhilongLampPlatform.instance.init();
  }

  Future turnOn() {
    return ZhilongLampPlatform.instance.turnOn();
  }

  Future turnOff() {
    return ZhilongLampPlatform.instance.turnOff();
  }

  Future toggle() {
    return ZhilongLampPlatform.instance.toggle();
  }
}
