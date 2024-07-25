import 'package:mobile_framework/packages/ui/suggestions/input_accessory_text_editing_controller.dart';

abstract interface class InputAccessoryViewTextParsable<
    T extends SuggestionItem> {
  String convertToSuggestionText(String target);

  List<T> extractSuggestionItems(String target);
}

class DefaultInputAccessoryViewTextParser
    implements InputAccessoryViewTextParsable<DefaultSuggestionItem> {
  final String regex;

  const DefaultInputAccessoryViewTextParser({
    this.regex = r"[\[](.+?)[\]]\((\d+)\)",
  });

  @override
  List<DefaultSuggestionItem> extractSuggestionItems(String target) {
    var matches = RegExp(regex).allMatches(target);
    return matches
        .map((e) => DefaultSuggestionItem(
            data: e.group(2) ?? "", title: e.group(1) ?? "", isInitial: true))
        .toList();
  }

  @override
  String convertToSuggestionText(String target) =>
      target.replaceAllMapped(RegExp(regex), (match) {
        return match.group(1) ?? "";
      });
}
