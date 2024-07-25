import 'package:mobile_framework/mobile_framework.dart';

/// [SideEffectController] will handle how use case will notify
/// the app to show error and success message, or do whatever actions
/// that need to be performed
///
/// One usecase will have one side effect controller
/// This controller will be delegated to the controller of [GetView] or
/// simply a [StatelessWidget] or [StatefulWidget]
///
@Deprecated("Use AlertControllerProvider to control alert")
abstract class SideEffectController {
  onError(Exception? error, {dynamic caller});
  onSuccess(dynamic any, {dynamic caller});
}

extension DriveSideEffect<ReturnType, Parameters>
    on UseCase<ReturnType, Parameters> {
  void driveSideEffectBy(SideEffectController controller) {
    sideEffectController = controller;
  }

  void noSideEffect() {
    sideEffectController = null;
  }
}

extension SideEffectControllerExts on UseCase {
  @Deprecated("Use showError instead")
  void emitError(Exception? error, {dynamic caller}) {
    sideEffectController?.onError(error, caller: caller);
  }

  @Deprecated("Use showSuccess instead")
  void emitSuccess(dynamic any, {dynamic caller}) {
    sideEffectController?.onSuccess(any, caller: caller);
  }
}
