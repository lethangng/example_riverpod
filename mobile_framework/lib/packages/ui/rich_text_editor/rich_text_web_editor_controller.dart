import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile_framework/packages/ui/rich_text_editor/execution_command_key.dart';

class RichTextWebEditorController {
  @protected
  late Function(String html) setHtmlContentCallback;
  @protected
  late Future<String?> Function() getHtmlContentCallback;
  @protected
  late Function(String command) execCommandCallback;
  @protected
  late Future<dynamic> Function(String command) queryCommandStateCallback;
  @protected
  late final Function() unFocusCallback;

  void setHtmlContent(String html) {
    setHtmlContentCallback(html);
  }

  Future<String?> getHtmlContent() async {
    var html = await getHtmlContentCallback();
    log(html ?? "", name: "RichTextEditor");
    return html;
  }

  void execCommand(String command, {bool? shouldShowUI, Object? parameters}) {
    var rawCommand = "";

    String convertMapToString(Map<ExecutionCommandKey, dynamic> map) {
      return "{${map.entries.map((e) {
        if (e.value is Map) {
          return "${e.key.rawKey}: ${convertMapToString(e.value as Map<ExecutionCommandKey, dynamic>)}";
        }

        if (e.value is String) {
          return "${e.key.rawKey}: '${e.value}'";
        } else if (e.value is bool) {
          return "${e.key.rawKey}: ${e.value}";
        } else if (e.value is List) {
          return "${e.key.rawKey}: ${(e.value as List).join(" ")}";
        } else if (e.value is num) {
          return "${e.key.rawKey}: ${e.value}";
        }
      }).join(", ")}}";
    }

    if (shouldShowUI != null) {
      rawCommand += "'$command', $shouldShowUI, ";
    } else {
      rawCommand += "'$command', ";
    }

    if (parameters != null && parameters is Map<ExecutionCommandKey, dynamic>) {
      rawCommand += convertMapToString(parameters);
    } else if (parameters != null && parameters is Map<String, dynamic>) {
      rawCommand += convertMapToString(parameters.map((key, value) {
        return MapEntry(ExecutionCommandKey.noQuote(key), value);
      }));
    } else if (parameters != null) {
      rawCommand += "'$parameters'";
    }

    execCommandCallback(rawCommand);
  }

  Future<dynamic> queryCommandState(String command) {
    return queryCommandStateCallback(command);
  }

  void unFocus() {
    unFocusCallback();
  }
}
