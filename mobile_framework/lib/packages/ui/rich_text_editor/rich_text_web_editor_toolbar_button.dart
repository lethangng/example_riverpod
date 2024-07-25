import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/gen/assets.gen.dart';
import 'package:mobile_framework/mobile_framework.dart';

class RichTextEditorToolbarButton extends ConsumerStatefulWidget {
  SvgGenImage image;
  VoidCallback? onPressed;
  bool canToggle;
  bool? isToggled;
  RichTextButtonType buttonType;

  @override
  ConsumerState<RichTextEditorToolbarButton> createState() =>
      _RichTextEditorToolbarButtonState();

  RichTextEditorToolbarButton(
      {super.key,
      required this.image,
      required this.onPressed,
      this.canToggle = false,
      required this.buttonType});
}

class _RichTextEditorToolbarButtonState
    extends ConsumerState<RichTextEditorToolbarButton> {
  var toggleState = false;
  var isDisable = false;

  @override
  void didUpdateWidget(covariant RichTextEditorToolbarButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.isToggled != null) {
      toggleState = widget.isToggled!;
    }
  }

  @override
  Widget build(BuildContext context) {
    toggleState = ref.watch(richTextButtonsProvider.select((value) =>
        value
            .firstOrNullWhere((element) => element.type == widget.buttonType)
            ?.isActive ??
        false));

    isDisable = ref.watch(richTextButtonsProvider.select((value) =>
        value
            .firstOrNullWhere((element) => element.type == widget.buttonType)
            ?.isDisable ??
        false));

    return CupertinoButton(
        borderRadius: BorderRadius.circular((36) / 2),
        color: widget.canToggle
            ? toggleState
                ? Colors.grey.shade300
                : null
            : null,
        onPressed: isDisable
            ? null
            : () {
                widget.onPressed?.call();
                setState(() {
                  toggleState = !toggleState;
                });
              },
        padding: EdgeInsets.zero,
        child: widget.image.svg(
          height: 25,
          width: 25,
          color: getIconColor(),
        )).squareBox(edgeSize: 36);
  }

  Color getIconColor() {
    if (isDisable) {
      return Colors.grey.shade500;
    }

    return Colors.black;
  }
}
