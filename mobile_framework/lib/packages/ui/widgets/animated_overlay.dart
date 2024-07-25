import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable

/// Global handler for closing [OverlayView]
@Deprecated(
    "No longer support in version 2.0.0, use context.showOverlay instead")
class OverlayViewManager {
  static Completer? _currentCompleter;

  static setCompleter(Completer? completer) {
    _currentCompleter = completer;
  }

  static Future<T?> close<T>({T? result}) async {
    if (_currentCompleter?.isCompleted ?? false) {
      return Future.value(null);
    }
    _currentCompleter?.complete(result);

    return await _currentCompleter?.future ?? Future.value(null);
  }
}

@immutable
// ignore: must_be_immutable
@Deprecated(
    "No longer support in version 2.0.0, use `context.showOverlay()` instead")
class OverlayView<T> extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final bool dismissible;

  /// control [OverlayView] show/hide state and passing data back
  final Completer<T?> overlayCompleter;

  late final OverlayState? overlayState =
      Navigator.of(scaffoldMessengerKey.currentContext!, rootNavigator: false)
          .overlay;

  BuildContext? get overlayContext {
    BuildContext? overlay;
    // globalKey.currentState?.overlay?.context.visitChildElements((element) {
    //   overlay = element;
    // });
    return overlay;
  }

  Future<void> Function()? _onCloseOverlay;

  OverlayView(
      {super.key,
      required this.child,
      this.duration,
      this.dismissible = true,
      Completer<T?>? overlayCompleter})
      : overlayCompleter = overlayCompleter ?? Completer<T?>();

  @override
  State<OverlayView> createState() => _OverlayViewState();

  Future<T?> show() async {
    /// close any `OverlayView` is presenting
    OverlayViewManager.close();
    OverlayViewManager.setCompleter(overlayCompleter);
    final overlayEntry = OverlayEntry(builder: (context) {
      return this;
    });

    overlayState?.insert(overlayEntry);
    var data = await overlayCompleter.future;
    await _onCloseOverlay?.call();
    overlayEntry.remove();
    return data;
  }
}

class _OverlayViewState extends State<OverlayView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 250));

  late Animation<Color?> overlayColorAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    overlayColorAnimation = ColorTween(
            begin: Colors.transparent, end: Colors.black.withOpacity(0.3))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });

    widget._onCloseOverlay = () {
      return controller.reverse();
    };

    if (widget.duration != null) {
      Future.delayed(widget.duration!, () {
        if (widget.overlayCompleter.isCompleted) {
          return;
        }
        widget.overlayCompleter.complete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: overlayColorAnimation.value),
        GestureDetector(onTap: () {
          if (widget.dismissible) {
            widget.overlayCompleter.complete();
          }
        }),
        Opacity(opacity: opacityAnimation.value, child: widget.child)
      ],
    );
  }
}
