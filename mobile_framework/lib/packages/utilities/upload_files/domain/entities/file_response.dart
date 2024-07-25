import 'package:mobile_framework/packages/utilities/upload_files/domain/entities/s3_domain_name_builder.dart';

class FileResponse {
  List<String>? responseUrls;

  FileResponse.from(this.responseUrls);

  FileResponse();

  List<String>? get fullUrls => responseUrls
      ?.where((element) => element.isNotEmpty)
      .map((e) => "${S3DomainBuilder().build()}$e")
      .toList();
}
