import 'package:async/async.dart' hide ResultFuture, Result;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

extension CancelableOperationRefExt<T> on CancelableOperation<Result<T>> {
  CancelableOperation<Result<T>> cancelBy(Ref ref) {
    if (ref is AutoDisposeRef) {
      var link = ref.keepAlive();
      ref.onCancel(() {
        /// close the link when ref is canceled
        /// so that the [AutoDisposeRef] can be disposed
        link.close();
      });

      ref.onDispose(() {
        if (isCanceled || isCompleted) {
          return;
        }
        cancel();
      });
    } else {
      ref.onCancel(() {
        cancel();
      });
    }

    return this;
  }

  Future<Result<T>> next() {
    return value;
  }

  Future<bool> isSuccess() {
    return value.then((value) => value.isSuccess);
  }

  Future<bool> isError() {
    return value.then((value) => value.isError);
  }
}

extension CancelableFutureResultPlus<T> on CancelableOperation<Result<T>> {
  CancelableOperation<Result<T>> onResult(Function() handler) {
    return then((result) {
      handler();
      return result;
    });
  }

  CancelableOperation<Result<T>> onSuccess(Function(T value) handler) {
    return then((result) {
      if (result case Success<T>(value: T val)) {
        handler(val);
      }
      return result;
    });
  }

  CancelableOperation<Result<T>> onError(Function(CommonError error) handler) {
    return then((result) {
      if (result case Failure(error: CommonError err)) {
        handler(err);
      }
      return result;
    });
  }

  CancelableOperation<T?> mapToValue({
    T? defaultValue,
  }) {
    return then(
        (r) => switch (r) {
              Success<T>(value: T value) => value,
              Failure(error: CommonError error) => defaultValue,
            }, onError: (error, trace) {
      talkerLogger.log(error.toString());
      return Future.value(defaultValue);
    });
  }
}

extension CancelableFutureResultNullable<T> on CancelableOperation<Result<T?>> {
  CancelableOperation<T> mapToValueOr({
    required T defaultValue,
  }) {
    return then(
        (r) => switch (r) {
              Success(:final T? value) => value ?? defaultValue,
              Failure(:final CommonError error) => throw Exception(error),
            }, onError: (error, trace) {
      talkerLogger.log(error.toString());
      return Future.value(defaultValue);
    });
  }
}

extension NullableFutureValue<T> on CancelableOperation<T?> {
  Future<T> onNullJustReturn(T v) {
    return then((value) {
      if (value == null) {
        return v;
      }
      return value;
    }).value;
  }

  Future<T?> onNullJustDo(VoidCallback callback) {
    return then((value) {
      if (value == null) {
        callback();
      }
      return value;
    }).value;
  }
}

extension FutureValue<T> on CancelableOperation<T> {
  @Deprecated("Use asFuture() instead")
  Future<T> next() => value;

  Future<T> asFuture() => value;
}

extension FutureResult<T> on CancelableOperation<Result<T>> {
  /// convert current result to another result with new success data
  CancelableOperation<Result<NewSuccess>>
      map<NewSuccess, NewError extends CommonError>(
          {required NewSuccess Function(T? value) onValue,
          NewError Function(CommonError error)? onError}) {
    return then((result) {
      switch (result) {
        case Success<T> s:
          return Success<NewSuccess>(value: onValue(s.value));
        case Failure<T> f:
          return Failure<NewSuccess>(error: onError?.call(f.error) ?? f.error);
      }
    });
  }
}

extension MetadataResult<T extends BaseListResponse>
    on CancelableOperation<Result<T>> {
  CancelableOperation<Result<T>> updateMetadataBy(
      MetadataUpdater metadataUpdater) {
    return then((result) {
      switch (result) {
        case Success<T> s:
          if (s.value.metadata != null) {
            metadataUpdater.updateMetadata(s.value.metadata!);
          }

          return s;
        case Failure<T> f:
          return f;
      }
    });
  }
}

extension BaseListResponseExts<E>
    on CancelableOperation<Result<BaseListResponse<E>>> {
  Future<List<E>> getItems() {
    return then((result) {
      switch (result) {
        case Success<BaseListResponse<E>> s:
          return (s.value.items).cast<E>();
        case Failure<BaseListResponse> f:
          return <E>[];
      }
    }).value;
  }
}

extension CastingFutureExts<T> on Future<T> {
  Future<Result<P>> as<P>() {
    return then((result) {
      if (result case Success success) {
        if (success.value is P) {
          return Success<P>(value: success.value as P);
        }

        throw Exception("$T is not subtype of $P");
      } else if (result case Failure(error: CommonError err)) {
        return Failure<P>(error: err);
      }

      throw Exception("Unknown result type");
    });
  }
}

extension CancelableFutureConverter<T> on Future<T> {
  CancelableOperation<T> asCancelable() {
    return CancelableOperation.fromFuture(this);
  }
}

extension CancelableNullableFutureConverter<T> on Future<T?> {
  CancelableOperation<T?> asCancelable() {
    return CancelableOperation.fromFuture(this);
  }
}

extension CancelManualOperation on CancelableOperation {
  CancelableOperation cancelManual(
      Function(CancelableOperation operation) manual) {
    manual(this);
    return this;
  }
}

extension CancelableUseCaseExt<T> on CancelableOperation<Result<T>> {
  CancelableOperation<Result<T>> showErrorBy(AlertMixin target) {
    return onError((e) {
      target.showError(e, caller: target);
    });
  }

  CancelableOperation<Result<T>> showSuccessBy(AlertMixin target,
      {required String message}) {
    return onSuccess((value) {
      target.showSuccess(message, caller: target);
    });
  }

  CancelableOperation<Result<T>> hideLoadingBy(AlertMixin target) {
    return onResult(() {
      target.hideLoading();
    });
  }
}

extension CancelableUseCaseNullableExt<T> on CancelableOperation<Result<T?>> {
  CancelableOperation<Result<T?>> showErrorBy(UseCase uc) {
    return onError((e) {
      uc.showError(e, caller: uc);
    });
  }

  CancelableOperation<Result<T?>> showSuccessBy(UseCase uc,
      {required String message}) {
    return onSuccess((value) {
      uc.showSuccess(message, caller: uc);
    });
  }
}
