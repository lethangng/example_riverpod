// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_framework/packages/ui/exts/double_exts.dart';
import 'package:mobile_framework/packages/ui/exts/widget_exts.dart';

// ignore: must_be_immutable
abstract class BaseItemView extends StatefulWidget {
  BaseItemView({super.key, this.onTap});

  double get height;
  Widget get content;

  double get radius {
    return 8.0;
  }

  EdgeInsets get margin {
    return const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: 8.0,
    );
  }

  Color get backgroundColor {
    return Colors.white;
  }

  List<BoxShadow> get boxShadows {
    return [];
  }

  List<Widget> get rightActions {
    return [];
  }

  List<Widget> get leftActions {
    return [];
  }

  /// if [Slidable] want to dismiss
  /// item by swipe left or right
  /// it must set [canDismiss] to [true]
  bool get canDismiss {
    return false;
  }

  bool get canConfirmDismiss {
    return false;
  }

  bool get autoResizing {
    return false;
  }

  VoidCallback? get onDismissSlidable {
    return null;
  }

  bool get _isSlidable {
    return rightActions.isNotEmpty || leftActions.isNotEmpty;
  }

  VoidCallback? onTap;
  VoidCallback _updateViews = () {};

  @override
  State<BaseItemView> createState() => _BaseItemViewState();

  void updateViews() {
    _updateViews();
  }
}

class _BaseItemViewState extends State<BaseItemView> {
  @override
  void initState() {
    super.initState();

    widget._updateViews = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    var content = Container(
      margin: widget.margin,
      height: widget.autoResizing ? null : widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.radius.borderAll(),
        color: widget.backgroundColor,
        boxShadow: widget.boxShadows,
      ),
      child: widget.onTap == null
          ? widget.content
          : widget.content.onTapWidget(radius: widget.radius, () {
              widget.onTap!.call();
              widget.updateViews();
            }),
    );

    if (widget._isSlidable) {
      return Slidable(
        key: UniqueKey(),
        startActionPane: widget.leftActions.isEmpty
            ? null
            : ActionPane(
                key: UniqueKey(),
                extentRatio: 0.3,
                motion: const DrawerMotion(),
                children: widget.leftActions,
                // dismissible: DismissiblePane(onDismissed: () {}),
              ),
        endActionPane: widget.rightActions.isEmpty
            ? null
            : ActionPane(
                key: UniqueKey(),
                extentRatio: 0.3,
                motion: const DrawerMotion(),
                dismissible: widget.canDismiss
                    ? DismissiblePane(
                        resizeDuration: const Duration(milliseconds: 250),
                        confirmDismiss: () =>
                            Future.value(widget.canConfirmDismiss),
                        onDismissed: () {
                          widget.onDismissSlidable?.call();
                        })
                    : null,
                children: widget.rightActions,
              ),
        child: content,
      );
    } else {
      return content;
    }
  }
}
