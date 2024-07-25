import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

final notificationTokenRepositoryProvider =
    Provider<INotificationTokenRepository>((ref) => throw UnimplementedError(
        "notificationTokenRepositoryProvider is not implemented yet. Register in ProviderScope"));

class NotificationTokenRepository extends BaseRepository
    implements INotificationTokenRepository {
  NotificationTokenRepository(Type moduleType)
      : super(
            urlBuilder: CommonURLBuilder(Module.findEnv(of: moduleType).baseUrl,
                StringAPIVersion("/v1")));

  @override
  ResultFuture<EmptyResponse> registerDeviceToken(
      RegisterNotificationDeviceTokenRequest request) {
    return make
        .request(
            path: "/notification/register_device",
            body: request.encode(),
            decoder: const EmptyResponse())
        .post();
  }
}
