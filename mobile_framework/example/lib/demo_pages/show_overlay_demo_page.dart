import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class ShowOverlayDemoPage extends StatelessWidget {
  const ShowOverlayDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Overlay Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.showOverlay(
                dismissible: true,
                PopupView(
                  width: context.width * .85,
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ),
                  ),
                ));
          },
          child: const Text('Show Overlay'),
        ),
      ),
    );
  }
}
