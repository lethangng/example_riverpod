// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_framework/packages/ui/exts/widget_exts.dart';
import 'package:mobile_framework/packages/ui/widgets/dev_pack_configuration.dart';
import 'package:mobile_framework/packages/ui/widgets/textfield.dart';

class PasswordTextFieldView extends StatefulWidget {
  final double? height;
  final String? title;
  final String? placeholder;
  final String? initialText;

  final bool autoFocus;
  final bool isRequired;

  final Function(String? text)? textFieldDidChange;
  final bool Function(String? text)? validator;
  final String Function()? errorText;
  final bool Function()? enableBy;
  final bool shouldShowBorder;
  final bool shouldShowOutsideBorder;
  final EdgeInsets? padding;

  const PasswordTextFieldView({
    super.key,
    this.height,
    this.title,
    this.placeholder,
    this.initialText,
    this.autoFocus = false,
    this.isRequired = true,
    this.errorText,
    this.validator,
    this.textFieldDidChange,
    this.enableBy,
    this.shouldShowBorder = true,
    this.shouldShowOutsideBorder = false,
    this.padding,
  });

  @override
  State<PasswordTextFieldView> createState() => _PasswordTextFieldViewState();
}

class _PasswordTextFieldViewState extends State<PasswordTextFieldView> {
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldView(
      autoFocus: widget.autoFocus,
      placeholder: widget.placeholder,
      initialText: widget.initialText,
      title: widget.title,
      isRequired: widget.isRequired,
      isObscureText: _isObscureText,
      textFieldDidChange: widget.textFieldDidChange,
      errorText: widget.errorText,
      validator: widget.validator,
      enableBy: widget.enableBy,
      shouldShowInsideBorder: widget.shouldShowBorder,
      shouldShowOutsideBorder: widget.shouldShowOutsideBorder,
      padding: widget.padding,
      suffixIcons: [
        PasswordEyeIcon(
          onTapEyeButton: () {
            setState(() {
              _isObscureText = !_isObscureText;
            });
          },
        )
      ],
    );
  }
}

class PasswordEyeIcon extends StatefulWidget {
  final VoidCallback? onTapEyeButton;

  const PasswordEyeIcon({
    super.key,
    this.onTapEyeButton,
  });

  @override
  State<PasswordEyeIcon> createState() => _PasswordEyeIconState();
}

class _PasswordEyeIconState extends State<PasswordEyeIcon>
    with GlobalThemePlugin {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return (_isSelected
            ? const Icon(
                Iconsax.eye,
                size: 16.0,
                color: Colors.black87,
              )
            : const Icon(
                Iconsax.eye_slash,
                size: 16.0,
                color: Colors.black87,
              ))
        .center()
        .box(h: 42.0, w: 42.0)
        .onTapWidget(radius: 4, () {
      setState(() {
        _isSelected = !_isSelected;
      });
      widget.onTapEyeButton?.call();
    });
  }
}
