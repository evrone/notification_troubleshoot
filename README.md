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

For android used https://github.com/thelittlefireman/AppKillerManager

## Troubleshoot platforms:
[x] Andoid

If you need any functionality on another platform, create a issue


## Getting Started

You can get a map of action:
```dart
final Map<NotificationTroubleshootActions, bool> availableActions = await NotificationTroubleshoot.availableActions;
```

Show all available actions in your application and let the user run that action:
```dart
NotificationTroubleshoot.startIntent(availableActions);
```
