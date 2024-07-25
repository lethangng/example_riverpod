// ignore_for_file: unnecessary_cast

import 'dart:async';

import 'package:isar/isar.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:path_provider/path_provider.dart';

abstract interface class SSOAccountListenable {
  void onAccountChange(SSOAccount account);
}

class SSOAccountManager {
  static late Isar _accountSchema;
  static SSOAccount? _currentAccount;
  static List<SSOAccount> _savedAccounts = [];
  static bool _isInit = false;

  static final Map<int, StreamSubscription<SSOAccount>> _accountListeners = {};
  static final ReplaySubject<SSOAccount> _accountReplaySubject = ReplaySubject(
    maxSize: 1,
    onListen: () {
      talkerLogger.log(
          "[SSOAccountManager] New subscriber for account stream has been added",
          level: LogLevel.info);
    },
  );

  static bool isInitialized() {
    return _isInit;
  }

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isInit = true;
    _accountSchema = await Isar.open([SSOAccountSchema], directory: dir.path);

    await SSOPermissionManager().init();
    await SSOAccountMigrator().migrateIfNeeded();
  }

  static bool hasNoAccountLoggedIn() {
    return getCurrentAccount() == null;
  }

  static SSOAccount? getCurrentAccount() {
    _assertInitStorage();
    return _currentAccount;
  }

  static void saveCurrentAccount(SSOAccount? account) {
    _assertInitStorage();
    if (account == null) {
      return;
    }

    account.makeCurrent();
    _removeAndUpdateAccount(account);
    _currentAccount = account;

    /// react to new account change
    _accountReplaySubject.add(account);
  }

  static void switchToAccount(SSOAccount? account) {
    _assertInitStorage();
    if (_currentAccount?.userId != account?.userId) {
      _currentAccount?.removeCurrent();
      _removeAndUpdateAccount(_currentAccount);

      saveCurrentAccount(account);
    }
  }

  static List<SSOAccount> getAccounts() {
    _assertInitStorage();
    if (_savedAccounts.isNotEmpty) {
      return _savedAccounts;
    }

    _savedAccounts = _accountSchema.sSOAccounts.where().findAllSync();

    return _savedAccounts;
  }

  static logout() {
    _assertInitStorage();
    if (_currentAccount == null) {
      return;
    }

    _currentAccount!.removeCurrent();
    _removeAndUpdateAccount(_currentAccount);
    _currentAccount = null;
  }

  static List<String> getRoles() {
    _assertInitStorage();
    return getCurrentAccount()?.roles?.split(",").toList() ?? [];
  }

  static _assertInitStorage() {
    assert(_isInit,
        "Calling `await SSOAccountManager.init()` before calling runApp()");
  }

  static _removeAndUpdateAccount(SSOAccount? account) {
    if (account == null) {
      return;
    }

    _accountSchema.writeTxnSync(() {
      _accountSchema.sSOAccounts
          .filter()
          .userIdEqualTo(account.userId)
          .deleteAllSync();

      _accountSchema.sSOAccounts.putSync(account);
    });
  }

  static void listenToAccountChange(SSOAccountListenable listener) {
    _accountListeners[listener.hashCode] =
        _accountReplaySubject.listen((event) {
      listener.onAccountChange(event);
    });
  }

  static void removeListener(SSOAccountListenable listener) {
    _accountListeners[listener.hashCode]?.cancel();
    _accountListeners.remove(listener.hashCode);
  }
}
