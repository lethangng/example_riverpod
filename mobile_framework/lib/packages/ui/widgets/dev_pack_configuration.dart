// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/gen/assets.gen.dart';

class GlobalThemeConfiguration extends InheritedWidget {
  final Color mainColor;
  final Color secondaryColor;
  final Color primaryButtonColor;
  final Color baseScaffoldBackgroundColor;
  final Color baseScaffoldNavigationBarBackgroundColor;
  final Color activeTabBarItemColor;
  final Color inactiveTabBarItemColor;
  final Color iconCheckColor;
  final Color focusBorderTextFieldColor;
  final Color textFieldDefaultColor;

  final TextStyle defaultTextStyle;
  final TextStyle secondaryTextStyle;
  final TextStyle itemTextStyle;
  final TextStyle bigTextStyle;
  final TextStyle mediumTextStyle;
  final TextStyle smallTextStyle;
  final TextStyle itemPickerTitleTextStyle;
  final TextStyle itemPickerCancelTextStyle;
  final TextStyle itemPickerConfirmTextStyle;
  final TextStyle itemPickerItemAllTextStyle;
  final TextStyle itemPickerItemTextStyle;
  final TextStyle popupCancelTextStyle;
  final TextStyle popupConfirmTextStyle;
  final TextStyle numpadTitleTextStyle;
  final TextStyle numpadCancelTextStyle;
  final TextStyle numpadConfirmTextStyle;
  final TextStyle numpadValueTextStyle;
  final TextStyle numpadItemTextStyle;
  final TextStyle textFieldErrorTextStyle;
  final TextStyle textFieldTitleTextStyle;
  final TextStyle datePickerTitleTextStyle;
  final TextStyle datePickerCancelTextStyle;
  final TextStyle datePickerConfirmTextStyle;

  final Widget tableViewCenterIndicator;
  final Widget tableViewLoadIndicator;
  final Widget loadingIndicator;
  final Widget numpadClearButton;

  final double textFieldBorderRadius;
  final double textFieldDefaultHeight;
  final double primaryButtonDefaultHeight;
  final double primaryButtonBorderRadius;

  const GlobalThemeConfiguration({super.key,
    required super.child,
    required this.mainColor,
    required this.secondaryColor,
    required this.primaryButtonColor,
    required this.baseScaffoldBackgroundColor,
    required this.baseScaffoldNavigationBarBackgroundColor,
    required this.activeTabBarItemColor,
    required this.inactiveTabBarItemColor,
    required this.iconCheckColor,
    required this.focusBorderTextFieldColor,
    required this.textFieldDefaultColor,
    required this.defaultTextStyle,
    required this.secondaryTextStyle,
    required this.itemTextStyle,
    required this.bigTextStyle,
    required this.mediumTextStyle,
    required this.smallTextStyle,
    required this.itemPickerTitleTextStyle,
    required this.itemPickerCancelTextStyle,
    required this.itemPickerConfirmTextStyle,
    required this.itemPickerItemAllTextStyle,
    required this.itemPickerItemTextStyle,
    required this.popupCancelTextStyle,
    required this.popupConfirmTextStyle,
    required this.numpadTitleTextStyle,
    required this.numpadCancelTextStyle,
    required this.numpadConfirmTextStyle,
    required this.numpadValueTextStyle,
    required this.numpadItemTextStyle,
    required this.textFieldErrorTextStyle,
    required this.textFieldTitleTextStyle,
    required this.datePickerTitleTextStyle,
    required this.datePickerCancelTextStyle,
    required this.datePickerConfirmTextStyle,
    required this.tableViewCenterIndicator,
    required this.tableViewLoadIndicator,
    required this.numpadClearButton,
    required this.textFieldBorderRadius,
    required this.textFieldDefaultHeight,
    required this.primaryButtonDefaultHeight,
    required this.primaryButtonBorderRadius,
    required this.loadingIndicator});

