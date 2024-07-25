// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_framework/packages/core/base/tab_router_builder.dart';

class ModuleRouter extends TabRouter {
  Function()? bindings;
  Widget? page;
  List<GetMiddleware>? middlewares;
  GetPageRoute Function(RouteSettings settings)? onCreatePageRoute;

  ModuleRouter({
    super.key,
    required super.navigatorId,
    this.onCreatePageRoute,
    this.bindings,
    this.page,
    this.middlewares,
  })  : assert(
          page == null || onCreatePageRoute == null,
          "onCreatePageRoute cannot be provided with one of bindings and page",
        ),
        assert(
          bindings == null || onCreatePageRoute == null,
          "onCreatePageRoute cannot be provided with one of bindings and page",
        );

  @override
  Route onGenerateRoute(RouteSettings settings) {
    if (onCreatePageRoute != null) {
      return onCreatePageRoute!(settings);
    }

    if (settings.name == '/') {
      return GetPageRoute(
          settings: settings,
          binding: BindingsBuilder(() {
            bindings?.call();
          }),
          page: () => page ?? Container(),
          middlewares: middlewares);
    }

    throw "Not a route";
  }
}
