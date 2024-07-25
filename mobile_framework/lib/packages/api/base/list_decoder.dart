import 'json_codable.dart';

class ListDecoder {
  dynamic anyList;

  ListDecoder(this.anyList) {
    assert(anyList is List?, "ListDecoder is only used with list");
  }

  List<T> decodeBy<T>(Decodable Function() itemHandler) {
    if (anyList == null || anyList.isEmpty) return [];

    return (anyList as List)
        .where(
          (element) {
            return element != null;
          },
        )
        .map((e) => (itemHandler()..decode(e)) as T)
        .toList();
  }

  List<T> as<T>() {
    if (anyList == null) return [];

    return (anyList as List)
        .where(
          (element) {
            return element != null;
          },
        )
        .map((e) => e as T)
        .toList();
  }
}
