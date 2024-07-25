// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/infinite_list_view/animated_infinite_item_view_manager.dart';

typedef TableView<T> = InfiniteTableView<T, Metadata>;

class TableViewItem<T> {
  T item;
  int index;
  Key? key;

  TableViewItem({
    required this.item,
    required this.index,
    this.key,
  });
}

class TableViewController {
  bool _isInit = false;
  bool _isRefreshing = false;

  late void Function() _onReloadListView;
  late void Function() _onRefresh;
  late void Function(
          int index, Future<void> Function(bool)? deleteAnimationHandler)
      _onBindDeleteItemAt;
  late void Function()? beforeRefresh;
  late void Function()? afterRefresh;

  late void Function()? beforeLoadMore;
  late void Function()? afterLoadMore;

  TableViewController(
      {this.beforeRefresh,
      this.afterRefresh,
      this.beforeLoadMore,
      this.afterLoadMore});

  void refresh({bool onlyRebuild = false}) {
    if (!_isInit) return;

    if (_isRefreshing) return;

    if (onlyRebuild) {
      _onReloadListView();
    } else {
      _onRefresh();
    }
  }

  void deleteAt(int index,
      {Future<void> Function(bool)? deleteAnimationHandler}) {
    if (!_isInit) return;
    _onBindDeleteItemAt(index, deleteAnimationHandler);
  }

  bool isRefreshing() {
    return _isRefreshing;
  }
}

/// an extended version of ListView
/// [InfiniteTableView] can refresh and loadmore itself with its internal controller
class InfiniteTableView<T, TableViewMetadata extends Metadata>
    extends ConsumerStatefulWidget {
  final Widget Function(int index)? separatorBuilder;
  final Widget Function(T item)? itemBuilder;
  final Widget Function(T item, int index)? itemIndexBuilder;
  final Widget Function(TableViewItem<T> tableViewItem)? tableViewItemBuilder;
  final Future<List<T>> Function(int page) onLoadItems;
  final bool enableRefresh;
  final bool enableLoadMore;
  final InfiniteListViewDataSource? dataSource;
  final InfiniteListViewEmptyDataSource? emptyDataSource;
  final SliverGridDelegate? gridViewDelegate;
  final EdgeInsets? padding;
  final MetadataUpdater<TableViewMetadata>? metadataUpdater;
  final bool shrinkWrap;
  final TableViewController controller;
  final Axis? axis;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final ScrollController? scrollController;
  final bool initialRefresh;
  final double? maxHeight;
  final bool shouldFollowTotalItemsHeight;
  final Function(double newHeight)? onHeightChanged;

  // ignore: use_key_in_widget_constructors
  InfiniteTableView({
    Key? key,
    required this.onLoadItems,
    @Deprecated("Use tableViewItemBuilder instead") this.itemBuilder,
    @Deprecated("Use tableViewItemBuilder instead") this.itemIndexBuilder,
    this.tableViewItemBuilder,
    this.separatorBuilder,
    this.enableLoadMore = true,
    this.enableRefresh = true,
    this.dataSource,
    this.emptyDataSource,
    this.gridViewDelegate,
    this.padding,
    this.metadataUpdater,
    this.shrinkWrap = false,
    this.axis,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    TableViewController? controller,
    this.scrollController,
    this.initialRefresh = true,
    this.maxHeight,
    this.shouldFollowTotalItemsHeight = false,
    this.onHeightChanged,
  }) : controller = controller ?? TableViewController();

  @override
  ConsumerState<InfiniteTableView<T, TableViewMetadata>> createState() =>
      _InfiniteTableViewState<T, TableViewMetadata>();
}

