import 'package:mobile_framework/mobile_framework.dart';

enum S3BucketType implements StringRawRepresentable {
  ommanilife("OMMANILIFE", "ommanilife"),
  omfarm('OMFARM', "omfarm"),
  omfood("OMFOOD", "omfood"),
  omfarmOrg('OMFARM_ORG', "omfarm-org"),
  issFnb('ISS_FNB', "iss-fnb"),
  iss365('ISS_365', "iss-365"),
  sso('SSO', "oms-sso");

  @override
  final String rawValue;

  final String domainName;

  const S3BucketType(this.rawValue, this.domainName);
}
