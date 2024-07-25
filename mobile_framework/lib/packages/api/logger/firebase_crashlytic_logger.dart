import 'package:mobile_framework/mobile_framework.dart';

class FirebaseCrashlyticErrorLogger extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    talkerLogger.log("FirebaseCrashlytics sent error to Firebase",
        level: LogLevel.verbose);

    try {
      if (SSOAccountManager.getCurrentAccount() != null) {
        FirebaseCrashlytics.instance.setCustomKey("current_user",
            SSOAccountManager.getCurrentAccount()!.encode().toString());
      }

      dynamic reason = "";

      if (err.response?.data != null &&
          err.response?.data?["message"] != null) {
        reason = {
          "status_code": err.response?.statusCode,
          "message": err.response?.data?["message"],
        };
      } else {
        reason = {
          "status_code": err.response?.statusCode,
          "message": err.message,
        };
      }

      await FirebaseCrashlytics.instance
          .recordError(err, err.stackTrace, reason: reason, fatal: false);
    } catch (e, s) {
      talkerLogger.log("Error: $e, $s");
    }

    super.onError(err, handler);
  }
}
