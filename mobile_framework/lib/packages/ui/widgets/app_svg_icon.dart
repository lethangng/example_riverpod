import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AppSvgIconView extends StatelessWidget {
  final SvgPicture child;
  final String name;
  final Color? color;
  final double? size;

  AppSvgIconView({super.key, required this.name, this.color, this.size})
      : child = SvgPicture.asset(
          name,
          width: size ?? 20.0,
          height: size ?? 20.0,
          color: color,
        );

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
