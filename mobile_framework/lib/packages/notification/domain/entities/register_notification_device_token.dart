// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mobile_framework/packages/api/base/json_codable.dart';

class RegisterNotificationDeviceTokenRequest implements Encodable {
  String? deviceToken;

  RegisterNotificationDeviceTokenRequest({
    this.deviceToken,
  });

  @override
  Map<String, dynamic> encode() {
    return {"token": deviceToken};
  }
}
