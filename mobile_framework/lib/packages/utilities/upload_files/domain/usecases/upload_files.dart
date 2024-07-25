// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_framework/packages/api/export.dart';
import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/usecase.dart';
import 'package:mobile_framework/packages/global/define.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/app_file.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/file_config.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/repositories/file_repository.dart';

enum FileType {
  image,
  file,
  video,
  unknown;

  String get contentType => switch (this) {
        // TODO: Handle this case.
        FileType.image => "image/*",
        // TODO: Handle this case.
        FileType.file => "file/*",
        // TODO: Handle this case.
        FileType.video => "video/*",
        // TODO: Handle this case.
        FileType.unknown => "",
      };

  String get rawValue => name.toUpperCase();
}

class UploadSingleFileUC extends LongRunningUseCase<String?, void> {
  IFileRepository repository;
  FileConfig fileConfig = get<FileConfig>();

  AppFile? file;

  UploadSingleFileUC({
    required this.repository,
    this.file,
  });

  @override
  Future<String?> call({void params}) async {
    if (file == null || !(file?.isLocalFile ?? false)) {
      return null;
    }

    final uploadType = file!.type;

    if (uploadType == FileType.unknown) {
      const message = 'Không nhận diện được tệp tin';
      showError(CommonError.message(message));
      return Future.error(message);
    }

    if (convertRawStringFileSize(file!.readableFileSize) > convertRawStringFileSize(fileConfig.maxImageSize)) {
      final message = 'Kích thước tệp tin không được vượt quá ${fileConfig.maxImageSize}';
      showError(CommonError.message(message));
      return Future.error(message);
    }
    
    showLoading(duration: const Duration(seconds: 180));

    return repository
        .uploadSingleFile(file!, uploadType: file!.type)
        .onError((error) => showError(error))
        .onResult(() => hideLoading())
        .mapToValue()
        .then((r) => r?.responseUrls?.first)
        .onNullJustReturn("");
  }
}

class UploadMultiFilesUC extends LongRunningUseCase<List<String>, void> {
  IFileRepository repository;
  FileConfig fileConfig = get<FileConfig>();

  List<AppFile> files;

  UploadMultiFilesUC({
    required this.repository,
    required this.files,
  });

  @override
  Future<List<String>> call({void params}) async {
    if (files.isEmpty) {
      return [];
    }

    for (var file in files) {
      final uploadType = files.first.type;

      if (uploadType == FileType.unknown) {
        const message = 'Không nhận diện được tệp tin';
        showError(CommonError.message(message));
        return Future.error(message);
      }

      if (convertRawStringFileSize(file.readableFileSize) > convertRawStringFileSize(fileConfig.maxImageSize)) {
        final message = 'Kích thước tệp tin không được vượt quá ${fileConfig.maxImageSize}';
        showError(CommonError.message(message));
        return Future.error(message);
      }
    }

    var localFiles =
        files.where((element) => (element.isLocalFile)).toList();

    if (localFiles.isEmpty) {
      return [];
    }

    showLoading(duration: const Duration(seconds: 180));

    final result = await Future.wait([
      for (var file in files) repository
          .uploadSingleFile(
          file,
          uploadType: file.type)
          .onError((error) {
        showError(error);
        hideLoading();
        return Future.error('Không tải lên được tệp tin');
      })
          .mapToValue()
          .asFuture()
    ]);

    hideLoading();

    return result.map((element) => element?.responseUrls?.first ?? '').toList();
  }
}
