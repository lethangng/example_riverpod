import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';

class PrettyDioLogger extends Interceptor {
  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// InitialTab count to components.add json response
  static const int kInitialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Print compact json response
  final bool compact;

  /// Width size per components.add
  final int maxWidth;

  /// Size in which the Uint8List will be splitted
  static const int chunkSize = 20;

  /// Log printer; defaults components.add log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  final void Function(Object object) logPrint;

  final List<String> components = [];

  PrettyDioLogger(
      {this.request = true,
      this.requestHeader = true,
      this.requestBody = true,
      this.responseHeader = false,
      this.responseBody = true,
      this.error = true,
      this.maxWidth = 90,
      this.compact = true,
      this.logPrint = print});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (request) {
      _printRequestHeader(options);
    }
    if (requestHeader) {
      _printMapAsTable(options.queryParameters, header: 'Query Parameters');
      final requestHeaders = <String, dynamic>{};
      requestHeaders.addAll(options.headers);
      requestHeaders['contentType'] = options.contentType?.toString();
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout?.toString();
      requestHeaders['receiveTimeout'] = options.receiveTimeout?.toString();
      _printMapAsTable(requestHeaders, header: 'Headers');
      _printMapAsTable(options.extra, header: 'Extras');
    }
    if (requestBody && options.method != 'GET') {
      final dynamic data = options.data;
      if (data != null) {
        if (data is Map) _printMapAsTable(options.data as Map?, header: 'Body');
        if (data is FormData) {
          final formDataMap = <String, dynamic>{}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(formDataMap, header: 'Form data | ${data.boundary}');
        } else {
          _printBlock(data.toString());
        }
      }
    }

