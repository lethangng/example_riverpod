// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable
class NumpadInputView extends ConsumerStatefulWidget {
  final String title;
  final bool isDecimal;
  final Function(double result, String resultText) onConfirm;

  Function()? onViewDispose;
  late NumpadInputProcessor processor;

  NumpadInputView.decimal({
    super.key,
    required this.title,
    required this.onConfirm,
    double? minValue,
    double? maxValue,
    double? currentValue,
    int maxDecimalLength = 1,
    this.onViewDispose,
  })  : isDecimal = true,
        processor = NumpadInputProcessor(
            maxDecimalLength: maxDecimalLength,
            minimumValue: minValue ?? 0,
            maximumValue: maxValue ?? 999999999,
            result: currentValue ?? (minValue ?? 0));

  NumpadInputView.normal({
    super.key,
    required this.title,
    required this.onConfirm,
    double? minValue,
    double? maxValue,
    double? currentValue,
    this.onViewDispose,
  })  : isDecimal = false,
        processor = NumpadInputProcessor(
          minimumValue: minValue ?? 0,
          maximumValue: maxValue ?? 999999999,
          result: currentValue ?? (minValue ?? 0),
        );

  @override
  ConsumerState<NumpadInputView> createState() => _NumpadInputViewState();
}

class _NumpadInputViewState extends ConsumerState<NumpadInputView> {
  late final numberProcessorProvider =
      StateNotifierProvider.autoDispose<NumpadInputProcessor, String>((ref) {
    return widget.processor;
  });

  List<String> get numpads => [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "000",
        "0",
        "",
      ];

  List<String> get decimalNumpads => [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        ",",
        "0",
        "",
      ];

  List<String> get pads => widget.isDecimal ? decimalNumpads : numpads;

  @override
  Widget build(BuildContext context) {
    return PopupView(
        cornerRadius: 24,
        backgroundColor: Colors.white,
        width: 290.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VSpace.v16,
            Text(
              widget.title,
              style: ref.theme.numpadTitleTextStyle,
            ).fontWeight(FontWeight.w500).fontSize(17),
            VSpace.v16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HSpace(40.0),
                ResultTextField(
                        text: ref.watch(numberProcessorProvider),
                        isError: widget.processor.isError.stream)
                    .expand(),
                SizedBox(
                  height: 30.0,
                  width: 40.0,
                  child: Icon(
                    CupertinoIcons.clear_circled_solid,
                    size: 16.0,
                    color: Colors.grey.shade500,
                  ).onTapWidget(radius: 15.0, () {
                    widget.processor.onTapDeleteAll();
                  }).paddingOnly(right: 8.0),
                )
              ],
            ),
            VSpace.v10,
            LineSeparator(
              color: Colors.grey.shade200,
              margin: EdgeInsets.zero,
              height: 0.8,
            ),
            Container(
              color: Colors.grey.shade100,
              // height: 120.0,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: numpads.length,
                gridDelegate: const FixedHeightSliverGridDelegate(
                    height: 54.0,
                    crossAxisCount: 3,
                    mainAxisSpacing: 0.8,
                    crossAxisSpacing: 0.8),
                itemBuilder: (context, index) => NumpadItem(
                  index: index,
                  title: pads[index],
                  onPressed: (isClearRightValueButton) {
                    if (isClearRightValueButton) {
                      ref.read(numberProcessorProvider.notifier).onTapClear();
                    } else {
                      ref
                          .read(numberProcessorProvider.notifier)
                          .onTapNumpad(pads[index]);
                    }
                  },
                ),
              ),
            ),
            Column(
              children: [
                LineSeparator(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.zero,
                  height: 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await context.popRoute();
                      },
                      child: Text(
                        "Thoát",
                        style: ref.theme.numpadCancelTextStyle,
                      ).center(),
                    ).box(h: 54.0).expand(),
                    Container(
                        height: 54.0, color: Colors.grey.shade200, width: 1),
                    TextButton(
                      onPressed: () async {
                        if (widget.processor.checkCanConfirm()) {
                          await context.popRoute();
                          widget.onConfirm(widget.processor.result,
                              widget.processor.resultString);
                        }
                      },
                      child: Text(
                        "Xác nhận",
                        style: ref.theme.numpadConfirmTextStyle,
                      ).center(),
                    ).box(h: 54.0).expand(),
                  ],
                )
              ],
            )
          ],
        ));
  }
}

class NumpadItem extends StatelessWidget {
  final String title;
  final int index;
  final Function(bool) onPressed;

