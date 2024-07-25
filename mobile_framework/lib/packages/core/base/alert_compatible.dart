
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AlertCompatible {
  void showLoading();
  void hideLoading();
  void showError(dynamic any);
  void showSuccess(String? message);
  void showWarning(String? message);
}

extension GetInterfaceExts on GetInterface {
  /// this api only closes a page without
  /// closes any overlay
  void closePage<T>({T? result}) {
    if (Get.context == null) {
      return;
    }

    return Navigator.of(Get.context!).pop<T>(result);
  }

  void closeOverlay<T>({T? result}) {
    if (Get.overlayContext == null) {
      return;
    }

    return Navigator.of(Get.overlayContext!).pop<T>(result);
  }
}
