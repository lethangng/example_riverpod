// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/widgets/seletable_text_editing_controller.dart';

class DatePickerTextFieldView extends StatefulWidget {
  final Function(DateTime? time) onConfirmSelectTime;
  final bool Function()? canOpenPicker;
  final DateTime? Function()? maxDate;
  final DateTime? Function()? minDate;
  final int? Function()? maxYear;
  final int? Function()? minYear;
  final DateTime? Function()? initialDateTime;
  final bool isDatePicker;

  final CupertinoDatePickerMode datePickerMode;

  final double height;
  final String? title;
  final String? placeholder;

  final bool isDisabled;
  final bool isRequired;

  final DateTimePickerTextEditingController? textEditingController;

  final Widget? titleWidget;
  final List<Widget> suffixIcons;
  final List<Widget> prefixIcons;

  final bool Function(String? text)? validator;
  final String Function()? errorText;

  final bool Function()? enableBy;
  final double borderRadius;
  final bool shouldShowOutsideBorder;
  final EdgeInsets? padding;
  final Color backgroundColor;
  late DateTimeFormatPattern pattern;

  DatePickerTextFieldView({
    super.key,
    required this.onConfirmSelectTime,
    this.canOpenPicker,
    this.maxDate,
    this.minDate,
    this.maxYear,
    this.minYear,
    this.initialDateTime,
    @Deprecated("Use datePickerMode instead") this.isDatePicker = true,
    this.datePickerMode = CupertinoDatePickerMode.date,
    this.height = 44,
    this.title,
    this.placeholder,
    this.isDisabled = false,
    this.isRequired = true,
    this.textEditingController,
    this.titleWidget,
    this.suffixIcons = const [],
    this.prefixIcons = const [],
    this.validator,
    this.errorText,
    this.enableBy,
    this.borderRadius = 16,
    this.shouldShowOutsideBorder = true,
    this.padding,
    this.backgroundColor = Colors.white,
    DateTimeFormatPattern? pattern,
  }) {
    switch (datePickerMode) {
      case CupertinoDatePickerMode.time:
        this.pattern = pattern ?? DateTimeFormatPattern.clock2;
      case CupertinoDatePickerMode.date:
        this.pattern = pattern ?? DateTimeFormatPattern.ddMMyyyy2;
      case CupertinoDatePickerMode.dateAndTime:
        this.pattern = pattern ?? DateTimeFormatPattern.hhMMddyyyy2;
      case CupertinoDatePickerMode.monthYear:
        this.pattern = pattern ?? DateTimeFormatPattern.MMyyyy;
    }
  }

  @override
  State<DatePickerTextFieldView> createState() =>
      _DatePickerTextFieldViewState();
}

class _DatePickerTextFieldViewState extends State<DatePickerTextFieldView> {
  late DateTimePickerTextEditingController textEditingController;
  DateTime? selectedDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textEditingController =
        widget.textEditingController ?? DateTimePickerTextEditingController();

    textEditingController.onClearSelectedDateTime = () {
      selectedDateTime = widget.initialDateTime?.call();
      textEditingController.text =
          selectedDateTime?.formatToString(pattern: widget.pattern) ?? "";
      setState(() {});
    };

    textEditingController.resetData();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldView(
      title: widget.title,
      placeholder: widget.placeholder ?? "Bấm để chọn",
      isDisabled: widget.isDisabled,
      isRequired: widget.isRequired,
      textEditingController: textEditingController,
      enableBy: widget.enableBy,
      isSelectable: true,
      borderRadius: widget.borderRadius,
      height: widget.height,
      shouldShowInsideBorder: !widget.shouldShowOutsideBorder,
      shouldShowOutsideBorder: widget.shouldShowOutsideBorder,
      padding: widget.padding,
      suffixIcons: const [
        Icon(
          Iconsax.calendar_1,
          size: 20.0,
          color: Colors.black87,
        ),
      ],
      onTapTextField: () {
        if (!(widget.canOpenPicker?.call() ?? true)) {
          return;
        }
        FocusScope.of(context).unfocus();
        selectedDateTime = widget.initialDateTime?.call();
        switch (widget.datePickerMode) {
          case CupertinoDatePickerMode.time:
            context.showOverlay(DateTimePicker.time(
                maxYear: widget.maxYear?.call(),
                minYear: widget.minYear?.call(),
                maxDate: widget.maxDate?.call(),
                minDate: widget.minDate?.call(),
                selectedDateTime: selectedDateTime,
                onConfirmSelectTime: (date) {
                  if (date == null) {
                    return;
                  }
                  textEditingController.text =
                      date.formatToString(pattern: widget.pattern) ?? "";
                  selectedDateTime = date;
                  widget.onConfirmSelectTime(date);
                }));
            break;
          case CupertinoDatePickerMode.date:
            context.showOverlay(DateTimePicker.date(
                maxYear: widget.maxYear?.call(),
                minYear: widget.minYear?.call(),
                maxDate: widget.maxDate?.call(),
                minDate: widget.minDate?.call(),
                selectedDateTime: selectedDateTime,
                onConfirmSelectTime: (date) {
                  if (date == null) {
                    return;
                  }
                  textEditingController.text =
                      date.formatToString(pattern: widget.pattern) ?? "";
                  selectedDateTime = date;
                  widget.onConfirmSelectTime(date);
                }));
            break;
          case CupertinoDatePickerMode.dateAndTime:
            context.showOverlay(DateTimePicker.dateAndTime(
                maxYear: widget.maxYear?.call(),
                minYear: widget.minYear?.call(),
                maxDate: widget.maxDate?.call(),
                minDate: widget.minDate?.call(),
                selectedDateTime: selectedDateTime,
                onConfirmSelectTime: (date) {
                  if (date == null) {
                    return;
                  }
                  textEditingController.text =
                      date.stringFormat(widget.pattern) ?? "";
                  selectedDateTime = date;
                  widget.onConfirmSelectTime(date);
                }));
            break;
          case CupertinoDatePickerMode.monthYear:
          // TODO: Handle this case.
        }
      },
    );
  }
}

class DateTimePickerTextEditingController
    extends SelectableTextEditingController {
  @protected
  late Function() onClearSelectedDateTime;

  @override
  void resetData() {
    onClearSelectedDateTime();
  }
}
