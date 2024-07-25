import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_framework/mobile_framework.dart';

class BaseScaffold extends Scaffold {
  BaseScaffold({
    super.key,
    Color? backgroundColor,
    Color? appBarColor,
    PreferredSizeWidget? customAppBar,
    bool noAppBar = false,
    List<Widget> rightActions = const [],
    int? navigatorId,
    String? titleText,
    bool canBack = true,
    bool centerTitle = true,
    bool super.resizeToAvoidBottomInset = true,
    PreferredSize? tabBar,
    Widget? leading,
    Widget? title,
    super.bottomSheet,
    Widget? fab,
    Widget? body,
    Widget? bottomView,
    VoidCallback? onRefresh,
    VoidCallback? onBack,
    super.drawer,
    super.drawerEnableOpenDragGesture,
    super.endDrawer,
    super.endDrawerEnableOpenDragGesture,
    Function(bool isOpened)? super.onDrawerChanged,
    Function(bool isOpened)? super.onEndDrawerChanged,
  }) : super(
            drawerScrimColor: Colors.black45,
            backgroundColor: backgroundColor ??
                GlobalThemeConfiguration.global()?.baseScaffoldBackgroundColor,
            appBar: noAppBar
                ? null
                : customAppBar ??
                    AppBar(
                        bottom: tabBar,
                        automaticallyImplyLeading: false,
                        backgroundColor: appBarColor ??
                            GlobalThemeConfiguration.global()?.mainColor,
                        actions: rightActions
                            .map((e) => Container(
                                  height: 32.0,
                                  width: 32.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: 16.toDouble().borderAll()),
                                  child: e.center(),
                                ).center().paddingOnly(right: 6.0))
                            .toList()
                          ..add(HSpace(10.0)),
                        centerTitle: centerTitle,
                        elevation: 0,
                        title: title ??
                            Text(
                              (titleText ?? "").toUpperCase(),
                              style: const TextStyle(color: Colors.white)
                                  .bold
                                  .size(18),
                            ),
                        leading: leading ??
                            IconButton(
                                splashRadius: 24.0,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  if (canBack) {
                                    if (onBack != null) {
                                      onBack();
                                    } else {
                                      appRouter.pop();
                                    }
                                  }
                                },
                                icon: Icon(
                                  Platform.isAndroid
                                      ? Icons.arrow_back_rounded
                                      : Icons.arrow_back_ios_new_rounded,
                                  size: 24.0,
                                  color: Colors.white,
                                )).visibility(canBack)),
            floatingActionButton: fab,
            bottomNavigationBar: bottomView,
            body: body != null
                ? AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.dark,
                    child: onRefresh == null
                        ? body
                        : body.onRefresh(() {
                            onRefresh.call();
                          }))
                : null);
}

extension UnFocusable on Widget {
  Widget unFocusable() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: this,
      );
    });
  }
}
