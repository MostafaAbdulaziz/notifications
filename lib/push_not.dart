// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:notification/local_notifications.dart';
//
// class PushNot {
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   static Future<void> init() async {
//     await messaging.requestPermission(); //create permission
//     //String? token = await messaging.getToken();
//     // print(token ?? 'null');
//     await pushBackGroundNot();
//     await pushForegroundMessage();
//   }
//
//   static Future<void> pushBackGroundNot() async {
//     FirebaseMessaging.onBackgroundMessage(onTapBack);
//   }
//
//   static Future<void> onTapBack(RemoteMessage message) async {}
//   static Future<void> pushForegroundMessage() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       LocalNotification.showBasicNotification(
//         title: 'message.notification?.title',
//         body: message.notification?.body,
//       );
//     });
//   }
// }
