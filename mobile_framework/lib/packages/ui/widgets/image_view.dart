import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/gen/assets.gen.dart';
import 'package:mobile_framework/mobile_framework.dart';

class ImageView extends StatelessWidget {
  final String url;
  final double? padding;
  final BoxFit fit;
  final Color? backgroundColor;
  final double? radius;
  final Widget? loadingIndicator;
  final double activityIndicatorSize;
  final Size? size;
  final Size? memCacheSize;
  final Widget? placeholder;
  final double defaultPlaceholderSize;

  const ImageView(
      {super.key,
      required this.url,
      this.fit = BoxFit.cover,
      this.padding,
      this.backgroundColor,
      this.radius,
      this.loadingIndicator,
      this.activityIndicatorSize = 10,
      this.placeholder,
      this.memCacheSize,
      this.size,
      this.defaultPlaceholderSize = 24});

  @override
  Widget build(BuildContext context) {
    var image = CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      useOldImageOnUrlChange: false,
      cacheKey: url,
      fadeInCurve: Curves.fastOutSlowIn,
      fadeOutCurve: Curves.fastOutSlowIn,
      fadeInDuration: const Duration(milliseconds: 20),
      fadeOutDuration: const Duration(milliseconds: 20),
      memCacheHeight: memCacheSize?.height.toInt(),
      memCacheWidth: memCacheSize?.width.toInt(),
      progressIndicatorBuilder: (context, url, progress) {
        return loadingIndicator ??
            CupertinoActivityIndicator(
              radius: activityIndicatorSize,
            );
      },
      errorWidget: (context, url, error) {
        return Container(
          color: backgroundColor,
          child: Center(
              child: placeholder ??
                  Assets.icons.icImageError.svg(
                      color: Colors.black87,
                      width: defaultPlaceholderSize,
                      height: defaultPlaceholderSize)),
        );
      },
    ).paddingAll(padding ?? 0);

    return SizedBox(
      height: size?.height,
      width: size?.width,
      child: ClipRRect(borderRadius: (radius ?? 0).borderAll(), child: image),
    );
  }
}
