import 'package:flutter/material.dart';
import 'package:mobile_framework/gen/assets.gen.dart';
import 'package:mobile_framework/mobile_framework.dart';

class RichTextEditorPrimaryToolBarView extends StatefulWidget
    with GlobalThemePlugin {
  final Function(bool isExpanded) isExpandedCallback;
  final FocusNode focusNode;
  final RichTextWebEditorController controller;

  @override
  State<RichTextEditorPrimaryToolBarView> createState() =>
      _RichTextEditorPrimaryToolBarViewState();

  const RichTextEditorPrimaryToolBarView({
    super.key,
    required this.isExpandedCallback,
    required this.focusNode,
    required this.controller,
  });
}

class _RichTextEditorPrimaryToolBarViewState
    extends State<RichTextEditorPrimaryToolBarView>
    with ImagesPickerCompatible, PickerSettings, ImageSourceCompatible {
  bool isExpanded = false;
  bool isKeyboardVisible = true;

  @override
  bool get supportMultiplePickOnGallery => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        isKeyboardVisible = true;
      } else {
        isKeyboardVisible = false;
        widget.controller.unFocus();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.029),
          blurRadius: 8,
          spreadRadius: 1,
          offset: Offset(0, -10),
        ),
      ]),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: context.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichTextEditorToolbarButton(
                onPressed: () {
                  widget.controller.execCommand("Bold");
                },
                image: Assets.icons.icBold,
                canToggle: true,
                buttonType: RichTextButtonType.bold,
              ),
              RichTextEditorToolbarButton(
                onPressed: () {
                  widget.controller.execCommand("Italic");
                },
                image: Assets.icons.icItalic,
                canToggle: true,
                buttonType: RichTextButtonType.italic,
              ),
              RichTextEditorToolbarButton(
                onPressed: () {
                  widget.controller.execCommand("Underline");
                },
                image: Assets.icons.icUnderline,
                canToggle: true,
                buttonType: RichTextButtonType.underline,
              ),
              RichTextEditorToolbarButton(
                onPressed: () {
                  widget.controller.execCommand('InsertUnorderedList');
                },
                image: Assets.icons.icUnorderedList,
                canToggle: true,
                buttonType: RichTextButtonType.unorderList,
              ),
              RichTextEditorToolbarButton(
                onPressed: () {
                  widget.controller.execCommand('InsertOrderedList');
                },
                image: Assets.icons.icOrderedList,
                canToggle: true,
                buttonType: RichTextButtonType.orderList,
              ),
              const VerticalDivider(
                thickness: 1,
                endIndent: 12,
                indent: 12,
              ),
              RichTextEditorToolbarButton(
                onPressed: () {
                  widget.controller.execCommand('mceInsertTable',
                      shouldShowUI: false,
                      parameters: {"rows": 2, "columns": 2});
                },
                image: Assets.icons.icInsertTable,
                buttonType: RichTextButtonType.insertTable,
              ),
              Container(
                      decoration: BoxDecoration(
                          color: isExpanded
                              ? const Color(0xFFF2F2F2)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.vertical(top: 12.0.circularRadius)),
                      height: 56,
                      width: 44,
                      child:
                          const Icon(Icons.more_vert_rounded).onTapWidget(() {
                        isExpanded = !isExpanded;
                        widget.isExpandedCallback(isExpanded);
                      }).paddingOnly(bottom: 8))
                  .paddingOnly(top: 8),
            ],
          ),
        ),
      ),
    );
  }
}
