import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/infinite_list_view/animated_infinite_item_view_manager.dart';

enum InfiniteListContentViewType {
  refreshView,
  gridView,
  responsiveGridView,
  listView,
  emptyView,
}

// ignore: must_be_immutable
class InfiniteListView<ItemType> extends ConsumerStatefulWidget {
  final InfiniteListViewDataSource dataSource;
  final InfiniteListViewEmptyDataSource? emptyDataSource;
  final AutoDisposeAsyncNotifierProvider<InfiniteListViewController<ItemType>,
      InfiniteListViewControllerState<ItemType>> provider;
  double? emptyDataHeight;
  Axis? axis;
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final ScrollController? scrollController;

  bool get inferredEmptyDataViewHeight {
    return emptyDataHeight == null;
  }

  InfiniteListView({
    super.key,
    required this.dataSource,
    required this.provider,
    this.emptyDataSource,
    this.emptyDataHeight,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.axis,
    this.scrollController,
  });

  @override
  ConsumerState<InfiniteListView<ItemType>> createState() =>
      _InfiniteListViewState<ItemType>();
}

class _InfiniteListViewState<ItemType>
    extends ConsumerState<InfiniteListView<ItemType>>
    with SingleTickerProviderStateMixin {
  final GlobalKey listViewKey = GlobalKey();
  ScrollController? scrollController;
  final Map<int, GlobalKey> itemKeys = {};

  double emptyDataViewMaxHeight = 0;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _getListViewHeightWhenNoData() {
    if (widget.inferredEmptyDataViewHeight) {
      emptyDataViewMaxHeight = listViewKey.currentContext?.size?.height ?? 0;
      return;
    }

    emptyDataViewMaxHeight = widget.emptyDataHeight!;
  }

  @override
  Widget build(BuildContext context) {
    var shouldShowLoading = ref.watch(widget.provider
        .select((controller) => controller.value?.shouldShowLoading ?? true));

    var refreshController = ref.watch(
        widget.provider.notifier.select((value) => value.refreshController));

    var items = ref.watch(
        widget.provider.select((controller) => controller.value?.items ?? []));

    var controller = ref.watch(widget.provider.notifier);

    var shouldShowEmptyView = widget.emptyDataSource
            ?.infiniteListViewEmptyDataShouldShowEmptyView(controller) ??
        false;

    var shouldShowCustomEmptyView =
        widget.emptyDataSource?.infiniteListViewEmptyDataCustomEmptyView() !=
            null;

    var animatedInfiniteItemsController =
        controller.animatedInfiniteItemsController;

    ref.listen(widget.provider, (previous, next) {
      if (previous == next) return;

      if (!mounted) {
        return;
      }

      notifyListViewHeightChanged();
    });

    InfiniteListContentViewType contentViewType;

    if (shouldShowLoading) {
      contentViewType = InfiniteListContentViewType.refreshView;
    } else if (shouldShowEmptyView) {
      contentViewType = InfiniteListContentViewType.emptyView;
    } else if (widget.dataSource.infiniteListViewGridViewDelegate() != null) {
      var delegate = widget.dataSource.infiniteListViewGridViewDelegate();

      contentViewType = delegate is ResponsiveGridDelegate
          ? InfiniteListContentViewType.responsiveGridView
          : InfiniteListContentViewType.gridView;
    } else {
      contentViewType = InfiniteListContentViewType.listView;
    }

    var finalScrollController =
        scrollController ?? PrimaryScrollController.maybeOf(context);
    var physics = widget.dataSource.infiniteListViewShouldScroll()
        ? const BouncingScrollPhysics()
        : const NeverScrollableScrollPhysics();

    return SmartRefresher(
        key: listViewKey,
        scrollController: finalScrollController,
        controller: refreshController,
        onRefresh: () => controller.onRefresh(),
        onLoading: () => controller.onLoading(),
        enablePullDown:
            widget.dataSource.infiniteListViewCanRefresh(controller),
        enablePullUp: widget.dataSource.infiniteListViewCanLoadMore(controller),
        header: widget.dataSource.infiniteListViewRefreshIndicator(),
        footer: widget.dataSource.infiniteListViewLoadMoreIndicator(),
        child: switch (contentViewType) {
          InfiniteListContentViewType.refreshView => SizedBox(
              height: widget.emptyDataHeight == null ? null : 150,
              child: Center(
                child:
                    widget.dataSource.infiniteListViewCenterRefreshIndicator(),
              ),
            )
                .animate()
                .fadeIn(duration: 0.25.seconds, curve: Curves.fastOutSlowIn),
          InfiniteListContentViewType.gridView => GridView.builder(
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              scrollDirection: widget.axis ?? Axis.vertical,
              physics: physics,
              shrinkWrap: widget.dataSource.shouldShrinkWrap(),
              cacheExtent: 100,
              itemBuilder: (_, index) {
                return animatedItemBuilder(
                    animatedInfiniteItemsController, index);
              },
              itemCount: items.length,
              gridDelegate:
                  widget.dataSource.infiniteListViewGridViewDelegate()!,
              controller: finalScrollController,
              padding: widget.dataSource.infiniteListViewPadding(),
            ),
          InfiniteListContentViewType.responsiveGridView =>
            ResponsiveGridView.builder(
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              scrollDirection: widget.axis ?? Axis.vertical,
              physics: physics,
              shrinkWrap: widget.dataSource.shouldShrinkWrap(),
              cacheExtent: 100,
              itemBuilder: (_, index) {
                return animatedItemBuilder(
                    animatedInfiniteItemsController, index);
              },
              itemCount: items.length,
              gridDelegate:
                  widget.dataSource.infiniteListViewGridViewDelegate()!
                      as ResponsiveGridDelegate,
              controller: finalScrollController,
              padding: widget.dataSource.infiniteListViewPadding(),
            ),
          InfiniteListContentViewType.listView => ListView.separated(
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              scrollDirection: widget.axis ?? Axis.vertical,
              physics: physics,
              shrinkWrap: widget.dataSource.shouldShrinkWrap(),
              controller: finalScrollController,
              padding: widget.dataSource.infiniteListViewPadding().add(
                  EdgeInsets.only(bottom: context.mediaQuery.padding.bottom)),
              itemBuilder: (_, index) {
                return animatedItemBuilder(
                    animatedInfiniteItemsController, index);
              },
              itemCount: items.length,
              separatorBuilder: (_, index) {
                return widget.dataSource
                    .infiniteListViewSeparatorForItemAt(index);
              },
            ),
          InfiniteListContentViewType.emptyView => SingleChildScrollView(
              scrollDirection: widget.axis ?? Axis.vertical,
              keyboardDismissBehavior: widget.keyboardDismissBehavior,
              child: Center(
                      child: SizedBox(
                height: emptyDataViewMaxHeight,
                child: shouldShowCustomEmptyView
                    ? widget.emptyDataSource
                        ?.infiniteListViewEmptyDataCustomEmptyView()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.emptyDataSource
                                  ?.infiniteListViewEmptyImageForEmptyView() ??
                              Container(),
                          widget.emptyDataSource
                                  ?.infiniteListViewEmptyDataTitleForEmptyView() ??
                              Container(),
                          widget.emptyDataSource
                                  ?.infiniteListViewEmptyDescriptionForEmptyView() ??
                              Container(),
                          widget.emptyDataSource
                                  ?.infiniteListViewEmptyButtonForEmptyView() ??
                              Container(),
                        ],
                      ),
              ))
                  .animate()
                  .fadeIn(duration: 0.25.seconds, curve: Curves.fastOutSlowIn),
            )
        });
  }

  Widget animatedItemBuilder(
      AnimatedInfiniteItemsController animatedInfiniteItemsController,
      int index) {
    // var isAnimated = animatedInfiniteItemsController.isItemAnimatedAt(index);

    var itemView = widget.dataSource.infiniteListViewWidgetForItemAt(index,
        key: _createUniqueKeyForItemAt(index));

    return itemView.animate(
        onComplete: (controller) {
          animatedInfiniteItemsController.markAsAnimated(index);
        },
        delay: 50.milliseconds,
        effects: [
          FadeEffect(
            begin: 0,
            end: 1.0,
            curve: Curves.fastOutSlowIn,
            duration: 250.milliseconds,
          ),
        ]);
  }

  void notifyListViewHeightChanged() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getListViewHeightWhenNoData();
      widget.dataSource
          .infiniteListViewHeightDidChanged(_getTotalHeightOfItems());

      if (mounted) {
        setState(() {});
      }
    });
  }

  GlobalKey _createUniqueKeyForItemAt(int index) {
    itemKeys[index] ??= GlobalKey();
    return itemKeys[index]!;
  }

  double _getTotalHeightOfItems() {
    var totalValue = 0.0;
    for (var key in itemKeys.values) {
      totalValue += key.currentContext?.size?.height ?? 0;
    }

    return totalValue;
  }
}
