// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:async/async.dart' hide Result, ResultFuture;
import 'package:flutter/foundation.dart';
import 'package:mobile_framework/packages/api/base/dio_base.dart';
import 'package:mobile_framework/packages/api/export.dart';

/// [RequestMaker] is a builder for http request components
///
/// We can change the request's components more flexible
class RequestMaker implements ApiRoutesBuilder {
  URLBuilder _urlBuilder;
  String _path = "";
  Map<String, dynamic> _params = {};
  Options? _options;
  dynamic _body;
  bool _noAuthenticationNeeded = false;
  BaseOptions? baseOptions;
  CancelToken? token;
  late Decodable decoder;

  RequestMaker._(URLBuilder urlBuilder) : _urlBuilder = urlBuilder;

  factory RequestMaker(URLBuilder urlBuilder) {
    return RequestMaker._(urlBuilder);
  }

  DioBase get dioBase => DioBase.instance;

  @Deprecated("Use cancelable to wrap request instead")
  RequestMaker cancelBy(Disposable disposable) {
    var token = CancelToken();
    disposable.addCancelToken(token);
    this.token = token;
    return this;
  }

  RequestMaker noAuthenticationNeeded() {
    _noAuthenticationNeeded = true;
    return this;
  }

  @Deprecated("Use request instead")
  RequestMaker create({
    required String path,
    Decodable decoder = const EmptyResponse(),
    ParametersBuildable? params,
    dynamic body,
    Options? options,
    BaseOptions? baseOptions,
    CancelToken? token,
  }) {
    _path = path;
    _params = (params?.buildParams()) ?? {};
    _options = options;
    _body = body;
    this.baseOptions = baseOptions;
    this.decoder = decoder;

    if (token != null) {
      this.token = token;
    }

    return this;
  }

  RequestMaker request({
    required String path,
    required Decodable decoder,
    ParametersBuildable? params,
    dynamic body,
    Options? options,
    BaseOptions? baseOptions,
  }) {
    _path = path;
    _params = (params?.buildParams()) ?? {};
    _options = options;
    _body = body;
    this.baseOptions = baseOptions;
    this.decoder = decoder;
    return this;
  }

  @protected
  @override
  String buildRoutes() {
    return _path;
  }

  @protected
  @override
  Map<String, dynamic>? buildParams() {
    return _params;
  }

  @protected
  @override
  buildBody() {
    return _body;
  }

  @protected
  @override
  Options? buildOptions() {
    return _options;
  }

  @Deprecated("No longer support, now request is cancelable by default")
  RequestMaker cancelable() {
    token = CancelToken();
    return this;
  }

  ResultFuture<T> get<T>() {
    if (_noAuthenticationNeeded) {
      dioBase.disableAuthentication();
    } else {
      dioBase.enableAuthentication();
    }

    dioBase.updateBaseOptionsWith(_urlBuilder, dioOptions: baseOptions);

    return _makeCancelable<T>((token) => dioBase.getMethod(this, decoder: () {
          return decoder;
        }, cancelToken: token).as<T>());
  }

  ResultFuture<T> post<T>() {
    if (_noAuthenticationNeeded) {
      dioBase.disableAuthentication();
    } else {
      dioBase.enableAuthentication();
    }
    dioBase.updateBaseOptionsWith(_urlBuilder, dioOptions: baseOptions);
    return _makeCancelable<T>((token) => dioBase.postMethod(this, decoder: () {
          return decoder;
        }, cancelToken: token).as<T>());
  }

  ResultFuture<T> put<T>() {
    if (_noAuthenticationNeeded) {
      dioBase.disableAuthentication();
    } else {
      dioBase.enableAuthentication();
    }
    dioBase.updateBaseOptionsWith(_urlBuilder, dioOptions: baseOptions);
    return _makeCancelable<T>((token) => dioBase.putMethod(this, decoder: () {
          return decoder;
        }, cancelToken: token).as<T>());
  }

  ResultFuture<T> patch<T>() {
    if (_noAuthenticationNeeded) {
      dioBase.disableAuthentication();
    } else {
      dioBase.enableAuthentication();
    }
    dioBase.updateBaseOptionsWith(_urlBuilder, dioOptions: baseOptions);
    return _makeCancelable<T>((token) => dioBase.patchMethod(this, decoder: () {
          return decoder;
        }, cancelToken: token).as<T>());
  }

  ResultFuture<T> delete<T>() {
    if (_noAuthenticationNeeded) {
      dioBase.disableAuthentication();
    } else {
      dioBase.enableAuthentication();
    }
    dioBase.updateBaseOptionsWith(_urlBuilder, dioOptions: baseOptions);
    return _makeCancelable<T>(
        (token) => dioBase.deleteMethod(this, decoder: () {
              return decoder;
            }, cancelToken: token).as<T>());
  }

  CancelableOperation<Result<T>> _makeCancelable<T>(
      Future<Result<T>> Function(CancelToken token) request) {
    _assertDecoderReturnType<T>();
    final token = CancelToken();
    CancelableOperation<Result<T>> operation = CancelableOperation.fromFuture(
      request(token),
      onCancel: () {
        String reason;
        if (token.requestOptions != null) {
          reason =
              'Request ${token.requestOptions?.baseUrl}${token.requestOptions?.path} has been canceled';
        } else {
          reason = 'Request has been canceled';
        }

        token.cancel(reason);
      },
    );
    return operation;
  }

  void _assertDecoderReturnType<T>() {
    assert(decoder is T, "Decoder must be of a subtype $T");
  }
}
