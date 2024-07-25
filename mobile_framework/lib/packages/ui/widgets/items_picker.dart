import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/widgets/items_picker_view.dart';

// ignore: must_be_immutable
mixin ItemPickerCompatible on Equatable {
  String get title;

  bool isSelected = false;

  /// search by any text if they are provided in [searchableTexts]
  List<String> get searchableTexts => [title];
}

/// [SimpleItemPicker] is a simple implementation of [ItemPickerCompatible] with only [title] provided
/// Only use the [title] for comparing model
class SimplePickerItem extends Equatable with ItemPickerCompatible {
  final String _title;

  @override
  // TODO: implement props
  List<Object?> get props => [_title];

  @override
  // TODO: implement title
  String get title => _title;

  SimplePickerItem({
    required String title,
  }) : _title = title;
}

typedef ItemsPicker<T extends ItemPickerCompatible>
    = InfiniteItemsPicker<T, Metadata>;

/// An [InfiniteItemsPicker] with embedded controller for
/// any [T] conforms ItemPickerCompatible
class InfiniteItemsPicker<T extends ItemPickerCompatible,
    ItemPickerMetadata extends Metadata> extends ConsumerStatefulWidget {
  final String title;
  final T? selectedItem;
  final List<T>? selectedItems;
  final Future<List<T>> Function(int page)? onLoadItems;

  final bool isMultiSelection;
  final bool enableLoadMore;
  final bool enableRefresh;
  final bool includeOptionAll;
  final MetadataUpdater<ItemPickerMetadata>? metadataUpdater;

  /// only invoke in single selection mode
  final Function(List<T> allItems)? onSelectOptionAll;
  final Widget Function(int index, T item, Key? key)? itemBuilder;
  final Widget Function()? itemPickerTitleBuilder;
  final Function(List<T> items)? onConfirmSelectMultipleItems;
  final Function(T item)? onConfirmSelectSingleItem;

  final Widget? emptyDataView;
  final List<Widget> topPluginViews;
  final List<Widget> bottomPluginViews;
  final bool shouldShowSearchTextField;
  final ScrollController? scrollController;

  const InfiniteItemsPicker(
      {super.key,
      required this.title,
      required this.onLoadItems,
      this.isMultiSelection = false,
      this.selectedItem,
      this.selectedItems,
      this.enableRefresh = true,
      this.enableLoadMore = false,
      this.includeOptionAll = false,
      this.onSelectOptionAll,
      this.emptyDataView,
      this.itemBuilder,
      this.itemPickerTitleBuilder,
      this.onConfirmSelectMultipleItems,
      this.onConfirmSelectSingleItem,
      this.metadataUpdater,
      this.topPluginViews = const [],
      this.bottomPluginViews = const [],
      this.shouldShowSearchTextField = true,
      this.scrollController})
      : assert(selectedItem == null || selectedItems == null,
            "Only selectedItem or selectedItems should be provided");

  @override
  ConsumerState<InfiniteItemsPicker<T, Metadata>> createState() =>
      _ItemsPickerState<T, ItemPickerMetadata>();
}

