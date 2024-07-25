import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/ui/suggestions/suggestion_settings.dart';

class InputAccessoryViewConfig {
  late SuggestionSettings suggestionSettings;
  final EdgeInsets suggestionViewPadding;
  final EdgeInsets suggestionListViewPadding;
  final EdgeInsets textFieldPadding;
  final Decoration suggestionViewDecoration;
  final bool shouldHideSuggestionsOnKeyboardHide;

  InputAccessoryViewConfig({
    SuggestionSettings? suggestionSettings,
    this.suggestionViewPadding = EdgeInsets.zero,
    this.suggestionListViewPadding = EdgeInsets.zero,
    this.suggestionViewDecoration = const BoxDecoration(color: Colors.white),
    this.textFieldPadding = EdgeInsets.zero,
    this.shouldHideSuggestionsOnKeyboardHide = true,
  }) : suggestionSettings = suggestionSettings ?? SuggestionSettings();
}
