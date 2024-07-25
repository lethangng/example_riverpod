import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart' hide RefreshIndicator;

extension WidgetX on Widget {
  Widget marginOnly({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: left ?? 0,
        right: right ?? 0,
        top: top ?? 0,
        bottom: bottom ?? 0,
      ),
      child: this,
    );
  }

  Widget marginAll(double value) {
    return Container(
      margin: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget marginSymmetric({double? vertical, double? horizontal}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: vertical ?? 0, horizontal: horizontal ?? 0),
      child: this,
    );
  }

  Widget paddingOnly({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left ?? 0,
        right: right ?? 0,
        top: top ?? 0,
        bottom: bottom ?? 0,
      ),
      child: this,
    );
  }

  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingSymmetric({double? vertical, double? horizontal}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: vertical ?? 0, horizontal: horizontal ?? 0),
      child: this,
    );
  }

  Widget padding([EdgeInsetsGeometry? padding]) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget defaultHorizontalPadding({double value = 20}) {
    return paddingOnly(left: value, right: value);
  }

  /// [expandedTapArea] will add extra padding to the widget to expand the tap area
  Widget onTapWidget(VoidCallback onTap,
      {double? radius, bool isEnabled = true}) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          highlightColor: Colors.transparent,
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(radius ?? 0),
          child: this),
    );
  }

  Widget align(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget expand() {
    return Expanded(
      child: this,
    );
  }

  Widget visibility(bool visible,
      {Widget replacement = const SizedBox.shrink()}) {
    return Visibility(
      visible: visible,
      replacement: replacement,
      child: this,
    );
  }

  Widget flexible({FlexFit fit = FlexFit.loose, int flex = 1}) {
    return Flexible(
      fit: fit,
      flex: flex,
      child: this,
    );
  }

  Widget squareBox({double edgeSize = 0}) {
    return SizedBox.square(
      dimension: edgeSize,
      child: this,
    );
  }

  Widget box({double? h, double? w}) {
    return SizedBox(
      height: h,
      width: w,
      child: this,
    );
  }

  /// no width just height
  Widget height(double value) {
    return box(h: value);
  }

  /// no height just width
  Widget width(double value) {
    return box(w: value);
  }

  Widget center() {
    return Center(
      child: this,
    );
  }

  Widget bottomCenter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }

  Widget topCenter() {
    return Align(
      alignment: Alignment.topCenter,
      child: this,
    );
  }

  Widget leftCenter() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Widget rightCenter() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Widget bottomLeft() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: this,
    );
  }

  Widget bottomRight() {
    return Align(
      alignment: Alignment.bottomRight,
      child: this,
    );
  }

  Widget topLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Widget topRight() {
    return Align(
      alignment: Alignment.topRight,
      child: this,
    );
  }

  Widget rounded({required double radius, Color? color}) {
    return Container(
      constraints: BoxConstraints(
          minWidth: radius * 2, maxHeight: radius * 2, minHeight: radius * 2),
      decoration: BoxDecoration(borderRadius: radius.borderAll(), color: color),
      child: this,
    );
  }

  Widget decoratedBy(Decoration decoration) {
    return DecoratedBox(decoration: decoration, child: this);
  }

  Widget debugColor([Color color = Colors.red]) {
    if (kDebugMode) {
      return makeColor(color);
    }
    return this;
  }

  Widget makeColor(Color color) {
    return ColoredBox(
      color: color,
      child: this,
    );
  }
}

extension LoadingWidgetExts on Widget {
  Widget withShimmer(bool isEnabled) {
    if (!isEnabled) {
      return animate().fadeIn(
          curve: Curves.fastOutSlowIn, duration: 450.milliseconds, begin: 0.7);
    }
    return animate(
      onInit: (controller) {},
      onComplete: (controller) {
        controller.repeat(reverse: false);
      },
    ).shimmer(
        duration: 1.5.seconds,
        colors: const [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        angle: 120,
        blendMode: BlendMode.srcATop);
  }
}

extension OnRefreshExts on Widget {
  Widget onRefresh(VoidCallback onRefresh) {
    assert(this is! CustomScrollView,
        "onRefresh widget doesn't apply to CustomScrollView");

    var isAndroid = Platform.isAndroid;

    var scrollable = this is SingleChildScrollView
        ? SliverFillRemaining(
            child: this,
          )
        : SliverList(delegate: SliverChildListDelegate([this]));

    if (isAndroid) {
      return RefreshIndicator(
        onRefresh: () async {
          onRefresh.call();
        },
        child: CustomScrollView(slivers: [scrollable]),
      );
    } else {
      return CustomScrollView(shrinkWrap: true, slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            onRefresh.call();
          },
        ),
        scrollable
      ]);
    }
  }
}

extension BoxyIdExt on Widget {
  Widget applyBoxyId<T extends Object>(
      {Object? id,
      bool? hasData,
      T? data,
      bool alwaysRelayout = true,
      bool alwaysRepaint = true}) {
    return BoxyId(
        id: id,
        hasData: hasData,
        data: data,
        alwaysRelayout: alwaysRelayout,
        alwaysRepaint: alwaysRepaint,
        child: this);
  }
}

extension AnimatedChildren on List<Widget> {
  List<Widget> toStaggered() {
    return AnimationConfiguration.toStaggeredList(
        childAnimationBuilder: (child) {
          return SlideAnimation(
              verticalOffset: 100,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 300),
              child: FadeInAnimation(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 300),
                child: child,
              ));
        },
        children: this);
  }
}