  factory GlobalThemeConfiguration.defaultTheme({required child}) {
    return GlobalThemeConfiguration(
        primaryButtonBorderRadius: 2,
        primaryButtonDefaultHeight: 48,
        textFieldDefaultHeight: 48,
        textFieldBorderRadius: 2,
        mainColor: const Color(0xFF29AB56),
        secondaryColor: const Color(0xFF29AB56),
        primaryButtonColor: const Color(0xFF29AB56),
        baseScaffoldBackgroundColor: const Color(0xFFF8F8F8),
        baseScaffoldNavigationBarBackgroundColor: const Color(0xFF29AB56),
        activeTabBarItemColor: const Color(0xFF29AB56),
        inactiveTabBarItemColor: const Color(0xFFA3A3A3),
        iconCheckColor: const Color(0xFF29AB56),
        focusBorderTextFieldColor: const Color(0xFF29AB56),
        textFieldDefaultColor: const Color(0xFF7C7B7B),
        defaultTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(16)
            .weight(FontWeight.w400),
        secondaryTextStyle: const TextStyle()
            .textColor(const Color(0xFF5C5C5C))
            .size(16)
            .weight(FontWeight.w400),
        itemTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(14)
            .weight(FontWeight.w400),
        bigTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(18)
            .weight(FontWeight.w400),
        mediumTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(14)
            .weight(FontWeight.w400),
        smallTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(12)
            .weight(FontWeight.w400),
        itemPickerTitleTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(20)
            .weight(FontWeight.w600),
        itemPickerCancelTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(17)
            .weight(FontWeight.w400),
        itemPickerConfirmTextStyle: const TextStyle()
            .textColor(const Color(0xFF29AB56))
            .size(16)
            .weight(FontWeight.w400),
        itemPickerItemAllTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(16)
            .weight(FontWeight.w400),
        itemPickerItemTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(16).weight(FontWeight.w400),
        popupCancelTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(16).weight(FontWeight.w400),
        popupConfirmTextStyle: const TextStyle().textColor(
            const Color(0xFF29AB56)).size(16).weight(FontWeight.w400),
        numpadTitleTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(20).weight(FontWeight.w600),
        numpadCancelTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(18).weight(FontWeight.w400),
        numpadConfirmTextStyle: const TextStyle().textColor(
            const Color(0xFF29AB56)).size(18).weight(FontWeight.w400),
        numpadValueTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(25).weight(FontWeight.w700),
        numpadItemTextStyle: const TextStyle().textColor(
            Colors.black87.withOpacity(0.8)).size(19).weight(FontWeight.w500),
        textFieldErrorTextStyle: const TextStyle().textColor(Colors.red).size(
            12).weight(FontWeight.w400),
        textFieldTitleTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(14).weight(
          FontWeight.w600,
        ),
        datePickerTitleTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(19).weight(FontWeight.w600),
        datePickerCancelTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(17).weight(FontWeight.w400),
        datePickerConfirmTextStyle: const TextStyle().textColor(
            const Color(0xFF29AB56)).size(17).weight(FontWeight.w400),
        tableViewCenterIndicator: Lottie.asset(
          fit: BoxFit.contain,
          height: 40,
          width: 40,
          frameRate: FrameRate(120),
          'assets/jsons/loading.json',
          package: "mobile_framework",
        ),
        tableViewLoadIndicator: SizedBox(
          height: 50,
          child: Lottie.asset(
            fit: BoxFit.contain,
            height: 20,
            width: 20,
            frameRate: FrameRate(120),
            'assets/jsons/loading.json',
            package: "mobile_framework",
          ).center(),
        ),
        numpadClearButton: Assets.icons.icNumpadClearButton.svg(
            height: 30, width: 30, package: "mobile_framework").center(),
        loadingIndicator: const SizedBox.shrink(),
        child: child);
  }

