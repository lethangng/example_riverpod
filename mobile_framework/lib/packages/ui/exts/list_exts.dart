import 'package:flutter/material.dart';

extension ListWidgetExt<T extends Widget> on List<T> {
  Widget embedColumn({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
  }) {
    return Column(
      key: key,
      children: this,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
    );
  }

  Widget embedRow({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
  }) {
    return Row(
      key: key,
      children: this,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
    );
  }

  Widget embedStack({
    Key? key,
    AlignmentDirectional alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return Stack(
      children: this,
      key: key,
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }
}

extension FilterListExts<T> on List<T> {
  /// if comparator is provided and returned value is true
  /// it means the element is not in array
  Iterable<T> filterNotIn(List<T> array,
      {bool Function(List<T> inputArray, T element)? condition}) {
    return where((element) => condition != null
        ? condition(array, element)
        : !array.contains(element));
  }

  /// if comparator is provided and returned value is true
  /// it means the element is in array
  Iterable<T> filterIn(List<T> array,
      {bool Function(List<T> inputArray, T element)? comparator}) {
    return where((element) => comparator != null
        ? comparator(array, element)
        : array.contains(element));
  }
}

extension FilterNotNullExt<T> on Iterable<T?> {
  Iterable<T> whereNotNull() {
    return whereType<T>();
  }
}

abstract interface class DeepCopyable<T> {
  T deepCopy();
}

extension ListDeepCopyExts<T> on List<DeepCopyable<T>> {
  List<T> deepCopy() {
    return map((e) => e.deepCopy()).toList();
  }
}
