import 'package:auto_route/auto_route.dart';
import 'package:mobile_framework/mobile_framework.dart';

class AuthenticationRouteGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (SSOModule.isAppNoLongerSignedIn()) {
      SSOModule.presentSSOAuthPage();
    } else {
      resolver.next(true);
    }
  }
}
