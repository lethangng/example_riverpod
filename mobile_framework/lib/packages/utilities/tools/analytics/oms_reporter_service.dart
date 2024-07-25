import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ReporterServiceFactory {
  static final Map<Type, ReporterService> _reporterServiceMap = {};

  static Future start(ReporterService reporterService) async {
    await reporterService.init();
    registerReporterService(reporterService);
  }

  static void registerReporterService(ReporterService reporterService) {
    _reporterServiceMap[reporterService.runtimeType] = reporterService;
  }

  static ReporterService get(Type type) {
    if (!_reporterServiceMap.containsKey(type)) {
      throw Exception(
          "ReporterServiceFactory: reporter service not found for type $type");
    }
    return _reporterServiceMap[type]!;
  }
}

abstract class ReportLogMessage {
  String toMessage();
}

abstract class ReporterService {
  Future init();

  void reportError(dynamic error, StackTrace stackTrace,
      {String? message, dynamic extraInformation}) {}

  void log(ReportLogMessage logMessage) {}

  /// only call when need to initialize report like [FirebaseCrashlytics]
  /// otherwise, it will be no-op
  void testErrorToStartSendReport() {}
}
