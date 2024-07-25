import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Create route which can be presented as fullscreen dialog, direction from bottom to top
class PresentedRoute extends CustomRoute {
  PresentedRoute(
      {required super.page, super.children, super.guards, super.initial})
      : super(
          durationInMilliseconds: 250,
          reverseDurationInMilliseconds: 250,
          fullscreenDialog: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                  parent: animation, curve: Curves.fastOutSlowIn)),
              child: child,
            );
          },
        );
}
