import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';

extension IntExts on int {
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

extension NullableIntExts on int? {
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
      return "${this!.toVietnameseWords()} đồng";
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
