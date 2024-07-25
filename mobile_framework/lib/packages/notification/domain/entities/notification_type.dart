import 'package:mobile_framework/mobile_framework.dart';

abstract interface class ModuleNotificationType {}

/// Filter notification type that can be navigated to a specific module
mixin NotificationTypeMixin<Type extends ModuleNotificationType> on Module {
  @override
  void prepare() {
    // TODO: implement prepare
    super.prepare();

    NotificationCenter().addObserver<Map<String, dynamic>>(
      openNotification,
      callback: (data) async {
        var notificationType = filterNotificationType(data);
        await onNavigateFromNotification(notificationType, data);
      },
    );
  }

  Type filterNotificationType(Map<String, dynamic>? data);

  Future onNavigateFromNotification(
      Type notificationType, Map<String, dynamic>? data);
}
