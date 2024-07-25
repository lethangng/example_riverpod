import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_framework/mobile_framework.dart';

/// Global variable of GetIt instance
///
/// Do not confuse with [Get] instance come from [Get] package
final get = GetIt.instance;

final appRouter = get<RootStackRouter>();

final GlobalKey globalKey = GlobalKey();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final globalThemeProvider =
    Provider((ref) => GlobalThemeConfiguration.of(globalKey.currentContext!));

extension GlobalThemeRefExts on WidgetRef {
  GlobalThemeConfiguration get theme {
    if (globalKey.currentContext == null) {
      throw "MaterialApp or CupertinoApp is missing key, please add globalKey to their key";
    }

    return watch(globalThemeProvider)!;
  }
}

extension RootStackRouterExt on RootStackRouter {
  Size get physicalSize =>
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;

  double get width => physicalSize.width;

  double get height => physicalSize.height;
}
