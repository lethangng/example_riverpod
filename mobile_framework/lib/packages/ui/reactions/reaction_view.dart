import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class ReactionBuilder extends StatefulWidget {
  final List<ReactionType> supportedReactions;
  final Function(ReactionType type) onSelectReaction;
  final ReactionSoundPlayerDelegate? soundPlayerDelegate;
  final Offset reactionBarOffset;
  final Size size;
  final ReactionType initialReactionType;
  final Widget Function(BuildContext context, ReactionType type) builder;

  const ReactionBuilder({
    super.key,
    List<ReactionType>? supportedReactions,
    required this.onSelectReaction,
    required this.builder,
    required this.size,
    this.soundPlayerDelegate,
    this.reactionBarOffset = const Offset(0, 0),
    this.initialReactionType = ReactionType.unselected,
  }) : supportedReactions = supportedReactions ?? ReactionType.values;

  @override
  State<ReactionBuilder> createState() => _ReactionBuilderState();
}

class _ReactionBuilderState<T> extends State<ReactionBuilder>
    with TickerProviderStateMixin {
  final double _reactSize = 36;
  final double _reactMargin = 4;
  final double _reactBarBotMargin = 22;
  final double _reactBarPadding = 4;
  final double _reactItemTitleHeight = 30;
  final List<Reaction> _reactions = [];
  final ReactionItem item = ReactionItem();

  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _reactController;
  late Animation<double> _reactAnimation;

  LongPressStartDetails _currentReactItemPositionDetail =
      const LongPressStartDetails();

  bool shouldShowReactionBar = false;
  int _reactSelected = -1;

  double get reactSize => _reactSize + _reactMargin * 2;

  double get reactScale => 1.2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initReactions();
    var itemDuration = const Duration(milliseconds: 300);
    _animationController =
        AnimationController(vsync: this, duration: itemDuration);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
    var reactDuration = const Duration(milliseconds: 1000);
    _reactController =
        AnimationController(vsync: this, duration: reactDuration);
    _reactAnimation =
        CurvedAnimation(parent: _reactController, curve: Curves.fastOutSlowIn);

    if (widget.initialReactionType != ReactionType.unselected) {
      item.setNewReaction(Reaction(type: widget.initialReactionType));
    }
  }

  _initReactions() {
    for (var reactionType in widget.supportedReactions) {
      if (reactionType == ReactionType.unselected) {
        continue;
      }
      var duration = const Duration(milliseconds: 300);
      var animationController =
          AnimationController(vsync: this, duration: duration);
      var animation = CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn);
      var reaction = Reaction(type: reactionType);
      reaction.setController(animationController);
      reaction.setAnimation(animation);
      _reactions.add(reaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
        visible: shouldShowReactionBar,
        portalFollower: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: _buildReactBarContainer(),
        ),
        anchor: Aligned(
            follower: Alignment.bottomCenter,
            offset: widget.reactionBarOffset,
            target: Alignment.topCenter,
            shiftToWithinBound: const AxisFlag(x: true, y: true)),
        child: ConstrainedBox(
            constraints: BoxConstraints.tight(widget.size),
            child: _buildReactionButton()));
  }

  var reactionContainerConstraintId = ConstraintId("reaction_container");
  var reactionIconsRowConstraintId = ConstraintId("reaction_icons_row");

  Widget _buildReaction(int index) {
    return AnimatedBuilder(
        animation: _reactions[index].animation,
        builder: (context, _) {
          var text = _reactions[index].text;
          double animationValue = _reactions[index].animation.value;
          double scale = reactScale * animationValue;
          double bigSize = _reactSize + _reactSize * scale;
          var icon = _reactions[index].lottie(Size(bigSize, bigSize));
          return ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: _reactItemTitleHeight +
                    _reactSize +
                    _reactSize * reactScale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.loose(Size(
                      _reactSize + _reactSize * scale, _reactItemTitleHeight)),
                  child: Opacity(
                    key: _reactions[index].reactionDescriptionTextKey,
                    opacity: animationValue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Material(
                        color: Colors.black54,
                        shape: const StadiumBorder(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 5),
                          child: Text(
                            text,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ).center(),
                ),
                icon,
              ],
            ),
          );
        });
  }

  /// A static reaction bar without animation on it
  Widget _buildReactBarContainer() {
    var circular = (reactSize + _reactBarPadding) / 2;
    var radius = BorderRadius.circular(circular);
    var shadow = const [
      BoxShadow(
          offset: Offset(0, 0),
          color: Color.fromRGBO(0, 0, 0, 0.07),
          blurRadius: 8,
          spreadRadius: 2)
    ];

    return ConstraintLayout().open(() {
      Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          color: Colors.white,
          boxShadow: shadow,
        ),
      ).defaultHorizontalPadding().applyConstraint(
          id: reactionContainerConstraintId,
          height: circular * 2,
          centerVerticalTo:
              reactionIconsRowConstraintId.bottomMargin(-_reactItemTitleHeight),
          centerHorizontalTo: reactionIconsRowConstraintId,
          left: reactionIconsRowConstraintId.left,
          right: reactionIconsRowConstraintId.right,
          zIndex: -1,
          width: matchConstraint);

      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ..._reactions.mapIndexed(
          (index, e) {
            return _buildReaction(index);
          },
        )
      ]).defaultHorizontalPadding().applyConstraint(
            id: reactionIconsRowConstraintId,
            left: parent.left,
            right: parent.right,
            bottom: parent.bottom,
            top: parent.top,
            centerTo: parent,
            // centerHorizontalTo: parent,
            // centerVerticalTo: parent,
            horizontalBias: 0.5,
            verticalBias: 0.5,
            zIndex: 1,
          );
    }).box(h: _reactSize + _reactSize * reactScale + _reactItemTitleHeight);
  }

  Widget _buildReactionButton() {
    return GestureDetector(
        onTap: () => setState(() {
              if (item.hasNoReaction) {
                item.setNewReaction(_reactions.firstWhere(
                  (element) => element.type == ReactionType.like,
                ));
                widget.onSelectReaction(ReactionType.like);
              } else {
                item.resetReaction();
                widget.onSelectReaction(ReactionType.unselected);
              }
            }),
        onLongPressMoveUpdate: _updatePointer,
        onLongPressStart: _savePointer,
        onLongPressEnd: (details) {
          _clearPointer(details);
        },
        onLongPress: () => _showReacts(),
        onLongPressUp: _hideReacts,
        child: widget.builder(
            context, item.reaction?.type ?? ReactionType.unselected));
  }

  void _hideReacts() async {
    await _animationController.reverse();
    shouldShowReactionBar = false;
    if (_reactSelected == -1) {
      await widget.soundPlayerDelegate?.playSoundReactionBoxDown();
    }
  }

  void _showReacts() async {
    if (!_animationController.isAnimating && !_reactController.isAnimating) {
      setState(() {
        shouldShowReactionBar = true;
      });
      _animationController.forward(from: 0);
      await widget.soundPlayerDelegate?.playSoundReactionBoxUp();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var reaction in _reactions) {
      reaction.dispose();
    }
    _reactController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _savePointer(LongPressStartDetails details) {
    _currentReactItemPositionDetail = details;
  }

  void _updatePointer(LongPressMoveUpdateDetails details) async {
    var globalOrigin = _currentReactItemPositionDetail.globalPosition;
    var newLongPress = globalOrigin + details.offsetFromOrigin;

    List<Rect> rects = _generateReactionRectangles(details);

    int index = -1;
    for (int i = 0; i < rects.length; i++) {
      if (rects[i].contains(newLongPress)) {
        index = i;
        break;
      }
    }
    if (index == -1) {
      if (_reactSelected != -1) {
        _reactions[_reactSelected].reverse();
        _reactSelected = -1;
      }
    } else {
      if (index != _reactSelected) {
        if (_reactSelected != -1) {
          _reactions[_reactSelected].reverse();
        }

        _reactSelected = index;
        await widget.soundPlayerDelegate?.playSoundFocus();
        _reactions[_reactSelected].forward();
      }
    }
  }

  List<Rect> _generateReactionRectangles(LongPressMoveUpdateDetails details) {
    var globalOrigin = _currentReactItemPositionDetail.globalPosition;
    var localOrigin = _currentReactItemPositionDetail.localPosition;
    double width = MediaQuery.of(context).size.width;

    var dy = globalOrigin.dy -
        _reactBarBotMargin -
        localOrigin.dy -
        _reactItemTitleHeight;

    if (_reactSelected == -1) {
      var wBar = reactSize * _reactions.length;
      var x = (width - wBar) / 2.0;
      Offset cursor = Offset(x, dy);
      return List.generate(_reactions.length, (index) {
        double size = reactSize;

        Offset start = cursor;
        Offset end = start + Offset(size, size);
        cursor = cursor + Offset(size, 0);

        return Rect.fromPoints(start, end);
      });
    } else {
      var wBar = reactSize * _reactions.length + reactScale * reactSize;
      var x = (width - wBar) / 2.0;
      Offset cursor = Offset(x, dy);
      return List.generate(_reactions.length, (index) {
        double bigSize = (reactScale + 1) * reactSize;
        double size = index == _reactSelected ? bigSize : reactSize;

        Offset start = cursor - Offset(0, size - reactSize);
        Offset end = start + Offset(size, size);
        cursor = cursor + Offset(size, 0);

        return Rect.fromPoints(start, end);
      });
    }
  }

  void _clearPointer(LongPressEndDetails details) async {
    if (_reactSelected != -1) {
      for (var element in _reactions) {
        element.reverse();
      }

      await widget.soundPlayerDelegate?.playSoundPick();

      var milliseconds =
          (_reactController.duration!.inMilliseconds * 0.1).floor();
      Future.delayed(Duration(milliseconds: milliseconds)).then((_) {
        item.setNewReaction(_reactions[_reactSelected]);
        if (item.reaction != null) {
          widget.onSelectReaction(item.reaction!.type);
        }
        setState(() {});
      });
      _reactController.forward(from: 0).then((_) {
        _reactSelected = -1;
        _currentReactItemPositionDetail = const LongPressStartDetails();
      });
    }
  }
}
