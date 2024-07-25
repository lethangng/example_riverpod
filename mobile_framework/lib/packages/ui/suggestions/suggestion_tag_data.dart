import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

@immutable
class SuggestionTagElement {
  final String suggestionSymbol;
  final String suggestionTitle;
  final Object? suggestionData;
  final Widget? suggestionDecorator;

  const SuggestionTagElement(
      {required this.suggestionSymbol,
      required this.suggestionTitle,
      this.suggestionData,
      this.suggestionDecorator});

  String get titleWithoutSymbol =>
      suggestionTitle.removeCharacter(suggestionSymbol);
}
