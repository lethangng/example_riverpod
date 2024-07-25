import 'package:mobile_framework/packages/api/builders/builder.dart';
import 'package:mobile_framework/packages/core/base/app_module.dart';
import 'package:mobile_framework/packages/global/define.dart';
import 'package:mobile_framework/packages/sso/export.dart';
import 'package:mobile_framework/packages/utilities/export.dart';

class S3SSODomainBuilder extends Builder<String> {
  @override
  String build() {
    var env = Module.findEnv(of: SSOModule);
    var fileConfig = get.get<FileConfig>();
    var envType = fileConfig.envType;

    return "https://${S3BucketType.sso.domainName}-${envType.rawValue}.s3.ap-southeast-1.amazonaws.com";
  }
}
