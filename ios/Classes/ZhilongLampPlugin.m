#import "ZhilongLampPlugin.h"
#if __has_include(<zhilong_lamp/zhilong_lamp-Swift.h>)
#import <zhilong_lamp/zhilong_lamp-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zhilong_lamp-Swift.h"
#endif

@implementation ZhilongLampPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZhilongLampPlugin registerWithRegistrar:registrar];
}
@end
