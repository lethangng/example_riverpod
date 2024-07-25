import 'dart:developer';

import 'package:mobile_framework/mobile_framework.dart';

class SSORetryRequestErrorHandler extends RetryRequestErrorHandler {
  @override
  void onRefreshTokenError({Response? response}) {
    log("SSO Refresh Token Error: ${response?.data}", name: ssoLoggerTag);
    SSOModule.presentSSOAuthPage();
  }

  @override
  void onRetryError({Response? response}) {
    log("SSO Retry Error: ${response?.data}", name: ssoLoggerTag);
  }
}
