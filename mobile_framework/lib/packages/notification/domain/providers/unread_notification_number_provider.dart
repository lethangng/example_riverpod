import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

final unreadNotificationNumberProvider = FutureProvider<int>((ref) {
  return ref.read(getNotificationStatUCProvider)().then((value) {
    return value.unread ?? 0;
  });
});

final updateUnreadNumberNotificationName =
    RawStringNotificationName("ommani.notification.update_unread");

final openNotification =
    RawStringNotificationName("ommani.notification.open_notification");

final markUnreadNotificationAsRead =
    RawStringNotificationName("ommani.notification.mark_unread");
final registerDeviceTokenNotificationName =
    RawStringNotificationName("ommani.notification.register_device_token");
