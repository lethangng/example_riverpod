// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/alert_notification_name.dart';

/// [UseCase] is an abstract class for usecase in Domain Layer
///
/// Each use case will handle a business logic
/// in order to separate business logics of application
/// to smaller pieces which can help us deal with bigger logic
/// if our app grows bigger
abstract class UseCase<ReturnType, Parameters> with AlertMixin {
  @Deprecated("Use AlertCompatible to control alert")
  SideEffectController? sideEffectController;

  ReturnType call({Parameters? params});

  /// use for cancel request, free other resources used in this use case
  void dispose() {}
}

/// [LongRunningUseCase] is used to represent usecase performing a
/// long running task, such as a api call, complex calculation task
abstract class LongRunningUseCase<ReturnType, Parameters>
    extends UseCase<Future<ReturnType>, Parameters> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

abstract class RefUseCase<ReturnType, Parameters>
    extends UseCase<ReturnType, Parameters> with RefCompatible {}

abstract class RefLongRunningUseCase<ReturnType, Parameters>
    extends RefUseCase<Future<ReturnType>, Parameters> {}

abstract class RefRepositoryLongRunningUseCase<ReturnType, Parameters,
    Repository> extends RefLongRunningUseCase<ReturnType, Parameters> {
  Repository repository;

  RefRepositoryLongRunningUseCase({
    required this.repository,
  });
}

extension RefUseCaseExts<R, T, S extends UseCase<R, T>> on S {
  S setRef(Ref ref) {
    as<RefCompatible>()?._setRef(ref);
    return this;
  }
}

mixin RefCompatible {
  Ref? _ref;

  Ref get ref {
    assert(_ref != null, "Please call setRef() before using ref");
    return _ref!;
  }

  void _setRef(Ref ref) {
    _ref = ref;
  }
}

mixin AlertMixin {
  void showError(Exception? error, {dynamic caller}) {
    NotificationCenter().postNotification(AlertNotificationName.showError, {
      "error": error,
      "caller": caller,
    });
  }

  void showLoading({Duration? duration}) {
    NotificationCenter()
        .postNotification(AlertNotificationName.showLoading, duration);
  }

  void showSuccess(dynamic any, {dynamic caller}) {
    NotificationCenter().postNotification(AlertNotificationName.showSuccess, {
      "message": any,
      "caller": caller,
    });
  }

  void hideLoading() async {
    NotificationCenter().postNotification(AlertNotificationName.hideLoading);
  }
}
