import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/infinite_list_view/animated_infinite_item_view_manager.dart';

const infiniteListViewTag = 'INFINITE_LIST_VIEW';

// TODO: Prepare for animated list
class InfiniteItemAnimationState {
  bool isForwarded;
  bool isAnimating;

  bool get isReversed => !isForwarded;

  InfiniteItemAnimationState({
    required this.isForwarded,
    required this.isAnimating,
  });

  void forward() {
    isForwarded = true;
    start();
  }

  void reverse() {
    isForwarded = false;
    start();
  }

  void start() {
    isAnimating = true;
  }

  void finish() {
    isAnimating = false;
  }
}

class InfiniteListViewControllerState<T> extends Equatable {
  final List<T> items;
  final bool isRefreshing;
  final bool isLoadMore;

  bool get shouldShowLoading => isRefreshing && !isLoadMore;

  const InfiniteListViewControllerState({
    required this.items,
    required this.isRefreshing,
    required this.isLoadMore,
  });

  InfiniteListViewControllerState copyWith({
    List<T>? items,
    bool? isRefreshing,
    bool? isLoadMore,
  }) {
    return InfiniteListViewControllerState(
      items: items ?? this.items,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  InfiniteListViewControllerState.empty()
      : this(items: [], isRefreshing: true, isLoadMore: false);

  const InfiniteListViewControllerState.more(
      {required List<T> currentItems, required List<T> newItems})
      : this(
            items: currentItems + newItems,
            isRefreshing: false,
            isLoadMore: true);

  const InfiniteListViewControllerState.change({required List<T> items})
      : this(items: items, isRefreshing: false, isLoadMore: false);

  @override
  // TODO: implement props
  List<Object?> get props => [items, isRefreshing, isLoadMore];
}

abstract class InfiniteListViewController<ItemType>
    extends AutoDisposeAsyncNotifier<
        InfiniteListViewControllerState<ItemType>> {
  late final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late final AnimatedInfiniteItemsController animatedInfiniteItemsController =
      AnimatedInfiniteItemsController();
  int currentPage = 0;
  bool initialRefresh;

  InfiniteListViewController({this.initialRefresh = true});

  List<ItemType> get items => List.from(state.value?.items ?? []);

  bool get isRefreshing => state.value?.isRefreshing ?? true;

  @override
  FutureOr<InfiniteListViewControllerState<ItemType>> build() async {
    if (initialRefresh) {
      await onRefresh();
    }

    return InfiniteListViewControllerState<ItemType>(
      items: items,
      isRefreshing: false,
      isLoadMore: false,
    );
  }

  Future<List<ItemType>> getData();

  Future onRefresh() async {
    talkerLogger.log("[$infiniteListViewTag] onRefresh called");
    refreshController.refreshCompleted(resetFooterState: true);
    currentPage = 0;
    state = AsyncValue.data(InfiniteListViewControllerState.empty());
  }

  void onLoading() {
    talkerLogger.log("[$infiniteListViewTag] onLoading called");
  }
}
