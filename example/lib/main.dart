import 'package:flutter/material.dart';
import 'dart:async';

import 'package:notification_troubleshoot/notification_troubleshoot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<NotificationTroubleshootActions, bool>? availableActions;

  @override
  void initState() {
    super.initState();
    initActions();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initActions() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      availableActions = await NotificationTroubleshoot.availableActions;
      print(availableActions);
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              availableActions?.entries.isNotEmpty == true ? Text('Available actions: \n') : Text('No action available'),

              for (final action in availableActions?.entries ?? <MapEntry<NotificationTroubleshootActions, bool>>[])
                ListTile(
                  title: Text('${action.key.toString().split('.')[1]}'),
                  subtitle: Text(
                    action.value ? 'available' : 'unavailable',
                    style: TextStyle(
                      color: action.value ? Colors.lightGreen : Colors.deepOrangeAccent,
                    ),
                  ),
                  onTap: action.value ? () => NotificationTroubleshoot.startIntent(action.key) : null,
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: action.value ? null : Colors.black12,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
