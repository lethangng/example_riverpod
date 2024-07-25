import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class ImagesAssetsViewerDemoPage extends StatelessWidget
    with ImagesPickerCompatible, ImageSourceCompatible, PickerSettings {
  ImagesAssetsViewerDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImagesAssetsViewer'),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return CupertinoButton(
            onPressed: () {
              showImageSourceBottomSheet(
                context,
                onSelectImage: (result) {
                  print(result);
                },
                onSelectImages: (result) {
                  print(result);
                },
              );
            },
            child: const Text("Press to open images assets viewer"),
          );
        }),
      ),
    );
  }
}
