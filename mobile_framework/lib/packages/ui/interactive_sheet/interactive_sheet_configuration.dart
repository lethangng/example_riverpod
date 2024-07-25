import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InteractiveSheetConfiguration extends InheritedWidget {
  TextStyle titleTextStyle;

  Color? barrierColor;

  Color? backgroundColor;

  Color? appBarBackroundColor;
  

  InteractiveSheetConfiguration(
      {super.key,
      required this.titleTextStyle,
      required super.child,
      this.backgroundColor,
      this.appBarBackroundColor,
      this.barrierColor});

  static InteractiveSheetConfiguration? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InteractiveSheetConfiguration>();
  }

  @override
  bool updateShouldNotify(InteractiveSheetConfiguration oldWidget) {
    return barrierColor != oldWidget.barrierColor ||
        backgroundColor != oldWidget.backgroundColor ||
        titleTextStyle != oldWidget.titleTextStyle;
  }
}
