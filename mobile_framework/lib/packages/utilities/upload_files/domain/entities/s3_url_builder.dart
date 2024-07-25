import 'package:mobile_framework/mobile_framework.dart';

class S3UrlBuilder extends URLBuilder {
  S3UrlBuilder() : super("") {
    baseUrl = Module.findEnv(of: FileModule).fileBaseUrl;
  }

  @override
  String build() {
    return UriComponentsBuilder(baseUrl)
        .apiVersion(StringAPIVersion("v1"))
        .apiPrefix("/s3")
        .build();
  }
}
