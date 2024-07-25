import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterLengthLimiter {
  late final int length;
  final bool canShowCharacterCount;
  final characterCountProvider = StateProvider((ref) => 0);

  CharacterLengthLimiter({
    this.canShowCharacterCount = true,
    required this.length,
  });

  /// Mô tả giới hạn 2000 ký tự
  CharacterLengthLimiter.description({
    this.canShowCharacterCount = true,
  }) : length = 2000;

  /// Tiêu đề giới hạn 200 ký tự
  CharacterLengthLimiter.title({
    this.canShowCharacterCount = true,
  }) : length = 200;

  /// Tên người dùng giới hạn 50 ký tự
  CharacterLengthLimiter.humanName({
    this.canShowCharacterCount = true,
  }) : length = 50;

  /// Mã giới hạn 20 ký tự
  CharacterLengthLimiter.code({
    this.canShowCharacterCount = true,
  }) : length = 20;

  /// Trình soạn thảo văn bản giới hạn 10000 ký tự
  CharacterLengthLimiter.textEditor({
    this.canShowCharacterCount = true,
  }) : length = 10000;
}
