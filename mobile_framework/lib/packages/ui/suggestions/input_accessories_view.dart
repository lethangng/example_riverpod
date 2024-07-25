import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

enum InputAccessoryViewSuggestionDirection { up, down }

class InputAccessoryView<T extends SuggestionItem> extends StatefulWidget {
  Future<List<T>> Function(int page, String query) onLoadSuggestions;
  Function(List<T> suggestions)? onUpdateSuggestions;

  Widget Function(BuildContext context, T item) suggestionItemBuilder;
  Widget Function(BuildContext context,
      InputAccessoryTextEditingController controller, Key key) textFieldBuilder;
  InputAccessoryViewConfig config;
  InputAccessoryTextEditingController<T> controller;
  String initialText;

  @override
  State<InputAccessoryView<T>> createState() => _InputAccessoryViewState<T>();

  InputAccessoryView({
    super.key,
    required this.onLoadSuggestions,
    required this.suggestionItemBuilder,
    required this.textFieldBuilder,
    required this.controller,
    this.initialText = "",
    InputAccessoryViewConfig? config,
    this.onUpdateSuggestions,
  }) : config = config ?? InputAccessoryViewConfig();
}

class _InputAccessoryViewState<T extends SuggestionItem>
    extends State<InputAccessoryView<T>> with SingleTickerProviderStateMixin {
  late Animation<double> opacityAnimation;
  late AnimationController suggestionOpacityAnimationController =
      AnimationController(
    vsync: this,
    duration: 200.milliseconds,
  );

  TableViewController tableViewController = TableViewController();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  InputAccessoryViewSuggestionDirection suggestionDirection =
      InputAccessoryViewSuggestionDirection.up;

  GlobalKey textFieldViewKey = GlobalKey();

  StreamSubscription? keyboardVisibilitySubscription;
  KeyboardHeightPlugin keyboardHeightPlugin = KeyboardHeightPlugin();

  double maxHeight = 0;
  double keyboardHeight = 0;
  double textFieldViewHeight = 0;

  double get minSuggestionHeight => 200;

  double get screenHeight => MediaQuery.of(context).size.height;

  double get topSuggestionDy {
    if (textFieldViewKey.currentContext == null) return 0;

    var renderBox =
        textFieldViewKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero).dy ?? 0;
  }

  double get bottomSuggestionsDy => topSuggestionDy + textFieldViewHeight;

  double get remainingTopSpaceForSuggestionView {
    return topSuggestionDy;
  }

  double get remainingBottomSpaceForSuggestionView =>
      max(0, screenHeight - bottomSuggestionsDy - keyboardHeight);

  double get spaceCutByTopAndBottomOfSuggestionView =>
      widget.config.suggestionViewPadding.top +
      widget.config.suggestionViewPadding.bottom;

  double get spaceForSuggestionView =>
      suggestionDirection == InputAccessoryViewSuggestionDirection.up
          ? remainingTopSpaceForSuggestionView
          : remainingBottomSpaceForSuggestionView;

  late StringDebouncer debouncer = StringDebouncer.miliseconds(
    onValue: (value) {
      if (_textEditingController.isSuggestionEnabled()) {
        _textEditingController.openSuggestions();
        tableViewController.refresh();
      }
    },
  );

  late InputAccessoryTextEditingController<T> _textEditingController;

  @override
  void initState() {
    super.initState();

    _setupSuggestionTextEditingController();

    _setupKeyboardAndAnimations();

    _updateSuggestionViewDirection();
  }

  void _setupKeyboardAndAnimations() {
    keyboardVisibilitySubscription =
        keyboardVisibilityController.onChange.listen((isVisible) async {
      if (!widget.config.shouldHideSuggestionsOnKeyboardHide) {
        return;
      }
      _textEditingController.shouldEnableSuggestion.value =
          isVisible & _textEditingController.isSuggestionEnabled();
    });

    suggestionOpacityAnimationController.addListener(() {
      setState(() {});
    });

    suggestionOpacityAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.reverse &&
          suggestionDirection == InputAccessoryViewSuggestionDirection.up) {
        draggableScrollableController.reset();
      }
    });

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: suggestionOpacityAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    keyboardHeightPlugin.onKeyboardHeightChanged(
      (height) {
        keyboardHeight = max(0, height);
      },
    );
  }

  void _setupSuggestionTextEditingController() {
    _textEditingController = widget.controller
      ..setUpdateSuggestions(widget.onUpdateSuggestions)
      ..suggestionSettings = widget.config.suggestionSettings
      ..resetText(widget.initialText)
      ..shouldEnableSuggestion.addListener(() async {
        if (_textEditingController.shouldEnableSuggestion.value) {
          await suggestionOpacityAnimationController.forward();
        } else {
          await suggestionOpacityAnimationController.reverse();
        }
      })
      ..setDebouncer(debouncer);
  }

  @override
  void dispose() {
    keyboardVisibilitySubscription?.cancel();
    suggestionOpacityAnimationController.dispose();
    draggableScrollableController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textFieldView = widget.textFieldBuilder(
        context, _textEditingController, textFieldViewKey);

    return PortalTarget(
        fit: StackFit.loose,
        visible: true,
        portalFollower: TapRegion(
          onTapOutside: (event) {
            _textEditingController.closeSuggestions();
          },
          child: IgnorePointer(
            ignoring: !(_textEditingController.shouldEnableSuggestion.value),
            child: Opacity(
              opacity: opacityAnimation.value,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: min(
                        max(
                            spaceForSuggestionView -
                                kToolbarHeight -
                                MediaQuery.of(context).viewPadding.top +
                                spaceCutByTopAndBottomOfSuggestionView,
                            0),
                        maxHeight)),
                child: _getSuggestionViewDependedOnDirection(),
              ),
            ),
          ),
        ),
        anchor: switch (suggestionDirection) {
          InputAccessoryViewSuggestionDirection.up => const Aligned(
              follower: Alignment.bottomCenter,
              target: Alignment.topCenter,
            ),
          InputAccessoryViewSuggestionDirection.down => const Aligned(
              follower: Alignment.topCenter,
              target: Alignment.bottomCenter,
            )
        },
        child: MeasureSizeBuilder(
          builder: (context) {
            return textFieldView;
          },
          debugLabel: "InputAccessoryView.TextField",
          onSizeChanged: (Size size) {
            textFieldViewHeight = size.height;
            setState(() {});
          },
        )).center();
  }

  /// if direction is up, therefore we can use a [DraggableScrollableSheet]
  /// but if direction is down, we should use a normal [TableView]
  Widget _getSuggestionViewDependedOnDirection() {
    Widget tableView([ScrollController? controller]) => Padding(
          padding: widget.config.suggestionViewPadding,
          child: Container(
            decoration: widget.config.suggestionViewDecoration,
            child: TableView<T>(
                initialRefresh: false,
                controller: tableViewController,
                scrollController: controller,
                padding: widget.config.suggestionListViewPadding,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                onLoadItems: (page) {
                  return widget
                      .onLoadSuggestions(
                          page,
                          _textEditingController.currentSuggestionQueryText ??
                              "")
                      .then(
                    (value) {
                      if (value.isEmpty) {
                        _textEditingController.closeSuggestions();
                      }
                      return value;
                    },
                  );
                },
                shouldFollowTotalItemsHeight: true,
                onHeightChanged: (newHeight) {
                  maxHeight =
                      newHeight + spaceCutByTopAndBottomOfSuggestionView;
                  setState(() {});
                },
                tableViewItemBuilder: (tableViewItem) {
                  return CupertinoButton(
                      key: tableViewItem.key,
                      padding: EdgeInsets.zero,
                      child: widget.suggestionItemBuilder(
                          context, tableViewItem.item),
                      onPressed: () {
                        _textEditingController
                            .addSuggestion(tableViewItem.item);
                      });
                }),
          ),
        );

    draggableScrollableController = DraggableScrollableController();

    return suggestionDirection == InputAccessoryViewSuggestionDirection.up
        ? DraggableScrollableSheet(
            controller: draggableScrollableController,
            snap: false,
            initialChildSize: 1,
            minChildSize: 0.5,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return tableView(scrollController);
            },
          )
        : tableView();
  }

  void _updateSuggestionViewDirection() {
    Future.microtask(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            if (!mounted) return;

            if (remainingTopSpaceForSuggestionView < minSuggestionHeight) {
              suggestionDirection = InputAccessoryViewSuggestionDirection.down;
            } else if (remainingBottomSpaceForSuggestionView <
                minSuggestionHeight) {
              suggestionDirection = InputAccessoryViewSuggestionDirection.up;
            }
            setState(() {});
          },
        );
      },
    );
  }
}
