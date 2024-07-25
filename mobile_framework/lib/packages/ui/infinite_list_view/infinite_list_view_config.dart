import 'package:flutter/material.dart';
import 'infinite_list_view_empty_datasource.dart';

class InfiniteListViewConfig extends InheritedWidget {
  const InfiniteListViewConfig({
    super.key,
    required super.child,
    required this.emptyPlaceholder
  });

  final InfiniteListViewEmptyDataSource emptyPlaceholder;

  static InfiniteListViewConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InfiniteListViewConfig>();
  }

  @override
  bool updateShouldNotify(InfiniteListViewConfig oldWidget) =>
      emptyPlaceholder != oldWidget.emptyPlaceholder;
}