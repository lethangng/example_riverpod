import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/s3_generated_file_response.dart';

abstract interface class IS3FileRepository {
  ResultFuture<S3GeneratedFileResponse>
      getGeneratedFileUrlForUploadingSingleImage(BaseParams? params);
}
