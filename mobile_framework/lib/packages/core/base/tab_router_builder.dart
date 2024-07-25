// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// use [TabRouter] for nested navigator
abstract class TabRouter extends StatelessWidget {
  TabRouter({super.key, required this.navigatorId});

  dynamic navigatorId;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(navigatorId),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }

  Route onGenerateRoute(RouteSettings settings);
}
