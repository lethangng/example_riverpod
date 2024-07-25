import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  final List<AutoRoutePageModule> modules;
  final double sideBarWidth;
  final Widget Function(
          List<AutoRoutePageModule> modules, PageController pageController)?
      sideNavigationBuilder;
  final Widget Function(
          List<AutoRoutePageModule> modules, TabsRouter tabsRouter)?
      bottomNavigationBuilder;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonBuilder? floatingActionButtonBuilder;

  @override
  ConsumerState<MainPage> createState() => _MainPageState();

  const MainPage(
      {super.key,
      required this.modules,
      this.sideBarWidth = 110,
      this.sideNavigationBuilder,
      this.bottomNavigationBuilder,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonBuilder});
}

class _MainPageState extends ConsumerState<MainPage>
    with
        RegisterUpdateUnreadNotificationMixin,
        RegisterMarkUnreadAsReadNotificationMixin {
  late final StreamSubscription _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  final connectivityProvider = StateProvider<bool>((ref) => true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationCenter().addObserver<RegisterNotificationDeviceTokenRequest>(
      registerDeviceTokenNotificationName,
      callback: (request) {
        ref.read(registerDeviceTokenUCProvider)(params: request);
      },
    );

    if (get.isRegistered<NotificationService>()) {
      get<NotificationService>().getDeviceToken();
    }

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.none)) {
        ref.read(connectivityProvider.notifier).state = false;
      } else {
        ref.read(connectivityProvider.notifier).state = true;
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      return AutoTabsRouter.pageView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        routes: widget.modules.map((e) => e.firstRoute).toList(),
        builder: (context, child, pageController) {
          return Row(
            children: [
              widget.sideNavigationBuilder == null
                  ? NavigationRail(
                      minWidth: widget.sideBarWidth,
                      selectedIndex: !pageController.positions.isNotEmpty
                          ? 0
                          : pageController.page!.toInt(),
                      onDestinationSelected: (index) {
                        pageController.jumpToPage(index);
                      },
                      destinations: widget.modules
                          .map((e) => NavigationRailDestination(
                              icon: e.item.activeIcon,
                              label: Text(e.item.label ?? "")))
                          .toList(),
                    )
                  : widget.sideNavigationBuilder!(
                      widget.modules, pageController),
              Expanded(child: child)
            ],
          );
        },
      );
    }

    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          AutoTabsScaffold(
            lazyLoad: false,
            routes: widget.modules.map((e) => e.firstRoute).toList(),
            transitionBuilder: (context, child, animation) {
              return child;
            },
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButtonBuilder: widget.floatingActionButtonBuilder,
            floatingActionButton: widget.floatingActionButton,
            bottomNavigationBuilder: (context, tabsRouter) {
              return widget.bottomNavigationBuilder == null
                  ? Theme(
                      data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.white,
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: ref.theme.activeTabBarItemColor,
                        unselectedItemColor: ref.theme.inactiveTabBarItemColor,
                        selectedLabelStyle: ref.theme.mediumTextStyle
                            .textColor(ref.theme.activeTabBarItemColor),
                        unselectedLabelStyle: ref.theme.mediumTextStyle
                            .textColor(ref.theme.inactiveTabBarItemColor),
                        currentIndex: tabsRouter.activeIndex,
                        items: widget.modules.map((e) => e.item).toList(),
                        onTap: (index) {
                          tabsRouter.setActiveIndex(index);
                        },
                      ),
                    )
                  : widget.bottomNavigationBuilder!(widget.modules, tabsRouter);
            },
          ).expand(),
          Consumer(
            builder: (context, provider, child) {
              var state = provider.watch(connectivityProvider);
              return Material(
                color: Colors.transparent,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.bottomCenter,
                  curve: Curves.easeInOut,
                  child: Container(
                      color: Colors.yellow.shade600,
                      height: state ? 0 : context.includeBottomPadding(10),
                      child: Text(
                        "Vui lòng kiểm tra lại kết nối",
                        style: provider.theme.smallTextStyle.semiBold
                            .size(10)
                            .textColor(Colors.black),
                      ).center().paddingOnly(bottom: 4)),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
