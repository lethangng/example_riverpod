// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/core/base/app_module.dart';

@Deprecated("Use BottomNavigationBar instead")
class BottomTabBar extends CupertinoTabBar {
  final List<PageModule> pageModules;

  BottomTabBar({
    super.key,
    required this.pageModules,
    required super.inactiveColor,
    required Color super.activeColor,
    super.currentIndex,
    super.border = null,
    Function(int selectedIndex)? onSelectItem,
  }) : super(
          items: pageModules.map((e) => e.item).toList(),
          backgroundColor: Colors.white,
          iconSize: 36.0,
          onTap: onSelectItem,
        );
}
