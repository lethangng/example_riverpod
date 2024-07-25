import 'package:flutter/material.dart';
import 'package:mobile_framework/packages/ui/suggestions/constants.dart';
import 'package:mobile_framework/packages/ui/suggestions/string_extensions.dart';
import 'package:mobile_framework/packages/ui/suggestions/suggestion_settings.dart';
import 'package:mobile_framework/packages/ui/suggestions/suggestion_tag_data.dart';
import 'package:stack_trace/stack_trace.dart';

class SuggestionTagTextEditingController extends TextEditingController {
  final List<SuggestionTagElement> _mentions = [];

  /// Get the list of data associated with you mentions, if no data was given the mention labels will be returned.
  List get mentions => List.from(_mentions
      .map((mention) => mention.suggestionData ?? mention.suggestionTitle));

  String get suggestionText {
    final List<SuggestionTagElement> tempList = List.from(_mentions);
    return super.text.replaceAllMapped(Constants.mentionEscape, (match) {
      if (tempList.isEmpty) return '';

      final SuggestionTagElement removedMention = tempList.removeAt(0);
      return suggestionSettings.convertSuggestionTagToText(removedMention);
    });
  }

  List<SuggestionTagElement> getSuggestionTags() => _mentions;

  void clearMentions() => _mentions.clear();

