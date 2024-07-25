import 'package:mobile_framework/mobile_framework.dart';

extension StringX on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPhoneNumber() {
    final RegExp regExp = RegExp(r"(09|03|08|07|05|\\+84[9|3|8|7])+([0-9]{8})");
    return regExp.hasMatch(this);
  }

  // 1 uppercase letter, 1 lowercase letter, 1 number, & 1 special character, at least 8 characters.
  bool isValidPassword() {
    final RegExp regExpPassword =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[\S ]{8,}$');
    return regExpPassword.hasMatch(this);
  }

  double toDouble() {
    return double.tryParse(removeCharacter(',')) ?? 0.0;
  }

  int toInt() {
    return int.tryParse(removeCharacter(',')) ?? 0;
  }

  String removeCharacter(String character) {
    return replaceAll(character, '');
  }

  String lastCharacter() {
    if (length == 0) {
      return "";
    }
    return substring(length - 1);
  }
}

extension OptionalString on String? {
  String unwrap({String defaultString = ""}) {
    return this == null ? defaultString : this!;
  }
}

extension DateTimeFormatString on DateTime? {
  String? format({String pattern = "dd/MM/yyyy"}) {
    return DateTimeUtils.stringFormatted(
        time: this, pattern: StringDateTimeFormatPattern(pattern));
  }
}
