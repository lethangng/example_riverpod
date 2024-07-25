// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_cast

import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/sso/user/domain/usecases/get_claim.dart';

@RoutePage()
class SSOWebPage extends ConsumerStatefulWidget {
  final String url;
  final String title;
  final SSOWebDataDelegate delegate;

  const SSOWebPage({
    super.key,
    required this.url,
    required this.title,
    required this.delegate,
  });

  @override
  ConsumerState<SSOWebPage> createState() => _SSOWebPageState();
}

class _SSOWebPageState extends ConsumerState<SSOWebPage> {
  late WebViewController webViewController;

  SSOConfiguration? configuration;

  bool isWebLoaded = false;
  bool shouldShowCoverContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    webViewController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        "sendToMobile",
        onMessageReceived: (jsMessage) async {
          setState(() {
            shouldShowCoverContainer = true;
          });

          var map = jsonDecode(jsMessage.message);
          await widget.delegate
              .onReceivedData(JavaScriptSSOWebBridgeMessage()..decode(map));
          setState(() {
            shouldShowCoverContainer = false;
          });
        },
      )
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          isWebLoaded = true;
          setState(() {});
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    configuration ??= SSOConfiguration.of(context);
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: configuration?.mainColor,
              leading: Container(
                height: 44,
                width: 44,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22))),
                child: InkWell(
                  radius: 22,
                  borderRadius: const BorderRadius.all(Radius.circular(22)),
                  onTap: () {
                    appRouter.pop();
                  },
                  child: const Icon(CupertinoIcons.clear),
                ),
              ),
              title: Text(
                widget.title,
                style: configuration?.ssoWebPageTitleTextStyle,
              ),
            ),
            body: WebViewWidget(
              controller: webViewController,
            ).animate(target: shouldShowCoverContainer ? 0 : 1, effects: [
              const FadeEffect(begin: 0, end: 1, curve: Curves.fastOutSlowIn)
            ])),
        IgnorePointer(
          ignoring: true,
          child: Container(
            child: ref.theme.loadingIndicator,
          ).animate(target: isWebLoaded ? 0 : 1, effects: [
            const FadeEffect(begin: 0, end: 1, curve: Curves.fastOutSlowIn)
          ]),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            color: Colors.white,
            child: Center(child: ref.theme.loadingIndicator),
          ).animate(target: shouldShowCoverContainer ? 1 : 0, effects: [
            const FadeEffect(begin: 0, end: 1, curve: Curves.fastOutSlowIn)
          ]),
        )
      ],
    );
  }
}

class SSOToken {
  String? refreshToken;
  String? accessToken;

  SSOToken({
    this.refreshToken,
    this.accessToken,
  });

  bool get isInvalid {
    return refreshToken == null || accessToken == null;
  }
}

class SSOWebDataLoginDelegate extends SSOWebDataDelegate with RefCompatible {
  final Function(SSOTokenData? token) onReceivedToken;

  SSOWebDataLoginDelegate({required this.onReceivedToken});

  @override
  Future onReceivedData(JavaScriptSSOWebBridgeMessage message) async {
    var accessToken = message.webData?.data["token"];
    var refreshToken = message.webData?.data["refreshToken"];

    var token = SSOToken(accessToken: accessToken, refreshToken: refreshToken);

    if (token.isInvalid) {
      return;
    }

    AuthManager.saveJWTToken(token.accessToken, token.refreshToken);

    await GetClaimUC(SSOAccountRepository())().then((account) {
      SSOAccountManager.saveCurrentAccount(account);

      appRouter.maybePop();

      onReceivedToken(SSOTokenData(data: account));
    });
  }
}
