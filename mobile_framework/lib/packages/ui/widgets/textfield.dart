// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable
class TextFieldView extends ConsumerStatefulWidget {
  double height;
  double? borderRadius;
  String? title;
  String? placeholder;
  String? initialText;
  @Deprecated("Use CharacterLengthLimiter instead")
  int? maxLength;
  CharacterLengthLimiter? lengthLimiter;

  bool isSelectable;
  bool isDisabled;
  bool isRequired;
  bool isObscureText;
  bool autoFocus;
  bool containHtml;
  bool shouldShowInsideBorder;
  bool shouldShowOutsideBorder;
  bool isExpanded;

  List<TextInputFormatter> inputFormatters;
  List<Widget> suffixIcons;
  List<Widget> prefixIcons;
  List<BoxShadow> shadows;

  TextEditingController? textEditingController;
  TextInputType inputType;
  TextAlignVertical? textAlignVertical;
  Color? backgroundColor;
  EdgeInsets? padding;
  Widget? titleWidget;
  BoxConstraints? constraints;
  FocusNode? focusNode;

  bool Function(String? text)? validator;
  bool Function()? enableBy;
  bool Function()? hasTapOnTextFieldWhenSelectable;
  String Function()? errorText;
  Function(String? text)? textFieldDidChange;
  VoidCallback? onTapTextField;

  Function(AnimationController errorBorderAnimationController)?
      onInitializeErrorBorderAnimationController;
  Function(AnimationController focusedBorderAnimationController)?
      onInitializeFocusedBorderAnimationController;

  TextFieldView(
      {super.key,
      this.autoFocus = false,
      this.height = 44,
      this.isExpanded = false,
      this.borderRadius,
      this.focusNode,
      @Deprecated("Use CharacterLengthLimiter instead") this.maxLength,
      this.lengthLimiter,
      this.title,
      this.placeholder,
      this.initialText,
      this.validator,
      this.inputFormatters = const [],
      this.isSelectable = false,
      this.isRequired = false,
      this.isDisabled = false,
      this.isObscureText = false,
      this.containHtml = false,
      this.textEditingController,
      this.titleWidget,
      this.suffixIcons = const [],
      this.prefixIcons = const [],
      this.textFieldDidChange,
      this.errorText,
      this.inputType = TextInputType.text,
      this.onTapTextField,
      this.enableBy,
      this.backgroundColor = Colors.white,
      this.shouldShowInsideBorder = true,
      this.shouldShowOutsideBorder = false,
      this.shadows = const [],
      this.textAlignVertical,
      this.padding,
      this.onInitializeErrorBorderAnimationController,
      this.onInitializeFocusedBorderAnimationController,
      this.hasTapOnTextFieldWhenSelectable,
      this.constraints})
      : assert(!(isSelectable && onTapTextField == null),
            "onTapTextField should not be null when isSelectable is true");

  TextFieldView.outsideBorder(
      {super.key,
      this.autoFocus = false,
      this.focusNode,
      this.height = 44,
      this.isExpanded = false,
      this.borderRadius,
      @Deprecated("Use CharacterLengthLimiter instead") this.maxLength,
      this.lengthLimiter,
      this.title,
      this.placeholder,
      this.initialText,
      this.validator,
      this.inputFormatters = const [],
      this.isSelectable = false,
      this.isRequired = false,
      this.isDisabled = false,
      this.isObscureText = false,
      this.containHtml = false,
      this.textEditingController,
      this.titleWidget,
      this.suffixIcons = const [],
      this.prefixIcons = const [],
      this.textFieldDidChange,
      this.errorText,
      this.inputType = TextInputType.text,
      this.onTapTextField,
      this.enableBy,
      this.backgroundColor,
      this.shadows = const [],
      this.textAlignVertical,
      this.padding,
      this.onInitializeErrorBorderAnimationController,
      this.onInitializeFocusedBorderAnimationController,
      this.hasTapOnTextFieldWhenSelectable,
      this.constraints})
      : assert(!(isSelectable && onTapTextField == null),
            "onTapTextField should not be null when isSelectable is true"),
        shouldShowInsideBorder = false,
        shouldShowOutsideBorder = true;

