import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class RadioButton extends ConsumerStatefulWidget {
  double size;
  bool isSelected;
  Function(bool isSelected) onChanged;

  @override
  ConsumerState createState() => _RadioButtonState();

  RadioButton({
    super.key,
    this.size = 30,
    this.isSelected = false,
    required this.onChanged,
  });
}

class _RadioButtonState extends ConsumerState<RadioButton> {
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant RadioButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSelected != widget.isSelected) {
      isSelected = widget.isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onChanged(isSelected);
        });
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? ref.theme.mainColor : const Color(0xffD8D8D8),
            width: 2,
          ),
        ),
        child: isSelected
            ? Container(
                width: widget.size - 12,
                height: widget.size - 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ref.theme.mainColor,
                ),
              ).center()
            : null,
      ),
    );
  }
}
