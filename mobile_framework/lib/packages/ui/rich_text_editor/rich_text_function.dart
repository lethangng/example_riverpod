class RawAnonymousFunction {
  String params;
  String body;

  @override
  String toString() {
    return "($params) => { $body }";
  }

  RawAnonymousFunction({
    required this.params,
    required this.body,
  });
}

class RawFunction {
  String name;
  String params;
  String body;

  RawFunction(this.name, this.params, this.body);

  @override
  String toString() {
    return "function $name($params) { $body }";
  }
}
