import 'package:flutter/material.dart';
import 'package:notification_troubleshoot/notification_troubleshoot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FutureBuilder<List<NotificationTroubleshootActions>>(

            /// Get available actions on this device
            future: NotificationTroubleshoot.availableActions,
            builder: (context, state) {
              var data = state.data;
              if (data == null) {
                return CircularProgressIndicator();
              }
              if (data.isEmpty) {
                return Text('No action available');
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Available actions: \n'),
                  for (final action in data)
                    ListTile(
                      title: Text('${action.toString().split('.')[1]}'),

                      /// Launch vendor-specific Activity
                      onTap: () => NotificationTroubleshoot.startIntent(action),
                      trailing: Icon(
                        Icons.arrow_forward,
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
