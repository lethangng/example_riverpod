import 'package:mobile_framework/packages/ui/rich_text_editor/rich_text_function.dart';

class RichTextWebEditorInitializer {
  Map<String, dynamic> init;
  String editorId;

  RichTextWebEditorInitializer({
    required this.init,
    required this.editorId,
  })  : assert(!init.containsKey("selector"),
            "Please set selector id in editorId property"),
        assert(!editorId.contains("#"), "editorId must not contain # symbol") {
    init["selector"] = "textarea#$editorId";
  }

  @override
  String toString() {
    return """
{
  ${init.entries.map((e) {
      String convertMapToString(Map<String, dynamic> map) {
        return "{${map.entries.map((e) {
          if (e.value is Map) {
            return "${e.key}: ${convertMapToString(e.value as Map<String, dynamic>)}";
          }

          if (e.value is String) {
            return "${e.key}: '${e.value}'";
          } else if (e.value is bool) {
            return "${e.key}: ${e.value}";
          } else if (e.value is List) {
            return "${e.key}: ${(e.value as List).map((e) {
              if (e is Map<String, dynamic>) {
                return convertMapToString(e);
              } else {
                return "'$e'";
              }
            })}";
          } else if (e.value is num) {
            return "${e.key}: '${e.value}'";
          }
        }).join(", ")}}";
      }

      if (e.value is Map) {
        return "${e.key}: ${convertMapToString(e.value as Map<String, dynamic>)}";
      } else if (e.value is RawAnonymousFunction) {
        return "${e.key}: ${e.value.toString()}";
      } else if (e.value is RawFunction) {
        return "${e.key}: ${e.value.toString()}";
      } else {
        return "${e.key}: '${e.value}'";
      }
    }).join(", ")}
}
    """;
  }
}
