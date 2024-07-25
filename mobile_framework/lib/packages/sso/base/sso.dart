// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/sso/base/sso_retry_request_error_handler.dart';
import 'package:mobile_framework/packages/sso/base/sso_web_view_page.dart';

const ssoLoggerTag = "SSO";

enum SSOAPIVersion implements APIVersion {
  v1;

  @override
  String get rawValue {
    switch (this) {
      case SSOAPIVersion.v1:
        return "/sso/v1";
    }
  }
}

class SSOModule extends Module {
  SSOModule(super.env);

  static SSOModule get instance {
    return get<SSOModule>();
  }

  static late SSOAuthDelegate tokenDelegate;
  static late PageRouteInfo<dynamic> ssoMain;

  String get ssoTargetDomain {
    switch (env.targetApp) {
      case TargetApp.omfarm:
        return getOmfarmTargetDomain();
      case TargetApp.omfood:
        return getOmfoodTargetDomain();
      case TargetApp.fnbOrder:
        return getFnbTargetDomain();
      case TargetApp.ecommerce:
        return getEcommerceTargetDomain();
      case TargetApp.iss365:
        return getIss365TargetDomain();
      case TargetApp.none:
        throw Exception("Target app is not defined");
    }
  }

  String get ssoWebUrl {
    switch (env.type) {
      case EnvType.dev:
        return "https://sso-dev.ommanilife.com";
      case EnvType.staging:
        return "https://accounts.ommani.vn";
      case EnvType.prod:
        return "https://accounts.ommani.vn";
    }
  }

  String get baseUrl {
    switch (env.type) {
      case EnvType.dev:
        return "https://test-farm-api.ommanilife.com";
      // return "http://192.168.1.14:3000";
      case EnvType.staging:
        return "https://api.omfarm.com.vn";
      case EnvType.prod:
        return "https://api.omfarm.com.vn";
    }
  }

  String get loginUrl {
    return "$ssoWebUrl/login?redirectTo=${SSOModule.instance.ssoTargetDomain}&service=${SSOModule.instance.env.targetApp.appId}";
  }

  String get registerUrl {
    return "$ssoWebUrl/register?redirectTo=${SSOModule.instance.ssoTargetDomain}&service=${SSOModule.instance.env.targetApp.appId}";
  }

  String get editProfileUrl =>
      "${SSOModule.instance.ssoWebUrl}/profile?username=${SSOAccountManager.getCurrentAccount()?.userName}&service=${SSOModule.instance.env.targetApp.appId}&redirectTo=${SSOModule.instance.ssoTargetDomain}";

  static void presentSSOWebView({bool isRegister = false}) {
    if (isRegister) {
      openSSORegisterWebView();
    } else {
      openSSOLoginWebView();
    }
  }

  static void presentSSOAuthPage() async {
    AuthManager.logout();
    SSOAccountManager.logout();

    if (!get.isRegistered<RootStackRouter>()) {
      return;
    }

    appRouter.replaceAll([const SSOAuthRoute()], onFailure: (error) {
      log("Failed to push SSOAuthRoute: $error");
    });
  }

  static void presentSSOAccountInformationPage(
    SSOWebDataDelegate delegate,
  ) async {
    get<RootStackRouter>().push(SSOWebRoute(
      url: SSOModule.instance.editProfileUrl,
      title: "Chỉnh sửa thông tin",
      delegate: delegate,
    ));
  }

  static void openSSOLoginWebView() async {
    appRouter.push(SSOWebRoute(
      url: SSOModule.instance.loginUrl,
      title: "Đăng nhập",
      delegate: SSOWebDataLoginDelegate(
        onReceivedToken: (token) {
          SSOModule.tokenDelegate.onReceivedToken(token);
        },
      ),
    ));
  }

  static void openSSORegisterWebView() async {
    appRouter.push(SSOWebRoute(
      url: SSOModule.instance.registerUrl,
      title: "Đăng ký",
      delegate: SSOWebDataLoginDelegate(
        onReceivedToken: (token) {
          SSOModule.tokenDelegate.onReceivedToken(token);
        },
      ),
    ));
  }

  static void enterMainPage() async {
    appRouter.replaceAll([SSOModule.ssoMain]);
  }

  static Future<void> logout({Future Function()? other}) async {
    await AuthManager.logout();
    await SSOAccountManager.logout();
    await other?.call();

    if (get.isRegistered<NotificationService>()) {
      get<NotificationService>().close();
    }

    presentSSOAuthPage();
  }

  static bool isAppNoLongerSignedIn() {
    return !AuthManager.checkValidAccessToken();
  }

  @override
  Future<void> registerDependency() async {
    // TODO: implement registerDependency
    super.registerDependency();

    get
      ..registerSingleton(SSOModule(Module.findEnv(of: SSOModule)))
      ..registerSingleton<RetryRequestErrorHandler>(
          SSORetryRequestErrorHandler())
      ..registerSingleton<IRefreshTokenService>(SSORefreshTokenService(
          refreshTokenRepository: OASSORefreshTokenRepository()))
      ..registerSingleton<RefreshTokenRequestDetector>(
          SSORefreshTokenRequestDetector());
  }
}

extension SSOExts on SSOModule {
  String getOmfarmTargetDomain() {
    switch (env.type) {
      case EnvType.dev:
        return "https://demo.omfarm.com.vn";
      case EnvType.staging:
      case EnvType.prod:
        return "https://omfarm.com.vn";
    }
  }

  String getOmfoodTargetDomain() {
    switch (env.type) {
      case EnvType.dev:
        return "http://test-omfood.ommanilife.com";
      case EnvType.staging:
      case EnvType.prod:
        return "https://omfood.vn";
    }
  }

  String getFnbTargetDomain() {
    switch (env.type) {
      case EnvType.dev:
        return "https://dev-fnb.ommanisoft.com";
      case EnvType.staging:
      case EnvType.prod:
        return "https://omfood.vn";
    }
  }

  String getEcommerceTargetDomain() {
    switch (env.type) {
      case EnvType.dev:
        return "https://dev-fnb.ommanisoft.com";
      case EnvType.staging:
      case EnvType.prod:
        return "https://omfarm.org/store";
    }
  }

  String getIss365TargetDomain() {
    switch (env.type) {
      case EnvType.dev:
        return "https://dev-iss-365.ommani.vn/individual_management/overview";
      case EnvType.staging:
      case EnvType.prod:
        return "https://omfarm.org/store";
    }
  }
}
