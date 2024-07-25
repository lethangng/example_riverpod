import 'package:mobile_framework/mobile_framework.dart';

class S3RequestGeneratedUrlParams extends BaseParams {
  final FileType fileType;
  final S3BucketType bucketType;
  final String fileName;

  @override
  Map<String, dynamic> buildParams() {
    // TODO: implement buildParams
    return {
      "type": fileType.rawValue,
      "bucket": bucketType.rawValue,
      "fileName": fileName,
    };
  }

  S3RequestGeneratedUrlParams({
    required this.fileType,
    required this.bucketType,
    required this.fileName,
  });
}
