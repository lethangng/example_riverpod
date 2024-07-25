import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class RichTextEditorColorsPickerView extends ConsumerWidget {
  Color? selectedColor;
  Function(String hexColor)? onColorChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: context.width * .8,
      constraints: const BoxConstraints.tightFor(height: 450),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.09),
          blurRadius: 12,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ]),
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              child: ColorPicker(
                color: selectedColor ?? ref.theme.mainColor,
                pickersEnabled: const <ColorPickerType, bool>{
                  ColorPickerType.both: false,
                  ColorPickerType.primary: false,
                  ColorPickerType.accent: false,
                  ColorPickerType.bw: false,
                  ColorPickerType.custom: false,
                  ColorPickerType.customSecondary: false,
                  ColorPickerType.wheel: true,
                },
                width: 40,
                height: 40,
                enableOpacity: false,
                title: Text(
                  "Chọn màu",
                  style: ref.theme.defaultTextStyle,
                ).center(),
                onColorChanged: (Color value) {
                  selectedColor = value;
                },
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PrimaryButton(
                      title: Text(
                        "Chọn",
                        style: ref.theme.defaultTextStyle.white,
                      ),
                      onPressed: () {
                        selectedColor ??= ref.theme.mainColor;
                        String hexColor = "#${colorToHex(selectedColor!)}";

                        onColorChanged?.call(hexColor);
                        Navigator.of(context).pop();
                      })
                  .defaultHorizontalPadding()
                  .center()
                  .paddingOnly(bottom: 12),
            ),
          ],
        ).center(),
      ),
    ).center();
  }

  RichTextEditorColorsPickerView(
      {super.key, this.selectedColor, this.onColorChanged});
}

String colorToHex(Color color) {
  return color.value.toRadixString(16).padLeft(8, '0');
}
