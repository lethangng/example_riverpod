import 'package:mobile_framework/mobile_framework.dart';
import 'package:auto_route/auto_route.dart';

class ApplicationMainRoute extends CustomRoute {
  /// [children] contains all routes that are not inside the tab
  /// when push any routes of [children], the bottom tab bar is pushed behind
  ApplicationMainRoute({
    required List<AutoRoute> tabs,
    List<AutoRouteGuard> guards = const [],
    List<AutoRoute> children = const [],
  }) : super(page: ApplicationMainRouter.page, initial: true, children: [
          AutoRoute(page: MainRoute.page, children: tabs, guards: guards),
          ...children
        ]);
}
