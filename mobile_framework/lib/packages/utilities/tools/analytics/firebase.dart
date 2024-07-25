import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'oms_reporter_service.dart';

class FireabaseReporterService extends ReporterService {
  @override
  void reportError(
    dynamic error,
    StackTrace stackTrace, {
    String? message,
    dynamic extraInformation,
  }) {
    if (extraInformation != null && extraInformation is List<DiagnosticsNode>) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace,
          reason: message, fatal: true, information: extraInformation);
      return;
    }

    FirebaseCrashlytics.instance
        .recordError(error, stackTrace, reason: message, fatal: true);
  }

  @override
  Future init() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  @override
  void log(ReportLogMessage logMessage) {
    FirebaseCrashlytics.instance.log(logMessage.toMessage());
  }

  @override
  void testErrorToStartSendReport() {
    throw Exception("Test error to start send report");
  }

  void setUserId(String userId) {
    FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  void setCustomKey(String key, dynamic value) {
    FirebaseCrashlytics.instance.setCustomKey(key, value);
  }
}
