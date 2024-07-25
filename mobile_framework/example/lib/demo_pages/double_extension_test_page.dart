import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class DoubleExtensionTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Double Extension Test'),
        ),
        body: Center(
          child: Text(10000000.348534857.formatCurrency()),
        ));
  }
}
