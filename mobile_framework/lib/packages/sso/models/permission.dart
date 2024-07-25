// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_cast
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_framework/packages/api/base/json_codable.dart';
import 'package:mobile_framework/packages/sso/base/sso_account_manager.dart';
import 'package:mobile_framework/packages/sso/models/sso_account.dart';

class SSOPermissionManager implements SSOAccountListenable {
  static late Decodable Function() permissionDecoder;
  static final SSOPermissionManager _manager = SSOPermissionManager._();

  bool _isInit = false;

  List<SSOPermission> _currentPermissions = [];

  factory SSOPermissionManager() {
    return _manager;
  }

  Future<void> init() async {
    SSOAccountManager.listenToAccountChange(this);
    _isInit = true;
    _getPermissions();
  }

  void _assertInit() {
    assert(
        _isInit, "SSOPermissionManager is not initialized, please call init()");
  }

  SSOPermissionManager._();

  void _getPermissions() {
    _assertInit();
    _currentPermissions.clear();

    var currentAccount = SSOAccountManager.getCurrentAccount();
    if (currentAccount == null) {
      return;
    }

    if (currentAccount.roles == null) {
      return;
    }

    if (currentAccount.roles!.isEmpty ||
        currentAccount.roles!.contains("owner")) {
      _currentPermissions = [owner];
      return;
    }

    _currentPermissions = currentAccount.roles!
        .split(",")
        .map((e) => (permissionDecoder()..decode(e)) as SSOPermission)
        .toList();
  }

  bool hasPermission(SSOPermission permission) {
    _assertInit();
    if (_currentPermissions.contains(owner)) {
      return true;
    }
    var rawValues = _currentPermissions.map((e) => e.rawValue).toList();

    return rawValues.contains(permission.rawValue);
  }

  bool hasPermissions(List<SSOPermission> permissions) {
    _assertInit();
    var rawValues = _currentPermissions.map((e) => e.rawValue).toList();

    if (rawValues.any((element) => element == owner.rawValue)) {
      return true;
    }

    return permissions.any((element) => rawValues.contains(element.rawValue));
  }

  @override
  void onAccountChange(SSOAccount account) {
    _assertInit();
    _getPermissions();
  }
}

class SSOPermissionGroup {
  List<SSOPermission> permissions;

  SSOPermissionGroup({
    required this.permissions,
  });
}

abstract class SSOPermission {
  String get rawValue;

  SSOPermission();
}

class SSOOwnerPermission extends SSOPermission with EquatableMixin {
  SSOOwnerPermission();

  @override
  // TODO: implement props
  List<Object?> get props => [rawValue];

  @override
  // TODO: implement rawValue
  String get rawValue => "owner";
}

extension SSOPermissionExtension on SSOPermission {
  bool isOwner() {
    return this is SSOOwnerPermission;
  }
}

final owner = SSOOwnerPermission();
