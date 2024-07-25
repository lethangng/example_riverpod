import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IOSRefreshIndicator extends RefreshIndicator {
  const IOSRefreshIndicator({super.key})
      : super(
            height: 80.0,
            refreshStyle: RefreshStyle.Follow,
            completeDuration: const Duration(milliseconds: 50));

  @override
  State<StatefulWidget> createState() {
    return IOSRefreshIndicatorState();
  }
}

class IOSRefreshIndicatorState
    extends RefreshIndicatorState<IOSRefreshIndicator>
    with TickerProviderStateMixin {
  ScrollPosition? _position;

  late AnimationController _offsetController;
  late AnimationController _valueAni;

  late Animation<Offset> _offsetTween;

  @override
  void initState() {
    _offsetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _valueAni = AnimationController(
        vsync: this,
        value: 0.0,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 300));

    _valueAni.addListener(() {
      if (mounted && (_position?.pixels ?? 0) <= 0) setState(() {});
    });

    _offsetTween = _offsetController.drive(Tween<Offset>(
        end: const Offset(0.0, 0.2), begin: const Offset(0.0, 0.0)));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant IOSRefreshIndicator oldWidget) {
    _position = Scrollable.of(context).position;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void onOffsetChange(double offset) {
    var progress = 0.0;
    var result = offset / 80.0;

    if (result >= 0 && result <= 1) {
      progress = result;
    }

    if (result > 1) {
      progress = 1;
    } else if (result < 0) {
      progress = 0;
    }

    _valueAni.value = progress;
    _offsetController.value = progress;
  }

  @override
  void onModeChange(RefreshStatus? mode) {
    if (mode == RefreshStatus.refreshing) {
      _offsetController.value = 1;
      _valueAni.value = 1;
    }

    super.onModeChange(mode);
  }

  @override
  void resetValue() {
    _valueAni.value = 0;
    _offsetController.value = 0;

    super.resetValue();
  }

  @override
  void dispose() {
    _valueAni.dispose();
    _offsetController.dispose();

    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return SlideTransition(
      position: _offsetTween,
      child: _valueAni.value == 1
          ? const CupertinoActivityIndicator(radius: 12.0).paddingOnly(bottom: 20.0)
          : CupertinoActivityIndicator.partiallyRevealed(
                  progress: _valueAni.value, radius: 12.0)
              .paddingOnly(bottom: 20.0),
    );
  }
}