class _InfiniteTableViewState<T, TableViewMetadata extends Metadata>
    extends ConsumerState<InfiniteTableView<T, TableViewMetadata>> {
  late final AutoDisposeAsyncNotifierProvider<InfiniteListViewController<T>,
          InfiniteListViewControllerState<T>> provider =
      AsyncNotifierProvider.autoDispose(
          () => _InternalTableViewController<T, TableViewMetadata>(
              onLoadItems: widget.onLoadItems,
              enableLoadMore: widget.enableLoadMore,
              enableRefresh: widget.enableRefresh,
              controller: widget.controller,
              metadataUpdater: widget.metadataUpdater,
              initialRefresh: widget.initialRefresh),
          name: "internalTableViewControllerProvider<$T>");
  double height = 0;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(provider.notifier)
        as _InternalTableViewController<T, TableViewMetadata>;

    final tableViewConfig = InfiniteListViewConfig.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight:
              widget.shouldFollowTotalItemsHeight ? height : double.infinity),
      child: InfiniteListView(
          axis: widget.axis,
          keyboardDismissBehavior: widget.keyboardDismissBehavior,
          scrollController: widget.scrollController,
          dataSource: widget.dataSource ??
              InfiniteListViewDataSourceBuilder(
                shouldShrinkWrapBuilder: () => widget.shrinkWrap,
                shouldScrollBuilder: () => true,
                canRefreshBuilder: (controller) {
                  var c = controller
                      as _InternalTableViewController<T, TableViewMetadata>;
                  return c.enableRefresh;
                },
                canLoadMoreBuilder: (controller) {
                  var c = controller
                      as _InternalTableViewController<T, TableViewMetadata>;
                  return c.shouldEnableLoadMore;
                },
                heightDidChangedBuilder: (newHeight) {
                  if (widget.maxHeight != null &&
                      newHeight > widget.maxHeight!) {
                    height = widget.maxHeight!;
                  } else {
                    height = newHeight;
                  }
                  widget.onHeightChanged?.call(height);
                  if (mounted) {
                    setState(() {});
                  }
                },
                widgetForItemAtBuilder: (index, {key}) {
                  var item = controller.items[index];

                  if (widget.tableViewItemBuilder != null) {
                    return widget.tableViewItemBuilder!(
                        TableViewItem(item: item, index: index, key: key));
                  }

                  assert(
                      widget.itemIndexBuilder != null ||
                          widget.itemBuilder != null,
                      "indexItemBuilder or itemBuilder must be not null");

                  return widget.itemIndexBuilder?.call(item, index) ??
                      widget.itemBuilder!.call(item);
                },
                separatorForItemAtBuilder: widget.separatorBuilder,
                centerRefreshIndicatorBuilder: () {
                  return ref.theme.tableViewCenterIndicator.center();
                },
                loadMoreIndicatorBuilder: () {
                  return CustomFooter(builder: (context, mode) {
                    if (mode == LoadStatus.idle ||
                        mode == LoadStatus.noMore ||
                        mode == LoadStatus.failed) {
                      return const SizedBox.shrink();
                    } else {
                      return Center(
                        child: ref.theme.tableViewLoadIndicator
                            .center()
                            .paddingOnly(top: 8.0),
                      );
                    }
                  });
                },
                gridViewDelegateBuilder: () {
                  return widget.gridViewDelegate;
                },
                paddingBuilder: () => widget.padding,
              ),
          emptyDataSource:
              tableViewConfig?.emptyPlaceholder ?? widget.emptyDataSource,
          provider: provider),
    );
  }
}

class _InternalTableViewController<T, TableViewMetadata extends Metadata>
    extends InfiniteListViewController<T> with AnimatedInfiniteItemsMixin<T> {
  final Future<List<T>> Function(int page) onLoadItems;
  final bool enableRefresh;
  final bool enableLoadMore;
  final TableViewController controller;
  final MetadataUpdater<TableViewMetadata>? metadataUpdater;

  TableViewMetadata? metadata;

  bool get shouldEnableLoadMore {
    return enableLoadMore && !isRefreshing && (metadata?.canLoadMore ?? false);
  }

  _InternalTableViewController({
    required this.onLoadItems,
    required this.enableLoadMore,
    required this.enableRefresh,
    required this.controller,
    this.metadataUpdater,
    super.initialRefresh = true,
  });

  @override
  FutureOr<InfiniteListViewControllerState<T>> build() {
    controller._isInit = true;

    controller._onReloadListView = () {
      state = AsyncData(InfiniteListViewControllerState.change(items: items));
    };

    controller._onRefresh = () {
      onRefresh();
    };

    controller._onBindDeleteItemAt = (index, handler) async {
      var oldItems = List.from(items);
      state = AsyncData(InfiniteListViewControllerState.change(
          items: oldItems.removeAt(index)));
      await handler?.call(true);
    };

    metadataUpdater?.onUpdateMetadata = (metadata) {
      this.metadata = metadata;
    };

    return super.build();
  }

  @override
  Future<List<T>> getData() async {
    return await onLoadItems(currentPage);
  }

  @override
  Future onRefresh() async {
    super.onRefresh();
    controller.beforeRefresh?.call();
    controller._isRefreshing = true;
    state = AsyncValue<InfiniteListViewControllerState<T>>.loading();

    state = await AsyncValue.guard(() async {
      var items = await getData();
      addFreshAnimationItems(items);
      return InfiniteListViewControllerState(
          items: items, isRefreshing: false, isLoadMore: false);
    });
    controller._isRefreshing = false;
    controller.afterRefresh?.call();

    // endRefresh();
  }

  @override
  void onLoading() async {
    super.onLoading();
    controller.beforeLoadMore?.call();
    currentPage += 1;

    state = await AsyncValue.guard(() async {
      var items = await getData();
      addAnimationItems(items);
      return InfiniteListViewControllerState.more(
          currentItems: this.items, newItems: items);
    });

    refreshController.loadComplete();
    controller.afterLoadMore?.call();
  }
}
