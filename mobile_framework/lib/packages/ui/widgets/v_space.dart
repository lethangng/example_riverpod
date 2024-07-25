import 'package:flutter/material.dart';

/// A short version of [SizedBox] with height provided
class VSpace extends StatelessWidget {
  double height;
  VSpace(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }

  static VSpace get v20 {
    return VSpace(20.0);
  }

  static VSpace get v16 {
    return VSpace(16.0);
  }

  static VSpace get v12 {
    return VSpace(12.0);
  }

  static VSpace get v10 {
    return VSpace(10.0);
  }

  static VSpace get v8 {
    return VSpace(8.0);
  }

  static VSpace get v6 {
    return VSpace(6.0);
  }

  static VSpace get v4 {
    return VSpace(4.0);
  }
}