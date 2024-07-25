abstract class APIVersion {
  String get rawValue;
}

class StringAPIVersion implements APIVersion {
  final String value;

  StringAPIVersion(this.value);

  @override
  String get rawValue => value;
}

enum DefaultAPIVersion implements APIVersion {
  v1;

  @override
  String get rawValue {
    switch (this) {
      case DefaultAPIVersion.v1:
        return "/api/v1";
    }
  }
}

extension APIVersionX on DefaultAPIVersion {
  String get rawValue {
    switch (this) {
      case DefaultAPIVersion.v1:
        return "/api/v1";
    }
  }
}
