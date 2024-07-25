import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/gen/assets.gen.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/infinite_list_view/animated_infinite_item_view_manager.dart';

typedef ItemPickerTitleBuilder = Widget Function();
typedef ItemPickerBuilder<T> = Widget Function(T item, int index, Key? key);
typedef ItemPickerItemAllBuilder<T> = Widget Function();
typedef ItemPickerSeparatorBuilder = Widget Function(int);
typedef ItemPickerLoadMoreIndicatorBuilder = LoadIndicator Function();
typedef ItemPickerCenterIndicatorBuilder = Widget Function();
typedef ItemPickerBottomViewBuilder = Widget Function();

class InfiniteItemsPickerView<T> extends ConsumerStatefulWidget {
  final ItemPickerBuilder<T> itemPickerBuilder;
  final ItemPickerTitleBuilder? itemPickerTitleBuilder;
  final ItemPickerSeparatorBuilder? separatorBuilder;
  final ItemPickerLoadMoreIndicatorBuilder? loadMoreIndicatorBuilder;
  final ItemPickerCenterIndicatorBuilder? centerIndicatorBuilder;
  final ItemPickerBottomViewBuilder? bottomViewBuilder;
  final ItemPickerItemAllBuilder? itemAllBuilder;

  final Widget? itemPickerCustomEmptyView;
  final bool includeAllOption;
  final bool shouldEnableSearch;
  final AutoDisposeAsyncNotifierProvider<ItemsPickerController<T>,
      InfiniteListViewControllerState<T>> provider;
  final List<Widget> topPluginViews;
  final List<Widget> bottomPluginViews;
  final ScrollController? scrollController;

  const InfiniteItemsPickerView(this.itemPickerBuilder,
      {super.key,
      this.itemAllBuilder,
      this.itemPickerTitleBuilder,
      this.separatorBuilder,
      this.loadMoreIndicatorBuilder,
      this.centerIndicatorBuilder,
      this.bottomViewBuilder,
      this.itemPickerCustomEmptyView,
      this.includeAllOption = false,
      this.shouldEnableSearch = true,
      this.topPluginViews = const [],
      this.bottomPluginViews = const [],
      this.scrollController,
      required this.provider});

  @override
  ConsumerState<InfiniteItemsPickerView<T>> createState() =>
      _DPItemsPickerViewState<T>();
}

class _DPItemsPickerViewState<T>
    extends ConsumerState<InfiniteItemsPickerView<T>> {
  double currentListViewHeight = 150.0;
  final double defaultListViewHeight = 150.0;
  final double maxHeight = 550.0;
  var scrollController = ScrollController();
  var shouldShrinkWrap = true;

  @override
  void initState() {
    super.initState();

    scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(widget.provider.notifier);
    return Center(
        child: Container(
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(maxHeight: maxHeight),
      width:
          ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 550.0 : 290.0,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: 12.toDouble().borderAll()),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            VSpace(4.0),
            widget.itemPickerTitleBuilder?.call() ?? Container(),
            if (widget.shouldEnableSearch) VSpace.v8,
            SizedBox(
              height: 44.0,
              child: CupertinoTextField.borderless(
                cursorColor: Colors.black,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 10)
                    ],
                    color: Colors.white,
                    borderRadius: 10.toDouble().borderAll()),
                prefixMode: OverlayVisibilityMode.always,
                prefix: Assets.icons.icSearch
                    .svg(width: 24, height: 24, color: Colors.grey.shade600)
                    .paddingOnly(left: 8.0, top: 2.0),
                placeholder: "Nhập để tìm kiếm...",
                placeholderStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF3C3C43).withOpacity(0.6)),
                onChanged: (text) {
                  controller.filterBy(text);
                },
              ),
            )
                .visibility(widget.shouldEnableSearch)
                .defaultHorizontalPadding(value: 16.0),
            ...widget.topPluginViews,
            VSpace.v4,
            AnimatedSize(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                height: currentListViewHeight,
                child: InfiniteListView<T>(
                  provider: widget.provider,
                  emptyDataHeight: 100.0,
                  scrollController: scrollController,
                  dataSource: InfiniteListViewDataSourceBuilder(
                    shouldShrinkWrapBuilder: () {
                      return !(scrollController.isNotNull &&
                          scrollController.hasClients &&
                          scrollController.position.maxScrollExtent > 0);
                    },
                    shouldScrollBuilder: () {
                      return scrollController.isNotNull &&
                          scrollController.hasClients &&
                          scrollController.position.maxScrollExtent > 0;
                    },
                    canRefreshBuilder: (controller) {
                      return (controller as ItemsPickerController)
                          .enableRefresh;
                    },
                    canLoadMoreBuilder: (controller) {
                      return (controller as ItemsPickerController)
                          .enableLoadMore;
                    },
                    centerRefreshIndicatorBuilder:
                        widget.centerIndicatorBuilder,
                    loadMoreIndicatorBuilder: widget.loadMoreIndicatorBuilder,
                    heightDidChangedBuilder: (newHeight) {
                      if (ref.read(widget.provider.notifier).isRefreshing) {
                        currentListViewHeight = defaultListViewHeight;
                        setState(() {});
                        return;
                      }

                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        if (newHeight == 0) {
                          currentListViewHeight = defaultListViewHeight;
                        } else {
                          currentListViewHeight = newHeight;
                        }

                        setState(() {});
                      });
                    },
                    separatorForItemAtBuilder: widget.separatorBuilder,
                    widgetForItemAtBuilder: (index, {key}) {
                      if (controller.isItemAllPosition(index)) {
                        return widget.itemAllBuilder?.call() ?? Container();
                      }

                      return widget.itemPickerBuilder(
                          controller.itemAt(index), index, key);
                    },
                  ),
                  emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
                      shouldShowEmptyViewCallback: (controller) {
                    return controller.items.isEmpty && !controller.isRefreshing;
                  }, customEmptyViewBuilder: () {
                    return widget.itemPickerCustomEmptyView;
                  }),
                ),
              ),
            ).flexible(),
            VSpace.v12,
            ...widget.bottomPluginViews,
          ]),
    ));
  }
}

abstract class ItemsPickerController<T> extends InfiniteListViewController<T>
    with AnimatedInfiniteItemsMixin<T> {
  bool get enableLoadMore;

  bool get enableRefresh;

  bool get includeAllOption {
    return false;
  }

  void filterBy(String? text);

  int numberOfItems() {
    if (includeAllOption) {
      return items.length + 1;
    }

    return items.length;
  }

  T itemAt(int index) {
    if (includeAllOption) {
      return items[index - 1];
    }

    return items[index];
  }

  bool isItemAllPosition(int index) {
    if (index == 0 && includeAllOption) {
      return true;
    }

    return false;
  }
}
