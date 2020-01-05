import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var scheduledNotificationDateTime =
    new DateTime.now().add(new Duration(seconds: 5));
var androidPlatformChannelSpecifics =
    new AndroidNotificationDetails('', '', '');
var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
NotificationDetails platformChannelSpecifics = new NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

Future<void> scheduleNotificationReminder(
    flutterLocalNotificationsPlugin, scheduledNotificationDateTime) async {
  await flutterLocalNotificationsPlugin.schedule(
      0,
      'scheduled title',
      'scheduled body',
      scheduledNotificationDateTime,
      platformChannelSpecifics);
}
