// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_framework/packages/ui/utilities/casting.dart';

class PageLifeCycleMiddleware extends GetMiddleware {
  BasePage page;

  PageLifeCycleMiddleware({
    required this.page,
  });

  @override
  int? priority = -10000;

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    page.as<BindingsLifeCycle>()?.onChangeBindingsBeforeInitializing(
          bindings,
        );
    return bindings;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    this.page.onDependenciesReady();
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    this.page.as<PageLifeCycle>()?.onWillAppear(page);
    return page;
  }

  @override
  void onPageDispose() {
    page.as<PageLifeCycle>()?.onDispose();
  }
}

extension PageExts on GetInterface {
  void open<T, P extends BasePage>(P Function() page,
      {dynamic arguments,
      Map<String, String>? parameters,
      Transition transition = Transition.native,
      Curve? curve,
      Duration? duration,
      int? id,
      String? routeName,
      List<GetMiddleware>? middlewares,
      Function(T? result)? onResult}) async {
    final finalMiddlewares = <GetMiddleware>[];

    if (middlewares != null) {
      finalMiddlewares.addAll(middlewares);
    }

    finalMiddlewares.add(PageLifeCycleMiddleware(page: page()));

    if ((await page().as<PageRedirectable>()?.canRedirect() ?? false)) {
      page()
          .as<PageRedirectable>()
          ?.onRedirect()
          .then((value) => onResult?.call(value));

      return;
    }

    global(id)
        .currentState
        ?.push<T>(
          GetPageRoute<T>(
              opaque: true,
              page: page,
              routeName: routeName,
              settings: RouteSettings(
                name: routeName ?? getRouteName(page),
                arguments: arguments,
              ),
              popGesture: defaultPopGesture,
              transition: transition,
              curve: curve,
              parameter: parameters,
              fullscreenDialog: false,
              showCupertinoParallax: Platform.isIOS,
              binding: BindingsBuilder(() {
                page().onDependenciesStart();
              }),
              transitionDuration: duration ?? defaultTransitionDuration,
              middlewares: finalMiddlewares),
        )
        .then((value) => onResult?.call(value));
  }

  void present<T, P extends BasePage>(P Function() page,
      {dynamic arguments,
      Map<String, String>? parameters,
      Curve? curve,
      Duration? duration,
      int? id,
      String? routeName,
      List<GetMiddleware>? middlewares,
      Function(T? result)? onResult}) async {
    final finalMiddlewares = <GetMiddleware>[];

    if (middlewares != null) {
      finalMiddlewares.addAll(middlewares);
    }

    finalMiddlewares.add(PageLifeCycleMiddleware(page: page()));

    if ((await page().as<PageRedirectable>()?.canRedirect() ?? false)) {
      page()
          .as<PageRedirectable>()
          ?.onRedirect()
          .then((value) => onResult?.call(value));

      return;
    }

    global(id)
        .currentState
        ?.push<T>(
          GetPageRoute<T>(
              opaque: true,
              page: page,
              routeName: routeName,
              settings: RouteSettings(
                name: routeName ?? getRouteName(page),
                arguments: arguments,
              ),
              popGesture: defaultPopGesture,
              transition: Transition.downToUp,
              curve: Curves.fastOutSlowIn,
              parameter: parameters,
              fullscreenDialog: true,
              showCupertinoParallax: false,
              binding: BindingsBuilder(() {
                page().onDependenciesStart();
              }),
              transitionDuration: duration ?? defaultTransitionDuration,
              middlewares: finalMiddlewares),
        )
        .then((value) => onResult?.call(value));
  }

  String getRouteName(dynamic page) {
    return page.runtimeType.toString().split(" ").last;
  }
}

mixin PageRedirectable {
  Future<bool> canRedirect();

  Future<dynamic> onRedirect();
}

mixin PageLifeCycle {
  void onWillAppear(Widget page) {}

  void onDispose() {}
}

mixin BindingsLifeCycle {
  void onChangeBindingsBeforeInitializing(List<Bindings>? bindings) {}

  void onDependenciesStart();

  void onDependenciesReady() {}
}

abstract class BasePage<T> extends GetView<T> with BindingsLifeCycle {
  const BasePage({super.key});

  @override
  void onDependenciesStart();

  @override
  void onDependenciesReady() {}

  @override
  Widget build(BuildContext context);
}
