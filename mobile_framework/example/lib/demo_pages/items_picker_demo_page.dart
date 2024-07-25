import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class ItemsPickerDemoPage extends StatelessWidget {
  const ItemsPickerDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ItemsPickerDemoPage'),
      ),
      body: Center(
        child: CupertinoButton(
          onPressed: () {
            context.showOverlay(ItemsPicker<SimplePickerItem>(
              onLoadItems: (page) async => [
                SimplePickerItem(title: 'item1'),
                SimplePickerItem(title: 'item2'),
                SimplePickerItem(title: 'item3'),
              ],
              title: 'Title',
            )
                // Container(
                //   width: context.width * 0.2,
                //   height: context.width * 0.2,
                //   color: Colors.red,
                //   child: Container(
                //     width: 20,
                //     height: 20,
                //     color: Colors.yellow,
                //   ),
                // ),
                );
          },
          child: const Text("Show items picker view"),
        ),
      ),
    );
  }
}
