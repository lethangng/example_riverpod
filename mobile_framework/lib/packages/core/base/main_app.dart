// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobile_framework/gen/assets.gen.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:stack_trace/stack_trace.dart';

/// Start services, other configurations before running app
class AppInitializer {
  Future<void> Function() initialize;

  AppInitializer(
    this.initialize,
  );

  Future<void> run() async {
    await initialize();
  }
}

class AppDependencies {
  Future<void> Function() initialize;

  AppDependencies(
    this.initialize,
  );

  Future<void> run() async {
    await initialize();
  }
}

/// [App] represents a single application which will be called
/// at starting point of program (at main() function)
class App {
  String name;
  AppInitializer initializeAfterAppAvailable;
  AppInitializer initializeBeforeAppAvailable;
  AppDependencies dependencies;
  MainModule module;
  Widget root;

  App({
    required this.name,
    required this.root,
    required this.initializeAfterAppAvailable,
    required this.initializeBeforeAppAvailable,
    required this.dependencies,
    required this.module,
  });

  Future<void> run() async {
    log("Starting $name application 📣", name: "Application");

    _initModules();
    log("Running $name application 🚀", name: "Application");
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    try {
      await dependencies.run();
    } catch (e, s) {
      talkerLogger.log("Exception: $e, StackTrace: ${Trace.from(s)}");
    }

    await initializeBeforeAppAvailable.run();

    if (SSOAccountManager.isInitialized() &&
        SSOAccountManager.getCurrentAccount() != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(
          SSOAccountManager.getCurrentAccount()!.id.toString());
    }

    FlutterError.onError = (errorDetails) {
      _switchMode(
        onReleaseMode: () {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        },
        onDebugMode: () {
          talker.log("Error: ${errorDetails.exceptionAsString()}");
        },
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      _switchMode(
        onReleaseMode: () {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        },
        onDebugMode: () {
          talker.log("Error: $error, StackTrace: $stack");
        },
      );

      return true;
    };

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;

      _switchMode(onReleaseMode: () async {
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
        );
      }, onDebugMode: () {
        talker.log(
            "Error: ${errorAndStacktrace.first}, StackTrace: ${errorAndStacktrace.last}");
      });
    }).sendPort);

    runApp(root);

    try {
      await initializeAfterAppAvailable.run();
    } catch (e, s) {
      talkerLogger.log("Exception: $e, StackTrace: ${Trace.from(s)}");
    }

    FlutterNativeSplash.remove();
  }

  void _initModules() {
    module.prepare();
    module.registerDependencies();
  }

  void _switchMode(
      {required Function() onReleaseMode, required Function() onDebugMode}) {
    if (kReleaseMode) {
      onReleaseMode();
    } else {
      onDebugMode();
    }
  }
}

final platformTheme = Platform.isAndroid ? blackMountainView : blackCupertino;

const TextTheme blackCupertino = TextTheme(
  labelSmall: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  bodySmall: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black87,
      decoration: TextDecoration.none),
  labelLarge: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  bodyLarge: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  bodyMedium: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  displayLarge: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  displayMedium: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  displaySmall: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  headlineMedium: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  headlineSmall: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  titleLarge: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  titleMedium: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
  titleSmall: TextStyle(
      fontFamily: '.SF UI Text',
      color: Colors.black,
      decoration: TextDecoration.none),
);

const TextTheme blackMountainView = TextTheme(
  labelSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  bodySmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black87,
      decoration: TextDecoration.none),
  labelLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  displayLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  displayMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  displaySmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  headlineMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  headlineSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  titleLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  titleMedium: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
  titleSmall: TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      decoration: TextDecoration.none),
);

class CustomErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  final Function() onBack;

  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  CustomErrorPage({
    super.key,
    required this.errorDetails,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.transparent,
      scaffoldMessengerKey: messengerKey,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: Module.findEnv(of: CoreModule).isProd
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(60),
                Assets.icons.icErrorCloud.svg(width: 150, height: 150).center(),
                if (!Module.findEnv(of: CoreModule).isProd)
                  Text(
                    errorDetails.summary.toString(),
                    textAlign: TextAlign.left,
                    maxLines: null,
                    style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    textDirection: TextDirection.ltr,
                  ).leftCenter(),
                const Gap(6),
                LineSeparator(
                  color: Colors.grey.shade100,
                ),
                const Gap(12),
                if (Module.findEnv(of: CoreModule).isProd) ...[
                  const Text(
                    "Ôi! Đã có lỗi xảy ra.\nRất xin lỗi vì sự bất tiện này! Hãy thử lại sau",
                    textAlign: TextAlign.center,
                    maxLines: 10,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                    softWrap: true,
                    textDirection: TextDirection.ltr,
                  ).center(),
                  const Gap(12),
                  CupertinoTheme(
                    data: const CupertinoThemeData(
                      primaryColor: Colors.blueAccent,
                    ),
                    child: ClipRRect(
                      borderRadius: 22.0.borderAll(),
                      child: CupertinoButton.filled(
                        onPressed: () {
                          try {
                            FirebaseCrashlytics.instance
                                .recordFlutterError(errorDetails);
                          } catch (e, s) {
                            log("Exception: $e, StackTrace: ${Trace.from(s)}",
                                name: "CustomError");
                          }

                          messengerKey.currentState?.showSnackBar(SnackBar(
                            content: const Text(
                              "Đã báo cáo lỗi",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ).center(),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.fixed,
                          ));
                        },
                        child: const Text("Báo cáo lỗi",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))
                            .center(),
                      ).width(250),
                    ),
                  ).center(),
                ],
                if (!Module.findEnv(of: CoreModule).isProd &&
                    errorDetails.stack != null)
                  SingleChildScrollView(
                    child: Text(
                      Chain.forTrace(errorDetails.stack!).toString(),
                      textAlign: TextAlign.left,
                      maxLines: null,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      textDirection: TextDirection.ltr,
                    ),
                  ).expand(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
