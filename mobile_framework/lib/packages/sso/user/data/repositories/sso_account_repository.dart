import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/sso/models/token_response.dart';

class SSOAccountRepository extends BaseRepository
    implements ISSOAccountRepository {
  SSOAccountRepository() : super(urlBuilder: SSOURLBuilder());

  @override
  ResultFuture<SSOAccount> getSSOAccountDetail() {
    return make.request(path: '/user', decoder: SSOAccountDetailModel()).get();
  }

  @override
  ResultFuture<SSOAccount> getClaims() {
    return make
        .request(path: "/auth/claim", decoder: SSOAccountJWTTokenModel())
        .get();
  }

  @override
  ResultFuture<TokenResponse> getToken(Encodable body) {
    return make
        .request(
            path: "/auth/gettoken",
            body: body.encode(),
            decoder: TokenResponseModel(),
            params: BaseParams()
                .add("service", Module.findEnv(of: SSOModule).targetApp.appId))
        .post();
  }

  @override
  ResultFuture<EmptyResponse> deleteSSOAccount() {
    return make
        .request(path: "/auth/identity/account", decoder: const EmptyResponse())
        .delete();
  }

  @override
  ResultFuture<EmptyResponse> checkUserExisted(String username) {
    return make
        .request(
            path: "/user/check",
            params: BaseParams().add("username", username),
            decoder: const EmptyResponse())
        .get();
  }
}