  /// The mentions or tags will be removed automatically using backspaces in TextField.
  /// If you encounter a scenario where you need to remove a custom tag or mention on some action, you need to call remove and give it index of the mention or tag in _controller.mentions.
  ///
  /// Note: _controller.mentions is a custom getter, mentions removed from it won't be removed from TextField so you must call _controller.remove to remove mention or tag from both _controller and TextField.
  void remove({required int index}) {
    if (_mentions.isEmpty) return;

    try {
      _mentions.removeAt(index);
      super.text =
          super.text.removeCharacterAtCount(Constants.mentionEscape, index + 1);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  late SuggestionSettings suggestionSettings;
  void Function(String?)? onSuggestion;

  set initialSuggestions(List<(String, Object?, Widget?)> value) {
    var suggestionSymbols =
        suggestionSettings.suggestionSymbols.map((e) => e.rawValue).toList();
    for (final mentionTuple in value) {
      if (!super.text.contains(mentionTuple.$1)) return;
      super.text =
          super.text.replaceFirst(mentionTuple.$1, Constants.mentionEscape);
      _temp = super.text;

      final mentionSymbol =
          mentionTuple.$1.checkMentionSymbol(suggestionSymbols);
      if (mentionSymbol.isEmpty) {
        throw 'No mention symbol with initialSuggestion';
      }

      final mention = suggestionSettings.showSuggestionStartSymbol
          ? mentionTuple.$1
          : mentionTuple.$1.removeMentionStart(suggestionSymbols);

      _mentions.add(SuggestionTagElement(
          suggestionSymbol: mentionSymbol,
          suggestionTitle: mention,
          suggestionData: mentionTuple.$2,
          suggestionDecorator: mentionTuple.$3));
    }
  }

  String _temp = '';
  String? _mentionInput;

  /// Mention or Tag label, this label will be visible in the Text Field.
  ///
  /// The data associated with this mention. You can get this data using _controller.mentions property.
  /// If you do not pass any data, a list of the mention labels will be returned.
  /// If you skip some values, mentioned labels will be added in those places.
  void addSuggestionTag({
    required String label,
    Object? data,
    Widget? stylingWidget,
  }) {
    if (_mentionInput == null) return;

    final indexCursor = selection.base.offset;
    final mentionSymbol = _mentionInput!.first;

    if (indexCursor < 0) {
      return;
    }

    final mention = suggestionSettings.showSuggestionStartSymbol
        ? "$mentionSymbol$label"
        : label;
    final SuggestionTagElement mentionTagElement = SuggestionTagElement(
        suggestionSymbol: mentionSymbol,
        suggestionTitle: mention,
        suggestionData: data,
        suggestionDecorator: stylingWidget);

    final textPart = super.text.substring(0, indexCursor);
    final indexPosition = textPart.countChar(Constants.mentionEscape);
    _mentions.insert(indexPosition, mentionTagElement);

    _replaceLastSubstringWithEscaping(indexCursor, _mentionInput!);
  }

  void _replaceLastSubstringWithEscaping(int indexCursor, String replacement) {
    try {
      _replaceLastSubstring(indexCursor, Constants.mentionEscape,
          allowDecrement: false);
      selection =
          TextSelection.collapsed(offset: indexCursor - replacement.length + 2);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _replaceLastSubstring(int indexCursor, String replacement,
      {bool allowDecrement = true}) {
    if (super.text.length == 1) {
      super.text = !allowDecrement
          ? "$replacement${suggestionSettings.suggestionBreakCharater}"
          : "$text$replacement${suggestionSettings.suggestionBreakCharater}";
      _temp = super.text;
      return;
    }

    var indexMentionStart = _getIndexFromMentionStart(indexCursor, super.text);
    indexMentionStart = indexCursor - indexMentionStart;

    super.text = super.text.replaceRange(
        !allowDecrement ? indexMentionStart - 1 : indexMentionStart,
        indexCursor,
        "$replacement${suggestionSettings.suggestionBreakCharater}");
    _temp = super.text;
  }

  int _getIndexFromMentionStart(int indexCursor, String value) {
    if (value.length < indexCursor) return -1;

    final mentionStartPattern = RegExp(suggestionSettings.suggestionSymbols.map(
      (e) {
        return e.rawValue;
      },
    ).join('|'));
    var indexMentionStart =
        value.substring(0, indexCursor).reversed.indexOf(mentionStartPattern);
    return indexMentionStart;
  }

  bool _isMentionEmbeddedOrDistinct(String value, int indexMentionStart) {
    final indexMentionStartSymbol = indexMentionStart - 1;
    if (indexMentionStartSymbol == 0) return true;
    if (suggestionSettings.allowEmbedding) return true;
    if (value[indexMentionStartSymbol - 1] == Constants.mentionEscape) {
      return true;
    }
    if (value[indexMentionStartSymbol - 1] == ' ') return true;
    return false;
  }

  String? getMention(String value) {
    final indexCursor = selection.base.offset;
    if (indexCursor < 0) return null;
    if (value.length < indexCursor) return null;

    final indexMentionFromStart = _getIndexFromMentionStart(indexCursor, value);

    if (suggestionSettings.maxWords != null) {
      int indexMentionEnd = 0;

      if (indexMentionFromStart == 0 && indexCursor == 1) {
        indexMentionEnd = 1;
      } else {
        indexMentionEnd = value
            .substring(0, indexCursor)
            .reversed
            .indexOfNthSpace(suggestionSettings.maxWords!);
      }

      if (indexMentionEnd != -1 && indexMentionEnd < indexMentionFromStart) {
        return null;
      }
    }

    if (indexMentionFromStart != -1) {
      if (value.length == 1) return value.first;

      final indexMentionStart = indexCursor - indexMentionFromStart;

      if (!_isMentionEmbeddedOrDistinct(value, indexMentionStart)) return null;

      if (indexMentionStart != -1 &&
          indexMentionStart >= 0 &&
          indexMentionStart <= indexCursor) {
        return value.substring(indexMentionStart - 1, indexCursor);
      }
    }
    return null;
  }

  void _updateOnMention(String? mention) {
    onSuggestion!(mention);
    _mentionInput = mention;
  }

  void onChanged(String value) async {
    if (onSuggestion == null) return;
    String? mention = getMention(value);
    _updateOnMention(mention ?? "");

    if (value.length < _temp.length) {
      _updateMentions(value);
    }

    _temp = value;
  }

  void _checkAndUpdateOnMention(
    String value,
    int mentionsCountTillCursor,
    int indexCursor,
  ) {
    if (_temp.length - value.length != 1) return;
    // if (!mentionTagDecoration.allowDecrement) return;
    if (mentionsCountTillCursor < 1) return;

    var indexMentionEscape = value
        .substring(0, indexCursor)
        .reversed
        .indexOf(Constants.mentionEscape);
    indexMentionEscape = indexCursor - indexMentionEscape - 1;
    final isCursorAtMention = (indexCursor - indexMentionEscape) == 1;
    if (isCursorAtMention) {
      final SuggestionTagElement? cursorMention =
          _mentions.elementAtOrNull(mentionsCountTillCursor - 1);
      if (cursorMention == null) return;

      final mentionText = suggestionSettings.showSuggestionStartSymbol
          ? cursorMention.suggestionTitle
          : "${cursorMention.suggestionSymbol}${cursorMention.suggestionTitle}";
      _updateOnMention(mentionText);
    }
  }

  void _updateMentions(String value) {
    try {
      final indexCursor = selection.base.offset;

      final mentionsCount = value.countChar(Constants.mentionEscape);
      final textPart = super.text.substring(0, indexCursor);
      final mentionsCountTillCursor =
          textPart.countChar(Constants.mentionEscape);

      _checkAndUpdateOnMention(value, mentionsCountTillCursor, indexCursor);
      if (mentionsCount == _mentions.length || _mentions.isEmpty) return;

      final SuggestionTagElement removedMention =
          _mentions.removeAt(mentionsCountTillCursor);
      remove(index: mentionsCountTillCursor);

      if (suggestionSettings.allowDecrement &&
          _temp.length - value.length == 1) {
        String replacementText = removedMention.suggestionTitle
            .substring(0, removedMention.suggestionTitle.length - 1);

        replacementText = suggestionSettings.showSuggestionStartSymbol
            ? replacementText
            : "${removedMention.suggestionSymbol}$replacementText";

        super.text =
            super.text.replaceRange(indexCursor, indexCursor, replacementText);

        final offset = suggestionSettings.showSuggestionStartSymbol
            ? indexCursor + removedMention.suggestionTitle.length - 1
            : indexCursor + removedMention.suggestionTitle.length;
        selection = TextSelection.collapsed(offset: offset);
        _updateOnMention(replacementText);
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(Chain.forTrace(s).toString());
    }
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final regexp = RegExp(
        '(?=${Constants.mentionEscape})|(?<=${Constants.mentionEscape})');
    final res = super.text.split(regexp);
    final tempList = List<SuggestionTagElement>.from(_mentions);

    return TextSpan(
      style: style,
      children: res.map((e) {
        if (e == Constants.mentionEscape && tempList.isNotEmpty) {
          final mention = tempList.removeAt(0);

          return WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: mention.suggestionDecorator ??
                Text(
                  mention.suggestionTitle,
                  style: suggestionSettings.suggestionTextStyle,
                ),
          );
        }
        return TextSpan(text: e, style: style);
      }).toList(),
    );
  }
}
