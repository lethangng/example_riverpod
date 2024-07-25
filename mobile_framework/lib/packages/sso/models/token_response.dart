import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/sso/base/sso_web_view_page.dart';

class TokenResponse {
  SSOToken? token;
  SSOAccount? account;
}

class TokenResponseModel extends TokenResponse implements Decodable {
  @override
  void decode(json) {
    token = SSOToken(
        refreshToken: json["refreshToken"], accessToken: json["token"]);
    account = SSOAccountJWTTokenModel()..decode(json["claims"]);
  }
}
