import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';

extension DoubleUIExts on double {
  Radius get circularRadius {
    return Radius.circular(this);
  }

  BorderRadius borderAll() {
    return BorderRadius.all(circularRadius);
  }
}

extension DoubleExts on double {
  String format(String pattern, {String locale = "vi_VN"}) {
    var f = NumberFormat(pattern, locale);
    return f.format(this);
  }

  double round(int fixed) {
    try {
      return double.parse(toStringAsFixed(fixed));
    } catch (e) {
      return 0;
    }
  }

  String percentSymbol() {
    return "${toString()}%";
  }

  double round1() {
    return round(1);
  }

  double round2() {
    return round(2);
  }

  String moneyFormat(
      {String locale = "vi_VN",
      fractionDigits = 0,
      CompactFormatType compactFormatType = CompactFormatType.short}) {
    var mf = MoneyFormatter(
        amount: this,
        settings: MoneyFormatterSettings(
          compactFormatType: compactFormatType,
          decimalSeparator: ",",
          fractionDigits: fractionDigits,
          symbol: "đ",
          symbolAndNumberSeparator: " ",
          thousandSeparator: ".",
        ));
    return mf.output.compactSymbolOnRight;
  }

  /// use [SupportLocale] to get supported locale for shorter syntax
  String formatCurrency(
      {Locale locale = const Locale("vi", "VN"),
      String symbol = "đ",
      bool isCompact = false,
      bool isVietnameseWordForm = false,
      int fractionDigits = 0,
      String defaultValue = "---",
      String? pattern}) {
    if (isVietnameseWordForm) {
      return "${toInt().toVietnameseWords()} đồng";
    }

    var localeString = "${locale.languageCode}_${locale.countryCode}";
    var numberFormat = isCompact
        ? NumberFormat.compactCurrency(
            locale: localeString, symbol: symbol, decimalDigits: fractionDigits)
        : NumberFormat.currency(
            locale: localeString,
            symbol: symbol,
            decimalDigits: fractionDigits,
            customPattern: pattern);

    return numberFormat.format(this);
  }
}

extension NullableDoubleExts on double? {
  String formatCurrency(
      {Locale locale = const Locale("vi", "VN"),
      String symbol = "đ",
      bool isCompact = false,
      bool isVietnameseWordForm = false,
      int fractionDigits = 0,
      String defaultValue = "---",
      String? pattern}) {
    if (this == null) return defaultValue;

    if (isVietnameseWordForm) {
      return "${this!.toInt().toVietnameseWords()} đồng";
    }

    var localeString = "${locale.languageCode}_${locale.countryCode}";
    var numberFormat = isCompact
        ? NumberFormat.compactCurrency(
            locale: localeString, symbol: symbol, decimalDigits: fractionDigits)
        : NumberFormat.currency(
            locale: localeString,
            symbol: symbol,
            decimalDigits: fractionDigits,
            customPattern: pattern);

    return numberFormat.format(this);
  }
}

extension SupportLocale on Locale {
  static const vi = Locale('vi', 'VN');
  static const en = Locale('en', 'US');
}