  factory GlobalThemeConfiguration.fnbTheme({required child}) {
    return GlobalThemeConfiguration(
        primaryButtonBorderRadius: 6,
        primaryButtonDefaultHeight: 48,
        textFieldDefaultHeight: 54,
        textFieldBorderRadius: 6,
        mainColor: const Color(0xFFF97414),
        secondaryColor: const Color(0xFF29AB56),
        primaryButtonColor: const Color(0xFF29AB56),
        baseScaffoldBackgroundColor: const Color(0xFFF8F8F8),
        baseScaffoldNavigationBarBackgroundColor: const Color(0xFF29AB56),
        activeTabBarItemColor: const Color(0xFF29AB56),
        inactiveTabBarItemColor: const Color(0xFFA3A3A3),
        iconCheckColor: const Color(0xFF29AB56),
        focusBorderTextFieldColor: const Color(0xFF29AB56),
        textFieldDefaultColor: const Color(0xFF7C7B7B),
        defaultTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(16)
            .weight(FontWeight.w400),
        secondaryTextStyle: const TextStyle()
            .textColor(const Color(0xFF5C5C5C))
            .size(16)
            .weight(FontWeight.w400),
        itemTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(14)
            .weight(FontWeight.w400),
        bigTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(18)
            .weight(FontWeight.w400),
        mediumTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(14)
            .weight(FontWeight.w400),
        smallTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(12)
            .weight(FontWeight.w400),
        itemPickerTitleTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(20)
            .weight(FontWeight.w600),
        itemPickerCancelTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(17)
            .weight(FontWeight.w400),
        itemPickerConfirmTextStyle: const TextStyle()
            .textColor(const Color(0xFF29AB56))
            .size(16)
            .weight(FontWeight.w400),
        itemPickerItemAllTextStyle: const TextStyle()
            .textColor(const Color(0xFF181818))
            .size(16)
            .weight(FontWeight.w400),
        itemPickerItemTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(16).weight(FontWeight.w400),
        popupCancelTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(16).weight(FontWeight.w400),
        popupConfirmTextStyle: const TextStyle().textColor(
            const Color(0xFF29AB56)).size(16).weight(FontWeight.w400),
        numpadTitleTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(20).weight(FontWeight.w600),
        numpadCancelTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(18).weight(FontWeight.w400),
        numpadConfirmTextStyle: const TextStyle().textColor(
            const Color(0xFF29AB56)).size(18).weight(FontWeight.w400),
        numpadValueTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(25).weight(FontWeight.w700),
        numpadItemTextStyle: const TextStyle().textColor(
            Colors.black87.withOpacity(0.8)).size(19).weight(FontWeight.w500),
        textFieldErrorTextStyle: const TextStyle().textColor(Colors.red).size(
            12).weight(FontWeight.w400),
        textFieldTitleTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(14).weight(
          FontWeight.w600,
        ),
        datePickerTitleTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(19).weight(FontWeight.w600),
        datePickerCancelTextStyle: const TextStyle().textColor(
            const Color(0xFF181818)).size(17).weight(FontWeight.w400),
        datePickerConfirmTextStyle: const TextStyle().textColor(
            const Color(0xFF29AB56)).size(17).weight(FontWeight.w400),
        tableViewCenterIndicator: Lottie.asset(
          fit: BoxFit.contain,
          height: 40,
          width: 40,
          frameRate: FrameRate(120),
          'assets/jsons/loading.json',
          package: "mobile_framework",
        ),
        tableViewLoadIndicator: Lottie.asset(
          fit: BoxFit.contain,
          height: 20,
          width: 20,
          frameRate: FrameRate(120),
          'assets/jsons/loading.json',
          package: "mobile_framework",
        ),
        numpadClearButton: Assets.icons.icNumpadClearButton.svg(
            height: 30, width: 30, package: "mobile_framework").center(),
        loadingIndicator: const SizedBox.shrink(),
        child: child);
  }

