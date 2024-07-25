import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/file_response.dart';

final fileRepositoryProvider = Provider<IFileRepository>((ref) =>
    throw UnimplementedError(
        'FileRepositoryProvider must be overridden in ProviderScope'));

class FileRepository extends BaseRepository implements IFileRepository {
  FileRepository({required super.urlBuilder});

  @override
  ResultFuture<FileResponse> uploadMultiFiles(List<AppFile?> files,
      {FileType uploadType = FileType.image}) {
    return files.convertToFormData().asCancelable().then((data) {
      return make
          .request(
              path: '/storage',
              body: data,
              decoder: FileResponseModel(),
              options: Options(headers: {'type': uploadType.rawValue}))
          .post<FileResponse>()
          .next();
    });
  }

  @override
  ResultFuture<FileResponse> uploadSingleFile(AppFile file,
      {FileType uploadType = FileType.image}) {
    return file.toFormData().asCancelable().then((data) => make
        .request(
            path: '/storage',
            body: data,
            options: Options(headers: {'type': uploadType.rawValue}),
            decoder: FileResponseModel())
        .post<FileResponse>()
        .next());
  }

  @override
  ResultFuture<EmptyResponse> deleteFile(String url) {
    return make
        .request(path: "/storage/$url", decoder: FileResponseModel())
        .delete();
  }

  @override
  ResultFuture<EmptyResponse> deleteFiles(List<String> urls) {
    return make
        .request(
            path: '/storage/_bulk', body: urls, decoder: const EmptyResponse())
        .delete();
  }
}
