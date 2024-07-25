import 'package:flutter/material.dart';

class Rounded extends StatefulWidget {
  final double radius;
  final EdgeInsetsGeometry contentPadding;
  final Widget child;
  final Decoration decoration;

  @override
  State<Rounded> createState() => _RoundedState();

  const Rounded({
    super.key,
    this.radius = 8,
    this.contentPadding = const EdgeInsets.all(8),
    this.decoration = const BoxDecoration(
      color: Colors.white,
    ),
    required this.child,
  });
}

class _RoundedState extends State<Rounded> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(widget.radius),
      child: Container(
        padding: widget.contentPadding,
        decoration: widget.decoration,
        child: widget.child,
      ),
    );
  }
}
