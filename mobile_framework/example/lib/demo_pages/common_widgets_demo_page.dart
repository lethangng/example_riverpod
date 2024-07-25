import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/export.dart';
import 'package:mobile_framework/packages/ui/tutorial/custom_tutorial_item.dart';

class CommonWidgetsDemoPage extends StatefulWidget {
  const CommonWidgetsDemoPage({super.key});

  @override
  State<CommonWidgetsDemoPage> createState() => _CommonWidgetsDemoPageState();
}

class _CommonWidgetsDemoPageState extends State<CommonWidgetsDemoPage> {
  String get text =>
      isSelected ? "RadioButton is selected" : "RadioButton is not selected";
  bool isSelected = false;
  TutorialController tutorialController = TutorialController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTimeUtils.setSupportedLocaleMessages();

    return Scaffold(
        appBar: AppBar(
          title: const Text('CommonWidgetsDemoPage'),
        ),
        body: Tutorial(
          controller: tutorialController,
          onShowcaseFinished: () {},
          shouldEnableShowcase: true,
          onShowcaseStarted:
              (int? index, GlobalKey<State<StatefulWidget>> key) {},
          onCompleted: (int? index, GlobalKey<State<StatefulWidget>> key) {},
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(DateTimeUtils.stringFormatted(time: DateTime.now()) ?? ''),
                CustomTutorialItem(
                  order: 1,
                  shouldShowTutorialItem: true,
                  size: const Size(250, 100),
                  shouldEnableBouncingAnimation: false,
                  tutorialItem: Container(
                    color: Colors.red,
                    height: 100,
                    width: 250,
                    // child: const Text("Tutorial"),
                  ),
                  child: CommonWidgetDemoItem(
                      title: "RadioButton",
                      child: RadioButton(
                        size: 30,
                        onChanged: (isSelected) {
                          setState(() {
                            this.isSelected = isSelected;
                          });
                        },
                      )),
                ),
                CommonWidgetDemoItem(
                    title: "ImageView",
                    child: const ImageView(
                      url: "",
                      defaultPlaceholderSize: 30,
                    )),
                DescriptionTutorialItem(
                  order: 2,
                  description: 'Tap to open DateTimePicker',
                  shouldShowTutorialItem: true,
                  child: CommonWidgetDemoItem(
                    title: "DatePickerTextFieldView",
                    child: DatePickerTextFieldView(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      title: "Sample",
                      initialDateTime: () => DateTime.now(),
                      onConfirmSelectTime: (time) {},
                    ),
                  ),
                )
              ],
            ).defaultHorizontalPadding(),
          ),
        ));
  }
}

class CommonWidgetDemoItem extends StatelessWidget {
  Widget child;
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VSpace.v12,
        Text(title),
        VSpace.v8,
        child,
        VSpace.v12,
      ],
    );
  }

  CommonWidgetDemoItem({
    super.key,
    required this.title,
    required this.child,
  });
}
