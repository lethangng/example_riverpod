import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/rich_text_editor/rich_text_editor_items_list_view.dart';

class RichTextEditorToolBarItem<T> extends Equatable {
  final GlobalKey key = GlobalKey();
  String title;
  T value;
  int? index;

  RichTextEditorToolBarItem({
    required this.title,
    required this.value,
    this.index,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title];
}

class RichTextEditorToolBarItemsPopupViewButton<T> extends StatefulWidget {
  List<RichTextEditorToolBarItem<T>> items;
  double width;
  TextStyle itemTextStyle;
  TextAlign itemTextAlign;
  RichTextEditorToolBarItem<T>? selectedItem;
  Widget child;
  Widget Function(RichTextEditorToolBarItem<T> selectedItem)
      selectedItemBuilder;
  Widget Function(RichTextEditorToolBarItem<T> item)? itemBuilder;
  Function(RichTextEditorToolBarItem<T> selectedItem) onItemSelected;

  @override
  State<RichTextEditorToolBarItemsPopupViewButton<T>> createState() =>
      _RichTextEditorToolBarItemsPopupViewButtonState<T>();

  RichTextEditorToolBarItemsPopupViewButton({
    super.key,
    required this.items,
    required this.child,
    required this.selectedItemBuilder,
    required this.itemTextStyle,
    required this.onItemSelected,
    required this.selectedItem,
    this.itemTextAlign = TextAlign.left,
    this.width = 200,
    this.itemBuilder,
  });
}

class _RichTextEditorToolBarItemsPopupViewButtonState<T>
    extends State<RichTextEditorToolBarItemsPopupViewButton<T>> {
  RichTextEditorToolBarItem<T>? selectedItem;
  ValueNotifier<bool> isOpenedNotifier = ValueNotifier<bool>(false);
  int? selectedItemIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant RichTextEditorToolBarItemsPopupViewButton<T> oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    selectedItem = widget.selectedItem;
    try {
      selectedItemIndex = widget.items.indexOf(selectedItem!);
    } catch (e) {
      selectedItemIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: isOpenedNotifier.value,
      closeDuration: const Duration(milliseconds: 200),
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            isOpenedNotifier.value = false;
          });
        },
      ),
      child: PortalTarget(
          visible: isOpenedNotifier.value,
          anchor: const Aligned(
              offset: Offset(0, -10),
              follower: Alignment.bottomCenter,
              target: Alignment.topCenter,
              alignToPortal: AxisFlag(x: true, y: false),
              shiftToWithinBound: AxisFlag(x: true, y: true)),
          portalFollower: Container(
            width: widget.width,
            clipBehavior: Clip.antiAlias,
            constraints: const BoxConstraints(
              maxHeight: 250,
            ),
            decoration: BoxDecoration(
              borderRadius: 12.0.borderAll(),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ],
              color: Colors.white,
            ),
            child: RichTextEditorPopupItemsListView(
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              itemSize: kMinInteractiveDimensionCupertino,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                var e = widget.items[index];
                return PullDownMenuEntryWrapper(
                  entry: widget.itemBuilder?.call(e) ??
                      RichTextEditorToolBarItemView(
                        buttonKey: e.key,
                        title: e.title,
                        textStyle: widget.itemTextStyle,
                        textAlign: widget.itemTextAlign,
                      ),
                  onTap: () {
                    setState(() {
                      selectedItem = e;
                      selectedItemIndex = index;
                      widget.onItemSelected.call(e);
                      setState(() {
                        isOpenedNotifier.value = false;
                      });
                    });
                  },
                );
              },
              selectedIndex: selectedItemIndex,
            ),
          ),
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  isOpenedNotifier.value = !isOpenedNotifier.value;
                });
              },
              child: selectedItem != null
                  ? widget.selectedItemBuilder
                      .call(selectedItem as RichTextEditorToolBarItem<T>)
                  : widget.child)),
    );
  }
}

class RichTextEditorToolBarItemView extends StatelessWidget {
  @override
  final GlobalKey buttonKey;
  String title;
  TextStyle textStyle;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
      textAlign: textAlign,
    );
  }

  RichTextEditorToolBarItemView(
      {super.key,
      required this.buttonKey,
      required this.title,
      required this.textStyle,
      required this.textAlign});
}

class PullDownMenuEntryWrapper extends StatelessWidget
    implements PullDownMenuEntry {
  final Widget entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(onPressed: onTap, child: entry);
  }

  const PullDownMenuEntryWrapper({
    super.key,
    required this.entry,
    required this.onTap,
  });
}