  const NumpadItem({
    super.key,
    required this.index,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var isClearRightValueButton = index == 11;

    return Container(
        color: Colors.white,
        child: (isClearRightValueButton
                ? GlobalThemeConfiguration.of(context)?.numpadClearButton ??
                    const SizedBox.shrink()
                : Text(title,
                    style: GlobalThemeConfiguration.of(context)
                        ?.numpadItemTextStyle))
            .center()
            .onTapWidget(() {
          onPressed(index == 11);
        }));
  }
}

class NumpadInputProcessor extends StateNotifier<String> {
  double maximumValue;
  double minimumValue;
  int maxDecimalLength = 1;
  double result = 0;
  StreamController<bool> isError = StreamController();

  var resultString = "0";
  var shouldClearInitialText = true;

  String get formatPattern {
    if (isDecimal) {
      return "#,##0.0${"#" * (maxDecimalLength - 1)}";
    }
    return "#,##0.${"#" * maxDecimalLength}";
  }

  bool get isDecimal => resultString.contains(",");

  NumpadInputProcessor(
      {required this.maximumValue,
      required this.minimumValue,
      required this.result,
      this.maxDecimalLength = 1})
      : super('') {
    resultString = result.format(formatPattern, locale: "vi_VN");
    state = resultString;
  }

  bool checkCanConfirm() {
    if (result < minimumValue) {
      result = minimumValue;
      _updateOutput();
      isError.add(true);
      return false;
    }

    resultString = result.format(formatPattern, locale: "vi_VN");

    return true;
  }

  void onTapNumpad(String value) {
    if (_checkMaximumDecimalLength()) {
      isError.add(true);
      return;
    }

    _clearResultString(value);

    if (resultString.contains(",") && value == ",") {
      return;
    }

    resultString += value;

    if (value == "," || (isDecimal && value == "0")) {
      state = resultString;
      return;
    }
    _parseResultString();
  }

  void _parseResultString() {
    var tempResultString = "";
    var tempResult = 0.0;

    tempResultString += resultString;
    tempResultString = tempResultString.replaceAll(".", "");

    if (resultString.contains(",")) {
      tempResultString = tempResultString.replaceAll(",", ".");
    }

    tempResult = double.tryParse(tempResultString) ?? tempResult;

    if (tempResult <= maximumValue) {
      result = tempResult;
    } else {
      isError.add(true);
      result = maximumValue;
    }

    _updateOutput();
  }

  void _clearResultString(String inputValue) {
    if (inputValue == ",") {
      return;
    }

    if (shouldClearInitialText) {
      shouldClearInitialText = false;
      resultString = "";
    }
  }

  void onTapDeleteAll() {
    resultString = "0";
    _parseResultString();
  }

  void onTapClear() {
    shouldClearInitialText = false;
    // if (resultString == minimumValue.toInt().toString()) {
    //   return;
    // }

    if (resultString.length >= 2) {
      resultString = resultString.substring(0, resultString.length - 1);
    } else {
      resultString = "0";
    }

    if (resultString.characters.last == "0") {
      state = resultString;
    }

    if (resultString.characters.last == ",") {
      resultString = resultString.removeCharacter(",");
      state = resultString;
    }

    _parseResultString();
  }

  void _updateOutput() {
    resultString = result.format(formatPattern, locale: "vi_VN");
    state = resultString;
  }

  bool _checkMaximumDecimalLength() {
    if (shouldClearInitialText) {
      return false;
    }
    if (resultString.contains(",")) {
      return resultString.split(",").last.length == maxDecimalLength;
    } else {
      return false;
    }
  }
}

// ignore: must_be_immutable
class ResultTextField extends StatefulWidget {
  String text;
  Stream<bool> isError;

  ResultTextField({
    super.key,
    required this.text,
    required this.isError,
  });

  @override
  State<ResultTextField> createState() => _ResultTextFieldState();
}

class _ResultTextFieldState extends State<ResultTextField>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 50), vsync: this);
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = ColorTween(begin: const Color(0xFF181818), end: Colors.red)
        .animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
    controller.forward();

    widget.isError.listen((isError) {
      if (isError) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      expands: false,
      maxLines: 1,
      decoration: InputDecoration(
          label: Text(widget.text,
                  style: GlobalThemeConfiguration.of(context)
                      ?.numpadValueTextStyle)
              .textColor(animation.value!)
              .center(),
          border: InputBorder.none),
    ).box(h: 44.0);
  }
}
