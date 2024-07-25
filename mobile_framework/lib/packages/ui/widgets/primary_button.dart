// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/ui/exts/widget_exts.dart';
import 'package:mobile_framework/packages/ui/widgets/dev_pack_configuration.dart';

class PrimaryButton extends StatelessWidget with GlobalThemePlugin {
  final VoidCallback? onPressed;
  final Widget title;
  final bool isDisable;
  final Size? size;
  final bool isVisible;
  final Color? color;
  final List<BoxShadow> shadows;

  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.title,
    this.isDisable = false,
    this.size,
    this.isVisible = true,
    this.color,
    this.shadows = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: shadows),
      child: CupertinoTheme(
        data: CupertinoThemeData(primaryColor: color ?? conf.mainColor),
        child: CupertinoButton.filled(
          borderRadius: BorderRadius.circular(conf.primaryButtonBorderRadius),
          disabledColor: Colors.grey.shade400,
          pressedOpacity: 0.8,
          onPressed: isDisable ? null : onPressed,
          padding: EdgeInsets.zero,
          child: Material(
              color: Colors.transparent,
              child: title.center().paddingOnly(left: 8.0, right: 8.0)),
        ),
      )
          .box(
              h: size?.height ?? conf.primaryButtonDefaultHeight,
              w: size?.width)
          .visibility(isVisible),
    );
  }
}
