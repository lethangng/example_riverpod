// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:mobile_framework/packages/ui/widgets/h_space.dart';

class SeparatedRow extends StatelessWidget {
  final List<Widget> children;
  final TextBaseline? textBaseline;
  final bool includeOuterSeparators;
  final TextDirection? textDirection;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  late IndexedWidgetBuilder separatorBuilder;
  final Key? rowKey;

  SeparatedRow({
    Key? key,
    this.textBaseline,
    this.textDirection,
    this.children = const <Widget>[],
    this.includeOuterSeparators = false,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    IndexedWidgetBuilder? separatorBuilder,
  }) : rowKey = key {
    this.separatorBuilder = separatorBuilder ?? (context, index) => HSpace.h8;
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final index = includeOuterSeparators ? 1 : 0;

    if (this.children.isNotEmpty) {
      if (includeOuterSeparators) {
        children.add(separatorBuilder(context, 0));
      }

      for (int i = 0; i < this.children.length; i++) {
        children.add(this.children[i]);

        if (this.children.length - i != 1) {
          children.add(separatorBuilder(context, i + index));
        }
      }

      if (includeOuterSeparators) {
        children.add(separatorBuilder(context, this.children.length));
      }
    }

    return Row(
      key: rowKey,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
