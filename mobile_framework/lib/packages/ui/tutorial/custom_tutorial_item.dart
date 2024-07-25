import 'package:flutter/cupertino.dart';
import 'package:mobile_framework/packages/ui/tutorial/tutorial.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomTutorialItem extends StatefulWidget {
  final int order;
  final Widget child;
  final Widget tutorialItem;
  final Size size;
  final ShapeBorder? shape;
  final bool shouldEnableBouncingAnimation;
  final bool shouldShowTutorialItem;

  @override
  State<CustomTutorialItem> createState() => _CustomTutorialItemState();

  const CustomTutorialItem({
    super.key,
    required this.order,
    required this.child,
    required this.size,
    required this.shouldShowTutorialItem,
    required this.tutorialItem,
    this.shouldEnableBouncingAnimation = true,
    this.shape,
  });
}

class _CustomTutorialItemState extends State<CustomTutorialItem> {
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

    return Showcase.withWidget(
        key:
            tutorialController.getGlobalKeyInOrder(widget.order) ?? GlobalKey(),
        toolTipSlideEndDistance: 3,
        targetShapeBorder: widget.shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
        movingAnimationDuration: const Duration(milliseconds: 1000),
        targetPadding: const EdgeInsets.symmetric(horizontal: 8),
        height: widget.size.height,
        width: widget.size.width,
        container: widget.tutorialItem,
        disableMovingAnimation: !widget.shouldEnableBouncingAnimation,
        child: widget.child);
  }
}
