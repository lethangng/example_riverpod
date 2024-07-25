import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

bool isMobile(BuildContext context) {
  return ResponsiveValue<bool>(context, conditionalValues: [
    const Condition<bool>.smallerThan(name: TABLET, value: true),
    const Condition<bool>.largerThan(name: MOBILE, value: false),
  ]).value;
}

bool isTablet(BuildContext context) {
  return ResponsiveValue<bool>(context, conditionalValues: [
    const Condition<bool>.largerThan(name: MOBILE, value: true),
    const Condition<bool>.smallerThan(name: TABLET, value: false),
  ]).value;
}

double responsiveDoubleValue(BuildContext context,
    {required double mobile, required double tablet}) {
  return ResponsiveValue<double>(context, conditionalValues: [
    Condition<double>.largerThan(name: MOBILE, value: tablet),
    Condition<double>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

int responsiveIntValue(BuildContext context,
    {required int mobile, required int tablet}) {
  return ResponsiveValue<int>(context, conditionalValues: [
    Condition<int>.largerThan(name: MOBILE, value: tablet),
    Condition<int>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

TextStyle responsiveTextStyle(BuildContext context,
    {required TextStyle mobile, required TextStyle tablet}) {
  return ResponsiveValue<TextStyle>(context, conditionalValues: [
    Condition<TextStyle>.largerThan(name: MOBILE, value: tablet),
    Condition<TextStyle>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

Widget responsiveWidget(BuildContext context,
    {required Widget mobile, required Widget tablet}) {
  return ResponsiveValue<Widget>(context, conditionalValues: [
    Condition<Widget>.largerThan(name: MOBILE, value: tablet),
    Condition<Widget>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

Color responsiveColor(BuildContext context,
    {required Color mobile, required Color tablet}) {
  return ResponsiveValue<Color>(context, conditionalValues: [
    Condition<Color>.largerThan(name: MOBILE, value: tablet),
    Condition<Color>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

Color? responsiveColorOrNull(BuildContext context,
    {Color? mobile, Color? tablet}) {
  return ResponsiveValue<Color?>(context, conditionalValues: [
    Condition<Color?>.largerThan(name: MOBILE, value: tablet),
    Condition<Color?>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

Widget? responsiveWidgetOrNull(BuildContext context,
    {Widget? mobile, Widget? tablet}) {
  return ResponsiveValue<Widget?>(context, conditionalValues: [
    Condition<Widget?>.largerThan(name: MOBILE, value: tablet),
    Condition<Widget?>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

TextStyle? responsiveTextStyleOrNull(BuildContext context,
    {TextStyle? mobile, TextStyle? tablet}) {
  return ResponsiveValue<TextStyle?>(context, conditionalValues: [
    Condition<TextStyle?>.largerThan(name: MOBILE, value: tablet),
    Condition<TextStyle?>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

int? responsiveIntValueOrNull(BuildContext context,
    {int? mobile, int? tablet}) {
  return ResponsiveValue<int?>(context, conditionalValues: [
    Condition<int?>.largerThan(name: MOBILE, value: tablet),
    Condition<int?>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

double? responsiveDoubleValueOrNull(BuildContext context,
    {double? mobile, double? tablet}) {
  return ResponsiveValue<double?>(context, conditionalValues: [
    Condition<double?>.largerThan(name: MOBILE, value: tablet),
    Condition<double?>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

T? responsiveValueOrNull<T>(BuildContext context,
    {required T mobile, required T tablet}) {
  return ResponsiveValue<T?>(context, conditionalValues: [
    Condition<T?>.largerThan(name: MOBILE, value: tablet),
    Condition<T?>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}

T responsiveValue<T>(BuildContext context,
    {required T mobile, required T tablet}) {
  return ResponsiveValue<T>(context, conditionalValues: [
    Condition<T>.largerThan(name: MOBILE, value: tablet),
    Condition<T>.smallerThan(name: TABLET, value: mobile),
  ]).value;
}
