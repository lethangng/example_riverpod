import 'dart:io';

import 'package:async/async.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageEntityGridItemView extends StatefulWidget {
  final AssetEntity entity;
  @override
  State<ImageEntityGridItemView> createState() =>
      _ImageEntityGridItemViewState();

  const ImageEntityGridItemView({
    super.key,
    required this.entity,
  });
}

class _ImageEntityGridItemViewState extends State<ImageEntityGridItemView>
    with GlobalThemePlugin {
  File? file;
  CancelableCompleter<Uint8List>? completer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // completer?.operation.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        ExtendedImage(
          image: AssetEntityImageProvider(widget.entity, isOriginal: false),
          fit: BoxFit.cover,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const CupertinoActivityIndicator();
              case LoadState.completed:
                return state.completedWidget;
              case LoadState.failed:
                return const Icon(Icons.error);
            }
          },
        ),
      ],
    );
  }
}
