import 'package:mobile_framework/mobile_framework.dart';

class ReadAllNotificationsUC extends RefLongRunningUseCase<bool, void> {
  INotificationRepository repository;

  @override
  Future<bool> call({void params}) {
    return repository
        .readAllNotifications()
        .cancelBy(ref)
        .onSuccess((value) {
          NotificationCenter()
              .postNotification(updateUnreadNumberNotificationName);
        })
        .onError(showError)
        .isSuccess();
  }

  ReadAllNotificationsUC({
    required this.repository,
  });
}

final readAllNotificationsUCProvider = RefUseCaseProviderFactory.create((ref) =>
    ReadAllNotificationsUC(
        repository: ref.read(notificationRepositoryProvider)));
