// ignore_for_file: unnecessary_cast

import 'package:async/async.dart';
import 'package:mobile_framework/mobile_framework.dart';

typedef ResultFuture<T> = CancelableOperation<Result<T>>;
typedef ResultListFuture<T> = CancelableOperation<Result<List<T>>>;
typedef ResultBaseListFuture<T>
    = CancelableOperation<Result<BaseListResponse<T>>>;

sealed class Result<T> {
  final T? _value;
  final CommonError? _error;

  Result(this._value, this._error);

  factory Result.success({required T value}) = Success;
  factory Result.failure({required CommonError error}) = Failure;
}

final class Success<T> extends Result<T> {
  Success({required T value}) : super(value, null);

  T get value {
    return _value!;
  }
}

final class Failure<T> extends Result<T> {
  Failure({required CommonError error}) : super(null, error);

  CommonError get error {
    return _error!;
  }
}

extension ResultExts on Result {
  bool get isSuccess => this is Success;

  bool get isError => this is Failure;
}
