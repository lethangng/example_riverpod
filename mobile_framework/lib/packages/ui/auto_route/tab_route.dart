import 'package:auto_route/auto_route.dart';

class TabRoute extends CustomRoute {
  /// [tabRouterPage] is the page which will be used to create the AutoRouter
  /// to manage route stack in current tab, it should be a router class extends [AutoRouter]
  /// [firstPage] is the initial page of the tab, which is the topmost page of the stack
  /// [children] is the children of the current tab, which is the children of the stack
  TabRoute(
      {required PageInfo tabRouterPage,
      required PageInfo firstPage,
      super.guards,
      List<AutoRoute>? children})
      : super(
          page: tabRouterPage,
          children: [
            AutoRoute(page: firstPage, initial: true),
            if (children != null) ...children,
          ],
          fullscreenDialog: false,
        );
}
