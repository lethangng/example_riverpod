import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';

abstract class DateTimeFormatPatternRepresentable {
  abstract final String pattern;
}

enum DateTimeFormatPattern implements DateTimeFormatPatternRepresentable {
  full("yyyy-MM-dd'T'HH:mm:ss"),
  yyyyMMdd1("yyyy-MM-dd"),
  yyyyMMdd2("yyyy/MM/dd"),
  ddMMyyyy1("dd-MM-yyyy"),
  ddMMyyyy2("dd/MM/yyyy"),
  hhMMddyyyy1("HH:mm dd-MM-yyyy"),
  hhMMddyyyy2("HH:mm dd/MM/yyyy"),
  MMyyyy("MM/yyyy"),
  clock("HH:mm:ss"),
  clock2("HH:mm"),
  clock3("mm:ss");

  @override
  final String pattern;

  const DateTimeFormatPattern(this.pattern);
}

class StringDateTimeFormatPattern
    implements DateTimeFormatPatternRepresentable {
  final String _pattern;

  StringDateTimeFormatPattern(this._pattern);

  @override
  // TODO: implement pattern
  String get pattern => _pattern;
}

class DateTimeUtils {
  static setSupportedLocaleMessages() {
    timeago.setLocaleMessages('vi', ViMessages());
  }

  /// If [formatTimeAgo] is true, [pattern] will be ignored
  /// But if today is 4 days ago since [time], [pattern] will be used
  static String? stringFormatted(
      {required DateTime? time,
      DateTimeFormatPatternRepresentable pattern =
          DateTimeFormatPattern.yyyyMMdd2,
      String? locale = "vi",
      bool formatTimeAgo = false}) {
    if (time == null) {
      return null;
    }

    if (formatTimeAgo) {
      return timeago.format(time, locale: locale);
    }

    final formatter = DateFormat(pattern.pattern);
    return formatter.format(time);
  }

  static DateTime? dateFormatted(
      {required String? stringTime,
      required DateTimeFormatPatternRepresentable pattern,
      String? locale}) {
    if (stringTime == null) {
      return null;
    }

    final formatter = DateFormat(pattern.pattern, locale);
    return formatter.parse(stringTime).atCurrentZone();
  }

  /// only for string in time zone format
  static String? stringFromTimeZoneFormat(
      String? tzTimeString, DateTimeFormatPatternRepresentable pattern,
      {String locale = 'vi', bool formatTimeAgo = false}) {
    if (tzTimeString == null) {
      return null;
    }

    var time = dateFormatted(
        stringTime: tzTimeString,
        pattern: DateTimeFormatPattern.full,
        locale: locale);
    return stringFormatted(
        time: time,
        pattern: pattern,
        formatTimeAgo: formatTimeAgo,
        locale: locale);
  }

