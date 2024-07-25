// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_framework/packages/api/base/base_repository.dart';
import 'package:mobile_framework/packages/api/base/result_plus.dart';
import 'package:mobile_framework/packages/api/builders/disposable.dart';
import 'package:mobile_framework/packages/api/builders/url_builder.dart';
import 'package:mobile_framework/packages/sso/base/sso.dart';
import 'package:mobile_framework/packages/sso/refresh_token/sso_refresh_token.dart';
import 'package:mobile_framework/packages/sso/refresh_token/sso_refresh_token_repository.dart';

class SSOURLBuilder implements URLBuilder {
  @override
  String baseUrl;

  SSOURLBuilder() : baseUrl = SSOModule.instance.baseUrl;

  @override
  String build() {
    return baseUrl + SSOAPIVersion.v1.rawValue;
  }
}

class OASSORefreshTokenRepository extends BaseRepository
    with Disposable
    implements ISSORefreshTokenRepository {
  OASSORefreshTokenRepository() : super(urlBuilder: SSOURLBuilder());

  @override
  ResultFuture<SSOAccessToken> getRefreshToken(SSORefreshTokenRequest request) {
    return make
        .request(
            path: "/auth/refresh-token",
            body: request.encode(),
            decoder: SSOAccessTokenModel())
        .noAuthenticationNeeded()
        .post();
  }
}
