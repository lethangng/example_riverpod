import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class AlertNotificationDemoPage extends StatelessWidget {
  const AlertNotificationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Notification Demo Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoTheme(
            data: const CupertinoThemeData(
              primaryColor: CupertinoColors.destructiveRed,
            ),
            child: CupertinoButton.filled(
              child: const Text("Show error message",
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                context.showError('404! Cannot find resource');
              },
            ),
          ),
          const Gap(16),
          CupertinoTheme(
            data: const CupertinoThemeData(
              primaryColor: CupertinoColors.activeGreen,
            ),
            child: CupertinoButton.filled(
              child: const Text("Show success message",
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                context.showSuccess('Update data succesfully');
              },
            ),
          ),
          const Gap(16),
          CupertinoTheme(
            data: const CupertinoThemeData(
              primaryColor: CupertinoColors.activeGreen,
            ),
            child: CupertinoButton.filled(
              child: const Text("Show success message",
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                context.showCustomSnackBarMessage(
                  message: 'ok',
                  icon: Icons.check,
                  toastType: ToastificationType.error,
                  type: AlertType.error,
                );
              },
            ),
          ),
        ],
      ).defaultHorizontalPadding(),
    );
  }
}
