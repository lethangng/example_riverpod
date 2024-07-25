import 'package:flutter/material.dart';

/// [TextOneLine] is a substitute for [Text] when [maxLines] is 1.
///
/// It renders ellipsis as expected, much better than the current
/// buggy and ugly-looking ellipsis of the native [Text].
///
/// This widget only makes sense while that issue is not fixed:
/// https://github.com/flutter/flutter/issues/18761
///
/// Known issues: The letter-spacing will work fine when the style is defined inline,
/// but it may not work fine when the style is inherited.
///
class TextOneLine extends Text {
  const TextOneLine(
    super.data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.overflow = TextOverflow.ellipsis,
    super.textScaleFactor,
    super.semanticsLabel,
    TextWidthBasis super.textWidthBasis = TextWidthBasis.parent,
    super.textHeightBehavior,
  }) : super(
          softWrap: false,
          maxLines: 1,
        );

  @override
  String? get data => super.data == null ? null : Characters(super.data!).toList().join("\u{200B}");

  // Note: Since Flutter adds letterSpacing between the zero-width chars we're using, there are
  // now two spacings where there should be only one. To fix this, we half the given spacing.
  // This will only work when the style is defined inline, meaning it's still buggy when a
  // style with non-zero letterSpacing is inherited.
  @override
  TextStyle? get style {
    return (super.style == null ||
            super.style!.letterSpacing == null ||
            super.style!.letterSpacing == 0.0)
        ? super.style
        : super.style!.apply(letterSpacingFactor: 0.5);
  }
}
