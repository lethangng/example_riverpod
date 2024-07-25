import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/suggestions/constants.dart';
import 'package:mobile_framework/packages/ui/suggestions/string_extensions.dart';

// ignore_for_file: constant_identifier_names

abstract class SuggestionItem {
  SuggestionItem(
      {required this.data,
      required this.title,
      this.decorator,
      this.suggestionSymbol = const SuggestionSymbol.mention(),
      this.isInitial = false});

  final dynamic data;
  final SuggestionSymbol suggestionSymbol;
  final bool isInitial;

  String title;

  /// if [decorator] is provided, [title] will be replaced with [decorator]
  final Widget? decorator;
}

class DefaultSuggestionItem extends SuggestionItem {
  DefaultSuggestionItem(
      {required super.data,
      required super.title,
      super.decorator,
      super.isInitial}) {
    if (isInitial) {
      title = suggestionSymbol.rawValue + title;
    }
  }
}

class SuggestionSymbol {
  const SuggestionSymbol({required this.rawValue});

  // The character the regex pattern starts with, used to find sections in the text, needs to be a single character
  final String rawValue;

  const SuggestionSymbol.mention() : rawValue = "@";

  const SuggestionSymbol.hashtag() : rawValue = "#";
}

/// Text editing controller that can parse suggestions
/// You need to provide ID type in order to identify each suggestion item
class InputAccessoryTextEditingController<T extends SuggestionItem>
    extends SuggestionTagTextEditingController {
  final ValueNotifier<bool> shouldEnableSuggestion = ValueNotifier(false);
  final List<T> suggestionItems = [];
  final List<SuggestionSymbol> suggestionSymbols;
  final InputAccessoryViewTextParsable<T> textParser;

  String? currentSuggestionQueryText;
  StringDebouncer? debouncer;

  Function(List<T> updatedSuggestions)? onUpdateSuggestions;

  InputAccessoryTextEditingController(
      {required this.textParser,
      this.suggestionSymbols = const [SuggestionSymbol.mention()],
      this.onUpdateSuggestions}) {
    onSuggestion = (mention) {
      onQueryChange(mention);
    };

    addListener(_checkCursorPositionRightAfterSuggestion);
  }

  void addSuggestion(T suggestion) {
    addSuggestionTag(
        label: suggestion.title,
        data: suggestion.data,
        stylingWidget: suggestion.decorator);
    suggestionItems.add(suggestion);
    _removeSuggestionQuery();
    _updateSuggestions();
  }

  void addSuggestions(List<T> suggestions) {
    suggestionItems.addAll(suggestions);
    _removeSuggestionQuery();
    _updateSuggestions();
  }

  bool isSuggestionEnabled() {
    return currentSuggestionQueryText != null &&
        suggestionSymbols.any(
          (element) {
            return currentSuggestionQueryText!.startsWith(element.rawValue);
          },
        );
  }

  bool isInputNewCharacterExceptSuggestionSymbol() {
    return (currentSuggestionQueryText?.length ?? 0) > 1;
  }

  void setCurrentSuggestionQueryText(String? text) {
    currentSuggestionQueryText = text;
  }

  void setDebouncer(StringDebouncer debouncer) {
    this.debouncer = debouncer;
  }

  /// if [onUpdateSuggestions] is already set, ignore this action
  void setUpdateSuggestions(
      Function(List<T> updatedSuggestions)? onUpdateSuggestions) {
    if (this.onUpdateSuggestions != null) return;
    this.onUpdateSuggestions = onUpdateSuggestions;
  }

  void setInitialSuggestionItems(List<T> initialSuggestionItems) {
    initialSuggestions = initialSuggestionItems
        .where(
          (element) {
            return element.isInitial;
          },
        )
        .map((e) => (e.title, e.data, e.decorator))
        .toList();
    suggestionItems.addAll(initialSuggestionItems);
  }

  void openSuggestions() {
    shouldEnableSuggestion.value = true;
  }

  void closeSuggestions() {
    shouldEnableSuggestion.value = false;
  }

  void resetText(String text) {
    clear();
    suggestionItems.clear();
    clearMentions();
    _removeSuggestionQuery();
    this.text = textParser.convertToSuggestionText(text);
    setInitialSuggestionItems(textParser.extractSuggestionItems(text));
    _updateSuggestions();
  }

  void onQueryChange(String? query) {
    setCurrentSuggestionQueryText(query);
    debouncer?.value = (query ?? "").removeMentionStart(
      suggestionSymbols.map((e) => e.rawValue).toList(),
    );
  }

  void _removeSuggestionQuery() {
    setCurrentSuggestionQueryText(null);
    shouldEnableSuggestion.value = isSuggestionEnabled();
  }

  void _updateSuggestions() {
    onUpdateSuggestions?.call(suggestionItems);
  }

  void _checkCursorPositionRightAfterSuggestion() {
    final cursorIndex = selection.base.offset;
    if (cursorIndex - 1 < 0) {
      _removeSuggestionQuery();
      return;
    }

    final characterBeforeCursor =
        text.characters.elementAtOrNull(cursorIndex - 1);

    if (getMention(text) != null) {
      onChanged(text);
      return;
    }

    if (characterBeforeCursor == Constants.mentionEscape) {
      var textToCursor = text.substring(0, cursorIndex);
      var numberOfMentionEscapeCharInTextToCursorPos =
          textToCursor.split('‡').length - 1;
      var indexOfMentionEscapeCharBeforeCursor =
          numberOfMentionEscapeCharInTextToCursorPos - 1;
      var mentionText = getSuggestionTags()
          .elementAtOrNull(indexOfMentionEscapeCharBeforeCursor)
          ?.suggestionTitle;
      onQueryChange(mentionText);
      return;
    } else {
      _removeSuggestionQuery();
    }
  }

  @override
  void remove({required int index}) {
    if (suggestionItems.isNotEmpty) {
      suggestionItems.removeAt(index);
    }

    _updateSuggestions();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    removeListener(_checkCursorPositionRightAfterSuggestion);
  }
}
