// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

final badgeNumberProvider = StateProvider<int?>((ref) => null);

class RefTabBarItem extends BottomNavigationBarItem {
  final String title;
  final Widget unselectedIcon;
  final Widget selectedIcon;
  final Widget Function(
          String unreadCountText, bool shouldShowBadge, Widget icon)
      selectedBadgeBuilder;
  final Widget Function(
          String unreadCountText, bool shouldShowBadge, Widget icon)
      unselectedBadgeBuilder;

  RefTabBarItem({
    Key? key,
    required this.title,
    required this.unselectedIcon,
    required this.selectedIcon,
    super.backgroundColor,
    required this.selectedBadgeBuilder,
    required this.unselectedBadgeBuilder,
  }) : super(
            label: title,
            icon: Consumer(builder: (context, ref, child) {
              final unreadCount = ref.watch(unreadNotificationNumberProvider);
              return unreadCount.maybeWhen(
                orElse: () {
                  return unselectedIcon.paddingOnly(top: 6);
                },
                data: (data) {
                  return unselectedBadgeBuilder("${(data) > 99 ? "99+" : data}",
                      data > 0, unselectedIcon);
                },
              );
            }),
            activeIcon: Consumer(builder: (context, ref, child) {
              final unreadCount = ref.watch(unreadNotificationNumberProvider);
              return unreadCount.maybeWhen(
                orElse: () {
                  return selectedIcon.paddingOnly(top: 6);
                },
                data: (data) {
                  return selectedBadgeBuilder(
                      "${(data) > 99 ? "99+" : data}", data > 0, selectedIcon);
                },
              );
            }));
}
