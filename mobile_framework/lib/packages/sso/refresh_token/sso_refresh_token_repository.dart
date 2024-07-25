import 'package:mobile_framework/packages/api/base/result_plus.dart';
import 'package:mobile_framework/packages/api/builders/disposable.dart';
import 'package:mobile_framework/packages/sso/refresh_token/sso_refresh_token.dart';

mixin ISSORefreshTokenRepository on Disposable {
  ResultFuture<SSOAccessToken> getRefreshToken(SSORefreshTokenRequest request);
}
