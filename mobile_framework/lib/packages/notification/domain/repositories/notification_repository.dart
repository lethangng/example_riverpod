import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

abstract interface class INotificationRepository {
  ResultBaseListFuture<AppNotification> getNotifications(BaseParams? params);

  ResultFuture<NotificationStat> getNotificationStat();
  ResultFuture<EmptyResponse> readAllNotifications();
  ResultFuture<EmptyResponse> markAsRead(String id);
}

final notificationRepositoryProvider = Provider<INotificationRepository>(
    (ref) => throw UnimplementedError("Must be implemented in before use"));
