import 'package:mobile_framework/mobile_framework.dart';

class CommonURLBuilder extends URLBuilder {
  APIVersion apiVersion;

  CommonURLBuilder(super.baseUrl, this.apiVersion);

  factory CommonURLBuilder.module(Type module) {
    return CommonURLBuilder(Module.findEnv(of: module).baseUrl,
        StringAPIVersion(Module.findEnv(of: module).apiVersion));
  }

  @override
  String build() {
    return baseUrl + apiVersion.rawValue;
  }
}
