import 'package:mobile_framework/packages/api/base/json_codable.dart';
import 'package:mobile_framework/packages/api/base/list_decoder.dart';
import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/file_response.dart';

class FileResponseModel extends FileResponse implements Decodable {
  @override
  void decode(json) {
    responseUrls = ListDecoder(json).as<String>();
  }
}
