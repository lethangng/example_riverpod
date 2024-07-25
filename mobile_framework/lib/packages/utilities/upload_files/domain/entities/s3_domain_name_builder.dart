import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/api/builders/builder.dart';

class S3DomainBuilder extends Builder<String> {
  @override
  String build() {
    var env = Module.findEnv(of: FileModule);
    var fileConfig = get.get<FileConfig>();
    var s3BucketType = fileConfig.bucketType;
    var envType = fileConfig.envType;

    return "https://${s3BucketType.domainName}-${envType.rawValue}.s3.ap-southeast-1.amazonaws.com";
  }
}
