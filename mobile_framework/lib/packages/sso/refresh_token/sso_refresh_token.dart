// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_framework/packages/api/base/json_codable.dart';
import 'package:mobile_framework/packages/sso/base/sso.dart';
import 'package:mobile_framework/packages/sso/base/sso_auth_page.dart';

class SSORefreshTokenRequest implements Encodable {
  String refreshToken;

  SSORefreshTokenRequest({
    required this.refreshToken,
  });

  @override
  Map<String, dynamic> encode() {
    return {
      "refreshToken": refreshToken,
      "service": SSOModule.instance.env.targetApp.appId
    };
  }
}

class SSOAccessToken {
  String? accessToken;
}

class SSOAccessTokenModel extends SSOAccessToken implements Decodable {
  @override
  void decode(json) {
    accessToken = json["token"];
  }
}
