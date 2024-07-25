import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/sso/models/token_response.dart';

abstract interface class ISSOAccountRepository {
  ResultFuture<SSOAccount> getSSOAccountDetail();
  ResultFuture<SSOAccount> getClaims();
  ResultFuture<TokenResponse> getToken(Encodable body);
  ResultFuture<EmptyResponse> deleteSSOAccount();

  ResultFuture<EmptyResponse> checkUserExisted(String username);
}
