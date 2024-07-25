import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class TableViewDemoPage extends StatelessWidget {
  const TableViewDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TableView'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TableView<int>(
            onLoadItems: (int page) async {
              return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
            },
            itemBuilder: (item) {
              return ListTile(
                title: Text(item.toString()),
              );
            },
          ).expand(),
        ],
      ),
    );
  }
}
