import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

enum RichTextButtonType {
  bold,
  italic,
  underline,
  unorderList,
  orderList,
  undo,
  redo,
  strikeThrough,
  subscript,
  superscript,
  blockQuote,
  indent,
  outdent,
  backgroundColor,
  textColor,
  insertTable,
  insertImages,
  fontFamily,
  fontSize,
  alignLeft,
  alignCenter,
  alignRight,
  alignJustify;

  static RichTextButtonType fromString(String value) {
    switch (value) {
      case 'bold':
        return RichTextButtonType.bold;
      case 'italic':
        return RichTextButtonType.italic;
      case 'underline':
        return RichTextButtonType.underline;
      case 'unorderList':
        return RichTextButtonType.unorderList;
      case 'orderList':
        return RichTextButtonType.orderList;
      case 'undo':
        return RichTextButtonType.undo;
      case 'redo':
        return RichTextButtonType.redo;
      case 'strikeThrough':
        return RichTextButtonType.strikeThrough;
      case 'subscript':
        return RichTextButtonType.subscript;
      case 'superscript':
        return RichTextButtonType.superscript;
      case 'blockQuote':
        return RichTextButtonType.blockQuote;
      case 'indent':
        return RichTextButtonType.indent;
      case 'outdent':
        return RichTextButtonType.outdent;
      case 'backgroundColor':
        return RichTextButtonType.backgroundColor;
      case 'textColor':
        return RichTextButtonType.textColor;
      case 'insertTable':
        return RichTextButtonType.insertTable;
      case 'insertImages':
        return RichTextButtonType.insertImages;
      case 'fontFamily':
        return RichTextButtonType.fontFamily;
      case 'fontSize':
        return RichTextButtonType.fontSize;
      case 'alignLeft':
        return RichTextButtonType.alignLeft;
      case 'alignCenter':
        return RichTextButtonType.alignCenter;
      case 'alignRight':
        return RichTextButtonType.alignRight;
      case 'alignJustify':
        return RichTextButtonType.alignJustify;
      default:
        throw Exception("Invalid ToggleStateButtonType");
    }
  }
}

class RichTextButton implements Decodable {
  late final RichTextButtonType type;
  late final bool isActive;
  late final bool isDisable;
  late final dynamic data;

  @override
  void decode(json) {
    type = RichTextButtonType.fromString(json['type']);
    isActive = json['isActive'] ?? false;
    isDisable = json['isDisable'] ?? false;
    data = json['data'];
  }
}

class ToggleStateButtons implements Decodable {
  List<RichTextButton> buttons = [];

  @override
  void decode(json) {
    buttons = ListDecoder(json["data"]).decodeBy(() => RichTextButton());
  }
}

final richTextButtonsProvider =
    StateProvider<List<RichTextButton>>((ref) => []);
