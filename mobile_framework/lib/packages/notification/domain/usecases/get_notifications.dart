import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class GetNotificationsUC
    extends RefLongRunningUseCase<List<AppNotification>, BaseParams>
    with MetadataUpdater {
  INotificationRepository repository;

  @override
  Future<List<AppNotification>> call({BaseParams? params}) {
    return repository
        .getNotifications(params)
        .updateMetadataBy(this)
        .getItems();
  }

  GetNotificationsUC({
    required this.repository,
  });
}

final getNotificationsUCProvider = Provider((ref) =>
    GetNotificationsUC(repository: ref.read(notificationRepositoryProvider)));
