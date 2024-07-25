import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/utilities/upload_files/data/models/s3_generated_image_file_response.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/file_response.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/s3_generated_file_response.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/s3_request_generated_url_params.dart';
import 'package:flutter/foundation.dart';

class S3FileRepository extends BaseRepository
    implements IFileRepository, IS3FileRepository {
  S3FileRepository({required super.urlBuilder});

  @override
  ResultFuture<EmptyResponse> deleteFile(String url) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  ResultFuture<EmptyResponse> deleteFiles(List<String> urls) {
    // TODO: implement deleteFiles
    throw UnimplementedError();
  }

  @override
  ResultFuture<FileResponse> uploadMultiFiles(List<AppFile?> files,
      {FileType uploadType = FileType.image}) {
    // TODO: implement uploadMultiFiles
    throw UnimplementedError();
  }


  @override
  ResultFuture<FileResponse> uploadSingleFile(AppFile file, {
    FileType uploadType = FileType.image
  }) {
    final s3Params = S3RequestGeneratedUrlParams(
        fileType: uploadType,
        bucketType: get.get<FileConfig>().bucketType,
        fileName: file.fileName ?? "");

    return getGeneratedFileUrlForUploadingSingleImage(s3Params)
        .mapToValue()
        .then((response) async {
          final uploadParams = (
            urlBuilder: urlBuilder,
            data: response,
            file: file.file,
            env: Module.findEnv(of: CoreModule)
          );

          return await compute((message) async {
            final dioOptions = BaseOptions(contentType: "application/octet-stream", headers: {
              Headers.contentLengthHeader: file.bytes?.length,
            });

            return await Dio(dioOptions)
                .put(message.data?.uploadUrl ?? "", data: message.file.openRead())
                .then(
                    (value) => Success(value: FileResponse.from([message?.data?.filePath ?? ""])),
                    onError: (error) => Failure(error: CommonError(message: error.toString())));
          }, uploadParams);
    });
  }


  @override
  ResultFuture<S3GeneratedFileResponse>
  getGeneratedFileUrlForUploadingSingleImage(BaseParams? params) {
    return make
        .request(
          path: '/generate-upload-url',
          params: params,
          decoder: S3GeneratedImageFileResponseModel())
        .get();
  }
}


