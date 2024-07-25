// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartx/dartx.dart';

/// [Validatable] told you if you want to validate your fields
/// you should implements me
abstract class Validatable {
  List<ValidatorCompatible> get validators;
}

/// [ValidatorCompatible] is base class for any class wants to
/// validate some inputs data
abstract class ValidatorCompatible {
  bool validate();
  String getErrorMessage();
}

class ValidationEvaluator extends ValidatorCompatible {
  dynamic input;
  bool Function(dynamic output) condition;
  String errorMessage;

  ValidationEvaluator({
    required this.input,
    required this.condition,
    required this.errorMessage,
  });

  @override
  String getErrorMessage() {
    return errorMessage;
  }

  @override
  bool validate() {
    return condition(input);
  }
}

extension ValidatableList<T extends ValidatorCompatible> on List<T> {
  bool validate() {
    return every((element) => element.validate());
  }

  String? get errorMessage {
    return firstOrNullWhere((element) => !element.validate())
        ?.getErrorMessage();
  }
}

extension ValidatableObject<T> on T {
  ValidatorCompatible validateBy(
      bool Function(T output) condition, String message) {
    return ValidationEvaluator(
        input: this,
        condition: (output) => condition(output),
        errorMessage: message);
  }
}

extension ValidatableExts<T> on Validatable {
  T validate({
    required T Function() onValid,
    required T Function(String? errorMessage) onInvalid,
  }) {
    if (validators.validate()) {
      return onValid();
    } else {
      return onInvalid(validators.errorMessage);
    }
  }
}
