import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart'as tz;
import 'package:timezone/data/latest.dart' as tz;
class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialze() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ico');

    final InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);
    await _localNotificationService.initialize(settings);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', "channel_name",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    return NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showSChedulNotification(
      {required int id, required String title, required String body,time}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(DateTime.now().add(Duration(seconds: time)), tz.local),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,);
  }

  void onDidReceviveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("idddddddddddddddd=?>===  $id");
  }
}
