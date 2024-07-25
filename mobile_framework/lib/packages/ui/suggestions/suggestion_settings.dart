import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/suggestions/suggestion_tag_data.dart';

class SuggestionSettings {
  SuggestionSettings({
    this.suggestionSymbols = const [SuggestionSymbol.mention()],
    this.suggestionBreakCharater = ' ',
    this.maxWords = 1,
    this.suggestionTextStyle =
        const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
    this.allowDecrement = false,
    this.allowEmbedding = false,
    this.showSuggestionStartSymbol = true,
    String Function(SuggestionTagElement tag)? convertSuggestionTagToText,
  }) : assert(
          maxWords == null ? true : maxWords > 0,
          "maxWords must be greater than 0 or null",
        ) {
    this.convertSuggestionTagToText =
        convertSuggestionTagToText ?? defaultConvertSuggestionTagToText;
  }

  /// Indicates the start point of mention or tag.
  final List<SuggestionSymbol> suggestionSymbols;

  /// Default character to place after mention.
  /// In case of tags if you don't want any space you can set this empty string.
  final String suggestionBreakCharater;

  /// TextStyle of mentioned or tagged text.
  final TextStyle suggestionTextStyle;

  /// The max amount of words a mention can have, must be greater than zero or null.
  /// In case of null, any number of words will be considered. That means onMention callback will send all the words after mention symbol unless you call setMention.
  final int? maxWords;

  /// Allow mentions to remove in decrement.
  ///
  /// e.g If textfield has this text, "I am @rowan" pressing back space will result "I am @rowa" if this property is set to true.
  /// The mention will be remove and you'll receive mention call back "@rowa" in onMention callback.
  ///
  /// If this property is set to false, whole mention will be removed on single backspace.
  final bool allowDecrement;

  /// If this value is set to true onMention callback will return the string even if start symbol is in the middle of text.
  ///
  /// e.g. If textfield has "example@gmail.com", setting this property true will cause the onMention callback to return "@gmail.com".
  /// By default this property is false, onMention callback won't return if mention start symbol is in the middle of text.
  ///
  /// In short, false value will cause the onMention callback to give mentions only if mention start symbol has a space behind it.
  final bool allowEmbedding;

  /// Whether to show mention start symbol with your mentions in the textfield or not.
  final bool showSuggestionStartSymbol;

  late String Function(SuggestionTagElement tag) convertSuggestionTagToText;

  static String defaultConvertSuggestionTagToText(SuggestionTagElement tag) {
    return "@[${tag.titleWithoutSymbol}](${tag.suggestionData})";
  }
}
