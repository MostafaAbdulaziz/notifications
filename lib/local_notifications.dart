import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  static InitializationSettings initSetting = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  static NotificationDetails notDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      color: Colors.green,
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('not'),
    ),
  );

  static var scheduledTime = tz.TZDateTime(
    tz.local,
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    10,
  );

  static var currentTime = tz.TZDateTime.now(tz.local);

  static Future<void> init() async {
    localNotifications.initialize(
      initSetting,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static onTap(NotificationResponse details) {}

  static Future<void> showBasicNotification() async {
    localNotifications.show(
      0,
      'Basic Notification',
      'Basic Notification body',
      notDetails,
    );
  }

  static Future<void> showRepeatedNot() async {
    await localNotifications.periodicallyShow(
      1,
      'Repeated',
      'body of Repeated',
      RepeatInterval.everyMinute,
      notDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  static Future<void> showScheduledNot() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    if (scheduledTime.isBefore(currentTime)) {
      scheduledTime = scheduledTime.add(Duration(days: 1));
    }
    await localNotifications.zonedSchedule(
      2,
      'Scheduled',
      'body of Scheduled',
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      scheduledTime,
      notDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  static Future<void> cancelNot(int id) async {
    await localNotifications.cancel(id);
  }
}
