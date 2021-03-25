# notification_troubleshoot

## Troubleshoot android notification.
[![pub package](https://img.shields.io/pub/v/notification_troubleshoot.svg)](https://pub.dev/packages/notification_troubleshoot)
[![Language](https://img.shields.io/badge/language-Dart-blue.svg)](https://dart.dev)

<a href="https://evrone.com/?utm_source=github&utm_campaign=notification_troubleshoot">
  <img src="https://evrone.com/logo/evrone-sponsored-logo.png"
       alt="Sponsored by Evrone" width="231">
</a>

### Developed for [Evrone.com](https://evrone.com/flutter?utm_source=github&utm_campaign=notification_troubleshoot)
Launch vendor-specific Activity for fix autostart, power-saving and notification settings

For android used https://github.com/thelittlefireman/AppKillerManager library

## Troubleshoot platforms:
  * Android

If you need any functionality on another platform, create an issue


## Getting Started

You can get a list of action:
```dart
final List<NotificationTroubleshootActions> availableActions = await NotificationTroubleshoot.availableActions;
```

Show all available actions in your application and let the user run that action:
```dart
NotificationTroubleshoot.startIntent(availableActions);
```

## Target of plugin

When using push-Notification, there is often a problem that notifications do not work on some android devices. This is often due to custom services that the manufacturer added to the android firmware. For example, power saving, blocking push notifications, banning autorun, and so on.

Some applications solve this problem by creating a troubleshooting guide, such as the one posted by Slack [https://slack.com/intl/en-ru/help/articles/360001562747-Known-issues-with-Android-notifications].
    
However android devices there is an appKillerManager library [https://github.com/thelittlefireman/AppKillerManager], which can open system settings on different vendors, where the user must allow the application to run in the background or mark the application as an exception in power saving.

    
When we use this package, we can create the "problems with notifications" item in the UI for the android app version  and show the user a list of actions that he should do, for example, make buttons:
* "Allow the application to use autorun"
* "Remove background activity restrictions"
* other



Now the plugin solves problems on Andoid devices, if similar problems are found on other devices platforms (web/Desktop), please create an issue
