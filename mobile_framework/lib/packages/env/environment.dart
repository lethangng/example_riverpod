// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_framework/mobile_framework.dart';

enum EnvType implements StringRawRepresentable {
  dev,
  staging,
  prod;

  @override
  String get rawValue {
    switch (this) {
      case EnvType.dev:
        return "dev";
      case EnvType.staging:
        return "staging";
      case EnvType.prod:
        return "prod";
    }
  }
}

enum TargetApp {
  omfarm,
  omfood,
  fnbOrder,
  ecommerce,
  iss365,

  none;
}

abstract class EnvExtraKey {}

abstract class Env {
  abstract final String baseUrl;
  abstract final String apiVersion;
  abstract final String fileBaseUrl;
  abstract final TargetApp targetApp;
  abstract final EnvType type;

  final Map<EnvExtraKey, dynamic> _extraKeys = {};

  set(EnvExtraKey key, value) {
    _extraKeys[key] = value;
  }

  get(EnvExtraKey key) {
    return _extraKeys[key];
  }
}

extension EnvExtension on Env {
  bool get isDev => type == EnvType.dev;

  bool get isStaging => type == EnvType.staging;

  bool get isProd => type == EnvType.prod;
}

abstract class EnvInjectable {
  final Env env;

  EnvInjectable(
    this.env,
  );
}
