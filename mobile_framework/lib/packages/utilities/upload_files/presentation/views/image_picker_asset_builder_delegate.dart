import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/utilities/upload_files/presentation/views/image_asset_picker_viewer_builder_delegate.dart';
import 'package:mobile_framework/packages/utilities/upload_files/presentation/views/image_entity_grid_item_view.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImagePickerAssetBuilderDelegate extends DefaultAssetPickerBuilderDelegate
    with GlobalThemePlugin {
  ImagePickerAssetBuilderDelegate(
      {required super.provider, required super.initialPermission})
      : super(
          loadingIndicatorBuilder: (context, event) {
            return Container(
              color: Colors.white,
              child: Center(
                  child: GlobalThemeConfiguration.global()
                      ?.tableViewCenterIndicator),
            );
          },
          keepScrollOffset: true,
          shouldRevertGrid: true,
          gridCount: 3,
          // gridThumbnailSize: ThumbnailSize(
          //     (75 * Get.mediaQuery.devicePixelRatio).toInt(),
          //     (75 * Get.mediaQuery.devicePixelRatio).toInt()),
          previewThumbnailSize: ThumbnailSize(
              (50 * globalKey.currentContext!.mediaQuery.devicePixelRatio)
                  .toInt(),
              (50 * globalKey.currentContext!.mediaQuery.devicePixelRatio)
                  .toInt()),
          pickerTheme: ThemeData(canvasColor: Colors.white),
          textDelegate: const VietnameseAssetPickerTextDelegate(),
        );

  @override
  SpecialPickerType get specialPickerType => SpecialPickerType.wechatMoment;

  @override
  AssetPickerAppBar appBar(BuildContext context) {
    // TODO: implement appBar
    return AssetPickerAppBar(
      backgroundColor: conf.mainColor,
      title: Semantics(
        onTapHint: semanticsTextDelegate.sActionSwitchPathLabel,
        child: pathEntitySelector(context),
      ),
      leading: const Icon(Icons.close_rounded, size: 28, color: Colors.white)
          .onTapWidget(() {
        appRouter.pop();
      }).paddingOnly(left: 16),
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
            appRouter.pop(provider.selectedAssets);
          }, radius: 16),
        ).paddingOnly(right: 16),
      ],
      blurRadius: 0,
    );
  }

  @override
  Widget imageAndVideoItemBuilder(
    BuildContext context,
    int index,
    AssetEntity asset,
  ) {
    final AssetEntityImageProvider imageProvider = AssetEntityImageProvider(
      asset,
      isOriginal: false,
      thumbnailSize: gridThumbnailSize,
    );
    SpecialImageType? type;
    if (imageProvider.imageFileType == ImageFileType.gif) {
      type = SpecialImageType.gif;
    } else if (imageProvider.imageFileType == ImageFileType.heic) {
      type = SpecialImageType.heic;
    }

    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Positioned.fill(
          child: ImageEntityGridItemView(
            entity: asset,
          ),
        ),
        if (type == SpecialImageType.gif) // 如果为GIF则显示标识
          gifIndicator(context, asset),
        if (asset.type == AssetType.video) // 如果为视频则显示标识
          videoIndicator(context, asset),
      ],
    );
  }

  @override
  Widget pathEntitySelector(BuildContext context) {
    Widget text(
      BuildContext context,
      String text,
      String semanticsText,
    ) {
      return Flexible(
        child: Text(
          text,
          style: conf.smallTextStyle.textColor(Colors.black87),
          maxLines: 1,
          overflow: TextOverflow.fade,
          semanticsLabel: semanticsText,
        ),
      );
    }

    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () {
          if (isPermissionLimited && provider.isAssetsEmpty) {
            PhotoManager.presentLimited();
            return;
          }
          if (provider.currentPath == null) {
            return;
          }
          isSwitchingPath.value = !isSwitchingPath.value;
        },
        child: Container(
          height: appBarItemHeight,
          constraints: BoxConstraints(
            maxWidth: context.mediaQuery.size.width * 0.5,
          ),
          padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Colors.white,
          ),
          child: Selector<DefaultAssetPickerProvider,
              PathWrapper<AssetPathEntity>?>(
            selector: (_, DefaultAssetPickerProvider p) => p.currentPath,
            builder: (_, PathWrapper<AssetPathEntity>? p, Widget? w) {
              final AssetPathEntity? path = p?.path;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  w!,
                  if (path == null && isPermissionLimited)
                    text(
                      context,
                      textDelegate.changeAccessibleLimitedAssets,
                      semanticsTextDelegate.changeAccessibleLimitedAssets,
                    ),
                  if (path != null)
                    text(
                      context,
                      isPermissionLimited && path.isAll
                          ? textDelegate.accessiblePathName
                          : pathNameBuilder?.call(path) ?? path.name,
                      isPermissionLimited && path.isAll
                          ? semanticsTextDelegate.accessiblePathName
                          : pathNameBuilder?.call(path) ?? path.name,
                    ),
                ],
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: conf.mainColor,
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isSwitchingPath,
                  builder: (_, bool isSwitchingPath, Widget? w) {
                    return Transform.rotate(
                      angle: isSwitchingPath ? math.pi : 0,
                      child: w,
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.chevron_down,
                    size: 14,
                    color: Colors.white,
                  ).paddingOnly(top: 2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget pathEntityListWidget(BuildContext context) {
    return Positioned.fill(
      top: isAppleOS(context)
          ? context.mediaQuery.viewPadding.top + kToolbarHeight
          : 0,
      bottom: null,
      child: ValueListenableBuilder<bool>(
        valueListenable: isSwitchingPath,
        builder: (_, bool isSwitchingPath, Widget? child) => Semantics(
          hidden: isSwitchingPath ? null : true,
          child: AnimatedAlign(
            duration: switchingPathDuration,
            curve: switchingPathCurve,
            alignment: Alignment.bottomCenter,
            heightFactor: isSwitchingPath ? 1 : 0,
            child: AnimatedOpacity(
              duration: switchingPathDuration,
              curve: switchingPathCurve,
              opacity: !isAppleOS(context) || isSwitchingPath ? 1 : 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: context.mediaQuery.size.height *
                        (isAppleOS(context) ? .6 : .8),
                  ),
                  color: Colors.white,
                  child: child,
                ),
              ),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ValueListenableBuilder<PermissionState>(
              valueListenable: permission,
              builder: (_, PermissionState ps, Widget? child) => Semantics(
                label: '${semanticsTextDelegate.viewingLimitedAssetsTip}, '
                    '${semanticsTextDelegate.changeAccessibleLimitedAssets}',
                button: true,
                onTap: PhotoManager.presentLimited,
                hidden: !isPermissionLimited,
                focusable: isPermissionLimited,
                excludeSemantics: true,
                child: isPermissionLimited ? child : const SizedBox.shrink(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: textDelegate.viewingLimitedAssetsTip,
                      ),
                      TextSpan(
                        text: ' '
                            '${textDelegate.changeAccessibleLimitedAssets}',
                        style: TextStyle(color: interactiveTextColor(context)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = PhotoManager.presentLimited,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Selector<DefaultAssetPickerProvider,
                  List<PathWrapper<AssetPathEntity>>>(
                selector: (_, DefaultAssetPickerProvider p) => p.paths,
                builder: (_, List<PathWrapper<AssetPathEntity>> paths, __) {
                  final List<PathWrapper<AssetPathEntity>> filtered = paths
                      .where(
                        (PathWrapper<AssetPathEntity> p) => p.assetCount != 0,
                      )
                      .toList();
                  return ListView.separated(
                    padding: const EdgeInsetsDirectional.only(top: 1),
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (BuildContext c, int i) => pathEntityWidget(
                      context: c,
                      list: filtered,
                      index: i,
                    ),
                    separatorBuilder: (_, __) => Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget pathEntityWidget({
    required BuildContext context,
    required List<PathWrapper<AssetPathEntity>> list,
    required int index,
  }) {
    final PathWrapper<AssetPathEntity> wrapper = list[index];
    final AssetPathEntity pathEntity = wrapper.path;
    final Uint8List? data = wrapper.thumbnailData;

    Widget builder() {
      if (data != null) {
        return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.memory(data, fit: BoxFit.cover))
            .paddingOnly(left: 16, top: 8, bottom: 8);
      }
      if (pathEntity.type.containsAudio()) {
        return ColoredBox(
          color: theme.colorScheme.primary.withOpacity(0.12),
          child: const Center(child: Icon(Icons.audiotrack)),
        );
      }
      return const ColoredBox(color: Colors.white);
    }

    final String pathName =
        pathNameBuilder?.call(pathEntity) ?? pathEntity.name;
    final String name = isPermissionLimited && pathEntity.isAll
        ? textDelegate.accessiblePathName
        : pathName;
    final String semanticsName = isPermissionLimited && pathEntity.isAll
        ? semanticsTextDelegate.accessiblePathName
        : pathName;
    final String? semanticsCount = wrapper.assetCount?.toString();
    final StringBuffer labelBuffer = StringBuffer(
      '$semanticsName, ${semanticsTextDelegate.sUnitAssetCountLabel}',
    );
    if (semanticsCount != null) {
      labelBuffer.write(': $semanticsCount');
    }
    return Selector<DefaultAssetPickerProvider, PathWrapper<AssetPathEntity>?>(
      selector: (_, DefaultAssetPickerProvider p) => p.currentPath,
      builder: (_, PathWrapper<AssetPathEntity>? currentWrapper, __) {
        final bool isSelected = currentWrapper?.path == pathEntity;
        return Semantics(
          label: labelBuffer.toString(),
          selected: isSelected,
          onTapHint: semanticsTextDelegate.sActionSwitchPathLabel,
          button: false,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Feedback.forTap(context);
              context.read<DefaultAssetPickerProvider>().switchPath(wrapper);
              isSwitchingPath.value = false;
              gridScrollController.jumpTo(0);
            },
            child: SizedBox(
              height: isAppleOS(context) ? 64 : 52,
              child: Row(
                children: <Widget>[
                  RepaintBoundary(
                    child: AspectRatio(aspectRatio: 1, child: builder()),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 15,
                        end: 20,
                      ),
                      child: ExcludeSemantics(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  end: 4,
                                ),
                                child: Text(
                                  name,
                                  style: conf.defaultTextStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if (semanticsCount != null)
                              Text(
                                '($semanticsCount)',
                                style: conf.defaultTextStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isSelected)
                    AspectRatio(
                      aspectRatio: 1,
                      child: Icon(Icons.check, color: conf.mainColor, size: 26),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> viewAsset(
    BuildContext context,
    int index,
    AssetEntity currentAsset,
  ) async {
    final DefaultAssetPickerProvider provider =
        context.read<DefaultAssetPickerProvider>();
    bool selectedAllAndNotSelected() =>
        !provider.selectedAssets.contains(currentAsset) &&
        provider.selectedMaximumAssets;
    bool selectedPhotosAndIsVideo() =>
        isWeChatMoment &&
        currentAsset.type == AssetType.video &&
        provider.selectedAssets.isNotEmpty;
    // When we reached the maximum select count and the asset
    // is not selected, do nothing.
    // When the special type is WeChat Moment, pictures and videos cannot
    // be selected at the same time. Video select should be banned if any
    // pictures are selected.
    if (selectedAllAndNotSelected() || selectedPhotosAndIsVideo()) {
      return;
    }
    final List<AssetEntity> current;
    final List<AssetEntity>? selected;
    final int effectiveIndex;
    if (isWeChatMoment) {
      if (currentAsset.type == AssetType.video) {
        current = <AssetEntity>[currentAsset];
        selected = null;
        effectiveIndex = 0;
      } else {
        current = provider.currentAssets
            .where((AssetEntity e) => e.type == AssetType.image)
            .toList();
        selected = provider.selectedAssets;
        effectiveIndex = current.indexOf(currentAsset);
      }
    } else {
      current = provider.currentAssets;
      selected = provider.selectedAssets;
      effectiveIndex = index;
    }
    final List<AssetEntity>? result =
        await AssetPickerViewer.pushToViewerWithDelegate(
      context,
      delegate: ImageAssetPickerViewerBuilderDelegate(
        currentIndex: effectiveIndex,
        previewAssets: current,
        provider: selected != null
            ? AssetPickerViewerProvider<AssetEntity>(
                selected,
                maxAssets: provider.maxAssets,
              )
            : null,
        themeData: theme.copyWith(primaryColor: Colors.white),
        specialPickerType: specialPickerType,
        selectedAssets: provider.selectedAssets,
        selectorProvider: provider,
        maxAssets: provider.maxAssets,
        shouldReversePreview: false,
        selectPredicate: selectPredicate,
      ),
    );
    if (result != null) {
      appRouter.pop(result);
    }
  }

  @override
  Widget selectIndicator(BuildContext context, int index, AssetEntity asset) {
    return const SizedBox.shrink();
  }

  @override
  Widget selectedBackdrop(BuildContext context, int index, AssetEntity asset) {
    final isSelected = provider.selectedAssets.contains(asset);

    return Positioned.fill(
      child: GestureDetector(
        onLongPress: () => viewAsset(context, index, asset),
        onTap: () => selectAsset(context, asset, index, isSelected),
        child: Consumer<DefaultAssetPickerProvider>(
          builder: (_, DefaultAssetPickerProvider p, __) {
            final int index = p.selectedAssets.indexOf(asset);
            final bool selected = index != -1;
            return Container(
              padding: const EdgeInsets.all(10),
              color: selected
                  ? Colors.black38
                  : theme.colorScheme.background.withOpacity(.1),
              child: selected && !isSingleAssetMode
                  ? Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.5),
                          color: conf.mainColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: conf.smallTextStyle.textColor(Colors.white),
                        ).center(),
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget bottomActionBar(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget itemBannedIndicator(BuildContext context, AssetEntity asset) {
    return const SizedBox.shrink();
  }
}
