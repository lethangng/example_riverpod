import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

const String autoRouterObsTag = 'AppRouterObserver';

class AppRouterObserver extends AutoRouteObserver {
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log("Initialized tab ${route.name}", name: autoRouterObsTag);
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log("Changed to tab ${route.name}", name: autoRouterObsTag);
    super.didChangeTabRoute(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    log("Popped ${route.settings.name ?? ""} to ${previousRoute?.settings.name}",
        name: autoRouterObsTag);
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    log("Pushed ${route.settings.name ?? ""} from ${previousRoute?.settings.name ?? 'root'}",
        name: autoRouterObsTag);
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // TODO: implement didRemove
    log("Removed ${route.settings.name ?? ""} from ${previousRoute?.settings.name ?? 'root'}",
        name: autoRouterObsTag);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    // TODO: implement didReplace
    log("Replaced ${oldRoute?.settings.name ?? ""} with ${newRoute?.settings.name}",
        name: autoRouterObsTag);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
