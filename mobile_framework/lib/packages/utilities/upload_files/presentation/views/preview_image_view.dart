// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class PreviewImagesView extends StatefulWidget {
  final int startIndex;
  final List<AppFile> previewImages;

  const PreviewImagesView({
    super.key,
    this.startIndex = 0,
    required this.previewImages,
  });

  @override
  State<PreviewImagesView> createState() => _PreviewImagesViewState();

  void show(int startIndex) {
    appRouter.push(
        PreviewImagesRoute(
            previewImages: previewImages,
            startIndex: startIndex
        ));
  }
}

class _PreviewImagesViewState extends State<PreviewImagesView> {
  late PageController controller;

  bool shouldEnableDismissible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = PageController(initialPage: widget.startIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          AppBar(
              backgroundColor: Colors.black,
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  appRouter.pop();
                },
                child: const SizedBox.square(
                  dimension: 48,
                  child: Icon(
                    CupertinoIcons.clear,
                    size: 24.0,
                  ),
                ),
              )),
          DismissiblePage(
            direction: DismissiblePageDismissDirection.down,
            disabled: !shouldEnableDismissible,
            onDismissed: () {
              appRouter.pop();
            },
            key: ValueKey(toString()),
            child: PageView.builder(
              controller: controller,
              itemCount: widget.previewImages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return KeepAliveWrapper(
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.3,
                    maxScale: 5,
                    onInteractionStart: (details) {
                      shouldEnableDismissible = false;
                      setState(() {});
                    },
                    onInteractionUpdate: (details) {
                      shouldEnableDismissible = true;
                      setState(() {});
                    },
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Center(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: widget.previewImages
                                  .elementAt(index)
                                  .isLocalFile
                              ? Image.file(File(widget.previewImages
                                  .elementAt(index)
                                  .fullUrl))
                              : CachedNetworkImage(
                                  imageUrl: widget.previewImages[index].fullUrl,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  cacheKey: widget.previewImages[index].fullUrl,
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return const CupertinoActivityIndicator(
                                      radius: 10.0,
                                    );
                                  },
                                ),
                        ).paddingOnly(left: 4.0, right: 4.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ).expand(),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: SmoothPageIndicator(
                effect: WormEffect(
                    radius: 8,
                    activeDotColor:
                        get<FileConfig>().previewImagesIndicatorColor,
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    dotColor: Colors.grey),
                controller: controller,
                count: widget.previewImages.length),
          ),
          SizedBox(height: context.mediaQuery.viewPadding.bottom + 12.0)
        ],
      ),
    );
  }
}
