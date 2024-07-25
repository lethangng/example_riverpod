// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/sso/models/s3_sso_domain_builder.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/s3_domain_name_builder.dart';

mixin FileURLMixin {
  String get relativePath => "";

  String get fullUrl => "${S3DomainBuilder().build()}$relativePath";
}

class AppFile with FileURLMixin {
  String? path;
  String? fileName;
  bool isLocalFile;
  bool isSSO = false;
  Uint8List? bytes;

  AppFile({
    this.path,
    this.fileName,
    this.isLocalFile = true,
    this.bytes,
  });

  static Future<AppFile> fromAssetEntity(AssetEntity entity) async {
    var file = await entity.file;

    if (file == null) throw Exception("File is null");

    return AppFile(
        path: file.path,
        fileName: file.path.split("/").last,
        bytes: await file.readAsBytes());
  }

  AppFile.remote({
    required this.path,
    this.fileName,
  }) : isLocalFile = false;

  AppFile.local({
    required this.path,
    required this.fileName,
    this.bytes,
  }) : isLocalFile = true;

  AppFile.remoteSSO({
    required this.path,
  })  : isLocalFile = false,
        isSSO = true;

  File get file => File(fullUrl);

  String get readableFileSize {
    if (bytes == null) {
      return "0 KB";
    }

    int sizeInBytes = bytes!.lengthInBytes;

    if (sizeInBytes < 1024) {
      return '$sizeInBytes B';
    } else if (sizeInBytes < 1024 * 1024) {
      double sizeInKB = sizeInBytes / 1024;
      return '${sizeInKB.round()} KB';
    } else if (sizeInBytes < 1024 * 1024 * 1024) {
      double sizeInMB = sizeInBytes / (1024 * 1024);
      return '${sizeInMB.round()} MB';
    } else {
      double sizeInGB = sizeInBytes / (1024 * 1024 * 1024);
      return '${sizeInGB.round()} GB';
    }
  }

  /// Represent file size in bytes
  /// 1 KB = 1024 bytes
  int get fileSize {
    if (bytes == null) {
      return 0;
    }

    return bytes!.lengthInBytes;
  }

  FileType get type {
    if (path == null) {
      return FileType.unknown;
    }

    String? mimeType = lookupMimeType(path!);

    if (mimeType != null) {
      if (mimeType.startsWith('image/')) {
        return FileType.image;
      } else if (mimeType.startsWith('video/')) {
        return FileType.video;
      }
    }

    return FileType.file;
  }

  Future<MultipartFile> toMultipartFile() async {
    if (bytes == null) {
      throw Exception("Bytes is null, can't convert to MultipartFile");
    }

    return MultipartFile.fromFile(
      file.path,
      contentType: MediaType.parse(lookupMimeType(path ?? "") ?? ""),
    );
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap(
      {
        "files": [await toMultipartFile()],
      },
      ListFormat.multiCompatible,
    );
  }

  @override
  String get relativePath => path ?? "";

  @override
  String get fullUrl {
    if (isSSO) {
      return S3SSODomainBuilder().build() + (path ?? "");
    }

    return isLocalFile ? (path ?? "") : super.fullUrl;
  }
}

extension ListFile<T extends AppFile> on List<T?> {
  Future<FormData> convertToFormData() async {
    var multipartFiles = <MultipartFile>[];

    for (AppFile file in this as List<AppFile>) {
      if (file.isLocalFile) {
        multipartFiles.add(await file.toMultipartFile());
      }
    }

    return FormData.fromMap({"files": multipartFiles});
  }
}

double convertRawStringFileSize(String size) {
  double fileSize = double.parse(size.replaceAll(RegExp(r'[^\d.]'), ''));

  if (size.contains('KB')) {
    fileSize *= 1024;
  } else if (size.contains('MB')) {
    fileSize *= 1024 * 1024;
  } else if (size.contains('GB')) {
    fileSize *= 1024 * 1024 * 1024;
  }

  return fileSize;
}
