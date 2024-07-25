import 'package:flutter/material.dart';

/// A short version of [SizedBox] with width provided
class HSpace extends StatelessWidget {
  double width;
  HSpace(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }

  static HSpace get h20 {
    return HSpace(20.0);
  }

  static HSpace get h16 {
    return HSpace(16.0);
  }

  static HSpace get h12 {
    return HSpace(12.0);
  }

  static HSpace get h10 {
    return HSpace(10.0);
  }

  static HSpace get h8 {
    return HSpace(8.0);
  }

  static HSpace get h6 {
    return HSpace(6.0);
  }

  static HSpace get h4 {
    return HSpace(4.0);
  }
}
