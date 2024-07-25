import 'package:mobile_framework/packages/api/api_version.dart';
import 'package:mobile_framework/packages/api/builders/builder.dart';
import 'package:mobile_framework/packages/api/builders/url_components_builder.dart';

/// this builder is used to build api endpoint
/// must be provided a [baseUrl]
abstract class URLBuilder extends Builder<String> {
  String baseUrl;

  URLBuilder(this.baseUrl);
}

class DefaultURLBuilder extends URLBuilder {
  DefaultAPIVersion apiVersion;
  String apiPrefix;

  DefaultURLBuilder(super.baseUrl, this.apiVersion, this.apiPrefix);

  @override
  String build() => UriComponentsBuilder(baseUrl)
      .apiPrefix(apiPrefix)
      .apiVersion(apiVersion)
      .build();
}
