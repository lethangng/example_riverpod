// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i10;
import 'package:flutter/material.dart' as _i8;
import 'package:mobile_framework/mobile_framework.dart' as _i9;
import 'package:mobile_framework/packages/core/base/main_page.dart' as _i2;
import 'package:mobile_framework/packages/sso/base/sso_auth_page.dart' as _i4;
import 'package:mobile_framework/packages/sso/base/sso_web_view_page.dart'
    as _i5;
import 'package:mobile_framework/packages/ui/auto_route/application_main_page.dart'
    as _i1;
import 'package:mobile_framework/packages/ui/widgets/simple_webview.dart'
    as _i6;
import 'package:mobile_framework/packages/utilities/upload_files/presentation/views/preview_image_view.dart'
    as _i3;

abstract class $MobileFrameworkRouterModule extends _i7.AutoRouterModule {
  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    ApplicationMainRouter.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ApplicationMainRouter(),
      );
    },
    MainRoute.name: (routeData) {
      final args = routeData.argsAs<MainRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.MainPage(
          key: args.key,
          modules: args.modules,
          sideBarWidth: args.sideBarWidth,
          sideNavigationBuilder: args.sideNavigationBuilder,
          bottomNavigationBuilder: args.bottomNavigationBuilder,
          floatingActionButton: args.floatingActionButton,
          floatingActionButtonLocation: args.floatingActionButtonLocation,
          floatingActionButtonBuilder: args.floatingActionButtonBuilder,
        ),
      );
    },
    PreviewImagesRoute.name: (routeData) {
      final args = routeData.argsAs<PreviewImagesRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PreviewImagesView(
          key: args.key,
          startIndex: args.startIndex,
          previewImages: args.previewImages,
        ),
      );
    },
    SSOAuthRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SSOAuthPage(),
      );
    },
    SSOWebRoute.name: (routeData) {
      final args = routeData.argsAs<SSOWebRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SSOWebPage(
          key: args.key,
          url: args.url,
          title: args.title,
          delegate: args.delegate,
        ),
      );
    },
    SimpleWebRoute.name: (routeData) {
      final args = routeData.argsAs<SimpleWebRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SimpleWebView(
          key: args.key,
          title: args.title,
          url: args.url,
          loadLocalFile: args.loadLocalFile,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ApplicationMainRouter]
class ApplicationMainRouter extends _i7.PageRouteInfo<void> {
  const ApplicationMainRouter({List<_i7.PageRouteInfo>? children})
      : super(
          ApplicationMainRouter.name,
          initialChildren: children,
        );

  static const String name = 'ApplicationMainRouter';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MainPage]
class MainRoute extends _i7.PageRouteInfo<MainRouteArgs> {
  MainRoute({
    _i8.Key? key,
    required List<_i9.AutoRoutePageModule> modules,
    double sideBarWidth = 110,
    _i8.Widget Function(
      List<_i9.AutoRoutePageModule>,
      _i8.PageController,
    )? sideNavigationBuilder,
    _i8.Widget Function(
      List<_i9.AutoRoutePageModule>,
      _i7.TabsRouter,
    )? bottomNavigationBuilder,
    _i8.Widget? floatingActionButton,
    _i8.FloatingActionButtonLocation? floatingActionButtonLocation,
    _i8.Widget? Function(
      _i8.BuildContext,
      _i7.TabsRouter,
    )? floatingActionButtonBuilder,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          MainRoute.name,
          args: MainRouteArgs(
            key: key,
            modules: modules,
            sideBarWidth: sideBarWidth,
            sideNavigationBuilder: sideNavigationBuilder,
            bottomNavigationBuilder: bottomNavigationBuilder,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonBuilder: floatingActionButtonBuilder,
          ),
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i7.PageInfo<MainRouteArgs> page =
      _i7.PageInfo<MainRouteArgs>(name);
}

class MainRouteArgs {
  const MainRouteArgs({
    this.key,
    required this.modules,
    this.sideBarWidth = 110,
    this.sideNavigationBuilder,
    this.bottomNavigationBuilder,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonBuilder,
  });

  final _i8.Key? key;

  final List<_i9.AutoRoutePageModule> modules;

  final double sideBarWidth;

  final _i8.Widget Function(
    List<_i9.AutoRoutePageModule>,
    _i8.PageController,
  )? sideNavigationBuilder;

  final _i8.Widget Function(
    List<_i9.AutoRoutePageModule>,
    _i7.TabsRouter,
  )? bottomNavigationBuilder;

  final _i8.Widget? floatingActionButton;

  final _i8.FloatingActionButtonLocation? floatingActionButtonLocation;

  final _i8.Widget? Function(
    _i8.BuildContext,
    _i7.TabsRouter,
  )? floatingActionButtonBuilder;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, modules: $modules, sideBarWidth: $sideBarWidth, sideNavigationBuilder: $sideNavigationBuilder, bottomNavigationBuilder: $bottomNavigationBuilder, floatingActionButton: $floatingActionButton, floatingActionButtonLocation: $floatingActionButtonLocation, floatingActionButtonBuilder: $floatingActionButtonBuilder}';
  }
}

/// generated route for
/// [_i3.PreviewImagesView]
class PreviewImagesRoute extends _i7.PageRouteInfo<PreviewImagesRouteArgs> {
  PreviewImagesRoute({
    _i10.Key? key,
    int startIndex = 0,
    required List<_i9.AppFile> previewImages,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          PreviewImagesRoute.name,
          args: PreviewImagesRouteArgs(
            key: key,
            startIndex: startIndex,
            previewImages: previewImages,
          ),
          initialChildren: children,
        );

  static const String name = 'PreviewImagesRoute';

  static const _i7.PageInfo<PreviewImagesRouteArgs> page =
      _i7.PageInfo<PreviewImagesRouteArgs>(name);
}

class PreviewImagesRouteArgs {
  const PreviewImagesRouteArgs({
    this.key,
    this.startIndex = 0,
    required this.previewImages,
  });

  final _i10.Key? key;

  final int startIndex;

  final List<_i9.AppFile> previewImages;

  @override
  String toString() {
    return 'PreviewImagesRouteArgs{key: $key, startIndex: $startIndex, previewImages: $previewImages}';
  }
}

/// generated route for
/// [_i4.SSOAuthPage]
class SSOAuthRoute extends _i7.PageRouteInfo<void> {
  const SSOAuthRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SSOAuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'SSOAuthRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SSOWebPage]
class SSOWebRoute extends _i7.PageRouteInfo<SSOWebRouteArgs> {
  SSOWebRoute({
    _i10.Key? key,
    required String url,
    required String title,
    required _i9.SSOWebDataDelegate delegate,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SSOWebRoute.name,
          args: SSOWebRouteArgs(
            key: key,
            url: url,
            title: title,
            delegate: delegate,
          ),
          initialChildren: children,
        );

  static const String name = 'SSOWebRoute';

  static const _i7.PageInfo<SSOWebRouteArgs> page =
      _i7.PageInfo<SSOWebRouteArgs>(name);
}

class SSOWebRouteArgs {
  const SSOWebRouteArgs({
    this.key,
    required this.url,
    required this.title,
    required this.delegate,
  });

  final _i10.Key? key;

  final String url;

  final String title;

  final _i9.SSOWebDataDelegate delegate;

  @override
  String toString() {
    return 'SSOWebRouteArgs{key: $key, url: $url, title: $title, delegate: $delegate}';
  }
}

/// generated route for
/// [_i6.SimpleWebView]
class SimpleWebRoute extends _i7.PageRouteInfo<SimpleWebRouteArgs> {
  SimpleWebRoute({
    _i8.Key? key,
    required String title,
    required String url,
    bool loadLocalFile = false,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SimpleWebRoute.name,
          args: SimpleWebRouteArgs(
            key: key,
            title: title,
            url: url,
            loadLocalFile: loadLocalFile,
          ),
          initialChildren: children,
        );

  static const String name = 'SimpleWebRoute';

  static const _i7.PageInfo<SimpleWebRouteArgs> page =
      _i7.PageInfo<SimpleWebRouteArgs>(name);
}

class SimpleWebRouteArgs {
  const SimpleWebRouteArgs({
    this.key,
    required this.title,
    required this.url,
    this.loadLocalFile = false,
  });

  final _i8.Key? key;

  final String title;

  final String url;

  final bool loadLocalFile;

  @override
  String toString() {
    return 'SimpleWebRouteArgs{key: $key, title: $title, url: $url, loadLocalFile: $loadLocalFile}';
  }
}
