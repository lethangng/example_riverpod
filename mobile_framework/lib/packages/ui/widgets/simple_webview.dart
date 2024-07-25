// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class SimpleWebView extends StatefulWidget {
  final String title;
  final String url;
  final bool loadLocalFile;

  const SimpleWebView({
    super.key,
    required this.title,
    required this.url,
    this.loadLocalFile = false,
  });

  const SimpleWebView.localFile({
    super.key,
    required this.title,
    required this.url,
  }) : loadLocalFile = true;

  const SimpleWebView.remoteFile({
    super.key,
    required this.title,
    required this.url,
  }) : loadLocalFile = false;

  @override
  State<SimpleWebView> createState() => _SimpleWebViewState();

  void show() {
    appRouter.push(SimpleWebRoute(title: title, url: url));
  }
}

class _SimpleWebViewState extends State<SimpleWebView> with GlobalThemePlugin {
  late WebViewController webViewController;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          isLoaded = true;
          setState(() {});
        },
      ));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (widget.loadLocalFile) {
      webViewController.loadFile(widget.url);
    } else {
      webViewController.loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      leading: const Icon(
        Icons.close_rounded,
        size: 28,
      ).center().onTapWidget(radius: 20.0, () {
        appRouter.pop();
      }).center(),
      titleText: widget.title,
      body: isLoaded
          ? WebViewWidget(
              controller: webViewController,
            )
          : Center(
              child: conf.tableViewCenterIndicator,
            ),
    );
  }
}
