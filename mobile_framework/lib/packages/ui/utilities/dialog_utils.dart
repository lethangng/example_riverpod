import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_framework/packages/ui/widgets/animated_overlay.dart';

class DialogUtils {
  static Completer? _loadingCompleter;

  static void showLoading(Widget loading, Duration timeout,
      {Color? barrierColor}) {
    hideLoading();
    _loadingCompleter = Completer();
    OverlayView(
      dismissible: false,
      duration: timeout,
      overlayCompleter: _loadingCompleter,
      child: loading,
    ).show();
  }

  static void hideLoading() {
    if (_loadingCompleter?.isCompleted ?? false) {
      return;
    }
    _loadingCompleter?.complete();
  }

  static Future<T?> show<T>(Widget view,
      {Color? barrierColor,
      bool closeOnTapBarrier = true,
      Completer<T?>? completer}) {
    return OverlayView<T>(
      dismissible: closeOnTapBarrier,
      overlayCompleter: completer,
      child: view,
    ).show();
  }

  static Future<T?> bottomSheet<T>(Widget view,
      {Color? barrierColor,
      bool closeOnTapBarrier = true,
      String? name,
      Object? args,
      bool isScrollControlled = true}) {
    return Get.bottomSheet<T>(view,
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.6),
        isScrollControlled: isScrollControlled,
        clipBehavior: Clip.antiAlias,
        settings: RouteSettings(name: name, arguments: args),
        enterBottomSheetDuration: const Duration(milliseconds: 250),
        exitBottomSheetDuration: const Duration(milliseconds: 200),
        isDismissible: true);
  }
}
