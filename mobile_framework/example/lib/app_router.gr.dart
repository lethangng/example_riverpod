// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:example/main.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i4;
import 'package:mobile_framework/mobile_framework.dart' as _i3;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MyHomeRoute.name: (routeData) {
      final args = routeData.argsAs<MyHomeRouteArgs>();
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.MyHomePage(
          key: args.key,
          title: args.title,
        ),
      );
    },
    ..._i3.MobileFrameworkRouterModule().pagesMap,
  };
}

/// generated route for
/// [_i1.MyHomePage]
class MyHomeRoute extends _i2.PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({
    _i4.Key? key,
    required String title,
    List<_i2.PageRouteInfo>? children,
  }) : super(
          MyHomeRoute.name,
          args: MyHomeRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static const _i2.PageInfo<MyHomeRouteArgs> page =
      _i2.PageInfo<MyHomeRouteArgs>(name);
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({
    this.key,
    required this.title,
  });

  final _i4.Key? key;

  final String title;

  @override
  String toString() {
    return 'MyHomeRouteArgs{key: $key, title: $title}';
  }
}
