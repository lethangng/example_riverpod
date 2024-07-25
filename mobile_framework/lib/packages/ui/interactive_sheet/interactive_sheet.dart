// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

typedef InteractiveSheetListItemPressedCallback = void Function(int index);
typedef InteractiveSheetListItemBuilder = Widget Function(
    BuildContext context, int index);
typedef InteractiveSheetListItemStyleBuilder = TextStyle Function(int index);

typedef InteractiveSheetListItemSeparatorBuilder = Widget Function(int index);

// ignore: must_be_immutable
class InteractiveSheet extends StatefulWidget {
  InteractiveSheetDataSource dataSource;
  InteractiveSheetDelegate? delegate;

  /// if [isInteractive] is false, then [InteractiveSheet] will not be grown by user's pan gesture
  final bool isInteractive;

  InteractiveSheet(
      {super.key,
      required this.dataSource,
      this.delegate,
      this.isInteractive = true});

  factory InteractiveSheet.fixedList(
      {required List<InteractiveListItem> items,
      Widget? header,
      InteractiveSheetListItemBuilder? itemBuilder,
      @Deprecated("Use onPressed in InteractiveListItem")
      InteractiveSheetListItemPressedCallback? onItemPressed,
      InteractiveSheetListItemStyleBuilder? itemStyle,
      InteractiveSheetListItemSeparatorBuilder? itemSeparatorBuilder,
      InteractiveSheetDelegate? delegate,
      bool isFloating = false,
      bool canShowIndicator = true}) {
    return InteractiveSheet(
        dataSource: InteractiveSheetListDataSource(items,
            header: header,
            itemBuilder: itemBuilder,
            onItemPressed: onItemPressed,
            itemTextStyle: itemStyle,
            itemSeparatorBuilder: itemSeparatorBuilder,
            isFloating: isFloating,
            canShowIndicator: canShowIndicator),
        delegate: delegate,
        isInteractive: false);
  }

  factory InteractiveSheet.growableList(
      {required List<InteractiveListItem> items,
      Widget? header,
      double? minHeightRatio,
      double? maxHeightRatio,
      double? initialHeightRatio,
      InteractiveSheetListItemBuilder? itemBuilder,
      @Deprecated("Use onPressed in InteractiveListItem")
      InteractiveSheetListItemPressedCallback? onItemPressed,
      InteractiveSheetListItemStyleBuilder? itemStyle,
      InteractiveSheetListItemSeparatorBuilder? itemSeparatorBuilder,
      InteractiveSheetDelegate? delegate,
      bool isFloating = false,
      bool canShowIndicator = true}) {
    return InteractiveSheet(
        dataSource: InteractiveSheetListDataSource(items,
            header: header,
            minHeightRatio: minHeightRatio,
            maxHeightRatio: maxHeightRatio,
            initialHeightRatio: initialHeightRatio,
            itemBuilder: itemBuilder,
            onItemPressed: onItemPressed,
            itemTextStyle: itemStyle,
            itemSeparatorBuilder: itemSeparatorBuilder,
            isFloating: isFloating,
            canShowIndicator: canShowIndicator),
        delegate: delegate,
        isInteractive: true);
  }

  factory InteractiveSheet.fixedContent(Widget content,
      {Widget? header,
      InteractiveSheetDelegate? delegate,
      bool isFloating = true,
      bool canShowIndicator = true}) {
    return InteractiveSheet(
      dataSource: InteractiveSheetContentDataSource(
          header: header,
          content,
          isFloating: isFloating,
          canShowIndicator: canShowIndicator),
      isInteractive: false,
      delegate: delegate,
    );
  }

  factory InteractiveSheet.growableContent(Widget content,
      {Widget? header,
      double? minHeightRatio,
      double? maxHeightRatio,
      double? initialHeightRatio,
      InteractiveSheetDelegate? delegate,
      bool isFloating = true,
      bool canShowIndicator = true}) {
    return InteractiveSheet(
      dataSource: InteractiveSheetContentDataSource(content,
          header: header,
          minHeightRatio: minHeightRatio,
          maxHeightRatio: maxHeightRatio,
          initialHeightRatio: initialHeightRatio,
          isFloating: isFloating,
          canShowIndicator: canShowIndicator),
      isInteractive: true,
      delegate: delegate,
    );
  }

  @override
  State<InteractiveSheet> createState() => _InteractiveSheetState();

