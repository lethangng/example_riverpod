import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/utilities/character_length_limiter.dart';

class TextFieldViewDemoPage extends StatelessWidget {
  const TextFieldViewDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextFieldView'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Outside Border"),
            const SizedBox(height: 10),
            TextFieldView.outsideBorder(
              borderRadius: 16,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              title: "Sample",
              placeholder: "Placeholder",
              errorText: () => 'error text',
              lengthLimiter: CharacterLengthLimiter.code(),
              validator: (_) => false,
            ),
            const SizedBox(height: 20),
            const Text("Inside Border"),
            TextFieldView.insideBorder(
              title: "Sample",
              placeholder: "Placeholder",
              errorText: () => 'error text',
              validator: (_) => false,
            ),
            const SizedBox(height: 20),
            const Text("Outside Border for multiple lines"),
            const SizedBox(height: 10),
            TextFieldView.outsideBorder(
              borderRadius: 16,
              isExpanded: true,
              height: 200,
              textAlignVertical: TextAlignVertical.top,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              title: "Sample",
              placeholder: "Placeholder",
              errorText: () => 'error text',
              validator: (_) => false,
            ),
            const SizedBox(height: 20),
            const Text("Inside Border for multiple lines"),
            const SizedBox(height: 10),
            TextFieldView.insideBorder(
              borderRadius: 2,
              isExpanded: true,
              height: 200,
              textAlignVertical: TextAlignVertical.top,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              title: "Sample",
              placeholder: "Placeholder",
              errorText: () => 'error text',
              validator: (_) => false,
            ),
            VSpace.v20,
            const Text("DatePickerTextFieldView"),
            const SizedBox(height: 10),
            DatePickerTextFieldView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                title: "Sample",
                onConfirmSelectTime: (time) {}),
            VSpace.v20,
          ],
        ).defaultHorizontalPadding(),
      ),
    );
  }
}
