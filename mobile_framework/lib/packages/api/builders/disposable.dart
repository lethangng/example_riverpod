import 'package:dio/dio.dart';

@Deprecated("Please refer to [cancelBy] in RequestMaker")
mixin Disposable {
  final List<CancelToken> _cancellableBag = [];

  void addCancelToken(CancelToken token) {
    _cancellableBag.add(token);
  }

  void dispose() {
    for (var element in _cancellableBag) {
      element.cancel();
    }
  }
}
