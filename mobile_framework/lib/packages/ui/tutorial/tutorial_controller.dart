import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialController {
  List<int> orders = [];

  List<(int, GlobalKey)> globalKeys = [];

  void addOrder(int order) {
    if (orders.contains(order)) {
      return;
    }
    orders.add(order);
    globalKeys.add((order, GlobalKey()));
  }

  void playTutorialAt(int order, BuildContext context) {
    if (!orders.contains(order)) {
      log("Cannot find order $order in orders list.",
          name: "TutorialController");
      return;
    }

    ShowCaseWidget.of(context).startShowCase(
        [globalKeys.firstWhere((element) => element.$1 == order).$2]);
  }

  GlobalKey? getGlobalKeyInOrder(int order) {
    if (!orders.contains(order)) {
      log("Cannot find order $order in orders list.",
          name: "TutorialController");
      return null;
    }
    return globalKeys.firstWhere((element) => element.$1 == order).$2;
  }

  void start(BuildContext context) {
    globalKeys.sort(
      (a, b) {
        return a.$1.compareTo(b.$1);
      },
    );

    ShowCaseWidget.of(context)
        .startShowCase(globalKeys.map((e) => e.$2).toList());
  }
}
