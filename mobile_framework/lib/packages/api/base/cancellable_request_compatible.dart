import 'package:dio/dio.dart';

mixin CancellableRequestsCompatible {
  final List<CancelToken> _bag = List.empty(growable: true);

  void cancelAllRequests() {
    for (var element in _bag) {
      element.cancel("Force to cancel request");
    }
  }

  void addToBag(CancelToken token) {
    _bag.add(token);
  }
}
