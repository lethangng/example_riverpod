// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:mobile_framework/packages/ui/widgets/v_space.dart';

class SeparatedColumn extends StatelessWidget {
  final List<Widget> children;
  final TextBaseline? textBaseline;
  final bool includeOuterSeparators;
  final TextDirection? textDirection;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  late IndexedWidgetBuilder separatorBuilder;

  SeparatedColumn({
    super.key,
    this.textBaseline,
    this.textDirection,
    this.children = const <Widget>[],
    this.includeOuterSeparators = false,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    IndexedWidgetBuilder? separatorBuilder,
  }) {
    this.separatorBuilder = separatorBuilder ?? (context, index) => VSpace.v8;
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

    return Column(
      key: key,
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
