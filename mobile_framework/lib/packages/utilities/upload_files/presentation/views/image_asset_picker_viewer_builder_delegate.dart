import 'dart:math' as math;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageAssetPickerViewerBuilderDelegate
    extends DefaultAssetPickerViewerBuilderDelegate with GlobalThemePlugin {
  ImageAssetPickerViewerBuilderDelegate({
    required super.currentIndex,
    required super.previewAssets,
    required super.themeData,
    super.selectorProvider,
    super.provider,
    super.selectedAssets,
    super.previewThumbnailSize,
    super.specialPickerType,
    super.maxAssets,
    super.shouldReversePreview,
    super.selectPredicate,
  });

  @override
  Widget appBar(BuildContext context) {
    // TODO: implement appBar
    return AssetPickerAppBar(
      title: StreamBuilder<int>(
        initialData: currentIndex,
        stream: pageStreamController.stream,
        builder: (_, AsyncSnapshot<int> snapshot) {
          return Text(
            '${snapshot.data! + 1}/${previewAssets.length}',
            style: conf.defaultTextStyle.textColor(Colors.white),
          );
        },
      ),
      leading: const Icon(Icons.close_rounded, size: 28, color: Colors.white)
          .onTapWidget(() {
        appRouter.pop();
      }).paddingOnly(left: 16),
      backgroundColor: conf.mainColor,
      actions: [
        Container(
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Row(
            children: [
              HSpace(8),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: conf.mainColor,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              HSpace(4),
              Text(
                "Xong",
                style: conf.smallTextStyle.textColor(Colors.black87),
              ),
              HSpace(8),
            ],
          ).onTapWidget(() {
            appRouter.pop(provider?.currentlySelectedAssets);
          }, radius: 16),
        ).paddingOnly(right: 16),
      ],
      blurRadius: 0,
    );
  }

  @override
  Widget bottomDetailItemBuilder(BuildContext context, int index) {
    const double padding = 8.0;

    void onTap(AssetEntity asset) {
      final int page;
      if (previewAssets != selectedAssets) {
        page = previewAssets.indexOf(asset);
      } else {
        page = index;
      }
      if (pageController.page == page.toDouble()) {
        return;
      }
      pageController.jumpToPage(page);
      final double offset =
          (index - 0.5) * (bottomPreviewHeight - padding * 3) -
              context.mediaQuery.size.width / 4;
      previewingListController.animateTo(
        math.max(0, offset),
        curve: Curves.ease,
        duration: kThemeChangeDuration,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding * 2,
      ),
      child: StreamBuilder<int>(
        initialData: currentIndex,
        stream: pageStreamController.stream,
        builder: (_, AsyncSnapshot<int> snapshot) {
          final AssetEntity asset = selectedAssets!.elementAt(index);
          final bool isViewing = previewAssets[snapshot.data!] == asset;

          return Semantics(
            label: '${semanticsTextDelegate.semanticTypeLabel(asset.type)}'
                '${index + 1}',
            selected: isViewing,
            onTap: () => onTap(asset),
            onTapHint: semanticsTextDelegate.sActionPreviewHint,
            excludeSemantics: true,
            child: GestureDetector(
              onTap: () => onTap(asset),
              child: Selector<AssetPickerViewerProvider<AssetEntity>?,
                  List<AssetEntity>?>(
                selector: (_, AssetPickerViewerProvider<AssetEntity>? p) =>
                    p?.currentlySelectedAssets,
                child: RepaintBoundary(
                  child: ExtendedImage(
                    image: AssetEntityImageProvider(asset, isOriginal: true),
                    width: 60,
                    height: 30,
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                builder: (
                  _,
                  List<AssetEntity>? currentlySelectedAssets,
                  Widget? w,
                ) {
                  return AnimatedContainer(
                    duration: kThemeAnimationDuration,
                    curve: Curves.easeInOut,
                    foregroundDecoration: BoxDecoration(
                      borderRadius: 8.0.borderAll(),
                      border: isViewing
                          ? Border.all(
                              color: Colors.white,
                              width: 2,
                            )
                          : null,
                    ),
                    child: w,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget bottomDetailBuilder(BuildContext context) {
    final Color backgroundColor = conf.mainColor;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return ValueListenableBuilder<bool>(
      valueListenable: isDisplayingDetail,
      builder: (_, bool first, __) => ValueListenableBuilder<int>(
        valueListenable: selectedNotifier,
        builder: (_, int second, Widget? child) =>
            AnimatedPositionedDirectional(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOut,
          bottom: first ? 0 : -(bottomPadding + bottomDetailHeight),
          start: 0,
          end: 0,
          height: bottomPadding + bottomDetailHeight,
          child: child!,
        ),
        child: ChangeNotifierProvider<
            AssetPickerViewerProvider<AssetEntity>?>.value(
          value: provider,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (provider != null)
                Container(
                  color: Colors.white,
                  height: bottomPreviewHeight + bottomPadding - 12,
                  child: ValueListenableBuilder<int>(
                    valueListenable: selectedNotifier,
                    builder: (_, int count, __) => Container(
                      width: count > 0 ? double.maxFinite : 0,
                      height: bottomPreviewHeight,
                      color: backgroundColor,
                      child: ListView.builder(
                        controller: previewingListController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        physics: const ClampingScrollPhysics(),
                        itemCount: count,
                        itemBuilder: bottomDetailItemBuilder,
                      ).paddingOnly(bottom: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget confirmButton(BuildContext context) {
    // TODO: implement confirmButton
    return const SizedBox.shrink();
  }
}
