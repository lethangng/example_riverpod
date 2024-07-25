import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:showcaseview/showcaseview.dart';

class Tutorial extends InheritedWidget {
  final TutorialController controller;

  Tutorial({
    super.key,
    required this.controller,
    required Widget child,
    Function()? onShowcaseFinished,
    Function(int? index, GlobalKey<State<StatefulWidget>> key)?
        onShowcaseStarted,
    Function(int? index, GlobalKey<State<StatefulWidget>> key)? onCompleted,
    required bool shouldEnableShowcase,
    bool autoPlay = false,
    bool playAutomatically = true,
  }) : super(
            child: ShowCaseWidget(
                onStart: (index, key) {
                  talkerLogger.log("Showcase started", level: LogLevel.info);
                  onShowcaseStarted?.call(index, key);
                },
                onComplete: (index, key) {
                  talkerLogger.log("Showcase completed", level: LogLevel.info);
                  onCompleted?.call(index, key);
                },
                onFinish: () {
                  talkerLogger.log("Showcase finished", level: LogLevel.info);
                  onShowcaseFinished?.call();
                },
                enableShowcase: shouldEnableShowcase,
                autoPlay: autoPlay,
                autoPlayDelay: const Duration(milliseconds: 3000),
                builder: Builder(
                    builder: (context) => _TutorialChildWrapper(
                        playAutomatically: playAutomatically, child: child))));

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static Tutorial of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Tutorial>()!;
  }
}

class _TutorialChildWrapper extends StatefulWidget {
  final Widget child;
  final bool playAutomatically;

  @override
  State<_TutorialChildWrapper> createState() => _TutorialChildWrapperState();

  const _TutorialChildWrapper(
      {required this.child, required this.playAutomatically});
}

class _TutorialChildWrapperState extends State<_TutorialChildWrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.playAutomatically) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(
          250.milliseconds,
          () => Tutorial.of(context).controller.start(context),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
