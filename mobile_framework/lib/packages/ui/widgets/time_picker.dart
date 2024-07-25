// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable
class DateTimePicker extends ConsumerStatefulWidget {
  final CupertinoDatePickerMode _mode;

  DateTime? selectedDateTime;
  Function(DateTime? selectedTime) onConfirmSelectTime;
  DateTime? maxDate;
  DateTime? minDate;
  int? maxYear;
  int? minYear;

  DateTimePicker.time({
    super.key,
    this.selectedDateTime,
    this.maxDate,
    this.minDate,
    this.maxYear,
    this.minYear,
    required this.onConfirmSelectTime,
  }) : _mode = CupertinoDatePickerMode.time;

  DateTimePicker.dateAndTime({
    super.key,
    this.selectedDateTime,
    this.maxDate,
    this.minDate,
    this.maxYear,
    this.minYear,
    required this.onConfirmSelectTime,
  }) : _mode = CupertinoDatePickerMode.dateAndTime;

  DateTimePicker.date({
    super.key,
    this.selectedDateTime,
    this.maxDate,
    this.minDate,
    this.maxYear,
    this.minYear,
    required this.onConfirmSelectTime,
  }) : _mode = CupertinoDatePickerMode.date;

  @override
  ConsumerState<DateTimePicker> createState() => _DPDateTimePickerState();
}

class _DPDateTimePickerState extends ConsumerState<DateTimePicker> {
  final pickerHeightProvider = StateProvider<double>((ref) => 0);

  String get title =>
      widget._mode == CupertinoDatePickerMode.time ? "Chọn giờ" : "Chọn ngày";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(pickerHeightProvider.notifier).state = 150;
    });

    if (widget.selectedDateTime != null) {
      return;
    }

    if (widget.maxYear != null && widget.maxDate == null) {
      widget.maxDate = DateTime(widget.maxYear!, 12, 31);
      widget.selectedDateTime = DateTime(widget.maxYear!);
    }

    if (widget.minYear != null && widget.minDate == null) {
      widget.minDate = DateTime(widget.minYear!);
      widget.selectedDateTime = DateTime(widget.maxYear!);
    }

    if (widget.maxDate != null && widget.minDate == null) {
      widget.selectedDateTime = widget.maxDate;
    }

    if (widget.minDate != null) {
      widget.selectedDateTime = widget.minDate;
    }

    widget.selectedDateTime ??= DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return PopupView(
        width: context.width * 0.8,
        cornerRadius: 24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VSpace.v12,
            Text(
              title,
              style: ref.theme.datePickerTitleTextStyle,
            ),
            VSpace.v12,
            AnimatedSize(
              duration: const Duration(milliseconds: 270),
              curve: Curves.fastOutSlowIn,
              child: SizedBox(
                height: ref.watch(pickerHeightProvider),
                child: CupertinoDatePicker(
                  use24hFormat: true,
                  maximumYear: widget.maxYear ?? 2099,
                  minimumYear: widget.minYear ?? 1900,
                  maximumDate: widget.maxDate,
                  minimumDate: widget.minDate,
                  initialDateTime: widget.selectedDateTime,
                  dateOrder: DatePickerDateOrder.dmy,
                  backgroundColor: Colors.white,
                  mode: widget._mode,
                  onDateTimeChanged: (value) {
                    widget.selectedDateTime = value;
                  },
                ),
              ),
            ),
            VSpace.v8,
            Column(
              children: [
                LineSeparator(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.zero,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.popRoute();
                      },
                      child: Text(
                        "Thoát",
                        style: ref.theme.datePickerCancelTextStyle,
                      ).center(),
                    ).box(h: 46.0).expand(),
                    Container(
                        height: 46.0, color: Colors.grey.shade200, width: 1),
                    TextButton(
                      onPressed: () {
                        widget.onConfirmSelectTime(widget.selectedDateTime);
                        context.popRoute();
                      },
                      child: Text(
                        "Xác nhận",
                        style: ref.theme.datePickerConfirmTextStyle,
                      ).center(),
                    ).box(h: 46.0).expand(),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
