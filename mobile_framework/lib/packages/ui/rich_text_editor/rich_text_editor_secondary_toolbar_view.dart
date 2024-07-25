import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/gen/assets.gen.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/rich_text_editor/rich_text_editor_tool_bar_items_popup_view.dart';

class RichTextEditorSecondaryToolBarView extends StatelessWidget
    with GlobalThemePlugin {
  final RichTextWebEditorController controller;
  final supportedFontFamilies = [
    "Arial",
    "Courier New",
    "Georgia",
    "Helvetica",
    "Tahoma",
    "Times New Roman",
    "Verdana",
    "Symbol",
    "Impact",
    "Roboto",
    "Andale Mono",
    "Wingdings",
  ];

  final List<String> supportedFontSizes =
      List.generate(50, (index) => index + 1).map((e) => "${e}px").toList();

  Map<String, String> get fontSizeMap => {
        for (var element in supportedFontSizes)
          element.toString(): element.toString()
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F2),
      height: 56,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SeparatedRow(
          separatorBuilder: (context, index) {
            return HSpace.h4;
          },
          children: [
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("undo");
              },
              image: Assets.icons.icUndo,
              buttonType: RichTextButtonType.undo,
            ),
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("redo");
              },
              image: Assets.icons.icRedo,
              buttonType: RichTextButtonType.redo,
            ),
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("StrikeThrough");
              },
              image: Assets.icons.icStrikeThrough,
              canToggle: true,
              buttonType: RichTextButtonType.strikeThrough,
            ),
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("Subscript");
              },
              image: Assets.icons.icSubscript,
              canToggle: true,
              buttonType: RichTextButtonType.subscript,
            ),
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("Superscript");
              },
              image: Assets.icons.icSuperscript,
              canToggle: true,
              buttonType: RichTextButtonType.superscript,
            ),
            // RichTextEditorToolbarClearFormattingButton(controller: controller),
            Consumer(
              builder: (context, ref, child) {
                var fontSize = ref.watch(richTextButtonsProvider.select(
                    (value) => value
                        .firstOrNullWhere((element) =>
                            element.type == RichTextButtonType.fontSize)
                        ?.data as String?));
                return RichTextEditorToolBarItemsPopupViewButton<String>(
                  itemTextStyle: conf.mediumTextStyle,
                  itemTextAlign: TextAlign.center,
                  width: 80,
                  items: supportedFontSizes
                      .mapIndexed((index, e) => RichTextEditorToolBarItem(
                          title: e.toString(),
                          value: e.toString(),
                          index: index))
                      .toList(),
                  selectedItemBuilder:
                      (RichTextEditorToolBarItem<String> selectedItem) {
                    return Row(
                      children: [
                        Text(
                          selectedItem.title,
                          style: conf.defaultTextStyle,
                        ),
                        HSpace(4),
                        Assets.icons.icArrow
                            .svg(
                              width: 6,
                              height: 6,
                            )
                            .center(),
                        HSpace.h8,
                      ],
                    );
                  },
                  onItemSelected:
                      (RichTextEditorToolBarItem<String> selectedItem) {
                    controller.execCommand("FontSize",
                        shouldShowUI: false, parameters: selectedItem.title);
                  },
                  selectedItem: RichTextEditorToolBarItem(
                      title: fontSize ?? "", value: fontSize ?? ""),
                  child: Row(
                    children: [
                      Text(
                        "",
                        style: conf.defaultTextStyle.semiBold,
                        textAlign: TextAlign.center,
                      ),
                      HSpace(4),
                      Assets.icons.icArrow
                          .svg(
                            width: 6,
                            height: 6,
                          )
                          .center(),
                      HSpace.h8,
                    ],
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                var fontFamily = ref.watch(richTextButtonsProvider.select(
                    (value) => value
                        .firstOrNullWhere((element) =>
                            element.type == RichTextButtonType.fontFamily)
                        ?.data as String?));

                return RichTextEditorToolBarItemsPopupViewButton<TextStyle>(
                  itemTextStyle: conf.mediumTextStyle,
                  items: supportedFontFamilies.mapIndexed((index, e) {
                    return RichTextEditorToolBarItem<TextStyle>(
                      title: e,
                      value: TextStyle(fontFamily: e),
                    );
                  }).toList(),
                  itemBuilder: (item) {
                    return Text(
                      item.title,
                      style: item.value,
                      textAlign: TextAlign.left,
                    ).leftCenter();
                  },
                  selectedItemBuilder:
                      (RichTextEditorToolBarItem<TextStyle> selectedItem) {
                    return Row(
                      children: [
                        Text(selectedItem.title,
                            style: selectedItem.value
                                .copyWith(color: Colors.black)),
                        HSpace(4),
                        Assets.icons.icArrow
                            .svg(
                              width: 6,
                              height: 6,
                            )
                            .center(),
                        HSpace.h8,
                      ],
                    );
                  },
                  onItemSelected:
                      (RichTextEditorToolBarItem<TextStyle> selectedItem) {
                    controller.execCommand("FontName",
                        shouldShowUI: false, parameters: selectedItem.title);
                  },
                  selectedItem: RichTextEditorToolBarItem<TextStyle>(
                      title: fontFamily ?? "",
                      value: TextStyle(fontFamily: fontFamily)),
                  child: Row(
                    children: [
                      Text(
                        fontFamily ?? "",
                        style: conf.mediumTextStyle,
                      ),
                      HSpace(4),
                      Assets.icons.icArrow
                          .svg(
                            width: 6,
                            height: 6,
                          )
                          .center(),
                      HSpace.h8,
                    ],
                  ),
                );
              },
            ),
            const VerticalDivider(
              indent: 10,
              endIndent: 10,
            ),
            // RichTextEditorToolbarButton(
            //   onPressed: () {
            //     context.showOverlay(RichTextEditorColorsPickerView(
            //       onColorChanged: (color) {},
            //     ));
            //   },
            //   image: Assets.icons.icTextColor,
            //   buttonType: RichTextButtonType.textColor,
            // ),
            // RichTextEditorToolbarButton(
            //   onPressed: () {
            //     context.showOverlay(RichTextEditorColorsPickerView(
            //       onColorChanged: (color) {},
            //     ));
            //   },
            //   image: Assets.icons.icBackgroundColor,
            //   buttonType: RichTextButtonType.backgroundColor,
            // ),
            // const VerticalDivider(
            //   indent: 10,
            //   endIndent: 10,
            // ),
            const VerticalDivider(
              indent: 10,
              endIndent: 10,
            ),
            RichTextEditorToolbarButton(
                image: Assets.icons.icAlignLeft,
                onPressed: () {
                  controller.execCommand("JustifyLeft");
                },
                buttonType: RichTextButtonType.alignLeft),

            RichTextEditorToolbarButton(
                image: Assets.icons.icAlignCenter,
                onPressed: () {
                  controller.execCommand("JustifyCenter");
                },
                buttonType: RichTextButtonType.alignCenter),
            RichTextEditorToolbarButton(
                image: Assets.icons.icAlignLeft,
                onPressed: () {
                  controller.execCommand("JustifyRight");
                },
                buttonType: RichTextButtonType.alignLeft),
            RichTextEditorToolbarButton(
                image: Assets.icons.icAlignJustify,
                onPressed: () {
                  controller.execCommand("JustifyFull");
                },
                buttonType: RichTextButtonType.alignJustify),
            const VerticalDivider(
              indent: 10,
              endIndent: 10,
            ),
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("mceBlockQuote");
              },
              image: Assets.icons.icBlockquote,
              canToggle: true,
              buttonType: RichTextButtonType.blockQuote,
            ),
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("Indent");
              },
              image: Assets.icons.icIndent,
              canToggle: true,
              buttonType: RichTextButtonType.indent,
            ),
            RichTextEditorToolbarButton(
              onPressed: () {
                controller.execCommand("Outdent");
              },
              image: Assets.icons.icOutdent,
              canToggle: true,
              buttonType: RichTextButtonType.outdent,
            ),
            const VerticalDivider(
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }

  RichTextEditorSecondaryToolBarView({super.key, required this.controller});

  double? getFontSize(String value) {
    return double.tryParse(value);
  }
}
