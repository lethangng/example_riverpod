// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable
class NumberInputTextFieldView extends StatefulWidget {
  double? height;
  double? borderRadius;
  String? title;
  String? placeholder;
  String? initialText;

  bool isDisabled;
  bool isRequired;
  bool isDecimal;
  bool isOutSideBorderEnabled;

  TextEditingController? textEditingController;

  Widget? titleWidget;
  List<Widget> suffixIcons;
  List<Widget> prefixIcons;

  bool Function()? enableBy;
  bool Function(String? text)? validator;
  String Function()? errorText;
  VoidCallback? onTapTextField;
  Function(String? text)? textFieldDidChange;

  double Function()? maxValue;
  double Function()? minValue;
  double Function()? initialCurrentValue;
  int Function()? maxDecimalLength;
  Function(double result) onConfirmNumberInput;
  EdgeInsets? padding;
  Color? backgroundColor;

  NumberInputTextFieldView({
    super.key,
    this.height,
    this.title,
    this.placeholder,
    this.initialText,
    this.isDisabled = false,
    this.isRequired = true,
    this.isDecimal = false,
    this.textEditingController,
    this.titleWidget,
    this.suffixIcons = const [],
    this.prefixIcons = const [],
    this.textFieldDidChange,
    this.validator,
    this.errorText,
    this.onTapTextField,
    required this.onConfirmNumberInput,
    this.maxValue,
    this.minValue,
    this.initialCurrentValue,
    this.maxDecimalLength,
    this.enableBy,
    this.borderRadius,
    this.isOutSideBorderEnabled = false,
    this.padding,
    this.backgroundColor
  });

  @override
  State<NumberInputTextFieldView> createState() =>
      _NumberInputTextFieldViewState();
}

class _NumberInputTextFieldViewState extends State<NumberInputTextFieldView> {
  late TextEditingController textEditingController;
  double? currentValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textEditingController = widget.textEditingController ??
        TextEditingController(text: widget.initialText);
    currentValue = widget.initialCurrentValue?.call();
  }

  @override
  void didUpdateWidget(covariant NumberInputTextFieldView oldWidget) {
    super.didUpdateWidget(oldWidget);

    currentValue = widget.initialCurrentValue?.call();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldView(
      isSelectable: true,
      autoFocus: false,
      isDisabled: widget.isDisabled,
      enableBy: widget.enableBy,
      textEditingController: textEditingController,
      placeholder: widget.placeholder,
      initialText: widget.initialText,
      title: widget.title,
      isRequired: widget.isRequired,
      shouldShowInsideBorder: !widget.isOutSideBorderEnabled,
      shouldShowOutsideBorder: widget.isOutSideBorderEnabled,
      borderRadius: widget.borderRadius,
      height: widget.height ?? 44,
      padding: widget.padding,
      backgroundColor: widget.backgroundColor,
      onTapTextField: () {
        FocusScope.of(context).unfocus();
        if (widget.isDecimal) {
          context.showOverlay(NumpadInputView.decimal(
            maxDecimalLength: widget.maxDecimalLength?.call() ?? 1,
            minValue: widget.minValue?.call(),
            maxValue: widget.maxValue?.call(),
            currentValue: currentValue,
            title: widget.placeholder ?? "",
            onConfirm: ((result, resultText) {
              textEditingController.text = resultText;
              currentValue = result;
              widget.onConfirmNumberInput(result);
            }),
          ));
        } else {
          context.showOverlay(NumpadInputView.normal(
            title: widget.placeholder ?? "",
            currentValue: currentValue,
            minValue: widget.minValue?.call(),
            maxValue: widget.maxValue?.call(),
            onConfirm: ((result, resultText) {
              textEditingController.text = resultText;
              currentValue = result;
              widget.onConfirmNumberInput(result);
            }),
          ));
        }
      },
    );
  }
}
