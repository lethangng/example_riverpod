import 'package:flutter/material.dart';

class LineSeparator extends StatelessWidget {
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  const LineSeparator({super.key, this.height = 1, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ??
            const EdgeInsets.only(
                right: 20.0, left: 20.0),
        height: height,
        color: color);
  }
}
