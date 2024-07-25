// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/core/base/module_router.dart';
import 'package:mobile_framework/packages/core/base/tabbar_item.dart';
import 'package:mobile_framework/packages/env/environment.dart';
import 'package:mobile_framework/packages/global/define.dart';
import 'package:mobile_framework/packages/ui/widgets/keep_alive_wrapper.dart';

/// [Module] is an abstract wrapper for a module
/// will be used to connect in super app
abstract class Module extends EnvInjectable {
  Module(super.env);

  void prepare() {}

  @mustCallSuper
  Future<void> registerDependency() async {
    get.registerSingleton(env, instanceName: runtimeType.toString());
  }

  static Env findEnv({required Type of}) {
    if (get.isRegistered<Env>(instanceName: of.toString())) {
      return get(instanceName: of.toString());
    }

    throw Exception("Env not found for $of");
  }
}

/// [PageModule] is an abstract wrapper for app modules
/// modules must be implement this class to show in tab bar
@Deprecated("Use `AutoRoutePageModule` instead")
abstract class PageModule extends Module {
  PageModule(
    super.env, {
    required this.router,
    required this.visible,
    required this.item,
  });

  @Deprecated("No longer supported")
  ModuleRouter router;

  bool visible;

  TabBarItem item;

  @Deprecated("No longer supported")
  KeepAliveWrapper get page => KeepAliveWrapper(child: router);
}

abstract class AutoRoutePageModule extends Module {
  AutoRoutePageModule(super.env,
      {this.visible = true, required this.item, required this.firstRoute});

  /// This is first route of module
  PageRouteInfo firstRoute;

  bool visible;

  BottomNavigationBarItem item;
}

class MainModule extends Module {
  List<Module> subModules = [];

  MainModule(
    super.env, {
    required this.subModules,
  });

  @override
  void prepare() {
    for (var element in subModules) {
      element.prepare();
    }
  }

  void registerDependencies() {
    registerDependency();

    for (var element in subModules) {
      element.registerDependency();
    }
  }
}

class CoreModule extends Module {
  CoreModule(super.env);
}
