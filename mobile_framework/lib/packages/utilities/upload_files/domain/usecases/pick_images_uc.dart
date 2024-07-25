import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/usecase.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/app_file.dart';
import 'package:mobile_framework/packages/utilities/upload_files/presentation/views/image_picker_delegate.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum ImagePickerMode { single, multi }

enum PhotoSource { camera, gallery }

class PickSingleImageUC extends LongRunningUseCase<AppFile?, void> {
  ImagesPickerDelegate? pickerDelegate;
  PhotoSource source;

  PickSingleImageUC({
    this.pickerDelegate,
    this.source = PhotoSource.gallery,
  });

  @override
  Future<AppFile?> call({void params}) async {
    switch (source) {
      case PhotoSource.camera:
        return pickerDelegate?.singlePickFromCamera();
      case PhotoSource.gallery:
        return pickerDelegate?.singlePickFromGallery();
    }
  }
}

class PickMultiImagesUC extends LongRunningUseCase<List<AppFile>?, RequestType> {
  ImagesPickerDelegate? pickerDelegate;

  PickMultiImagesUC({
    this.pickerDelegate,
  });

  @override
  Future<List<AppFile>?> call({RequestType? params}) async {
    return pickerDelegate?.multiPickFromGallery(requestType: params);
  }
}
