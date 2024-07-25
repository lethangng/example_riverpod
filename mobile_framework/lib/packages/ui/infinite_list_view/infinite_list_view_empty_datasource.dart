import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/ui/infinite_list_view/infinite_list_view_controller.dart';

abstract class InfiniteListViewEmptyDataSource {
  bool infiniteListViewEmptyDataShouldShowEmptyView(
      InfiniteListViewController controller);

  Widget? infiniteListViewEmptyDataCustomEmptyView() {
    return null;
  }

  Widget? infiniteListViewEmptyDataTitleForEmptyView() {
    return null;
  }

  Widget? infiniteListViewEmptyDescriptionForEmptyView() {
    return null;
  }

  Widget? infiniteListViewEmptyImageForEmptyView() {
    return null;
  }

  Widget? infiniteListViewEmptyButtonForEmptyView() {
    return null;
  }
}

class InfiniteListViewEmptyDataSourceBuilder
    extends InfiniteListViewEmptyDataSource {
  final Widget? Function()? customEmptyViewBuilder;
  final Widget? Function()? titleForEmptyViewBuilder;
  final Widget? Function()? descriptionForEmptyViewBuilder;
  final Widget? Function()? imageForEmptyViewBuilder;
  final Widget? Function()? buttonForEmptyViewBuilder;

  final bool Function(InfiniteListViewController controller)?
      shouldShowEmptyViewCallback;

  @override
  bool infiniteListViewEmptyDataShouldShowEmptyView(
      InfiniteListViewController controller) {
    return shouldShowEmptyViewCallback?.call(controller) ??
        (controller.items.isEmpty && !controller.isRefreshing);
  }

  @override
  Widget? infiniteListViewEmptyDataCustomEmptyView() {
    // TODO: implement customEmptyView
    return customEmptyViewBuilder?.call();
  }

  @override
  Widget? infiniteListViewEmptyDataTitleForEmptyView() {
    return titleForEmptyViewBuilder?.call();
  }

  @override
  Widget? infiniteListViewEmptyDescriptionForEmptyView() {
    return descriptionForEmptyViewBuilder?.call();
  }

  @override
  Widget? infiniteListViewEmptyImageForEmptyView() {
    return imageForEmptyViewBuilder?.call();
  }

  @override
  Widget? infiniteListViewEmptyButtonForEmptyView() {
    return buttonForEmptyViewBuilder?.call();
  }

  InfiniteListViewEmptyDataSourceBuilder({
    this.customEmptyViewBuilder,
    this.titleForEmptyViewBuilder,
    this.descriptionForEmptyViewBuilder,
    this.imageForEmptyViewBuilder,
    this.buttonForEmptyViewBuilder,
    this.shouldShowEmptyViewCallback,
  });
}
