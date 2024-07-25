import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class RichTextEditorPopupItemsListView extends StatefulWidget {
  NullableIndexedWidgetBuilder itemBuilder;
  IndexedWidgetBuilder separatorBuilder;
  int itemCount;
  int? selectedIndex;
  double? itemSize;

  @override
  State<RichTextEditorPopupItemsListView> createState() =>
      _RichTextEditorPopupItemsListViewState();

  RichTextEditorPopupItemsListView({
    super.key,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    required this.selectedIndex,
    this.itemSize,
  });
}

class _RichTextEditorPopupItemsListViewState
    extends State<RichTextEditorPopupItemsListView> {
  late AutoScrollController controller =
      AutoScrollController(suggestedRowHeight: widget.itemSize);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.selectedIndex != null) {
        controller.scrollToIndex(widget.selectedIndex!,
            duration: 100.milliseconds,
            preferPosition: AutoScrollPosition.middle);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      child: ListView.separated(
          reverse: true,
          shrinkWrap: true,
          controller: controller,
          itemBuilder: (context, index) {
            return AutoScrollTag(
                index: index,
                key: ValueKey(index),
                controller: controller,
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.selectedIndex == index
                          ? Colors.grey.shade200
                          : null),
                  child: widget.itemBuilder(context, index),
                ));
          },
          separatorBuilder: widget.separatorBuilder,
          itemCount: widget.itemCount),
    );
  }
}
