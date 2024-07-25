import 'package:get_storage/get_storage.dart';

/// [StorageKey] provides an abtraction of Key for several storage type
///
///
/// ```dart
///   enum OcopKey implements StorageKey {
///     key1, key2;
///
///     String get rawKey => 'ocop_keys.' + this.name;
///   }
/// ```
/// usage:
/// ```dart
///   Storage.save(OcopKey.key1, "some info");
/// ```
///
abstract class StorageKey {
  String get rawKey;
}

/// [Storage] is a local storage of app
/// when saving data, please provide an unique key in [StorageKey] corresponding to it
class Storage {
  static String _containerName = "";

  static final _storage = GetStorage(_containerName);

  static Future<bool> init(String name) async {
    _containerName = name;
    return await GetStorage.init(_containerName);
  }

  static void save(StorageKey key, data) {
    _storage.write(key.rawKey, data);
  }

  static T? get<T>(StorageKey key) {
    return _storage.read<T>(key.rawKey);
  }

  static void clean() async {
    return await _storage.erase();
  }

  static bool hasDataOn(StorageKey key) {
    return _storage.hasData(key.rawKey);
  }
}
