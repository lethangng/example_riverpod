import 'package:flutter/cupertino.dart';

abstract class SelectableTextEditingController extends TextEditingController {
  SelectableTextEditingController({super.text});

  void resetData();
}
