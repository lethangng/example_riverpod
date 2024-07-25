import 'package:auto_route/auto_route.dart';
import 'package:mobile_framework/mobile_framework.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Page|Screen|View,Route')
class MobileFrameworkRouterModule extends $MobileFrameworkRouterModule {
  static List<AutoRoute> get routes => [
        PresentedRoute(page: PreviewImagesRoute.page),
        PresentedRoute(page: SSOAuthRoute.page),
        PresentedRoute(page: SSOWebRoute.page),
        PresentedRoute(page: SimpleWebRoute.page),
      ];
}
