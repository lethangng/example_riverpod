class RichTextWebEditorCssBuilder {
  String? className;
  Map<String, String> properties;

  RichTextWebEditorCssBuilder.withClassName({
    required this.className,
    required this.properties,
  });

  RichTextWebEditorCssBuilder.simple({
    required this.properties,
  });

  @override
  String toString() {
    if (className != null) {
      return """
$className {
  ${properties.entries.map((e) => "${e.key}: ${e.value};").join("\n")}
}
      """;
    } else {
      return """
{
  ${properties.entries.map((e) => "${e.key}: ${e.value};").join("\n")}
}
      """;
    }
  }
}