  TextFieldView.insideBorder(
      {super.key,
      this.autoFocus = false,
      this.focusNode,
      this.height = 54,
      this.isExpanded = false,
      this.borderRadius,
      @Deprecated("Use CharacterLengthLimiter instead") this.maxLength,
      this.lengthLimiter,
      this.title,
      this.placeholder,
      this.initialText,
      this.validator,
      this.inputFormatters = const [],
      this.isSelectable = false,
      this.isRequired = false,
      this.isDisabled = false,
      this.isObscureText = false,
      this.containHtml = false,
      this.textEditingController,
      this.titleWidget,
      this.suffixIcons = const [],
      this.prefixIcons = const [],
      this.textFieldDidChange,
      this.errorText,
      this.inputType = TextInputType.text,
      this.onTapTextField,
      this.enableBy,
      this.backgroundColor,
      this.shadows = const [],
      this.textAlignVertical,
      this.padding,
      this.onInitializeErrorBorderAnimationController,
      this.onInitializeFocusedBorderAnimationController,
      this.hasTapOnTextFieldWhenSelectable,
      this.constraints})
      : assert(!(isSelectable && onTapTextField == null),
            "onTapTextField should not be null when isSelectable is true"),
        assert(height >= 54, "Height should be greater than or equal to 54"),
        shouldShowInsideBorder = true,
        shouldShowOutsideBorder = false;

  @override
  ConsumerState<TextFieldView> createState() => _TextFieldViewState();
}

