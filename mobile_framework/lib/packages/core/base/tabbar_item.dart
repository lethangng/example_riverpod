// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/ui/exts/widget_exts.dart';

class TabBarItem extends BottomNavigationBarItem {
  final String title;
  final Widget unselectedIcon;
  final Widget? selectedIcon;

  final double? itemHeight;
  final double? itemWidth;

  final bool Function()? canShowBadgeWhenDeselect;
  final bool Function()? canShowBadgeWhenSelect;
  final int Function()? badgeCount;
  final Function(void Function(void Function()) setState)? updateBadge;

  TabBarItem(
      {Key? key,
      required this.title,
      required this.unselectedIcon,
      required this.selectedIcon,
      this.itemHeight,
      this.itemWidth,
      this.canShowBadgeWhenDeselect,
      this.canShowBadgeWhenSelect,
      super.backgroundColor,
      this.badgeCount,
      this.updateBadge})
      : super(
          label: title,
          icon: StatefulBuilder(
            builder: ((context, setState) {
              updateBadge?.call(setState);
              return Badge(
                label: Text(
                  "${(badgeCount?.call() ?? 0) > 99 ? "99+" : badgeCount?.call()}",
                ),
                backgroundColor: Colors.red,
                isLabelVisible: canShowBadgeWhenDeselect?.call() ?? false,
                largeSize: 17,
                padding: const EdgeInsets.only(left: 5, right: 5),
                alignment: const AlignmentDirectional(4, 0),
                textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                child: unselectedIcon.paddingOnly(top: 6),
              );
            }),
          ).center(),
          activeIcon: StatefulBuilder(
            builder: ((context, setState) {
              updateBadge?.call(setState);
              return Badge(
                label: Text(
                  "${(badgeCount?.call() ?? 0) > 99 ? "99+" : badgeCount?.call()}",
                ),
                backgroundColor: Colors.red,
                isLabelVisible: canShowBadgeWhenSelect?.call() ?? false,
                largeSize: 17,
                padding: const EdgeInsets.only(left: 5, right: 5),
                alignment: const AlignmentDirectional(4, 0),
                textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                child: (selectedIcon ?? unselectedIcon).paddingOnly(top: 6),
              );
            }),
          ).center(),
        );
}
