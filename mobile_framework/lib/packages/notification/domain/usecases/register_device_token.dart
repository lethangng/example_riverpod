// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class RegisterDeviceTokenUC
    extends LongRunningUseCase<void, RegisterNotificationDeviceTokenRequest> {
  INotificationTokenRepository repository;

  RegisterDeviceTokenUC({
    required this.repository,
  });

  @override
  Future<void> call({RegisterNotificationDeviceTokenRequest? params}) async {
    if (params == null) {
      return;
    }

    await repository
        .registerDeviceToken(params)
        .onError((error) => log("${error.message}"))
        .next();
  }
}

final registerDeviceTokenUCProvider = Provider<RegisterDeviceTokenUC>((ref) {
  return RegisterDeviceTokenUC(
    repository: ref.read(notificationTokenRepositoryProvider),
  );
});
