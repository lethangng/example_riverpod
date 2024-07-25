import 'package:flutter/cupertino.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_framework/gen/assets.gen.dart';

enum ReactionType {
  like,
  love,
  thinking,
  haha,
  wow,
  sad,
  angry,
  unselected;

  String get text => switch (this) {
        ReactionType.like => "Thích",
        ReactionType.love => "Yêu thích",
        ReactionType.haha => "Haha",
        ReactionType.wow => "Wow",
        ReactionType.sad => "Buồn",
        ReactionType.angry => "Tức giận",
        ReactionType.thinking => "Suy nghĩ",
        ReactionType.unselected => "",
      };

  String get lottiePath => switch (this) {
        ReactionType.like => Assets.jsons.reactionLike,
        ReactionType.love => Assets.jsons.reactionLove,
        ReactionType.haha => Assets.jsons.reactionHaha,
        ReactionType.wow => Assets.jsons.reactionWow,
        ReactionType.sad => Assets.jsons.reactionCry,
        ReactionType.angry => Assets.jsons.reactionAngry,
        ReactionType.thinking => Assets.jsons.reactionThinking,
        ReactionType.unselected => "",
      };

  AssetGenImage? get iconPng => switch (this) {
        ReactionType.like => Assets.icons.icReactionLike,
        ReactionType.love => Assets.icons.icReactionLove,
        ReactionType.haha => Assets.icons.icReactionHaha,
        ReactionType.wow => Assets.icons.icReactionWow,
        ReactionType.sad => Assets.icons.icReactionCry,
        ReactionType.angry => Assets.icons.icReactionAngry,
        ReactionType.thinking => Assets.icons.icReactionThinking,
        ReactionType.unselected => null,
      };

  String get rawValue => switch (this) {
        ReactionType.like => 'LIKE',
        ReactionType.love => 'LOVE',
        ReactionType.haha => 'HAHA',
        ReactionType.wow => 'WOW',
        ReactionType.sad => 'SAD',
        ReactionType.angry => 'ANGRY',
        ReactionType.thinking => 'LOVEX2',
        ReactionType.unselected => "",
      };

  static ReactionType? fromValue(String? value) => switch (value) {
        'LIKE' => ReactionType.like,
        'LOVE' => ReactionType.love,
        'HAHA' => ReactionType.haha,
        'WOW' => ReactionType.wow,
        'SAD' => ReactionType.sad,
        'ANGRY' => ReactionType.angry,
        'LOVEX2' => ReactionType.thinking,
        _ => null
      };
}

class Reaction {
  late final AnimationController controller;
  late final Animation<double> animation;
  final ReactionType type;
  final reactionDescriptionTextKey = GlobalKey();

  late final ConstraintId layoutId = ConstraintId(type.name);

  Reaction({
    required this.type,
  });

  String get svgPath => type.lottiePath;

  Widget lottie(Size size, {bool repeat = true}) {
    return LottieBuilder.asset(
      svgPath,
      width: size.width,
      height: size.height,
      filterQuality: FilterQuality.high,
      frameRate: const FrameRate(120),
      repeat: repeat,
      animate: true,
      renderCache: RenderCache.drawingCommands,
    );
  }

  AssetGenImage? get icon => type.iconPng;

  String get text => type.text;

  TickerFuture reverse({double? from}) => controller.reverse(from: from);

  TickerFuture forward({double? from}) => controller.forward(from: from);

  void setController(AnimationController controller) {
    this.controller = controller;
  }

  void setAnimation(Animation<double> animation) {
    this.animation = animation;
  }

  void dispose() => controller.dispose();
}
