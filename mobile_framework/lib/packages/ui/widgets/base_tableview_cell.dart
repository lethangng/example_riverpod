// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable
class BaseTableViewCell extends StatefulWidget {
  final List<SwipeAction> rightActions;
  final List<SwipeAction> leftActions;
  final Color backgroundColor = Colors.white;
  final Widget child;

  int? index;
  SwipeActionController? swipeActionController;

  BaseTableViewCell({
    super.key,
    this.index,
    this.swipeActionController,
    this.rightActions = const [],
    this.leftActions = const [],
    required this.child,
  });

  @override
  State<BaseTableViewCell> createState() => _BaseTableViewCellState();
}

class _BaseTableViewCellState extends State<BaseTableViewCell> {
  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(hashCode),
      leadingActions: widget.leftActions,
      trailingActions: widget.rightActions,
      backgroundColor: widget.backgroundColor,
      selectedForegroundColor: Colors.black12,
      controller: widget.swipeActionController,
      index: widget.index,
      isDraggable:
          widget.rightActions.isNotEmpty || widget.leftActions.isNotEmpty,
      child: widget.child,
    );
  }
}

class TutorialTableViewCell extends StatefulWidget {
  final List<SwipeAction> rightActions;
  final List<SwipeAction> leftActions;
  final Color backgroundColor;
  final Widget child;
  final int? index;
  final String description;
  final bool Function() shouldEnableShowcase;
  final Function() onFinishedTutorial;

  @override
  State<TutorialTableViewCell> createState() => _TutorialTableViewCellState();

  const TutorialTableViewCell({
    super.key,
    this.rightActions = const [],
    this.leftActions = const [],
    required this.child,
    required this.shouldEnableShowcase,
    required this.description,
    required this.onFinishedTutorial,
    this.backgroundColor = Colors.white,
    this.index,
  });
}

class _TutorialTableViewCellState extends State<TutorialTableViewCell> {
  SwipeActionController swipeActionController = SwipeActionController();
  TutorialController tutorialController = TutorialController();

  bool get shouldShowTutorialItem => widget.index == 0;

  @override
  Widget build(BuildContext context) {
    return Tutorial(
        controller: tutorialController,
        onShowcaseFinished: () {
          swipeActionController.closeAllOpenCell();
        },
        shouldEnableShowcase: widget.shouldEnableShowcase(),
        onShowcaseStarted: (int? index, GlobalKey<State<StatefulWidget>> key) {
          if (shouldShowTutorialItem && widget.shouldEnableShowcase()) {
            Future.delayed(1.seconds, () {
              swipeActionController.openCellAt(index: 0, trailing: true);
            });
          }
        },
        onCompleted: (int? index, GlobalKey<State<StatefulWidget>> key) {
          swipeActionController.closeAllOpenCell();
          widget.onFinishedTutorial();
        },
        child: DescriptionTutorialItem(
          description: widget.description,
          order: widget.index ?? 0,
          shouldShowTutorialItem: shouldShowTutorialItem,
          child: BaseTableViewCell(
            swipeActionController: swipeActionController,
            index: widget.index,
            leftActions: widget.leftActions,
            rightActions: widget.rightActions,
            child: widget.child,
          ),
        ));
  }
}
