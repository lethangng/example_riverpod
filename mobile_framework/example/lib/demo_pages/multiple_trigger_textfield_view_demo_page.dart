import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class MultipleTriggerTextFieldViewDemoPage extends StatefulWidget {
  const MultipleTriggerTextFieldViewDemoPage({super.key});

  @override
  State<MultipleTriggerTextFieldViewDemoPage> createState() =>
      _MultipleTriggerTextFieldViewDemoPageState();
}

class _MultipleTriggerTextFieldViewDemoPageState
    extends State<MultipleTriggerTextFieldViewDemoPage> {
  late InputAccessoryTextEditingController<DefaultSuggestionItem>
      textEditingController =
      InputAccessoryTextEditingController<DefaultSuggestionItem>(
          textParser: const DefaultInputAccessoryViewTextParser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MultipleTriggerTextFieldView"),
        ),
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
                child: const Text("Reset text"),
                onPressed: () {
                  textEditingController
                      .resetText("@[Item 1](1) oke @[Item 2](2)");
                }),
            InputAccessoryView<DefaultSuggestionItem>(
              controller: textEditingController,
              onUpdateSuggestions: (suggestions) {
                print(textEditingController.suggestionText);
              },
              onLoadSuggestions: (page, query) async {
                // return [];
                return [
                  DefaultSuggestionItem(
                    title: "Item 1",
                    data: '1',
                  ),
                  DefaultSuggestionItem(
                    title: "Item 1",
                    data: '1',
                  ),
                  DefaultSuggestionItem(
                    title: "Item 1",
                    data: '1',
                  ),
                  DefaultSuggestionItem(
                    title: "Item 1",
                    data: '1',
                  ),
                  DefaultSuggestionItem(
                    title: "Item 1",
                    data: '1',
                  ),
                  // DefaultSuggestionItem(
                  //   title: "Item 1",
                  //   data: '1',
                  // ),
                  // DefaultSuggestionItem(
                  //   title: "Item 1",
                  //   data: '1',
                  // ),
                ];
              },
              config: InputAccessoryViewConfig(
                shouldHideSuggestionsOnKeyboardHide: false,
                // suggestionViewDecoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(16),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black.withOpacity(0.1),
                //       blurRadius: 8,
                //       offset: const Offset(0, 2),
                //     ),
                //   ],
                // ),
                // suggestionViewPadding: const EdgeInsets.all(16)
              ),
              suggestionItemBuilder: (BuildContext context, item) {
                return Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  child: Text(item.title).paddingAll(12),
                );
              },
              textFieldBuilder: (BuildContext context,
                  InputAccessoryTextEditingController controller, Key key) {
                return TextFieldView.outsideBorder(
                  key: key,
                  textEditingController: controller,
                  textFieldDidChange: (text) {
                    controller.onChanged(text ?? "");
                  },
                  constraints: const BoxConstraints(
                    minHeight: 48,
                  ),
                  isExpanded: true,
                  textAlignVertical: TextAlignVertical.top,
                  borderRadius: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  title: "xxx",
                  placeholder: "yyy",
                )
                    .bottomCenter()
                    .paddingOnly(bottom: context.includeBottomPadding(12));
              },
              // initialText: "@[Item 1](1) oke @[Item 2](2)",
              initialText: "",
            ),
          ],
        ).defaultHorizontalPadding());
  }
}
