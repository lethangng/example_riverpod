// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

extension Optional<T> on T? {
  bool get isNull {
    return this == null;
  }

  bool get isNotNull {
    return !isNull;
  }

  T unwrapOr(T defaultValue) {
    if (isNull) {
      return defaultValue;
    }

    return this!;
  }

  T guard({VoidCallback? onNull, required T rollback}) {
    if (this == null) {
      onNull?.call();
      return rollback;
    }

    return this!;
  }
}