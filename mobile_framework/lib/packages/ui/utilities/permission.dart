import 'package:mobile_framework/packages/ui/utilities/storage.dart';

enum PermissionKey implements StorageKey {
  allowedPermissions;

  @override
  String get rawKey => 'ommanisoft.permissions.$name';
}

abstract class Permission {
  abstract final String rawValue;
}

abstract class DPPermissionManager<T extends Permission> {
  List<T> _allowedPermissions = [];

  void addPermissions(List<T> permissions) {
    _allowedPermissions = permissions;
    savePermissions(permissions);
  }

  bool hasPermission(T p);

  bool hasPermissions(List<T> permissions);

  void savePermissions(List<T> permissions) {
    var rawPermissions = permissions.map((e) => e.rawValue).toList();
    Storage.save(PermissionKey.allowedPermissions, rawPermissions);
  }

  List<T> getPermissions() {
    if (_allowedPermissions.isNotEmpty) {
      return List.from(_allowedPermissions);
    }

    List<String> permissions =
        (Storage.get(PermissionKey.allowedPermissions) as List)
            .map((e) => e as String)
            .toList();

    _allowedPermissions
        .addAll(permissions.map((e) => convertPermissionFrom(e)).toList());

    return List.from(_allowedPermissions);
  }

  T convertPermissionFrom(String rawPermission);
}
