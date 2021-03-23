
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum NotificationTroubleshootActions { actionAutostart, actionNotifications, actionPowersaving }

class NotificationTroubleshoot {
  static const MethodChannel _channel =
      const MethodChannel('notification_troubleshoot');

  static Future<Map<NotificationTroubleshootActions, bool>> get availableActions async {
    if (kIsWeb || !Platform.isAndroid) {
      return {};
    }
    Map<String, bool>? version = await _channel.invokeMapMethod<String, bool>('availableActions');
    version ??= {};
    return version.map((key, value) => MapEntry<NotificationTroubleshootActions, bool>(_mapActionString(key), value));
  }

  static NotificationTroubleshootActions _mapActionString(String name) {
    switch (name) {
      case 'action_autostart':
        return NotificationTroubleshootActions.actionAutostart;
      case 'action_notifications':
        return NotificationTroubleshootActions.actionNotifications;
      case 'action_powersaving':
        return NotificationTroubleshootActions.actionPowersaving;
    }
    throw 'Uncnown action \'$name\'';
  }

  static String _mapAction(NotificationTroubleshootActions actions) {
    switch (actions) {
      case NotificationTroubleshootActions.actionAutostart:
        return 'action_autostart';
      case NotificationTroubleshootActions.actionNotifications:
        return 'action_notifications';
      case NotificationTroubleshootActions.actionPowersaving:
        return 'action_powersaving';
    }
  }

  static Future<bool> startIntent(NotificationTroubleshootActions action) async {
    if (kIsWeb || !Platform.isAndroid) {
      return false;
    }
    final bool? res = await _channel.invokeMethod<bool>('startIntent', {'action': _mapAction(action)});
    return res ?? false;
  }
}
