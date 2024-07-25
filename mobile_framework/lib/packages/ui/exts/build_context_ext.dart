import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

extension BuildContextExts on BuildContext {
  Future<T?> showOverlay<T>(
    Widget overlayView, {
    bool dismissible = true,
    Duration? duration,
  }) {
    Timer? timer;
    if (duration != null) {
      timer = Timer(
        duration,
        () {
          appRouter.pop();
        },
      );
    }

    return showAdaptiveDialog<T>(
        context: this,
        barrierDismissible: dismissible,
        useRootNavigator: true,
        builder: (context) {
          return overlayView;
        }).then((value) {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }

      return value;
    });
  }

  Future<T?> showInteractiveSheet<T>(InteractiveSheet sheet) {
    return showModalBottomSheet<T>(
      context: this,
      builder: (BuildContext context) {
        return sheet;
      },
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: InteractiveSheetConfiguration.of(this)?.barrierColor,
    );
  }

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double includeBottomPadding(double value) {
    return value + mediaQuery.padding.bottom;
  }

  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;
}
