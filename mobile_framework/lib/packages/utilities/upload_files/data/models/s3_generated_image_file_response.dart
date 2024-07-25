import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/s3_generated_file_response.dart';

class S3GeneratedImageFileResponseModel extends S3GeneratedFileResponse
    implements Decodable {
  @override
  void decode(json) {
    uploadUrl = json['uploadUrl'];
    filePath = json['imagePath'];
    fileUrl = json['imageUrl'];
  }
}
