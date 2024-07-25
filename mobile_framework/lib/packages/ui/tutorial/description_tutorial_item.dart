import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:showcaseview/showcaseview.dart';

class DescriptionTutorialItem extends StatefulWidget {
  final int order;
  final Widget child;
  final String? title;
  final String description;
  final ShapeBorder? shape;
  final bool shouldEnableBouncingAnimation;
  final bool shouldShowTutorialItem;
  final EdgeInsets targetPadding;

  @override
  State<DescriptionTutorialItem> createState() =>
      _DescriptionTutorialItemState();

  const DescriptionTutorialItem({
    super.key,
    required this.order,
    required this.child,
    required this.description,
    required this.shouldShowTutorialItem,
    this.targetPadding = EdgeInsets.zero,
    this.shouldEnableBouncingAnimation = true,
    this.shape,
    this.title,
  });
}

class _DescriptionTutorialItemState extends State<DescriptionTutorialItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    var tutorialController = Tutorial.of(context).controller;
    if (widget.shouldShowTutorialItem) {
      tutorialController.addOrder(widget.order);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.shouldShowTutorialItem) {
      return widget.child;
    }

    var tutorialController = Tutorial.of(context).controller;

    return Showcase(
      key: tutorialController.getGlobalKeyInOrder(widget.order) ?? GlobalKey(),
      scaleAnimationCurve: Curves.fastOutSlowIn,
      toolTipSlideEndDistance: 3,
      tooltipPadding: const EdgeInsets.all(16),
      targetPadding: widget.targetPadding,
      targetShapeBorder: widget.shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
      scaleAnimationDuration: const Duration(milliseconds: 250),
      movingAnimationDuration: const Duration(milliseconds: 1000),
      title: widget.title,
      description: widget.description,
      disableMovingAnimation: !widget.shouldEnableBouncingAnimation,
      child: widget.child,
    );
  }
}
