import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/sso/models/token_response.dart';

class RenewTokenUC extends LongRunningUseCase<TokenResponse, dynamic> {
  ISSOAccountRepository repository;

  RenewTokenUC(this.repository);

  @override
  Future<TokenResponse> call({params}) {
    return repository
        .getToken(params)
        .mapToValue()
        .onNullJustReturn(TokenResponse());
  }
}

final renewTokenUCProvider = Provider<RenewTokenUC>((ref) {
  return RenewTokenUC(SSOAccountRepository());
});
