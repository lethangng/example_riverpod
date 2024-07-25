import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:mobile_framework/mobile_framework.dart';

extension ExtensionSnackbar on BuildContext {
  static ToastificationItem? _currentToastificationItem;

  void showError(String? message) async {
    await Haptics.vibrate(HapticsType.error);
    showCustomSnackBarMessage(
      icon: CupertinoIcons.exclamationmark_circle,
      message: message,
      type: AlertType.error,
      toastType: ToastificationType.error,
    );
  }

  void showSuccess(String? message) async {
    await Haptics.vibrate(HapticsType.success);
    showCustomSnackBarMessage(
        icon: CupertinoIcons.checkmark_alt_circle,
        type: AlertType.success,
        message: message,
        toastType: ToastificationType.success);
  }

  void showCustomSnackBarMessage(
      {String? message,
      required IconData icon,
      required AlertType type,
      required ToastificationType toastType}) {
    if (_currentToastificationItem != null) {
      toastification.dismiss(_currentToastificationItem!,
          showRemoveAnimation: false);
    }

    _currentToastificationItem = toastification.showCustom(
        animationDuration: kThemeAnimationDuration,
        alignment: Alignment.topCenter,
        animationBuilder: (context, animation, alignment, child) {
          return SlideTransition(
              position: Tween(
                      begin: const Offset(0, -1), end: const Offset(0, 0))
                  .animate(
                      CurvedAnimation(parent: animation, curve: Curves.linear)),
              child: child);
        },
        dismissDirection: DismissDirection.vertical,
        autoCloseDuration: type.lifetime.seconds,
        builder: (BuildContext context, ToastificationItem holder) {
          return GestureDetector(
            onVerticalDragStart: (details) {
              toastification.dismiss(holder, showRemoveAnimation: true);
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: 80),
              decoration: ShapeDecoration(
                  color: switch (type) {
                    AlertType.error => Colors.red,
                    AlertType.success => Colors.green,
                    AlertType.warning => Colors.yellow,
                    AlertType.info => Colors.blue,
                    _ => Colors.transparent,
                  },
                  shadows: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        spreadRadius: 1)
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          Platform.isIOS ? 16.0.borderAll() : 4.0.borderAll())),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(16),
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                  const Gap(12),
                  Text(
                    message ?? "",
                    maxLines: null,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(vertical: 12).flexible(),
                  const Gap(16)
                ],
              ).center(),
            ).marginSymmetric(horizontal: 16),
          );
        });
  }
}