  static GlobalThemeConfiguration? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GlobalThemeConfiguration>();
  }

  static GlobalThemeConfiguration? global() {
    if (globalKey.currentContext == null) {
      return null;
    }
    return GlobalThemeConfiguration.of(globalKey.currentContext!);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  GlobalThemeConfiguration copyWith({
    Color? mainColor,
    Color? secondaryColor,
    Color? primaryButtonColor,
    Color? baseScaffoldBackgroundColor,
    Color? baseScaffoldNavigationBarBackgroundColor,
    Color? activeTabBarItemColor,
    Color? inactiveTabBarItemColor,
    Color? iconCheckColor,
    Color? focusBorderTextFieldColor,
    Color? textFieldDefaultColor,
    TextStyle? defaultTextStyle,
    TextStyle? secondaryTextStyle,
    TextStyle? itemTextStyle,
    TextStyle? bigTextStyle,
    TextStyle? mediumTextStyle,
    TextStyle? smallTextStyle,
    TextStyle? itemPickerTitleTextStyle,
    TextStyle? itemPickerCancelTextStyle,
    TextStyle? itemPickerConfirmTextStyle,
    TextStyle? itemPickerItemAllTextStyle,
    TextStyle? itemPickerItemTextStyle,
    TextStyle? popupCancelTextStyle,
    TextStyle? popupConfirmTextStyle,
    TextStyle? numpadTitleTextStyle,
    TextStyle? numpadCancelTextStyle,
    TextStyle? numpadConfirmTextStyle,
    TextStyle? numpadValueTextStyle,
    TextStyle? numpadItemTextStyle,
    TextStyle? textFieldErrorTextStyle,
    TextStyle? textFieldTitleTextStyle,
    TextStyle? datePickerTitleTextStyle,
    TextStyle? datePickerCancelTextStyle,
    TextStyle? datePickerConfirmTextStyle,
    Widget? tableViewCenterIndicator,
    Widget? tableViewLoadIndicator,
    Widget? numpadClearButton,
    double? textFieldBorderRadius,
    double? textFieldDefaultHeight,
    double? primaryButtonDefaultHeight,
    double? primaryButtonBorderRadius,
    Widget? loadingIndicator,
  }) {
    return GlobalThemeConfiguration(
      primaryButtonBorderRadius: primaryButtonBorderRadius ??
          this.primaryButtonBorderRadius,
      primaryButtonDefaultHeight: primaryButtonDefaultHeight ??
          this.primaryButtonDefaultHeight,
      textFieldDefaultHeight: textFieldDefaultHeight ??
          this.textFieldDefaultHeight,
      textFieldBorderRadius: textFieldBorderRadius ??
          this.textFieldBorderRadius,
      mainColor: mainColor ?? this.mainColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryButtonColor: primaryButtonColor ?? this.primaryButtonColor,
      baseScaffoldBackgroundColor:
      baseScaffoldBackgroundColor ?? this.baseScaffoldBackgroundColor,
      baseScaffoldNavigationBarBackgroundColor:
      baseScaffoldNavigationBarBackgroundColor ??
          this.baseScaffoldNavigationBarBackgroundColor,
      activeTabBarItemColor:
      activeTabBarItemColor ?? this.activeTabBarItemColor,
      inactiveTabBarItemColor:
      inactiveTabBarItemColor ?? this.inactiveTabBarItemColor,
      iconCheckColor: iconCheckColor ?? this.iconCheckColor,
      focusBorderTextFieldColor:
      focusBorderTextFieldColor ?? this.focusBorderTextFieldColor,
      textFieldDefaultColor:
      textFieldDefaultColor ?? this.textFieldDefaultColor,
      defaultTextStyle: defaultTextStyle ?? this.defaultTextStyle,
      secondaryTextStyle: secondaryTextStyle ?? this.secondaryTextStyle,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      bigTextStyle: bigTextStyle ?? this.bigTextStyle,
      mediumTextStyle: mediumTextStyle ?? this.mediumTextStyle,
      smallTextStyle: smallTextStyle ?? this.smallTextStyle,
      itemPickerTitleTextStyle:
      itemPickerTitleTextStyle ?? this.itemPickerTitleTextStyle,
      itemPickerCancelTextStyle:
      itemPickerCancelTextStyle ?? this.itemPickerCancelTextStyle,
      itemPickerConfirmTextStyle:
      itemPickerConfirmTextStyle ?? this.itemPickerConfirmTextStyle,
      itemPickerItemAllTextStyle:
      itemPickerItemAllTextStyle ?? this.itemPickerItemAllTextStyle,
      itemPickerItemTextStyle:
      itemPickerItemTextStyle ?? this.itemPickerItemTextStyle,
      popupCancelTextStyle: popupCancelTextStyle ?? this.popupCancelTextStyle,
      popupConfirmTextStyle:
      popupConfirmTextStyle ?? this.popupConfirmTextStyle,
      numpadTitleTextStyle: numpadTitleTextStyle ?? this.numpadTitleTextStyle,
      numpadCancelTextStyle:
      numpadCancelTextStyle ?? this.numpadCancelTextStyle,
      numpadConfirmTextStyle:
      numpadConfirmTextStyle ?? this.numpadConfirmTextStyle,
      numpadValueTextStyle: numpadValueTextStyle ?? this.numpadValueTextStyle,
      numpadItemTextStyle: numpadItemTextStyle ?? this.numpadItemTextStyle,
      textFieldErrorTextStyle:
      textFieldErrorTextStyle ?? this.textFieldErrorTextStyle,
      textFieldTitleTextStyle:
      textFieldTitleTextStyle ?? this.textFieldTitleTextStyle,
      datePickerTitleTextStyle:
      datePickerTitleTextStyle ?? this.datePickerTitleTextStyle,
      datePickerCancelTextStyle:
      datePickerCancelTextStyle ?? this.datePickerCancelTextStyle,
      datePickerConfirmTextStyle:
      datePickerConfirmTextStyle ?? this.datePickerConfirmTextStyle,
      tableViewCenterIndicator:
      tableViewCenterIndicator ?? this.tableViewCenterIndicator,
      tableViewLoadIndicator:
      tableViewLoadIndicator ?? this.tableViewLoadIndicator,
      numpadClearButton: numpadClearButton ?? this.numpadClearButton,
      loadingIndicator: loadingIndicator ?? this.loadingIndicator,
      child: child,
    );
  }
}

mixin GlobalThemePlugin {
  GlobalThemeConfiguration get conf {
    if (globalKey.currentContext == null) {
      throw Exception(
          "navigatorKey should be set in MaterialApp or CupertinoApp");
    }

    var context = globalKey.currentContext!;

    if (GlobalThemeConfiguration.of(context) == null) {
      throw Exception("Cannot find GlobalThemeConfiguration");
    }

    return GlobalThemeConfiguration.of(context)!;
  }
}
