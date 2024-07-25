// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unnecessary_cast

import 'package:mobile_framework/packages/api/authentication/auth_manager.dart';
import 'package:mobile_framework/packages/api/authentication/refresh_token_service.dart';
import 'package:mobile_framework/packages/global/define.dart';
import 'package:mobile_framework/packages/sso/base/sso_account_manager.dart';
import 'package:mobile_framework/packages/sso/models/sso_account.dart';
import 'package:mobile_framework/packages/sso/user/data/repositories/sso_account_repository.dart';
import 'package:mobile_framework/packages/sso/user/domain/usecases/get_claim.dart';

abstract class SSOAccountTokenParserDelegate {
  const SSOAccountTokenParserDelegate();

  Future getNewAccessToken();

  Future<SSOAccount?> retrieveSSOAccount() async {
    return await GetClaimUC(SSOAccountRepository())();
  }
}

class DefaultSSOAccountTokenParserDelegate
    extends SSOAccountTokenParserDelegate {
  const DefaultSSOAccountTokenParserDelegate();

  @override
  Future<String?> getNewAccessToken() async {
    var result = await get<IRefreshTokenService>().refreshToken();

    if (result) {
      return AuthManager.getAccessToken();
    }

    return null;
  }
}

class SSOAccountMigrator {
  SSOAccountTokenParserDelegate delegate;

  SSOAccountMigrator({
    this.delegate = const DefaultSSOAccountTokenParserDelegate(),
  });

  /// invoke before [runApp] is called
  Future<void> migrateIfNeeded() async {
    /// get a new access token when user enters app from terminate state
    await delegate.getNewAccessToken();

    var newAccount = await delegate.retrieveSSOAccount();
    SSOAccountManager.saveCurrentAccount(newAccount);
  }
}