class _ItemsPickerState<T extends ItemPickerCompatible,
        ItemPickerMetadata extends Metadata>
    extends ConsumerState<InfiniteItemsPicker<T, ItemPickerMetadata>>
    with GlobalThemePlugin {
  late AutoDisposeAsyncNotifierProvider<ItemsPickerController<T>,
          InfiniteListViewControllerState<T>> internalProvider =
      AsyncNotifierProvider.autoDispose(
          () => _InternalItemsPickerController<T, Metadata>(
              widget.onLoadItems!, widget.isMultiSelection,
              selectedItems: widget.selectedItem != null
                  ? [widget.selectedItem!]
                  : widget.selectedItems,
              canLoadMore: widget.enableLoadMore,
              canRefresh: widget.enableRefresh,
              shouldShowAllOption: widget.includeOptionAll,
              onSelectItemAll: widget.onSelectOptionAll,
              onConfirmSelectMultipleItems: widget.onConfirmSelectMultipleItems,
              onConfirmSelectSingleItem: widget.onConfirmSelectSingleItem,
              metadataUpdater: widget.metadataUpdater),
          name: "internalItemsPickerControllerProvider<$T>");

  @override
  Widget build(BuildContext context) {
    late var controller = ref.watch(internalProvider.notifier)
        as _InternalItemsPickerController<T, Metadata>;

    return InfiniteItemsPickerView<T>(
      provider: internalProvider,
      itemPickerCustomEmptyView: widget.emptyDataView,
      shouldEnableSearch: widget.shouldShowSearchTextField,
      scrollController: widget.scrollController,
      itemPickerTitleBuilder: () {
        return widget.itemPickerTitleBuilder?.call() ??
            SizedBox(
              height: 48,
              child: Material(
                color: Colors.white,
                child: Text(
                  widget.title.unwrap(),
                  style: conf.itemPickerTitleTextStyle,
                ).center(),
              ),
            );
      },
      topPluginViews: widget.topPluginViews,
      itemAllBuilder: () {
        return SizedBox(
          height: 52.0,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tất cả",
                style: conf.itemPickerItemAllTextStyle,
              ).flexible(),
              Icon(
                Icons.check,
                color: conf.iconCheckColor,
              ).visibility(controller.isItemAllSelected)
            ],
          )),
        ).onTapWidget(() {
          setState(() {});
          widget.onSelectOptionAll
              ?.call(controller.items.map((e) => e).toList());
          controller.onSelectAllItem();
        });
      },
      (item, index, Key? key) {
        return (widget.itemBuilder != null
                ? widget.itemBuilder!(index, item, key)
                : SizedBox(
                    key: key,
                    height: 52.0,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.title,
                          style: conf.itemPickerItemTextStyle,
                        ).flexible(),
                        Icon(
                          Icons.check,
                          color: conf.iconCheckColor,
                        ).visibility(item.isSelected)
                      ],
                    )),
                  ))
            .onTapWidget(() {
          setState(() {});
          controller.onSelectItem(item);
        });
      },
      separatorBuilder: (_) => LineSeparator(
          height: 0.7,
          color: Colors.grey.shade200,
          margin: const EdgeInsets.only()),
      loadMoreIndicatorBuilder: () {
        return CustomFooter(builder: (context, mode) {
          if (mode == LoadStatus.idle ||
              mode == LoadStatus.noMore ||
              mode == LoadStatus.failed) {
            return const SizedBox.shrink();
          } else {
            return Center(
              child: conf.tableViewLoadIndicator.center().paddingOnly(top: 8.0),
            );
          }
        });
      },
      centerIndicatorBuilder: () {
        return conf.tableViewCenterIndicator.paddingOnly(top: 20.0).center();
      },
      bottomPluginViews: [
        if (widget.isMultiSelection)
          Column(
            children: [
              LineSeparator(
                color: Colors.grey.shade200,
                margin: EdgeInsets.zero,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.popRoute();
                    },
                    child: Text(
                      "Thoát",
                      style: conf.itemPickerCancelTextStyle,
                    ).center(),
                  ).box(h: 44.0).expand(),
                  Container(
                      height: 44.0, color: Colors.grey.shade200, width: 1),
                  TextButton(
                    onPressed: () {
                      controller.onConfirm();
                    },
                    child: Text(
                      "Xác nhận",
                      style: conf.itemPickerConfirmTextStyle,
                    ).center(),
                  ).box(h: 44.0).expand(),
                ],
              )
            ],
          ),
        ...widget.bottomPluginViews
      ],
    );
  }
}

