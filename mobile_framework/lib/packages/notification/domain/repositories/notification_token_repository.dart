import 'package:mobile_framework/mobile_framework.dart';

abstract interface class INotificationTokenRepository {
  ResultFuture<EmptyResponse> registerDeviceToken(
      RegisterNotificationDeviceTokenRequest request);
}
