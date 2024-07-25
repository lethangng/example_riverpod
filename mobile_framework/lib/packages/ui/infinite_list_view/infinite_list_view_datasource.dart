import 'dart:io';

import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:mobile_framework/packages/ui/infinite_list_view/infinite_list_view_controller.dart';
import 'package:mobile_framework/packages/ui/infinite_list_view/platform_indicator/ios_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class InfiniteListViewDataSource {
  bool infiniteListViewCanRefresh(InfiniteListViewController controller);

  bool infiniteListViewCanLoadMore(InfiniteListViewController controller);

  Widget infiniteListViewWidgetForItemAt(int index, {Key? key});

  Widget infiniteListViewSeparatorForItemAt(int index);

  Widget infiniteListViewCenterRefreshIndicator();

  SliverGridDelegate? infiniteListViewGridViewDelegate() => null;

  EdgeInsets infiniteListViewPadding() =>
      const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 12);

  void infiniteListViewHeightDidChanged(double newHeight) {}

  RefreshIndicator infiniteListViewRefreshIndicator() {
    if (Platform.isIOS) {
      return const IOSRefreshIndicator();
    } else {
      return const MaterialClassicHeader();
    }
  }

  LoadIndicator? infiniteListViewLoadMoreIndicator() => null;

  bool shouldShrinkWrap() => false;
  bool infiniteListViewShouldScroll() => true;
}

class InfiniteListViewDataSourceBuilder extends InfiniteListViewDataSource {
  final bool Function(InfiniteListViewController controller)? canRefreshBuilder;
  final bool Function(InfiniteListViewController controller)?
  canLoadMoreBuilder;
  final Widget Function(int index, {Key? key})? widgetForItemAtBuilder;
  final Widget Function(int index)? separatorForItemAtBuilder;
  final Widget Function()? centerRefreshIndicatorBuilder;
  final EdgeInsets? Function()? paddingBuilder;
  final RefreshIndicator Function()? refreshIndicatorBuilder;
  final LoadIndicator? Function()? loadMoreIndicatorBuilder;
  final SliverGridDelegate? Function()? gridViewDelegateBuilder;
  final void Function(double newHeight)? heightDidChangedBuilder;
  final bool Function()? shouldShrinkWrapBuilder;
  final bool Function()? shouldScrollBuilder;

  @override
  bool infiniteListViewCanRefresh(InfiniteListViewController controller) {
    return canRefreshBuilder?.call(controller) ?? true;
  }

  @override
  bool infiniteListViewCanLoadMore(InfiniteListViewController controller) {
    return canLoadMoreBuilder?.call(controller) ?? true;
  }

  @override
  Widget infiniteListViewWidgetForItemAt(int index, {Key? key}) {
    return widgetForItemAtBuilder?.call(index, key: key) ?? Container();
  }

  @override
  Widget infiniteListViewSeparatorForItemAt(int index) {
    return separatorForItemAtBuilder?.call(index) ?? Container();
  }

  @override
  Widget infiniteListViewCenterRefreshIndicator() {
    return centerRefreshIndicatorBuilder?.call() ?? Container();
  }

  @override
  SliverGridDelegate? infiniteListViewGridViewDelegate() {
    return gridViewDelegateBuilder?.call();
  }

  @override
  EdgeInsets infiniteListViewPadding() {
    return paddingBuilder?.call() ?? super.infiniteListViewPadding();
  }

  @override
  void infiniteListViewHeightDidChanged(double newHeight) {
    heightDidChangedBuilder?.call(newHeight);
  }

  @override
  RefreshIndicator infiniteListViewRefreshIndicator() {
    return refreshIndicatorBuilder?.call() ??
        super.infiniteListViewRefreshIndicator();
  }

  @override
  LoadIndicator? infiniteListViewLoadMoreIndicator() {
    return loadMoreIndicatorBuilder?.call();
  }

  @override
  bool shouldShrinkWrap() {
    return shouldShrinkWrapBuilder?.call() ?? false;
  }

  @override
  bool infiniteListViewShouldScroll() => shouldScrollBuilder?.call() ?? false;

  InfiniteListViewDataSourceBuilder(
      {this.canRefreshBuilder,
        this.canLoadMoreBuilder,
        this.widgetForItemAtBuilder,
        this.separatorForItemAtBuilder,
        this.centerRefreshIndicatorBuilder,
        this.gridViewDelegateBuilder,
        this.paddingBuilder,
        this.heightDidChangedBuilder,
        this.refreshIndicatorBuilder,
        this.loadMoreIndicatorBuilder,
        this.shouldShrinkWrapBuilder,
        this.shouldScrollBuilder});
}

mixin ReorderableDelegate<T> {
  void onConfirmReorder(List<T> items, int fromIndex, toIndex) {}

  void onReorderStart(int startIndex) {}

  void onDragStart() {}

  void onDragEnd() {}

  void onNoReorder(int index) {}
}
