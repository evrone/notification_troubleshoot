# notification_troubleshoot

Troubleshoot android notification. Launch vendor-specific Activity for fix autostart, power-saving and notification settings
Used https://github.com/thelittlefireman/AppKillerManager

##Troubleshoot platforms:
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
