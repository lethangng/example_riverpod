import 'package:mobile_framework/packages/api/export.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/file_response.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/app_file.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/usecases/upload_files.dart';

abstract interface class IFileRepository {
  ResultFuture<FileResponse> uploadSingleFile(AppFile file,
      {FileType uploadType = FileType.image});

  ResultFuture<FileResponse> uploadMultiFiles(List<AppFile?> files,
      {FileType uploadType = FileType.image});

  ResultFuture<EmptyResponse> deleteFile(String url);

  ResultFuture<EmptyResponse> deleteFiles(List<String> urls);
}
