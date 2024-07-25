// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:mobile_framework/packages/ui/exts/double_exts.dart';

/// Wrap your item with [TableViewCell]
/// [TableViewCell] also supports [SwipeAction] like [Wechat]
/// // ignore: must_be_immutable
class TableViewCell extends StatefulWidget {
  final List<SwipeAction> trailingActions;
  final List<SwipeAction> leadingActions;
  final Color? backgroundColor;
  final SwipeActionController? controller;
  final bool isDraggable;
  final int? index;
  final Color? selectedForegroundColor;
  final Color? unselectedIndicator;
  final double? height;
  final double radius;
  final Border? border;
  final BorderRadius? borderRadius;
  final Widget child;
  final EdgeInsets? padding;
  final dynamic data;
  final Function()? onTap;

  List<BoxShadow> boxShadows;

  TableViewCell({
    super.key,
    this.trailingActions = const [],
    this.leadingActions = const [],
    this.backgroundColor,
    this.controller,
    this.isDraggable = true,
    this.index,
    this.selectedForegroundColor,
    this.unselectedIndicator,
    this.height,
    this.radius = 8.0,
    this.border,
    this.borderRadius,
    this.boxShadows = const [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.08),
          blurRadius: 16,
          offset: Offset(0, 0))
    ],
    this.padding,
    this.data,
    this.onTap,
    required this.child,
  });

  @override
  State<TableViewCell> createState() => _TableViewCellState();
}

class _TableViewCellState extends State<TableViewCell> {
  bool get isSwipeable =>
      widget.trailingActions.isNotEmpty || widget.leadingActions.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    var child = Container(
        padding: widget.padding,
        height: widget.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            boxShadow: widget.boxShadows,
            border: widget.border,
            color: widget.backgroundColor,
            borderRadius: widget.borderRadius ?? widget.radius.borderAll()),
        child: widget.child);

    if (isSwipeable) {
      child = Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            boxShadow: widget.boxShadows,
            border: widget.border,
            color: widget.backgroundColor,
            borderRadius: widget.borderRadius ?? widget.radius.borderAll()),
        child: SwipeActionCell(
          key: ValueKey(widget.data),
          leadingActions: widget.leadingActions,
          trailingActions: widget.trailingActions,
          backgroundColor: widget.backgroundColor,
          closeWhenScrolling: true,
          deleteAnimationDuration: 500,
          controller: widget.controller,
          isDraggable: widget.isDraggable,
          firstActionWillCoverAllSpaceOnDeleting: true,
          index: widget.index,
          selectedForegroundColor: widget.selectedForegroundColor,
          child: SizedBox(height: widget.height, child: widget.child),
        ),
      );
    }

    if (widget.onTap != null) {
      return CupertinoButton(
          padding: EdgeInsets.zero,
          child: child,
          onPressed: () {
            widget.onTap!();
          });
    }

    return child;
  }
}
