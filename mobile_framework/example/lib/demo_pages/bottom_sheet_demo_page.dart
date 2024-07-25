import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class BottomSheetDemoPage extends ConsumerWidget {
  const BottomSheetDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InteractiveSheet"),
      ),
      body: Column(
        children: [
          CupertinoButton(
            onPressed: () {
              context.showInteractiveSheet(InteractiveSheet.fixedContent(
                Container(
                  color: Colors.white,
                  height: context.height * .8,
                  // width: context.width,
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Item $index"),
                            onTap: () {
                              print("Item $index pressed");
                            },
                          );
                        },
                      ).expand()
                    ],
                  ),
                ),
              ));
            },
            child: const Text("Content growable sheet"),
          ).center(),
          VSpace.v6,
          CupertinoButton(
            onPressed: () {
              InteractiveSheet.growableList(
                isFloating: false,
                items: [
                  InteractiveListItem.normal(
                      title: "Item 1",
                      onPressed: () {
                        print("Item 1 pressed");
                      }),
                  InteractiveListItem.normal(
                      title: "Item 2",
                      onPressed: () {
                        print("Item 2 pressed");
                      })
                ],
                onItemPressed: (index) {
                  print("Item $index pressed");
                },
              ).show();
            },
            child: const Text("Press to show botom sheet"),
          ).center(),
        ],
      ),
    );
  }
}