    logPrint("""
    ${components.join(' \n\t')}
    """);
    components.clear();
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      if (err.type == DioExceptionType.badResponse) {
        final uri = err.response?.requestOptions.uri;
        _printBoxed(
            header:
                'DioError | Status: ${err.response?.statusCode} ${err.response?.statusMessage}',
            text: uri.toString());
        if (err.response != null && err.response?.data != null) {
          components.add('╔ ${err.type.toString()}');
          _printResponse(err.response!);
        }
        _printLine('╚');
        components.add('');
      } else {
        _printBoxed(
            header: 'DioError  ${err.type}',
            text: err.error?.toString() ?? err.message);
      }
    }
    logPrint("""
    ${components.join(' \n\t')}
    """);
    components.clear();
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printResponseHeader(response);
    if (responseHeader) {
      final responseHeaders = <String, String>{};
      response.headers
          .forEach((k, list) => responseHeaders[k] = list.toString());
      _printMapAsTable(responseHeaders, header: 'Headers');
    }

    if (responseBody) {
      components.add('╔ Body');
      components.add('');
      _printResponse(response);
      components.add('');
      _printLine('╚');
    }
    logPrint("""
    ${components.join(' \n\t')}
    """);
    components.clear();
    super.onResponse(response, handler);
  }

  void _printBoxed({String? header, String? text}) {
    components.add("""
    \n\t╔ $header
      $text
    ${_appendLine('╚')}
    """);
  }

  void _printResponse(Response response) {
    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(response.data as Map);
      } else if (response.data is Uint8List) {
        components.add('${_indent()}[');
        _printUint8List(response.data as Uint8List);
        components.add('${_indent()}]');
      } else if (response.data is List) {
        components.add('${_indent()}[');
        _printList(response.data as List);
        components.add('${_indent()}]');
      } else {
        _printBlock(response.data.toString());
      }
    }
  }

  void _printResponseHeader(Response response) {
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;
    _printBoxed(
        header:
            'Response | $method | Status: ${response.statusCode} ${response.statusMessage}',
        text: uri.toString());
  }

  void _printRequestHeader(RequestOptions options) {
    final uri = options.uri;
    final method = options.method;
    _printBoxed(header: 'Request | $method ', text: uri.toString());
  }

  void _printLine([String pre = '', String suf = '╝']) =>
      components.add('$pre${'═' * maxWidth}$suf');

  String _appendLine([String pre = '', String suf = '╝']) {
    return '$pre${'═' * maxWidth}$suf';
  }

  void _printKV(String? key, Object? v) {
    final pre = ' "$key": ';
    final msg = v.toString();

    if (pre.length + msg.length > maxWidth) {
      components.add(pre);
      _printBlock(msg);
    } else {
      components.add('$pre$msg');
    }
  }

  void _printBlock(String msg) {
    final lines = (msg.length / maxWidth).ceil();
    for (var i = 0; i < lines; ++i) {
      components.add((i >= 0 ? ' ' : '') +
          msg.substring(i * maxWidth,
              math.min<int>(i * maxWidth + maxWidth, msg.length)));
    }
  }

  String _indent([int tabCount = kInitialTab]) => tabStep * tabCount;

  void _printPrettyMap(
    Map data, {
    int initialTab = kInitialTab,
    bool isListItem = false,
    bool isLast = false,
  }) {
    var tabs = initialTab;
    final isRoot = tabs == kInitialTab;
    final initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) components.add('$initialIndent{');

    data.keys.toList().asMap().forEach((index, dynamic key) {
      final isLast = index == data.length - 1;
      dynamic value = data[key];

      if (value is String) {
        value = '"${value.toString().replaceAll(RegExp(r'([\r\n])+'), " ")}"';
      }

      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          components
              .add('${_indent(tabs)} "$key": $value${!isLast ? ',' : ''}');
        } else {
          components.add('${_indent(tabs)} "$key": {');
          _printPrettyMap(value, initialTab: tabs);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value)) {
          components.add(
              '${_indent(tabs)} "$key": ${value.toString()}${isLast ? '' : ','}');
        } else {
          components.add('${_indent(tabs)} "$key": [');
          _printList(value, tabs: tabs);
          components.add('${_indent(tabs)} ]${isLast ? '' : ','}');
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(tabs);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final lines = (msg.length / linWidth).ceil();
          for (var i = 0; i < lines; ++i) {
            components.add(
                '${_indent(tabs)} ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}');
          }
        } else {
          components.add('${_indent(tabs)} "$key": $msg${!isLast ? ',' : ''}');
        }
      }
    });

    components.add('$initialIndent}${!isLast ? ',' : ''}');
  }

  void _printList(List list, {int tabs = kInitialTab}) {
    list.asMap().forEach((i, dynamic e) {
      var value = e;

      if (value is String) {
        value = '"${value.replaceAll(RegExp(r'([\r\n])+'), " ")}"';
      }

      final isLast = i == list.length - 1;
      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          components.add('${_indent(tabs)}  $value${!isLast ? ',' : ''}');
        } else {
          _printPrettyMap(value,
              initialTab: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        components.add('${_indent(tabs + 2)} $value${isLast ? '' : ','}');
      }
    });
  }

  void _printUint8List(Uint8List list, {int tabs = kInitialTab}) {
    var chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
            i, i + chunkSize > list.length ? list.length : i + chunkSize),
      );
    }
    for (var element in chunks) {
      components.add('${_indent(tabs)} ${element.join(", ")}');
    }
  }

  bool _canFlattenMap(Map map) {
    return map.values
            .where((dynamic val) => val is Map || val is List)
            .isEmpty &&
        map.toString().length < maxWidth;
  }

  bool _canFlattenList(List list) {
    return list.length < 10 && list.toString().length < maxWidth;
  }

  void _printMapAsTable(Map? map, {String? header}) {
    if (map == null || map.isEmpty) return;
    components.add('╔ $header ');
    map.forEach((dynamic key, dynamic value) {
      if (value is MultipartFile) {
        _printKV(key.toString(), multipartFileToJson(value));
      } else if (value is List<MultipartFile>) {
        _printKV(
            key.toString(), value.map((e) => multipartFileToJson(e)).toList());
      } else {
        _printKV(key.toString(), value);
      }
    });
    _printLine('╚');
  }
}

String multipartFileToJson(MultipartFile file) {
  return "MultipartFile(length: ${file.length}, filename: ${file.filename}, contentType: ${file.contentType})";
}
