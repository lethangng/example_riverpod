// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/usecase.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/app_file.dart';

abstract class FilesPickerDelegate {
  Future<AppFile?> singlePickFromFilesManager();

  Future<List<AppFile>?> multiPickFromFilesManager();
}

mixin FilesPickerCompatible implements FilesPickerDelegate {
  @override
  Future<AppFile?> singlePickFromFilesManager() async {
    var result = await FilePicker.platform.pickFiles(
      dialogTitle: "Chọn tệp tin",
      allowMultiple: false,
      withData: true,
      type: FileType.custom,
      allowedExtensions: [
        "pdf",
        "doc",
        "docx",
        "xls",
        "xlsx",
        "ppt",
        "pptx",
        "txt"
      ],
    );

    if (result?.files == null) {
      return null;
    }

    var file = result?.files.firstOrNull;

    if (file == null) {
      return null;
    }

    return AppFile(
        bytes: file.bytes ?? Uint8List(0),
        fileName: file.name,
        path: file.path);
  }

  @override
  Future<List<AppFile>?> multiPickFromFilesManager() async {
    var result = await FilePicker.platform.pickFiles(
        dialogTitle: "Chọn tệp tin",
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          "pdf",
          "doc",
          "docx",
          "xls",
          "xlsx",
          "ppt",
          "pptx",
          "txt"
        ],
        withData: true);

    return result?.files
        .map((e) => AppFile(
            bytes: e.bytes ?? Uint8List(0), fileName: e.name, path: e.path))
        .toList();
  }
}

enum FilePickerMode { single, multi }

class PickSingleFileUC extends LongRunningUseCase<AppFile?, void> {
  FilesPickerDelegate? pickerDelegate;

  PickSingleFileUC({
    this.pickerDelegate,
  });

  @override
  Future<AppFile?> call({void params}) async {
    return pickerDelegate?.singlePickFromFilesManager();
  }
}

class PickMultiFilesUC extends LongRunningUseCase<List<AppFile>?, void> {
  FilesPickerDelegate? pickerDelegate;

  PickMultiFilesUC({
    this.pickerDelegate,
  });

  @override
  Future<List<AppFile>?> call({void params}) async {
    return pickerDelegate?.multiPickFromFilesManager();
  }
}
