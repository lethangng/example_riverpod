// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mobile_framework/packages/ui/exts/widget_exts.dart';

import 'package:mobile_framework/packages/ui/widgets/v_space.dart';

class EmptyView extends StatelessWidget {
  Widget? image;
  String? title;
  String? description;
  String? buttonTitle;
  Function()? onPressed;

  EmptyView({
    super.key,
    this.image,
    this.title,
    this.description,
    this.buttonTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: AnimationConfiguration.toStaggeredList(
          childAnimationBuilder: (child) {
            return SlideAnimation(
                child: FadeInAnimation(
              child: child,
            ));
          },
          children: [
            // image.orEmpty(),
            VSpace.v12,
            Text(
              title ?? "",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            VSpace.v4,
            Text(
              description ?? "",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey.shade400),
            ),
            VSpace.v16,
            Container(
              decoration: const BoxDecoration(color: Colors.green),
              height: 56,
            )
          ]),
    ).center().box(h: 472));
  }
}
