import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

enum NotificationTroubleshootActions { actionAutostart, actionNotifications, actionPowersaving }

class NotificationTroubleshoot {
  static const MethodChannel _channel = const MethodChannel('notification_troubleshoot');

  /// Available actions on device. If the device has actions available,
  /// user can run [startIntent] for each one to check the settings
  /// on these screens and correct them if necessary
  static Future<List<NotificationTroubleshootActions>> get availableActions async {
    if (kIsWeb || !Platform.isAndroid) {
      return const <NotificationTroubleshootActions>[];
    }
    List<String>? version = await _channel.invokeListMethod<String>('availableActions');
    return version?.map((value) => _mapActionString(value)).toList() ?? const <NotificationTroubleshootActions>[];
  }

  /// Start intent
  static Future<bool> startIntent(NotificationTroubleshootActions action) async {
    if (kIsWeb || !Platform.isAndroid) {
      return false;
    }
    final bool? res = await _channel.invokeMethod<bool>('startIntent', {'action': _mapAction(action)});
    return res ?? false;
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
}
