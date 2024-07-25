/// use to transform object to Map to send in request body
abstract interface class Encodable {
  Map<String, dynamic> encode();
}

abstract interface class Decodable {
  void decode(json);
}

abstract interface class Codable implements Encodable, Decodable {}
