import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var androidPlatformChannelSpecifics =
    new AndroidNotificationDetails('', '', '');
var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
NotificationDetails platformChannelSpecifics = new NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

class NotificationHelper {
  static Future<void> scheduleNotificationReminder(
      flutterLocalNotificationsPlugin,
      scheduledNotificationDateTime,
      id,
      content) async {
    await flutterLocalNotificationsPlugin.schedule(id, 'Task reminder',
        content.title, scheduledNotificationDateTime, platformChannelSpecifics);
  }

  static Future<void> removeNotification(
      flutterLocalNotificationsPlugin, int notifyId) async {
    await flutterLocalNotificationsPlugin.cancel(notifyId);
  }
}