  /// Format: yyyy-MM-dd
  static String? yyyyMMdd1(DateTime? time,
      {String? locale, bool formatTimeAgo = false}) {
    return stringFormatted(
        time: time,
        pattern: DateTimeFormatPattern.yyyyMMdd1,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }

  /// Format: yyyy/MM/dd
  static String? yyyyMMdd2(DateTime? time,
      {String? locale, bool formatTimeAgo = false}) {
    return stringFormatted(
        time: time,
        pattern: DateTimeFormatPattern.yyyyMMdd2,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }

  /// Format: dd-MM-yyyy
  static String? ddMMyyyy1(DateTime? time,
      {String? locale, bool formatTimeAgo = false}) {
    return stringFormatted(
        time: time,
        pattern: DateTimeFormatPattern.ddMMyyyy1,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }

  /// Format: dd/MM/yyy
  static String? ddMMyyyy2(DateTime? time,
      {String? locale, bool formatTimeAgo = false}) {
    return stringFormatted(
        time: time,
        pattern: DateTimeFormatPattern.ddMMyyyy2,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }

  /// Format: HH:mm dd-MM-yyyy
  static String? hhMMddyyyy1(DateTime? time,
      {String? locale, bool formatTimeAgo = false}) {
    return stringFormatted(
        time: time,
        pattern: DateTimeFormatPattern.hhMMddyyyy1,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }

  /// Format: HH:mm dd/MM/yyyy
  /// Example: 12:00 01/01/2021
  static String? hhMMddyyyy2(DateTime? time,
      {String? locale, bool formatTimeAgo = false}) {
    return stringFormatted(
        time: time,
        pattern: DateTimeFormatPattern.hhMMddyyyy2,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }
}

extension DateTimeExts on DateTime {
  DateTime atCurrentZone() {
    return add(DateTime.now().timeZoneOffset);
  }
}

extension DateTimeMiliseconds on DateTime {
  static DateTime? decodeMillisecondsFrom(dynamic json) {
    if (json == null) {
      return null;
    }

    if (json is! int) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(json);
  }
}

extension NullableDateTimeFormatExts on DateTime? {
  // Pattern: yyyy-MM-dd
  String? yyyyMMdd1({String? locale, bool formatTimeAgo = false}) {
    return DateTimeUtils.yyyyMMdd1(this,
        locale: locale, formatTimeAgo: formatTimeAgo);
  }

  // Pattern: yyyy/MM/dd
  String? yyyyMMdd2({String? locale, bool formatTimeAgo = false}) {
    return DateTimeUtils.yyyyMMdd2(this,
        locale: locale, formatTimeAgo: formatTimeAgo);
  }

  // Pattern: dd-MM-yyyy
  String? ddMMyyyy1({String? locale, bool formatTimeAgo = false}) {
    return DateTimeUtils.ddMMyyyy1(this,
        locale: locale, formatTimeAgo: formatTimeAgo);
  }

  // Pattern: dd/MM/yyyy
  String? ddMMyyyy2({String? locale, bool formatTimeAgo = false}) {
    return DateTimeUtils.ddMMyyyy2(this,
        locale: locale, formatTimeAgo: formatTimeAgo);
  }

  // Pattern: HH:mm dd-MM-yyyy
  String? hhMMddyyyy1({String? locale, bool formatTimeAgo = false}) {
    return DateTimeUtils.hhMMddyyyy1(this,
        locale: locale, formatTimeAgo: formatTimeAgo);
  }

  // Pattern: HH:mm dd/MM/yyyy
  String? hhMMddyyyy2({String? locale, bool formatTimeAgo = false}) {
    return DateTimeUtils.hhMMddyyyy2(this,
        locale: locale, formatTimeAgo: formatTimeAgo);
  }

  @Deprecated("Use formatToString instead, formatToString is more meaningful")
  String? stringFormat(DateTimeFormatPattern pattern,
      {String? locale, bool formatTimeAgo = false}) {
    return DateTimeUtils.stringFormatted(
        time: this,
        pattern: pattern,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }

  String? formatToString(
      {DateTimeFormatPattern pattern = DateTimeFormatPattern.ddMMyyyy2,
      String? locale,
      bool formatTimeAgo = false}) {
    return DateTimeUtils.stringFormatted(
        time: this,
        pattern: pattern,
        locale: locale,
        formatTimeAgo: formatTimeAgo);
  }
}

class ViMessages implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => '$seconds giây';

  @override
  String aboutAMinute(int minutes) => '1 phút';

  @override
  String minutes(int minutes) => '$minutes phút';

  @override
  String aboutAnHour(int minutes) => '1 giờ';

  @override
  String hours(int hours) => '$hours giờ';

  @override
  String aDay(int hours) => '1 ngày';

  @override
  String days(int days) => '$days ngày';

  @override
  String aboutAMonth(int days) => '1 tháng';

  @override
  String months(int months) => '$months tháng';

  @override
  String aboutAYear(int year) => '1 năm';

  @override
  String years(int years) => '$years năm';

  @override
  String wordSeparator() => ' ';
}
