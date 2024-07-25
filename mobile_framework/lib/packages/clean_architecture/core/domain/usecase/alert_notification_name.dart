import 'package:mobile_framework/mobile_framework.dart';

enum AlertNotificationName implements NotificationName {
  showError,
  showSuccess,
  showLoading,
  hideLoading;

  @override
  String get rawValue => name;
}
