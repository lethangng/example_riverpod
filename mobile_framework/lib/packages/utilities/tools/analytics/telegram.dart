// import 'dart:developer';
//
// import 'package:dart_telegram_bot/dart_telegram_bot.dart';
// import 'package:dart_telegram_bot/telegram_entities.dart';
//
// import 'oms_reporter_service.dart';
//
// class TelegramReportErrorService extends ReporterService {
//   final int chatId = -952965015;
//
//   late Bot telegramBot;
//
//   @override
//   Future init() async {
//     telegramBot = Bot(
//         token: "6243599270:AAHO-iTrX6XqfZXgrgL9WnbCW-9dV9MEiwY",
//         onReady: (bot) {
//           bot.start();
//         },
//         onStartFailed: (bot, exp, stackTrace) {
//           log("Telegram bot failed to start",
//               error: exp,
//               stackTrace: stackTrace,
//               name: "TelegramAnalyticService");
//         },
//         allowedUpdates: [UpdateType.message]);
//   }
//
//   @override
//   void reportError(error, StackTrace stackTrace,
//       {String? message, extraInformation}) {
//     String text = '';
//     if (extraInformation != null) {
//       text += '$extraInformation\n';
//     }
//
//     text += 'Error: $error\n';
//     text += 'Stack: $stackTrace\n';
//     text += 'Message: $message\n';
//
//     telegramBot.sendMessage(ChatID(chatId), text);
//   }
// }