  Future<T?> show<T>() {
    var context = appRouter.navigatorKey.currentContext;
    if (context == null) {
      return Future.value(null);
    }

    InteractiveSheetConfiguration? c =
        InteractiveSheetConfiguration.of(context);

    return showModalBottomSheet<T>(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: c?.barrierColor,
    );
  }
}

class _InteractiveSheetState extends State<InteractiveSheet> {
  DraggableScrollableController controller = DraggableScrollableController();

  InteractiveSheetDataSource get _dataSource {
    return widget.dataSource;
  }

  InteractiveSheetDelegate? get _delegate {
    return widget.delegate;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (widget.isInteractive) {
      return SizedBox.expand(
        child: DraggableScrollableSheet(
            controller: controller,
            minChildSize: _dataSource.interactiveSheetMinHeightRatio(),
            maxChildSize: _dataSource.interactiveSheetMaxHeightRatio(),
            initialChildSize: _dataSource.interactiveSheetInitialRatio(),
            expand: false,
            builder: (context, scrollController) =>
                _buildSheet(context, scrollController: scrollController)),
      );
    }

    return _buildSheet(context);
  }

  Widget _buildSheet(BuildContext context,
      {ScrollController? scrollController}) {
    InteractiveSheetConfiguration? configuration =
        InteractiveSheetConfiguration.of(context);

    assert(configuration != null,
        "You haven't configure the [InteractiveSheetConfiguration], go to MaterialApp or GetMaterialApp and wrap them with [InteractiveSheetConfiguration]");

    return GestureDetector(
            onTap: () {
              _delegate?.interactiveSheetDidTapBarrier();
              FocusScope.of(context).unfocus();
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: context.width *
                  (_dataSource.interactiveSheetShouldChangeToFloatingForm()
                      ? .9
                      : 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(16),
                      bottom: _dataSource
                              .interactiveSheetShouldChangeToFloatingForm()
                          ? const Radius.circular(16)
                          : Radius.zero),
                  color: configuration!.backgroundColor),
              child: (widget.isInteractive
                      ? _GrowableContentWidget(
                          header: _dataSource.interactiveSheetAppBarWidget(),
                          scrollController: scrollController,
                          canShowIndicator:
                              _dataSource.interactiveSheetShouldShowIndicator(),
                          child: _dataSource
                              .interactiveSheetChildWidget(scrollController))
                      : _FixedContentWidget(
                          header: _dataSource.interactiveSheetAppBarWidget(),
                          canShowIndicator:
                              _dataSource.interactiveSheetShouldShowIndicator(),
                          child: _dataSource
                              .interactiveSheetChildWidget(scrollController)))
                  .paddingOnly(
                      bottom: _dataSource
                              .interactiveSheetShouldChangeToFloatingForm()
                          ? 0
                          : 12),
            ))
        .paddingOnly(
            bottom: _dataSource.interactiveSheetShouldChangeToFloatingForm()
                ? context.includeBottomPadding(12)
                : 0);
  }
}

class _GrowableContentWidget extends StatelessWidget {
  final Widget header;
  final Widget child;
  final ScrollController? scrollController;
  final bool canShowIndicator;

  _GrowableContentWidget(
      {required this.header,
      required this.child,
      required this.canShowIndicator,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPinnedHeader(
            child: Column(
          children: [
            if (canShowIndicator) const _InteractiveSheetHeaderIndicator(),
            header,
          ],
        )),
        SliverFillRemaining(
          child: child is ListView ? child.expand() : child,
        )
      ],
      controller: scrollController,
    );
  }
}

class _FixedContentWidget extends StatelessWidget {
  final Widget header;
  final Widget child;
  final bool canShowIndicator;

  _FixedContentWidget({
    required this.header,
    required this.child,
    required this.canShowIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (canShowIndicator) const _InteractiveSheetHeaderIndicator(),
        header,
        child
      ],
    );
  }
}

class _InteractiveSheetSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  Widget child;

  _InteractiveSheetSliverPersistentHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _InteractiveSheetHeaderIndicator extends StatelessWidget {
  const _InteractiveSheetHeaderIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14,
      child: Container(
        height: 3,
        width: 60,
        decoration: ShapeDecoration(
            color: Colors.grey.shade300,
            shape: RoundedRectangleBorder(borderRadius: 8.0.borderAll())),
      ).center(),
    );
  }
}
