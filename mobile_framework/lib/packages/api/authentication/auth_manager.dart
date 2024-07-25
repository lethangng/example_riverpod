import 'package:get_storage/get_storage.dart';
import 'package:mobile_framework/packages/api/consts.dart';

class AuthManager {
  static final _storage = GetStorage('ommanisoft.auth_manager');

  static Future<bool> init() async {
    return await GetStorage.init('ommanisoft.auth_manager');
  }

  static Future<void> saveAccessToken(String? accessToken) {
    return _storage.write(APIConsts.accessTokenKey, accessToken);
  }

  static void saveRefreshToken(String? accessToken) {
    _storage.write(APIConsts.refreshTokenKey, accessToken);
  }

  static void saveJWTToken(String? accessToken, String? refreshToken) {
    saveAccessToken(accessToken);
    saveRefreshToken(refreshToken);
  }

  static bool checkValidAccessToken() {
    return getAccessToken()?.isNotEmpty ?? false;
  }

  static String? getAccessToken() {
    return _storage.read(APIConsts.accessTokenKey);
  }

  static String? getRefreshToken() {
    return _storage.read(APIConsts.refreshTokenKey);
  }

  static String? getBearerToken() {
    var token = getAccessToken();
    if (token == null) {
      return null;
    }

    return 'Bearer $token';
  }

  static Map<String, dynamic> getAuthorizationHeader() {
    if (getBearerToken() != null) {
      return {"Authorization": getBearerToken()};
    }

    return {};
  }

  static logout() {
    _storage.erase();
  }
}
