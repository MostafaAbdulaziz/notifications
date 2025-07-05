import 'package:flutter/material.dart';
import 'package:notification/work_manager_service.dart';

import 'local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await PushNot.init();
  await Future.wait([WorkManagerService.init(), LocalNotification.init()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: Text('Basic notification'),
            trailing: IconButton(
              onPressed: () async {
                //await PushNot.pushForegroundMessage();
                LocalNotification.cancelNot(0);
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () async {
              await LocalNotification.showBasicNotification();
            },
          ),
          ListTile(
            leading: Text('Repeated notification'),
            trailing: IconButton(
              onPressed: () async {
                await LocalNotification.cancelNot(1);
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () async {
              await LocalNotification.showRepeatedNot();
            },
          ),
          ListTile(
            leading: Text('scheduled notification'),
            trailing: IconButton(
              onPressed: () async {
                //  await LocalNotification.cancelNot(2);
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () async {
              await LocalNotification.showScheduledNot();
            },
          ),
        ],
      ),
    ),
  );
}