class _InternalItemsPickerController<T extends ItemPickerCompatible,
    ItemPickerMetadata extends Metadata> extends ItemsPickerController<T> {
  final Future<List<T>> Function(int page) onLoadItems;
  final bool isMultiSelection;
  final bool canLoadMore;
  final bool canRefresh;
  final Function(List<T> items)? onConfirmSelectMultipleItems;
  final Function(T item)? onConfirmSelectSingleItem;

  bool isSearching = false;
  bool isItemAllSelected = false;
  bool shouldShowAllOption = false;

  List<T> selectedItems = List.empty(growable: true);
  List<T> localItems = List.empty(growable: true);

  String? searchText;
  ItemPickerMetadata? metadata;

  Function(List<T> allItems)? onSelectItemAll;
  MetadataUpdater<ItemPickerMetadata>? metadataUpdater;

  _InternalItemsPickerController(this.onLoadItems, this.isMultiSelection,
      {List<T>? selectedItems,
      required this.canLoadMore,
      required this.canRefresh,
      this.shouldShowAllOption = false,
      this.onSelectItemAll,
      this.metadataUpdater,
      this.onConfirmSelectSingleItem,
      this.onConfirmSelectMultipleItems})
      : selectedItems = selectedItems ?? List.empty(growable: true);

  @override
  bool get includeAllOption => shouldShowAllOption;

  @override
  bool get enableLoadMore =>
      !(state.value?.isRefreshing ?? true) &&
      canLoadMore &&
      (metadata?.canLoadMore ?? false);

  @override
  bool get enableRefresh => canRefresh;

  @override
  FutureOr<InfiniteListViewControllerState<T>> build() {
    metadataUpdater?.onUpdateMetadata = (metadata) {
      this.metadata = metadata;
    };
    return super.build();
  }

  @override
  void filterBy(String? text) {
    isSearching = text?.isNotEmpty ?? false;

    if (!isSearching) {
      onRefresh();
      return;
    }

    searchText = text!.trim();
    onRefresh();
  }

  @override
  Future<List<T>> getData() async {
    if (isSearching) {
      return Future.value(localItems.where((element) {
        return element.searchableTexts.any((element) =>
            element.withoutDiacriticCharacters.toLowerCase().contains(
                searchText?.toLowerCase().withoutDiacriticCharacters ?? ""));
      }).toList());
    }
    return onLoadItems(currentPage);
  }

  @override
  void onLoading() async {
    var hasNoData = false;
    currentPage += 1;
    state = await AsyncValue.guard(() async {
      var newItems = await getData();
      var currentItems = items;

      addAnimationItems(currentItems);

      hasNoData = newItems.isEmpty;
      if (hasNoData) {
        return state.value!;
      }

      return InfiniteListViewControllerState.more(
          currentItems: currentItems, newItems: newItems);
    });

    if (hasNoData) {
      refreshController.loadNoData();
      return;
    }

    _markSelectedItems();

    if (!isSearching) {
      localItems.clear();
      localItems.addAll(items);
    }

    refreshController.loadComplete();
  }

  @override
  Future onRefresh() async {
    super.onRefresh();
    state = AsyncValue<InfiniteListViewControllerState<T>>.loading();
    var newState = await AsyncValue.guard(() async {
      var items = await getData();

      addFreshAnimationItems(items);

      return InfiniteListViewControllerState<T>(
          items: items, isRefreshing: false, isLoadMore: false);
    });

    state = newState;

    _markSelectedItems();

    if (!isSearching) {
      localItems.clear();
      localItems.addAll(items);
    }
  }

  void onSelectItem(T item) {
    if (isMultiSelection) {
      _onMultiSelection(item);
    } else {
      _onSingleSelection(item);
    }
  }

  void onSelectAllItem() {
    isItemAllSelected = !isItemAllSelected;

    if (isItemAllSelected) {
      _selectAllItems();
    } else {
      _deselectAllItems();
    }
  }

  void onConfirm() {
    onConfirmSelectMultipleItems?.call(selectedItems);
  }

  void _onMultiSelection(T item) {
    item.isSelected = !item.isSelected;

    if (item.isSelected) {
      selectedItems.add(item);
    } else {
      selectedItems.removeWhere((element) {
        if (element is IdentifierComparable && item is IdentifierComparable) {
          return (element as IdentifierComparable).identifier ==
              (item as IdentifierComparable).identifier;
        }

        return element == item;
      });
    }

    isItemAllSelected = items.every((element) => element.isSelected);
  }

  void _onSingleSelection(T item) {
    onConfirmSelectSingleItem?.call(item);
  }

  void _markSelectedItems() {
    var currentItems = List<T>.from(items);
    for (var item in currentItems) {
      item.isSelected = selectedItems.any((element) {
        if (element is IdentifierComparable && item is IdentifierComparable) {
          return (element as IdentifierComparable).identifier ==
              (item as IdentifierComparable).identifier;
        }

        return element == item;
      });
    }

    if (selectedItems.isNotEmpty) {
      isItemAllSelected = currentItems.every((element) => element.isSelected);
    }

    state = AsyncData(
        InfiniteListViewControllerState<T>.change(items: currentItems));
  }

  void _selectAllItems() {
    selectedItems.clear();

    for (var item in items) {
      item.isSelected = true;
    }

    selectedItems.addAll(items);

    if (!isMultiSelection) {
      onSelectItemAll?.call(items);
      return;
    }
  }

  void _deselectAllItems() {
    selectedItems.clear();

    for (var item in items) {
      item.isSelected = false;
    }
  }
}

extension DiacriticCharaters on String {
  String get withoutDiacriticCharacters {
    return removeDiacritics(this);
  }
}
