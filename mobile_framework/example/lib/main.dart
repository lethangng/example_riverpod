import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:example/app_router.dart';
import 'package:example/app_router.gr.dart';
import 'package:example/demo_pages/alert_notification_demo_page.dart';
import 'package:example/demo_pages/audio_player_demo_page.dart';
import 'package:example/demo_pages/bottom_sheet_demo_page.dart';
import 'package:example/demo_pages/common_widgets_demo_page.dart';
import 'package:example/demo_pages/double_extension_test_page.dart';
import 'package:example/demo_pages/images_assets_viewer_demo_page.dart';
import 'package:example/demo_pages/items_picker_demo_page.dart';
import 'package:example/demo_pages/multiple_trigger_textfield_view_demo_page.dart';
import 'package:example/demo_pages/reaction_demo_page.dart';
import 'package:example/demo_pages/rich_text_editor_demo_page.dart';
import 'package:example/demo_pages/show_overlay_demo_page.dart';
import 'package:example/demo_pages/table_view_demo_page.dart';
import 'package:example/demo_pages/text_field_view_demo_page.dart';
import 'package:example/ui_kind.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class SampleEnv extends Env {
  @override
  // TODO: implement apiVersion
  String get apiVersion => "";

  @override
  // TODO: implement baseUrl
  String get baseUrl => "";

  @override
  // TODO: implement fileBaseUrl
  String get fileBaseUrl => "";

  @override
  // TODO: implement targetApp
  TargetApp get targetApp => TargetApp.iss365;

  @override
  // TODO: implement type
  EnvType get type => EnvType.prod;
}

void main() {
  get.registerSingleton<RootStackRouter>(AppRouter());
  CoreModule(SampleEnv())
    ..prepare()
    ..registerDependency();

  ErrorWidget.builder = (detail) => CustomErrorPage(
        errorDetails: detail,
        onBack: () {
          exit(1);
        },
      );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: InteractiveSheetConfiguration(
        titleTextStyle: const TextStyle(),
        backgroundColor: Colors.white,
        child: GlobalThemeConfiguration.defaultTheme(
          child: Portal(
            child: ToastificationWrapper(
              config: ToastificationConfig(
                marginBuilder: (alignment) {
                  return const EdgeInsets.only(top: 0);
                },
              ),
              child: MaterialApp.router(
                key: globalKey,
                theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // TRY THIS: Try running your application with "flutter run". You'll see
                  // the application has a purple toolbar. Then, without quitting the app,
                  // try changing the seedColor in the colorScheme below to Colors.green
                  // and then invoke "hot reload" (save your changes or press the "hot
                  // reload" button in a Flutter-supported IDE, or press "r" if you used
                  // the command line to start the app).
                  //
                  // Notice that the counter didn't reset back to zero; the application
                  // state is not lost during the reload. To reset the state, use hot
                  // restart instead.
                  //
                  // This works for code too, not just values: Most code changes can be
                  // tested with just a hot reload.
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                builder: (context, child) {
                  return ResponsiveBreakpoints.builder(
                    child: OverlayRootBuilderWidget(
                        builder: (context, ref) => child!),
                    useShortestSide: true,
                    debugLog: kDebugMode,
                    breakpointsLandscape: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
                      const Breakpoint(start: 451, end: 800, name: TABLET),
                    ],
                    breakpoints: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
                      const Breakpoint(start: 451, end: 800, name: TABLET),
                    ],
                  );
                },
                routerConfig: appRouter.config(
                    navigatorObservers: () => [TalkerRouteObserver(talker)],
                    deepLinkBuilder: (_) =>
                        DeepLink([MyHomeRoute(title: 'UI Mobile Framework')])),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UI Mobile Framework"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return VSpace.v8;
        },
        itemCount: UIKind.values.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.grey[200]),
            child: ListTile(
              title: Row(
                children: [
                  Text(UIKind.values.elementAt(index).name),
                  const Spacer(),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 20,
                    color: Colors.grey[600],
                  )
                ],
              ),
              onTap: () {
                switch (UIKind.values.elementAt(index)) {
                  case UIKind.images:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagesAssetsViewerDemoPage(),
                      ),
                    );
                    break;
                  case UIKind.commonWidgets:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommonWidgetsDemoPage(),
                      ),
                    );
                    break;
                  case UIKind.textFieldView:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TextFieldViewDemoPage(),
                      ),
                    );
                    break;
                  case UIKind.multipleTriggerTextFieldView:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MultipleTriggerTextFieldViewDemoPage(),
                      ),
                    );
                    break;
                  case UIKind.interactiveSheet:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomSheetDemoPage(),
                      ),
                    );
                    break;
                  case UIKind.showOverlay:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowOverlayDemoPage(),
                      ),
                    );
                    break;
                  case UIKind.audio:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioPlayerDemoPage(),
                      ),
                    );
                    break;
                  case UIKind.doubleExts:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoubleExtensionTestPage(),
                      ),
                    );
                  case UIKind.richTextEditor:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RichTextEditorDemoPage(),
                      ),
                    );
                  case UIKind.itemsPicker:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ItemsPickerDemoPage(),
                      ),
                    );
                  case UIKind.tableView:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TableViewDemoPage(),
                      ),
                    );
                  case UIKind.reaction:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReactionDemoPage(),
                      ),
                    );
                  case UIKind.alertMessage:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AlertNotificationDemoPage(),
                      ),
                    );
                  default:
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
