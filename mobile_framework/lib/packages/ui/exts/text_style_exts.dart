
import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/ui/exts/responsive_value_ext.dart';

/// these functions are shorthand
/// to modify most popular porperties of TextStyle
extension TextStyleX on TextStyle {
  TextStyle buildFontSize(double size) {
    return copyWith(fontSize: size);
  }

  TextStyle buildFontWeight(FontWeight weight) {
    return copyWith(fontWeight: weight);
  }

  TextStyle buildColor(Color color) {
    return copyWith(color: color);
  }
}

extension TextStyleExtensions on TextStyle {
  // Weights
  TextStyle get thin => weight(FontWeight.w100);

  TextStyle get extraLight => weight(FontWeight.w200);

  TextStyle get light => weight(FontWeight.w300);

  TextStyle get regular => weight(FontWeight.normal);

  TextStyle get medium => weight(FontWeight.w500);

  TextStyle get semiBold => weight(FontWeight.w600);

  TextStyle get bold => weight(FontWeight.w700);

  TextStyle get extraBold => weight(FontWeight.w800);

  TextStyle get black => weight(FontWeight.w900);

  /// Shortcut for italic
  TextStyle get italic => style(FontStyle.italic);

  /// Shortcut for underline
  TextStyle get underline => textDecoration(TextDecoration.underline);

  /// Shortcut for linethrough
  TextStyle get lineThrough => textDecoration(TextDecoration.lineThrough);

  /// Shortcut for overline
  TextStyle get overline => textDecoration(TextDecoration.overline);

  /// Shortcut for color
  TextStyle textColor(Color v) => copyWith(color: v);

  /// Shortcut for backgroundColor
  TextStyle textBackgroundColor(Color v) => copyWith(backgroundColor: v);

  /// Shortcut for fontSize
  TextStyle size(double v) => copyWith(fontSize: v);

  /// Scales fontSize up or down
  TextStyle scale(double v) => copyWith(fontSize: (fontSize ?? 14) * v);

  /// Shortcut for fontWeight
  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  /// Shortcut for FontStyle
  TextStyle style(FontStyle v) => copyWith(fontStyle: v);

  /// Shortcut for letterSpacing
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  /// Shortcut for wordSpacing
  TextStyle wordSpace(double v) => copyWith(wordSpacing: v);

  /// Shortcut for textBaseline
  TextStyle baseline(TextBaseline v) => copyWith(textBaseline: v);

  /// Shortcut for height
  TextStyle textHeight(double v) => copyWith(height: v);

  /// Shortcut for locale
  TextStyle textLocale(Locale v) => copyWith(locale: v);

  /// Shortcut for foreground
  TextStyle textForeground(Paint v) => copyWith(foreground: v);

  /// Shortcut for background
  TextStyle textBackground(Paint v) => copyWith(background: v);

  /// Shortcut for shadows
  TextStyle textShadows(List<Shadow> v) => copyWith(shadows: v);

  /// Shortcut for fontFeatures
  TextStyle textFeatures(List<FontFeature> v) => copyWith(fontFeatures: v);

  /// Shortcut for decoration
  TextStyle textDecoration(TextDecoration v,
          {Color? color, TextDecorationStyle? style, double? thickness}) =>
      copyWith(
          decoration: v,
          decorationColor: color,
          decorationStyle: style,
          decorationThickness: thickness);

  TextStyle get white => textColor(Colors.white);

  TextStyle responsiveSize(BuildContext context,
      {double? mobile, double? tablet}) {
    return copyWith(
        fontSize: responsiveDoubleValueOrNull(context,
            mobile: mobile, tablet: tablet));
  }
}

extension StyledText<T extends Text> on T {
  Text copyWith({
    String? data,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
  }) =>
      Text(
        data ?? this.data ?? "",
        style: style ?? this.style,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        locale: locale ?? this.locale,
        maxLines: maxLines ?? this.maxLines,
        overflow: overflow ?? this.overflow,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        softWrap: softWrap ?? this.softWrap,
        textDirection: textDirection ?? this.textDirection,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      );

  T textStyle(TextStyle? style) => copyWith(
        style: (this.style ?? const TextStyle()).copyWith(
          background: style?.background,
          backgroundColor: style?.backgroundColor,
          color: style?.color,
          debugLabel: style?.debugLabel,
          decoration: style?.decoration,
          decorationColor: style?.decorationColor,
          decorationStyle: style?.decorationStyle,
          decorationThickness: style?.decorationThickness,
          fontFamily: style?.fontFamily,
          fontFamilyFallback: style?.fontFamilyFallback,
          fontFeatures: style?.fontFeatures,
          fontSize: style?.fontSize,
          fontStyle: style?.fontStyle,
          fontWeight: style?.fontWeight,
          foreground: style?.foreground,
          height: style?.height,
          inherit: style?.inherit,
          letterSpacing: style?.letterSpacing,
          locale: style?.locale,
          shadows: style?.shadows,
          textBaseline: style?.textBaseline,
          wordSpacing: style?.wordSpacing,
        ),
      ) as T;

  T textScale(double scaleFactor) =>
      copyWith(textScaleFactor: scaleFactor) as T;

  T bold() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontWeight: FontWeight.bold,
        ),
      ) as T;

  T italic() => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontStyle: FontStyle.italic,
        ),
      ) as T;

  T fontWeight(FontWeight fontWeight) => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontWeight: fontWeight,
        ),
      ) as T;

  T fontSize(double size) => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontSize: size,
        ),
      ) as T;

  T fontFamily(String font) => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          fontFamily: font,
        ),
      ) as T;

  T letterSpacing(double space) => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          letterSpacing: space,
        ),
      ) as T;

  T wordSpacing(double space) => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          wordSpacing: space,
        ),
      ) as T;

  T textShadow({
    Color color = const Color(0x34000000),
    double blurRadius = 0.0,
    Offset offset = Offset.zero,
  }) =>
      copyWith(
        style: (style ?? const TextStyle()).copyWith(
          shadows: [
            Shadow(
              color: color,
              blurRadius: blurRadius,
              offset: offset,
            ),
          ],
        ),
      ) as T;

  T textColor(Color color) => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          color: color,
        ),
      ) as T;

  T textAlignment(TextAlign align) => copyWith(textAlign: align) as T;

  T textDirection(TextDirection direction) =>
      copyWith(textDirection: direction) as T;

  T textBaseline(TextBaseline textBaseline) => copyWith(
        style: (style ?? const TextStyle()).copyWith(
          textBaseline: textBaseline,
        ),
      ) as T;

  T textWidthBasis(TextWidthBasis textWidthBasis) =>
      copyWith(textWidthBasis: textWidthBasis) as T;

  T withUnderLine() => copyWith(
      style: (style ?? const TextStyle())
          .copyWith(decoration: TextDecoration.underline)) as T;
}
