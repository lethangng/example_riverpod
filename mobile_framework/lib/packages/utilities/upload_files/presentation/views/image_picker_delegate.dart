// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_framework/mobile_framework.dart' hide ImageSource;
import 'package:mobile_framework/packages/utilities/upload_files/presentation/views/access_permission_popup_view.dart';
import 'package:mobile_framework/packages/utilities/upload_files/presentation/views/image_picker_asset_builder_delegate.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

mixin PickerSettings {
  BuildContext get pickerContext => appRouter.navigatorKey.currentContext!;

  GlobalThemeConfiguration get theme => GlobalThemeConfiguration.global()!;

  AssetPickerConfig singleSelectionConfig(RequestType requestType) =>
      AssetPickerConfig(
          gridCount: 3,
          pageSize: 18,
          textDelegate: const VietnameseAssetPickerTextDelegate(),
          maxAssets: 1,
          specialPickerType: SpecialPickerType.noPreview,
          pickerTheme: ThemeData(
            appBarTheme: AppBarTheme(
                elevation: 0,
                shadowColor: Colors.transparent,
                color: theme.mainColor,
                actionsIconTheme: const IconThemeData(color: Colors.white)),
            primaryColor: theme.mainColor,
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                buttonColor: theme.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),
          shouldRevertGrid: false,
          loadingIndicatorBuilder: (context, event) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 10,
                ),
              ),
            );
          },
          keepScrollOffset: true,
          requestType: requestType,
          pathNameBuilder: (asset) => asset.name,
          pathThumbnailSize: const ThumbnailSize(100, 100));

  AssetPickerConfig multiSelectionConfig(RequestType requestType) =>
      AssetPickerConfig(
          gridCount: 4,
          pageSize: 20,
          textDelegate: const VietnameseAssetPickerTextDelegate(),
          pickerTheme: ThemeData(
            appBarTheme: AppBarTheme(
                elevation: 0,
                shadowColor: Colors.transparent,
                color: theme.mainColor,
                actionsIconTheme: const IconThemeData(color: Colors.white)),
            primaryColor: theme.mainColor,
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                buttonColor: theme.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),
          loadingIndicatorBuilder: (context, event) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 10,
                ),
              ),
            );
          },
          maxAssets: 30,
          requestType: requestType,
          keepScrollOffset: true,
          shouldRevertGrid: true,
          pathNameBuilder: (asset) => asset.name,
          pathThumbnailSize: const ThumbnailSize(100, 100));
}

abstract interface class ImagesPickerDelegate {
  Future<AppFile?> singlePickFromGallery();

  Future<AppFile?> singlePickFromCamera();

  Future<List<AppFile>?> multiPickFromGallery({RequestType? requestType});

  void previewImages(List<AppFile> images, {int? startIndex});

  bool selectImagePredicate(AppFile image);

  Future shouldShowPermissionPopupView(ImageSource source);
}

mixin ImagesPickerCompatible implements ImagesPickerDelegate {
  Function(bool predicationResult)? onResultPredicate;

  PickerSettings get settings {
    if (this is PickerSettings) {
      return this as PickerSettings;
    }

    throw Exception("ImagesPickerCompatible must be mixed with PickerSettings");
  }

  @override
  Future<AppFile?> singlePickFromGallery({RequestType? requestType}) async {
    return await _shouldCheckPermissionForGallery().then((value) async {
      final pickerConfig =
          settings.singleSelectionConfig(requestType ?? RequestType.common);
      final DefaultAssetPickerProvider provider = DefaultAssetPickerProvider(
        maxAssets: pickerConfig.maxAssets,
        pageSize: pickerConfig.pageSize,
        pathThumbnailSize: pickerConfig.pathThumbnailSize,
        selectedAssets: pickerConfig.selectedAssets,
        requestType: pickerConfig.requestType,
        sortPathDelegate: pickerConfig.sortPathDelegate,
        filterOptions: pickerConfig.filterOptions,
      );

      final List<AssetEntity>? assets =
          await AssetPicker.pickAssetsWithDelegate(settings.pickerContext,
              delegate: ImagePickerAssetBuilderDelegate(
                provider: provider,
                initialPermission: PermissionState.authorized,
              ));

      if (assets == null || assets.isEmpty) {
        return null;
      }

      return AppFile.fromAssetEntity(assets.first);
    });
  }

  @override
  Future<List<AppFile>?> multiPickFromGallery(
      {RequestType? requestType}) async {
    return await _shouldCheckPermissionForGallery().then((value) async {
      if (!value) {
        return null;
      }
      final pickerConfig =
          settings.multiSelectionConfig(requestType ?? RequestType.common);
      final DefaultAssetPickerProvider provider = DefaultAssetPickerProvider(
        maxAssets: pickerConfig.maxAssets,
        pageSize: pickerConfig.pageSize,
        pathThumbnailSize: pickerConfig.pathThumbnailSize,
        selectedAssets: pickerConfig.selectedAssets,
        requestType: requestType ?? pickerConfig.requestType,
        sortPathDelegate: pickerConfig.sortPathDelegate,
        filterOptions: pickerConfig.filterOptions,
      );

      final List<AssetEntity>? assets =
          await AssetPicker.pickAssetsWithDelegate(settings.pickerContext,
              delegate: ImagePickerAssetBuilderDelegate(
                provider: provider,
                initialPermission: PermissionState.authorized,
              ));

      if (assets == null || assets.isEmpty) {
        return null;
      }

      return await Future.wait(
          assets.map((e) async => AppFile.fromAssetEntity(e)));
    });
  }

  @override
  Future<AppFile?> singlePickFromCamera() async {
    return await _shouldCheckPermissionForCamera().then((value) async {
      if (!value) {
        return null;
      }
      var result = await ImagePicker().pickImage(
          imageQuality: 100,
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear);

      if (result == null) {
        return null;
      }

      return AppFile.local(
          bytes: await result.readAsBytes(),
          fileName: result.name,
          path: result.path);
    });
  }

  @override
  void previewImages(List<AppFile> images, {int? startIndex}) {
    PreviewImagesView(
      previewImages: images,
      startIndex: startIndex ?? 0,
    ).show(startIndex ?? 0);
  }

  @override
  bool selectImagePredicate(AppFile image) {
    if (image.fileSize <=
        convertRawStringFileSize(get<FileConfig>().maxImageSize)) {
      return true;
    }
    return false;
  }

  @override
  Future shouldShowPermissionPopupView(ImageSource source) async {
    await settings.pickerContext.showOverlay(AccessPermissionPopupView(
      source: source,
      onOpenSettings: () {
        switch (source) {
          case ImageSource.camera:
            AppSettings.openAppSettings();
            break;
          case ImageSource.gallery:
            openAppSettings();
            break;
        }
      },
    ));
  }

  Future<bool> _shouldCheckPermissionForGallery() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    if (ps case PermissionState.notDetermined) {
      return false;
    }

    var result = switch (ps) {
      PermissionState.notDetermined ||
      PermissionState.denied ||
      PermissionState.restricted =>
        false,
      PermissionState.limited || PermissionState.authorized => true,
    };

    if (!result) {
      await shouldShowPermissionPopupView(ImageSource.gallery);
    }

    return result;
  }

  Future<bool> _shouldCheckPermissionForCamera() async {
    return ph.Permission.camera.request().then((value) async {
      if (value
          case ph.PermissionStatus.denied ||
              ph.PermissionStatus.permanentlyDenied) {
        await shouldShowPermissionPopupView(ImageSource.camera);
        return false;
      } else {
        return true;
      }
    });
  }
}
