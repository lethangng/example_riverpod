// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

abstract class SSOApp {
  String get appId;
}

class SSOTokenData {
  dynamic data;

  SSOTokenData({
    required this.data,
  });
}

abstract class SSOAuthDelegate {
  void onReceivedToken(SSOTokenData? token);
}

extension SSOAppId on TargetApp {
  String get appId {
    switch (this) {
      case TargetApp.omfarm:
        return "farm";
      case TargetApp.omfood:
        return "food";
      case TargetApp.fnbOrder:
        return "fnb";
      case TargetApp.ecommerce:
        return "life";
      case TargetApp.iss365:
        return "iss";
      case TargetApp.none:
        throw Exception("Target app is not defined");
    }
  }
}

class SSOConfiguration extends InheritedWidget {
  final Color mainColor;
  final Widget logo;
  final TargetApp app;
  final bool shouldEnableRegisterFeature;
  final TextStyle ssoWebPageTitleTextStyle;

  const SSOConfiguration({
    super.key,
    required this.mainColor,
    required this.logo,
    required this.app,
    required super.child,
    this.ssoWebPageTitleTextStyle = const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    this.shouldEnableRegisterFeature = true,
  });

  static SSOConfiguration? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<SSOConfiguration>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

@RoutePage()
class SSOAuthPage extends StatefulWidget {
  const SSOAuthPage({
    super.key,
  });

  @override
  State<SSOAuthPage> createState() => _SSOAuthPageState();
}

class _SSOAuthPageState extends State<SSOAuthPage> {
  SSOConfiguration? configuration;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    configuration ??= SSOConfiguration.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints(
            maxWidth: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                ? 400
                : double.infinity),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (child) {
                  return SlideAnimation(
                      verticalOffset: 150,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 600),
                      child: FadeInAnimation(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 600),
                        child: child,
                      ));
                },
                children: [
                  configuration?.logo ?? const SizedBox(),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: configuration?.mainColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0))),
                            child: CupertinoButton(
                                child: const Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                onPressed: () {
                                  SSOModule.openSSOLoginWebView();
                                })),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: CupertinoButton(
                              onPressed: () {
                                SSOModule.openSSORegisterWebView();
                              },
                              child: Text(
                                "Đăng ký",
                                style: TextStyle(
                                    color: Colors.grey.shade900,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )),
                        ).paddingOnly(top: 16).visibility(
                            configuration?.shouldEnableRegisterFeature ?? true),
                      ],
                    ),
                  ),
                ])),
      ).center(),
    );
  }
}
