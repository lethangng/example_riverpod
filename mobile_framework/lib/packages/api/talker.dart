import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile_framework/mobile_framework.dart';

class CrashlyticsTalkerObserver extends TalkerObserver {
  CrashlyticsTalkerObserver();

  @override
  void onError(err) {
    FirebaseCrashlytics.instance.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
    );
  }

  @override
  void onException(err) {
    FirebaseCrashlytics.instance.recordError(
      err.exception,
      err.stackTrace,
      reason: err.message,
    );
  }
}

class NonNullableMessageLogFilter extends LoggerFilter {
  @override
  bool shouldLog(msg, LogLevel level) {
    return msg != "null" || msg != null;
  }
}

class ExtendedLoggerNoLeftBorderFormatter implements LoggerFormatter {
  const ExtendedLoggerNoLeftBorderFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final underline = getBottomLine(settings.maxLineWidth);
    final topLine = getTopLine(settings.maxLineWidth);

    final msg = details.message?.toString() ?? '';
    final msgBorderedLines = msg.split('\n').map(
      (e) {
        return e;
      },
    ).join('\n');

    return [topLine, msgBorderedLines, underline].join('\n');
  }

  String getTopLine(int length) {
    final line = "═" * length;
    return '╔$line╗';
  }

  String getBottomLine(int length) {
    final line = "═" * length;
    return '╚$line╝';
  }

  String printLimitedLength(String text, int maxLength) {
    final words = text.split(' ');
    final lines = <String>[];

    var line = '';

    for (var word in words) {
      if ((line.length + word.length) >= maxLength) {
        lines.add(line);
        line = '';
      }
      line += '$word ';
    }

    if (line.trim().isNotEmpty) {
      lines.add(line.trim());
    }

    return lines.join('\n');
  }
}

final crashlyticsTalkerObserver = CrashlyticsTalkerObserver();

final talkerLogger = TalkerLogger(
  settings: TalkerLoggerSettings(enableColors: false, maxLineWidth: 100),
  filter: NonNullableMessageLogFilter(),
  formatter: const ExtendedLoggerNoLeftBorderFormatter(),
  output: (message) async {
    await Future.microtask(
      () {
        if (kDebugMode) {
          log("\n$message", name: "🤖");
        }
      },
    );
  },
);

final talker = Talker(
  observer: crashlyticsTalkerObserver,
  logger: talkerLogger,
  settings: TalkerSettings(),
);
