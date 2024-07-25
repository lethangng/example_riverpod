import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class GetNotificationStatUC extends LongRunningUseCase<NotificationStat, void> {
  INotificationRepository repository;

  @override
  Future<NotificationStat> call({void params}) {
    return repository
        .getNotificationStat()
        .onSuccess((value) {
          FlutterAppBadger.updateBadgeCount(value.unread ?? 0);
        })
        .mapToValueOr(defaultValue: NotificationStat())
        .asFuture();
  }

  GetNotificationStatUC({
    required this.repository,
  });
}

final getNotificationStatUCProvider = Provider((ref) => GetNotificationStatUC(
    repository: ref.read(notificationRepositoryProvider)));
