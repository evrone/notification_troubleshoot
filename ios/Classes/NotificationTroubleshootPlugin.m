#import "NotificationTroubleshootPlugin.h"
#if __has_include(<notification_troubleshoot/notification_troubleshoot-Swift.h>)
#import <notification_troubleshoot/notification_troubleshoot-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "notification_troubleshoot-Swift.h"
#endif

@implementation NotificationTroubleshootPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNotificationTroubleshootPlugin registerWithRegistrar:registrar];
}
@end
