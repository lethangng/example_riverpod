import 'notification_handler_mixin.dart';

abstract class NotificationService {
  Future<void> initializeTerminatedNotification();
  Future<void> start();
  Future<void> close();
  void getDeviceToken();

  void registerDeviceToken(String? deviceToken);
  void registerDependency();
  void deleteRegisteredDeviceToken();
  NotificationService handleNotificationBy(NotificationHandler handler);

  /// Use to configure show/hide foreground message
  /// Due to some unknown reasons from Messaging SDK (FirebaseMessaging SDK, etc)
  /// We have to manually show notifications with [FlutterLocalNotifications] plugin
  void initializeLocalForegroundMessage();

  Future<void> requestNotificationPermission();
}
