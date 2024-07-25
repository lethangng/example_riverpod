import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class RichTextWebEditor extends ConsumerStatefulWidget {
  String initialHtml;
  RichTextWebEditorController controller;
  String height;
  FocusNode focusNode;

  RichTextWebEditorInitializer initializer;
  List<RichTextWebEditorCssBuilder> cssListBuilder;

  @override
  ConsumerState<RichTextWebEditor> createState() => _RichTextWebEditorState();

  RichTextWebEditor({
    super.key,
    required this.initialHtml,
    required this.controller,
    required this.height,
    required this.initializer,
    required this.cssListBuilder,
    required this.focusNode,
  });
}

class _RichTextWebEditorState extends ConsumerState<RichTextWebEditor> {
  String get editorSourceCode => """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.ommani.net/tinymce/tinymce.min.js?v=2"
            referrerpolicy="origin"></script>
        
    <script>
        tinymce.init(${widget.initializer.toString()});
    </script>

    <style>
      body {
        background-color: #FFFFFF;  // Set the background color to white
      }
      textarea {
        background-color: #FFFFFF;  // Set the background color of textarea to white
      }
      ${widget.cssListBuilder.map((e) => e.toString()).join("\n")}
    </style>
</head>

<body>
<textarea id="${widget.initializer.editorId}" style="width: 100%, height: ${widget.height} background-color:white;"></textarea>
</body>
</html>
  """;

  late InAppWebViewController controller;
  bool isWebViewVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller.setHtmlContentCallback = (String html) {
      controller.evaluateJavascript(source: "setContentHtml('$html')");
    };

    widget.controller.getHtmlContentCallback = () async {
      return (await controller.evaluateJavascript(
          source: "tinymce.activeEditor.getContent()")) as String?;
    };

    widget.controller.queryCommandStateCallback = (String command) {
      return controller.evaluateJavascript(
          source: "tinymce.activeEditor.queryCommandState($command)");
    };

    widget.controller.execCommandCallback = (String command) {
      controller.evaluateJavascript(
          source: "tinymce.activeEditor.execCommand($command)");
    };

    widget.controller.unFocusCallback = () {
      controller.evaluateJavascript(source: "tinymce.activeEditor.blur()");
    };

    log(editorSourceCode, name: "RichTextEditor");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedCrossFade(
        crossFadeState: isWebViewVisible
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: SizedBox(
            height: 30,
            width: 30,
            child: Platform.isAndroid
                ? CircularProgressIndicator(
                    color: ref.theme.mainColor,
                  )
                : const CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 15,
                    animating: true,
                  )),
        secondChild: InAppWebView(
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          gestureRecognizers: {}..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
          initialSettings: InAppWebViewSettings(
            supportZoom: false,
            isInspectable: true,
          ),
          onConsoleMessage: (controller, consoleMessage) {
            log(consoleMessage.message);
          },
          onReceivedError: (controller, request, error) {
            log(error.toString());
          },
          onLoadStart: (controller, url) {
            isWebViewVisible = false;
          },
          onLoadStop: (controller, url) {
            controller.addJavaScriptHandler(
              handlerName: "sendToggleState",
              callback: (arguments) {
                ref.read(richTextButtonsProvider.notifier).state =
                    (ToggleStateButtons()..decode(jsonDecode(arguments.first)))
                        .buttons;
              },
            );
            controller.addJavaScriptHandler(
              handlerName: "setVisibleEditor",
              callback: (arguments) {
                isWebViewVisible = arguments.first as bool;
                setState(() {});
              },
            );

            controller.addJavaScriptHandler(
              handlerName: "onFocusChanged",
              callback: (arguments) {
                if (arguments.first) {
                  widget.focusNode.requestFocus();
                } else {
                  widget.focusNode.unfocus();
                }
              },
            );
          },
          initialData: InAppWebViewInitialData(data: editorSourceCode),
        ),
        duration: 200.milliseconds,
        alignment: Alignment.center,
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            children: [
              Positioned(
                key: bottomChildKey,
                child: bottomChild,
              ),
              Positioned(
                key: topChildKey,
                child: topChild,
              ),
            ],
          );
        },
      ),
    );
  }
}
