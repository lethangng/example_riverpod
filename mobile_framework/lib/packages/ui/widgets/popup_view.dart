import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable
class PopupView extends ConsumerStatefulWidget {
  double get defaultWidth =>
      globalKey.currentContext!.mediaQuery.size.width - 40;

  double? height;

  double? width;

  double cornerRadius;

  /// if you use `context.showOverlay` to show [PopupView], [dismissible] will be ignored
  bool dismissible;

  Color backgroundColor;

  Widget child;

  @override
  ConsumerState<PopupView> createState() => _PopupViewState();

  PopupView({
    super.key,
    this.height,
    this.width,
    this.cornerRadius = 12,
    this.backgroundColor = Colors.white,
    this.dismissible = false,
    required this.child,
  });
}

class _PopupViewState extends ConsumerState<PopupView> with GlobalThemePlugin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var modalRoute = ModalRoute.of(context);

    var canDismissByParent =
        (modalRoute as RawDialogRoute?)?.barrierDismissible ??
            widget.dismissible;

    return GestureDetector(
      onTap: canDismissByParent
          ? () {
              Navigator.of(context).pop();
            }
          : null,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: widget.cornerRadius.borderAll(),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 12)
                ]),
            child: widget.child.center(),
          ).box(h: widget.height, w: widget.width).center(),
        ).center(),
      ),
    );
  }
}
