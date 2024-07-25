import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/alert_notification_name.dart';

class OverlayRootBuilderWidget extends ConsumerStatefulWidget {
  final Widget Function(BuildContext context, WidgetRef ref) builder;

  const OverlayRootBuilderWidget({super.key, required this.builder});

  @override
  ConsumerState createState() => _OverlayRootBuildWidgetState();
}

class _OverlayRootBuildWidgetState
    extends ConsumerState<OverlayRootBuilderWidget> {
  ShakeDetector? detector;
  bool isLoggerShown = false;
  bool isLoadingShown = false;

  BuildContext get navigatorContext {
    var ctx = appRouter.navigatorKey.currentContext;

    assert(ctx != null,
        "Navigator key is missing, please set navigatorKey in navigatorKey in MaterialApp");

    return ctx!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationCenter().addObserver<Map<String, dynamic>>(
        AlertNotificationName.showError, callback: (data) {
      var error = data?["error"];

      if (error is CommonError) {
        if (error.errorData != null) {
          try {
            context.showError(error.errorData is String
                ? error.errorData
                : error.errorData?["message"]);
          } catch (e, s) {
            log("Error: $e, $s");
            context.showError("Ôi! Đã có lỗi xảy ra rồi");
          }
        } else if (error.message != null) {
          context.showError(error.message);
        } else {
          context.showError("Ôi! Đã có lỗi xảy ra rồi");
        }
      }
    });

    NotificationCenter().addObserver<Map<String, dynamic>>(
        AlertNotificationName.showSuccess, callback: (data) {
      var message = data?["message"] as String;
      context.showSuccess(message);
    });

    NotificationCenter().addObserver<Duration>(
        AlertNotificationName.showLoading, callback: (duration) {
      if (!mounted) {
        return;
      }
      isLoadingShown = true;
      setState(() {});

      var loadingDuration = duration ?? AlertType.loading.lifetime.seconds;
      Future.delayed(
        loadingDuration,
        () {
          if (isLoadingShown) {
            isLoadingShown = false;
            if (!mounted) {
              return;
            }
            setState(() {});
          }
        },
      );
    });

    NotificationCenter().addObserver(AlertNotificationName.hideLoading,
        callback: (_) {
      isLoadingShown = false;
      setState(() {});
    });

    if (Module.findEnv(of: CoreModule).isProd) {
      return;
    }

    detector = ShakeDetector.autoStart(onPhoneShake: () {
      if (isLoggerShown) {
        return;
      }

      isLoggerShown = true;
      appRouter.pushWidget(
        TalkerScreen(talker: talker),
        fullscreenDialog: true,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          );
        },
      ).then((value) => isLoggerShown = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalWidget(
        visible: isLoadingShown,
        modal: ref.theme.loadingIndicator,
        child: widget.builder(context, ref));
  }
}

class ModalWidget extends StatelessWidget {
  const ModalWidget({
    super.key,
    required this.visible,
    required this.modal,
    required this.child,
    this.onClose,
  });

  final Widget child;
  final Widget modal;
  final bool visible;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return BarrierWidget(
      visible: visible,
      onClose: onClose,
      child: PortalTarget(
        visible: visible,
        closeDuration: kThemeAnimationDuration,
        portalFollower: TweenAnimationBuilder<double>(
          duration: kThemeAnimationDuration,
          curve: Curves.easeOut,
          tween: Tween(begin: 0, end: visible ? 1 : 0),
          builder: (context, progress, child) {
            return Transform(
              transform: Matrix4.translationValues(0, (1 - progress) * 50, 0),
              child: Opacity(
                opacity: progress,
                child: child,
              ),
            );
          },
          child: Center(child: modal),
        ),
        child: child,
      ),
    );
  }
}

class BarrierWidget extends StatelessWidget {
  const BarrierWidget({
    super.key,
    required this.onClose,
    required this.visible,
    required this.child,
  });

  final Widget child;
  final VoidCallback? onClose;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: visible,
      closeDuration: kThemeAnimationDuration,
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClose,
        child: TweenAnimationBuilder<Color>(
          duration: kThemeAnimationDuration,
          tween: _ColorTween(
            begin: Colors.transparent,
            end: visible ? Colors.black54 : Colors.transparent,
          ),
          builder: (context, color, child) {
            return ColoredBox(color: color);
          },
        ),
      ),
      child: child,
    );
  }
}

/// Non-nullable version of ColorTween.
class _ColorTween extends Tween<Color> {
  _ColorTween({required Color begin, required Color end})
      : super(begin: begin, end: end);

  @override
  Color lerp(double t) => Color.lerp(begin, end, t)!;
}
