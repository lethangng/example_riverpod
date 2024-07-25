import 'package:mobile_framework/packages/api/base/json_codable.dart';

mixin MetadataUpdater<T extends Metadata> {
  Function(T? metadata)? onUpdateMetadata;

  void updateMetadata(T metadata) {
    onUpdateMetadata?.call(metadata);
  }
}

class Metadata implements Decodable {
  int? total;
  int? totalPage;
  int? size;
  int? page;

  @override
  void decode(json) {
    if (json == null) {
      return;
    }

    total = json['total'];
    totalPage = json['total_page'] ?? json["totalPage"];
    size = json['size'];
    page = json['page'];
  }

  bool get canLoadMore {
    if (totalPage == null) {
      return false;
    }

    if (page == null) {
      return true;
    }

    return page! < (totalPage! - 1);
  }
}
