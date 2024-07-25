import 'package:mobile_framework/packages/api/api_version.dart';

class UriComponentsBuilder {
  late Uri _uri;

  UriComponentsBuilder(String uri) {
    _uri = Uri.parse(uri);
  }

  UriComponentsBuilder scheme(String scheme) {
    _uri = _uri.replace(scheme: scheme);
    return this;
  }

  UriComponentsBuilder host(String host) {
    _uri = _uri.replace(host: host);
    return this;
  }

  UriComponentsBuilder port(int port) {
    _uri = _uri.replace(port: port);
    return this;
  }

  UriComponentsBuilder path(String path) {
    _uri = _uri.replace(path: path);
    return this;
  }

  UriComponentsBuilder queryParameters(Map<String, dynamic> queryParameters) {
    _uri = _uri.replace(queryParameters: queryParameters);
    return this;
  }

  UriComponentsBuilder apiPrefix(String prefix) {
    if (_uri.pathSegments.contains(prefix)) return this;
    _uri = _uri.replace(path: '${_uri.path}/$prefix');
    return this;
  }

  UriComponentsBuilder apiVersion(APIVersion version) {
    if (_uri.pathSegments.contains(version.rawValue)) return this;
    _uri = _uri.replace(path: '${_uri.path}/${version.rawValue}');
    return this;
  }

  String build() {
    return _uri.toString();
  }
}
