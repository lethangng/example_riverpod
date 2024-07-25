import 'package:mobile_framework/mobile_framework.dart';

class AnimatedInfiniteItemState extends Equatable {
  final int index;
  bool isAnimated = false;

  AnimatedInfiniteItemState({
    required this.index,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [index, isAnimated];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}

class AnimatedInfiniteItemsController {
  List<AnimatedInfiniteItemState> state = List.empty(growable: true);
  final int animatedRange;

  AnimatedInfiniteItemsController({this.animatedRange = 3});

  void add(AnimatedInfiniteItemState item) {
    state.add(item);
  }

  void markAsAnimated(int index) {
    var item = state.firstWhereOrNull((element) => element.index == index);
    if (item != null && !item.isAnimated) {
      item.isAnimated = true;
    }
  }

  void clear() {
    state = List.empty(growable: true);
  }

  bool isItemAnimatedAt(int index) {
    var item = state.firstWhereOrNull((element) => element.index == index);
    return item?.isAnimated ?? false;
  }
}

mixin AnimatedInfiniteItemsMixin<T> on InfiniteListViewController<T> {
  void addFreshAnimationItems(List<T> items) {
    animatedInfiniteItemsController.clear();
    addAnimationItems(items);
  }

  void addAnimationItems(List<T> items) {
    var lastItemIndex = this.items.length - 1;
    items.forEachIndexed((index, element) {
      animatedInfiniteItemsController
          .add(AnimatedInfiniteItemState(index: index + lastItemIndex + 1));
    });
  }
}
