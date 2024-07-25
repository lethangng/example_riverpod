import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/rich_text_editor/rich_text_editor_secondary_toolbar_view.dart';
import 'package:mobile_framework/packages/ui/rich_text_editor/rich_text_web_editor_controller.dart';

class RichTextEditorToolBarView extends StatefulWidget with GlobalThemePlugin {
  final RichTextWebEditorController controller;
  final FocusNode focusNode;

  @override
  State<RichTextEditorToolBarView> createState() =>
      _RichTextEditorToolBarViewState();

  const RichTextEditorToolBarView({
    super.key,
    required this.controller,
    required this.focusNode,
  });
}

class _RichTextEditorToolBarViewState extends State<RichTextEditorToolBarView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: 250.milliseconds);
  late Animation<double?> toolbarHeightAnimation;
  late Animation<Alignment> primaryToolbarAlignmentAnimation;

  late Function(bool isExpanded) isExpandedCallback = (bool isExpanded) {
    if (isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController.addListener(() {
      setState(() {});
    });

    toolbarHeightAnimation = Tween<double>(begin: 56, end: 56 * 2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    primaryToolbarAlignmentAnimation = Tween<Alignment>(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
          height: toolbarHeightAnimation.value,
          child: Stack(
            children: [
              RichTextEditorSecondaryToolBarView(
                controller: widget.controller,
              ).bottomCenter(),
              Align(
                alignment: primaryToolbarAlignmentAnimation.value,
                child: RichTextEditorPrimaryToolBarView(
                  controller: widget.controller,
                  isExpandedCallback: isExpandedCallback,
                  focusNode: widget.focusNode,
                ),
              ),
            ],
          ));
    });
  }
}
