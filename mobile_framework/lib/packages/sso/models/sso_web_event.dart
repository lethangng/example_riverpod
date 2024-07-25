import 'package:mobile_framework/packages/api/base/json_codable.dart';

enum SSOWebEventType {
  onLogin,
  onChangeProfile,

  undefine;

  static fromString(String value) {
    switch (value) {
      case "ON_LOGIN":
        return SSOWebEventType.onLogin;
      case "ON_CHANGE_PROFILE":
        return SSOWebEventType.onChangeProfile;
      default:
        return SSOWebEventType.undefine;
    }
  }
}

class JavaScriptSSOWebBridgeMessage implements Decodable {
  SSOWebErrorData? webError;
  SSOWebData? webData;

  @override
  void decode(json) {
    webError = SSOWebErrorData()..decode(json["error"]);
    webData = SSOWebData()..decode(json["data"]);
  }
}

class SSOWebErrorData implements Decodable {
  @override
  void decode(json) {}
}

class SSOWebData implements Decodable {
  SSOWebEventType type = SSOWebEventType.undefine;
  dynamic data;

  @override
  void decode(json) {
    type = SSOWebEventType.fromString(json["event"]);
    data = json["ssoData"];
  }
}

enum SSOWebDataDelegateTag {
  onLoginTag,
  onChangeProfileTag,
}

abstract class SSOWebDataDelegate {
  Future onReceivedData(JavaScriptSSOWebBridgeMessage message);
}
