import 'package:mobile_framework/packages/api/base/json_codable.dart';
import 'package:mobile_framework/packages/api/base/metadata.dart';

class BaseListResponse<T> {
  List<T> items = [];
  Metadata? metadata;
}

class BaseListResponseModel<T extends Decodable> extends BaseListResponse<T>
    implements Decodable {
  /// can't be null
  late T Function() itemHandler;
  late T decoder;

  BaseListResponseModel.decodeBy(this.itemHandler);

  @override
  void decode(json) {
    if (json == null) {
      return;
    }

    List dataJson = [];
    Map<String, dynamic>? metadataJson;

    if (json is List) {
      dataJson = json;
    } else if (json is Map) {
      dataJson = json['data'] as List;
      metadataJson = json["metadata"];
    }

    items.addAll(dataJson.map((e) => itemHandler()..decode(e)));

    if (metadataJson != null) {
      metadata = Metadata()..decode(metadataJson);
    }
  }
}

/// an [EmptyResponse] will have no data
class EmptyResponse implements Decodable {
  const EmptyResponse();

  @override
  void decode(json) {}
}

const empty = EmptyResponse();
