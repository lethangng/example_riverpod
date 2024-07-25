import 'package:mobile_framework/mobile_framework.dart';

class MarkNotificationAsReadUC extends RefLongRunningUseCase<bool, String> {
  INotificationRepository repository;

  @override
  Future<bool> call({String? params}) {
    assert(params != null, "Params must not be null");
    return repository
        .markAsRead(params!)
        .cancelBy(ref)
        .onError(showError)
        .onSuccess((value) {
      NotificationCenter().postNotification(updateUnreadNumberNotificationName);
    }).isSuccess();
  }

  MarkNotificationAsReadUC({
    required this.repository,
  });
}

final markNotificationAsReadUCProvider = RefUseCaseProviderFactory.create(
    (ref) => MarkNotificationAsReadUC(
        repository: ref.read(notificationRepositoryProvider)));
