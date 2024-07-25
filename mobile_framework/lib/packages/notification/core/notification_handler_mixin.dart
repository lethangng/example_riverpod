import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as local_notification;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin NotificationHandler {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  /// Show notification in here
  didReceiveNotificationFromForegroundState(dynamic data);

  /// Calling when background notification is tapped
  didReceiveNotificationFromBackgroundState(dynamic data);

  /// Calling when notification is tapped
  /// when application starts from terminate state
  didReceiveNotificationFromTerminatedState(dynamic data);

  /// Calling in initState of MyApp
  onNotificationFromTerminateState() {}

  /// Handle notification when user taps on it when application is on foreground
  onTapNotificationWhenShowingInForeground(
      local_notification.NotificationResponse response);

  onRegisterNotificationDeviceToken(String? token);

  void showNotification(
    int id,
    String? title,
    String? body,
    NotificationDetails? notificationDetails, {
    String? payload,
  }) {
    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }
}

abstract class RefNotificationHandlerCompatible {
  late WidgetRef ref;
}
