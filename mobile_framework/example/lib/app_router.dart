import 'package:auto_route/auto_route.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:auto_route/annotations.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(modules: [MobileFrameworkRouterModule])
class AppRouter extends $AppRouter {
  @override
  // TODO: implement routes
  List<AutoRoute> get routes =>
      [AutoRoute(page: MyHomeRoute.page, initial: true)];
}