class _TextFieldViewState extends ConsumerState<TextFieldView>
    with TickerProviderStateMixin, GlobalThemePlugin {
  late FocusNode _focusNode;

  late final AnimationController _errorBorderAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 100));
  late final AnimationController _focusBorderAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 100));
  late Animation<Color?> _errorBorderAnimationColor;
  late Animation<Color?> _focusBorderAnimationColor;
  late Animation<double> _errorTextOpacityAnimation;

  bool get canShowDefaultTitle =>
      widget.titleWidget == null && (widget.title?.isNotNullOrEmpty ?? false);

  bool get canShowCustomTitle => widget.titleWidget != null;

  bool get canValidateInputText => widget.validator != null;

  bool get shouldShowError {
    if (widget.isSelectable) {
      return !(widget.hasTapOnTextFieldWhenSelectable?.call() ?? true) &&
          shouldValidateTextField &&
          !(widget.validator?.call(textEditingController.text) ?? true);
    }

    return !_focusNode.hasFocus &&
        shouldValidateTextField &&
        !(widget.validator?.call(textEditingController.text) ?? true);
  }

  bool shouldValidateTextField = false;
  bool validationResult = false;

  late TextEditingController textEditingController;
  late CharacterLengthLimiter? lengthLimiter;

  double textFieldViewHeight = 0;
  double errorTextFieldHeight = 0;

  double get totalHeight => textFieldViewHeight + errorTextFieldHeight;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();

    widget.borderRadius ??= conf.textFieldBorderRadius;
    lengthLimiter = widget.lengthLimiter;

    _errorBorderAnimationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _focusBorderAnimationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        return;
      }

      if (shouldShowError) {
        _errorBorderAnimationController.forward();
      } else {
        _errorBorderAnimationController.reverse();
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusBorderAnimationController.forward();
      } else {
        _focusBorderAnimationController.reverse();
      }
    });

    _errorBorderAnimationColor =
        ColorTween(begin: const Color(0xFFE0E0E0), end: const Color(0xFFFF0000))
            .animate(_errorBorderAnimationController);

    _focusBorderAnimationColor = ColorTween(
            begin: const Color(0xFFE0E0E0), end: conf.focusBorderTextFieldColor)
        .animate(_focusBorderAnimationController);

    _errorTextOpacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_errorBorderAnimationController);

    textEditingController = widget.textEditingController ??
        TextEditingController(text: widget.initialText);

    widget.onInitializeFocusedBorderAnimationController
        ?.call(_focusBorderAnimationController);
    widget.onInitializeErrorBorderAnimationController
        ?.call(_errorBorderAnimationController);
  }

  @override
  void didUpdateWidget(covariant TextFieldView oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// update initial text when user cannot edit by keyboard
    if (widget.initialText != oldWidget.initialText) {
      textEditingController.text = widget.initialText ?? "";
    }

    if (widget.enableBy != null) {
      widget.isDisabled = !(widget.enableBy!());
    }

    if (widget.isSelectable) {
      shouldValidateTextField = textEditingController.text.isNotEmpty;
    }

    widget.borderRadius ??= conf.textFieldBorderRadius;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _errorBorderAnimationController.dispose();
    _focusBorderAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outsideBorderSide = BorderSide.none;
    var insideBorderSide = BorderSide.none;
    var hasFocus = false;

    if (widget.isSelectable) {
      hasFocus = widget.hasTapOnTextFieldWhenSelectable?.call() ?? false;
    } else {
      hasFocus = _focusNode.hasFocus;
    }

    if (hasFocus) {
      if (widget.shouldShowInsideBorder) {
        insideBorderSide = BorderSide(
            color: _focusBorderAnimationColor.value ?? Colors.transparent,
            width: 1.2);
      } else if (widget.shouldShowOutsideBorder) {
        outsideBorderSide = BorderSide(
            color: _focusBorderAnimationColor.value ?? Colors.transparent,
            width: 1.2);
      }
    } else if (widget.shouldShowOutsideBorder) {
      outsideBorderSide = BorderSide(
          width: 1.2,
          color: shouldValidateTextField && shouldShowError
              ? _errorBorderAnimationColor.value!
              : const Color(0xFFE0E0E0));
    } else if (widget.shouldShowInsideBorder) {
      insideBorderSide = BorderSide(
          width: 1.2,
          color: shouldValidateTextField && shouldShowError
              ? _errorBorderAnimationColor.value!
              : const Color(0xFFE0E0E0));
    }

    var content = IgnorePointer(
      ignoring: widget.isSelectable || widget.isDisabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.only(
              left: widget.padding?.left ?? 0.0,
              right: widget.padding?.right ?? 0.0,
              top: widget.padding?.top ?? 0.0,
            ),
            decoration: ShapeDecoration(
                color: widget.isDisabled && widget.shouldShowOutsideBorder
                    ? Colors.grey.shade200
                    : widget.backgroundColor,
                shadows: widget.shadows,
                shape: RoundedRectangleBorder(
                    side: outsideBorderSide,
                    borderRadius:
                        (widget.borderRadius!).toDouble().borderAll())),
            child: Column(
              children: [
                Row(
                  children: [
                    if (widget.prefixIcons.isNotEmpty &&
                        widget.shouldShowOutsideBorder)
                      Row(
                        children: widget.prefixIcons,
                      ).align(Alignment.centerLeft),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        VSpace(12.0),
                        _getTitleWidget(),
                        if (!widget.isExpanded || widget.shouldShowInsideBorder)
                          VSpace(4.0),
                        IntrinsicHeight(
                          child: TextField(
                            autocorrect: false,
                            autofocus: widget.autoFocus,
                            controller: textEditingController,
                            focusNode: _focusNode,
                            enabled: !widget.isDisabled,
                            keyboardType: widget.inputType,
                            expands: widget.isExpanded,
                            maxLines: widget.isExpanded ? null : 1,
                            onTapOutside: (_) => _focusNode.unfocus(),
                            inputFormatters: [
                              if (lengthLimiter != null)
                                LengthLimitingTextInputFormatter(
                                    lengthLimiter!.length),
                              ...widget.inputFormatters.where((element) =>
                                  element is! LengthLimitingTextInputFormatter),
                            ],
                            onChanged: (text) {
                              if (lengthLimiter != null) {
                                ref
                                    .read(lengthLimiter!
                                        .characterCountProvider.notifier)
                                    .state = text.length;
                              }

                              shouldValidateTextField = true;
                              validationResult =
                                  widget.validator?.call(text) ?? true;
                              widget.textFieldDidChange?.call(text);

                              if (_focusNode.hasFocus) {
                                _errorBorderAnimationController.reverse();
                                return;
                              }

                              if (widget.validator == null) {
                                return;
                              }

                              if (validationResult) {
                                _errorBorderAnimationController.reverse();
                              } else {
                                _errorBorderAnimationController.forward();
                              }
                            },
                            obscureText: widget.isObscureText,
                            textAlignVertical: widget.textAlignVertical ??
                                TextAlignVertical.center,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: widget.isDisabled &&
                                    widget.shouldShowInsideBorder,
                                fillColor: widget.isDisabled &&
                                        widget.shouldShowInsideBorder
                                    ? Colors.grey.shade200
                                    : Colors.transparent,
                                constraints: widget.constraints ??
                                    BoxConstraints.tightFor(
                                        height: widget.height),
                                contentPadding: EdgeInsets.only(
                                    top:
                                        widget.shouldShowOutsideBorder ? 8 : 14,
                                    bottom:
                                        widget.shouldShowOutsideBorder ? 0 : 14,
                                    left:
                                        widget.shouldShowOutsideBorder ? 0 : 12,
                                    right: widget.shouldShowOutsideBorder
                                        ? 0
                                        : 12),
                                alignLabelWithHint: true,
                                labelStyle: const TextStyle(
                                  color: Color(0xFF181818),
                                  fontSize: 14,
                                ),
                                hintText: widget.placeholder,
                                hintStyle: TextStyle(
                                  color:
                                      const Color(0xFF858585).withOpacity(0.8),
                                  fontSize: 14,
                                ),
                                prefixIcon: widget.shouldShowInsideBorder &&
                                        widget.prefixIcons.isNotEmpty
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (widget.prefixIcons.isNotEmpty)
                                            HSpace.h12,
                                        ],
                                      )
                                    : null,
                                suffixIcon: widget.shouldShowInsideBorder &&
                                        widget.suffixIcons.isNotEmpty
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ...widget.suffixIcons,
                                          if (widget.suffixIcons.isNotEmpty)
                                            HSpace.h12
                                        ],
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                    borderRadius: (widget.borderRadius!)
                                        .toDouble()
                                        .borderAll(),
                                    borderSide: insideBorderSide),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: (widget.borderRadius!)
                                        .toDouble()
                                        .borderAll(),
                                    borderSide: insideBorderSide),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: (widget.borderRadius!)
                                        .toDouble()
                                        .borderAll(),
                                    borderSide: insideBorderSide),
                                errorBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        (widget.borderRadius!).toDouble().borderAll(),
                                    borderSide: insideBorderSide)),
                          ),
                        ),
                      ],
                    ).expand(),
                    if (widget.suffixIcons.isNotEmpty &&
                        widget.shouldShowOutsideBorder)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: widget.suffixIcons,
                      ),
                  ],
                ),
                if (lengthLimiter != null &&
                    lengthLimiter!.canShowCharacterCount) ...[
                  Consumer(
                    builder: (context, provider, child) {
                      var characterCount =
                          provider.watch(lengthLimiter!.characterCountProvider);
                      var limit = lengthLimiter!.length;
                      var color = characterCount >= limit
                          ? Colors.red
                          : Colors.grey.shade600;
                      var text = "$characterCount/$limit";
                      return Text(
                        text,
                        style: conf.smallTextStyle.size(12).textColor(color),
                      );
                    },
                  ).rightCenter(),
                  VSpace.v6,
                ]
              ],
            ),
          ),
          if (shouldShowError) VSpace(4.0),
          Padding(
            padding: EdgeInsets.only(
              left: widget.padding?.left ?? 0.0,
              right: widget.padding?.right ?? 0.0,
              bottom: widget.padding?.bottom ?? 0.0,
            ),
            child: FadeTransition(
              opacity: _errorTextOpacityAnimation,
              child: Text(
                widget.errorText?.call() ?? "",
                style: conf.textFieldErrorTextStyle,
              ),
            ).visibility(shouldShowError),
          )
        ],
      ),
    );

    if (widget.isSelectable) {
      return CupertinoButton(
        onPressed: () {
          shouldValidateTextField = true;
          widget.onTapTextField?.call();
        },
        padding: EdgeInsets.zero,
        child: content,
      );
    }
    return content;
  }

  Widget _getTitleWidget() {
    if (canShowDefaultTitle) {
      return EasyRichText(
        widget.isRequired ? "${widget.title} *" : widget.title!,
        defaultStyle: conf.textFieldTitleTextStyle,
        patternList: [
          if (widget.isRequired)
            EasyRichTextPattern(
                targetString: "*",
                superScript: true,
                style: const TextStyle(color: Color(0xFFFF0000), fontSize: 16)
                    .weight(FontWeight.w500),
                hasSpecialCharacters: true)
        ],
      );
    } else if (canShowCustomTitle) {
      return widget.titleWidget!;
    }

    return const SizedBox.shrink();
  }
}

// ignore: must_be_immutable
class SelectableTextFieldView extends TextFieldView {
  SelectableTextFieldView(
      {super.key,
      super.title,
      super.placeholder,
      super.initialText,
      super.validator,
      super.isRequired = false,
      super.isDisabled = false,
      super.textEditingController,
      super.titleWidget,
      super.prefixIcons = const [],
      super.textFieldDidChange,
      super.errorText,
      super.inputType = TextInputType.text,
      super.onTapTextField,
      super.enableBy,
      super.height,
      super.backgroundColor,
      super.shouldShowInsideBorder,
      super.shadows,
      super.padding,
      super.shouldShowOutsideBorder,
      super.borderRadius,
      super.onInitializeErrorBorderAnimationController,
      super.onInitializeFocusedBorderAnimationController,
      super.hasTapOnTextFieldWhenSelectable})
      : super(isSelectable: true, suffixIcons: [
          const Icon(
            CupertinoIcons.chevron_down,
            size: 18.0,
            color: Colors.black87,
          ),
        ]);
}
