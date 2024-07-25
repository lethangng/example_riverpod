// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_framework/packages/api/export.dart';
import 'package:mobile_framework/packages/global/define.dart';
import 'package:mobile_framework/packages/sso/refresh_token/sso_refresh_token.dart';
import 'package:mobile_framework/packages/sso/refresh_token/sso_refresh_token_repository.dart';

class SSORefreshTokenService extends IRefreshTokenService {
  @override
  bool isRefreshToken = false;

  final ISSORefreshTokenRepository refreshTokenRepository;

  SSORefreshTokenService({
    required this.refreshTokenRepository,
  });

  @override
  Future<bool> refreshToken() async {
    if (isRefreshToken) {
      return false;
    }

    isRefreshToken = true;

    var request = SSORefreshTokenRequest(
      refreshToken: AuthManager.getRefreshToken() ?? "",
    );

    return await refreshTokenRepository
        .getRefreshToken(request)
        .onSuccess((value) {
          AuthManager.saveAccessToken(value.accessToken);
          isRefreshToken = false;
        })
        .onError(
          (error) {
            isRefreshToken = false;
            get<RetryRequestErrorHandler>().onRefreshTokenError();
          },
        )
        .next()
        .then((value) => value.isSuccess);
  }
}

class SSORefreshTokenRequestDetector implements RefreshTokenRequestDetector {
  @override
  bool isRefreshTokenRequest(DioException exp) {
    return exp.requestOptions.path == "/auth/refresh-token";
  }
}
