import 'dart:async';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/api/base/http_status_codes.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioBase extends DioForNative {
  final int maxRetryCount;
  late URLBuilder _urlBuilder;

  bool _needAuthentication = false;

  DioBase(this.maxRetryCount) {
    (httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return client;
    };
  }

  static DioBase instance = DioBase(3);

  /// must call when init provider
  void updateBaseOptionsWith(URLBuilder urlBuilder, {BaseOptions? dioOptions}) {
    _urlBuilder = urlBuilder;

    Map<String, dynamic> header = {};

    if (_needAuthentication) {
      header.addAll(AuthManager.getAuthorizationHeader());
    }

    options = dioOptions ??
        BaseOptions(baseUrl: _urlBuilder.build(), headers: header);
  }

  void disableAuthentication() {
    _needAuthentication = false;
  }

  void enableAuthentication() {
    _needAuthentication = true;
  }

  List<Interceptor> get developmentInterceptors {
    var defaultInterceptors = [
      ServiceUnavailableInterceptor(),
    ];

    if (Module.findEnv(of: CoreModule).isProd) {
      return defaultInterceptors;
    }

    return [
      ...defaultInterceptors,
      TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: false,
          )),
    ];
  }

  @override
  Interceptors get interceptors => Interceptors()
    ..addAll([
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.headers['Authorization'] !=
                  AuthManager.getBearerToken() &&
              options.headers['Authorization'] != null &&
              _needAuthentication) {
            options.headers['Authorization'] = AuthManager.getBearerToken();
          }

          handler.next(options);
        },
        onError: (err, handler) async {
          final refreshTokenDetector = get<RefreshTokenRequestDetector>();

          final refreshTokenService = get<IRefreshTokenService>();

          if (err.response?.statusCode != status401Unauthorized) {
            handler.next(err);
            return;
          }

          var shouldRetry = false;
          var attempt = err.requestOptions._attempt + 1;

          if (err.requestOptions.headers["Authorization"] ==
              AuthManager.getBearerToken()) {
            shouldRetry = attempt <= maxRetryCount &&
                await refreshTokenService.refreshToken();
          }

          if (!shouldRetry) {
            handler.next(err);
            return;
          }

          if (refreshTokenDetector.isRefreshTokenRequest(err)) {
            handler.next(err);
            return;
          }

          err.requestOptions._attempt = attempt;

          RequestOptions options = err.requestOptions;
          var currentHeaders = options.headers;
          currentHeaders["Authorization"] = AuthManager.getBearerToken();

          options.copyWith(headers: currentHeaders);

          try {
            await fetch<void>(options).then((value) => handler.resolve(value));
          } on DioException catch (e) {
            handler.next(e);
          }
        },
      ),
    ])
    ..addAll(developmentInterceptors);

  Future<Result<T>> getMethod<T extends Decodable>(ApiRoutesBuilder builder,
      {required T Function() decoder,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      return await super
          .get(builder.buildRoutes(),
              queryParameters: builder.buildParams(),
              cancelToken: cancelToken,
              options: builder.buildOptions(),
              onReceiveProgress: onReceiveProgress)
          .then((value) => _handleResponse(response: value, decoder: decoder))
          .then((value) => Success<T>(value: value));
    } on Exception catch (e, s) {
      talkerLogger.log("Exception: $e\nStackTrace: ${Chain.forTrace(s)}",
          level: LogLevel.error);
      if (e is DioException) {
        var error = CommonError.fromDioError(e);
        final result = Failure<T>(error: error);
        return Future.value(result);
      } else {
        final result =
            Failure<T>(error: CommonError.message("An error occurred!"));
        return Future.value(result);
      }
    }
  }

  Future<Result<T>> postMethod<T extends Decodable>(ApiRoutesBuilder builder,
      {required T Function() decoder,
      CancelToken? cancelToken,
      Function(int, int)? onReceiveProgress,
      Function(int, int)? onSendProgress}) async {
    try {
      return await super
          .post(builder.buildRoutes(),
              queryParameters: builder.buildParams(),
              data: builder.buildBody(),
              options: builder.buildOptions(),
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress,
              onSendProgress: onSendProgress)
          .then((value) => _handleResponse(response: value, decoder: decoder))
          .then((value) => Success<T>(value: value));
    } on Exception catch (e, s) {
      talkerLogger.log("Exception: $e\nStackTrace: ${Chain.forTrace(s)}",
          level: LogLevel.error);
      if (e is DioException) {
        var error = CommonError.fromDioError(e);
        final result = Failure<T>(error: error);
        return Future.value(result);
      } else {
        final result =
            Failure<T>(error: CommonError.message("An error occurred!"));
        return Future.value(result);
      }
    }
  }

  Future<Result<T>> patchMethod<T extends Decodable>(ApiRoutesBuilder builder,
      {required T Function() decoder,
      CancelToken? cancelToken,
      Function(int, int)? onReceiveProgress,
      Function(int, int)? onSendProgress}) async {
    try {
      return await super
          .patch(builder.buildRoutes(),
              queryParameters: builder.buildParams(),
              data: builder.buildBody(),
              options: builder.buildOptions(),
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress,
              onSendProgress: onSendProgress)
          .then((value) => _handleResponse(response: value, decoder: decoder))
          .then((value) => Success<T>(value: value));
    } on Exception catch (e, s) {
      talkerLogger.log("Exception: $e\nStackTrace: ${Chain.forTrace(s)}",
          level: LogLevel.error);
      if (e is DioException) {
        var error = CommonError.fromDioError(e);
        final result = Failure<T>(error: error);
        return Future.value(result);
      } else {
        final result =
            Failure<T>(error: CommonError.message("An error occurred!"));
        return Future.value(result);
      }
    }
  }

  Future<Result<T>> putMethod<T extends Decodable>(ApiRoutesBuilder builder,
      {required T Function() decoder,
      CancelToken? cancelToken,
      Function(int, int)? onReceiveProgress,
      Function(int, int)? onSendProgress}) async {
    try {
      return await super
          .put(builder.buildRoutes(),
              queryParameters: builder.buildParams(),
              data: builder.buildBody(),
              options: builder.buildOptions(),
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress,
              onSendProgress: onSendProgress)
          .then((value) => _handleResponse(response: value, decoder: decoder))
          .then((value) => Success<T>(value: value));
    } on Exception catch (e, s) {
      talkerLogger.log("Exception: $e\nStackTrace: ${Chain.forTrace(s)}",
          level: LogLevel.error);
      if (e is DioException) {
        var error = CommonError.fromDioError(e);
        final result = Failure<T>(error: error);
        return Future.value(result);
      } else {
        final result =
            Failure<T>(error: CommonError.message("An error occurred!"));
        return Future.value(result);
      }
    }
  }

  Future<Result<T>> deleteMethod<T extends Decodable>(ApiRoutesBuilder builder,
      {required T Function() decoder, CancelToken? cancelToken}) async {
    try {
      return await super
          .delete(builder.buildRoutes(),
              queryParameters: builder.buildParams(),
              data: builder.buildBody(),
              cancelToken: cancelToken)
          .then((value) => _handleResponse(response: value, decoder: decoder))
          .then((value) => Success<T>(value: value));
    } on Exception catch (e, s) {
      talkerLogger.log("Exception: $e\nStackTrace: ${Chain.forTrace(s)}",
          level: LogLevel.error);
      if (e is DioException) {
        var error = CommonError.fromDioError(e);
        final result = Failure<T>(error: error);
        return Future.value(result);
      } else {
        final result =
            Failure<T>(error: CommonError.message("An error occurred!"));
        return Future.value(result);
      }
    }
  }

  Future<T> _handleResponse<T extends Decodable>(
      {required Response response, required T Function() decoder}) async {
    if (response.statusCode == null) {
      throw CommonError(message: "Status code is null");
    }

    if (response.statusCode! >= 500) {
      throw CommonError(
          message: "Internal server error!", errorCode: response.statusCode);
    }

    if (response.statusCode! >= 400) {
      throw CommonError(
          message: "Something went wrong!", errorCode: response.statusCode);
    }

    try {
      if (response.data == null) {
        talkerLogger.log("Response data is null", level: LogLevel.warning);
      }

      return decoder()..decode(response.data);
    } catch (e, s) {
      talkerLogger.log(
          "Error while parsing data: $e\nStackTrace: ${Chain.forTrace(s)}",
          level: LogLevel.warning);
      throw CommonError.message("Error while parsing data");
    }
  }
}

extension RequestOptionsX on RequestOptions {
  static const _kAttemptKey = 'ro_attempt';
  static const _kDisableRetryKey = 'ro_disable_retry';

  int get _attempt => (extra[_kAttemptKey] as int?) ?? 0;

  set _attempt(int value) => extra[_kAttemptKey] = value;

  bool get disableRetry => (extra[_kDisableRetryKey] as bool?) ?? false;

  set disableRetry(bool value) => extra[_kDisableRetryKey] = value;
}
