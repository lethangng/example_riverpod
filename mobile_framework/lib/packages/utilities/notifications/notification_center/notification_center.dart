import 'dart:async';
import 'dart:developer';

abstract class NotificationName {
  String get rawValue;
}

class RawStringNotificationName extends NotificationName {
  final String _name;

  RawStringNotificationName(this._name);

  @override
  // TODO: implement name
  String get rawValue => _name;
}

class NotificationCenter {
  static final NotificationCenter _instance = NotificationCenter._internal();

  factory NotificationCenter() {
    return _instance;
  }

  NotificationCenter._internal();

  final Map<String, StreamController<dynamic>> _controllers =
      <String, StreamController<dynamic>>{};

  final Map<String, List<StreamSubscription>> _subscriptions =
      <String, List<StreamSubscription>>{};

  void addObserver<T>(
    NotificationName name, {
    void Function(T?)? callback,
    Function? onError,
  }) {
    try {
      if (_controllers.containsKey(name.rawValue)) {
        final subscription = _controllers[name.rawValue]!.stream.listen(
          (event) {
            callback?.call(event);
          },
          onError: onError,
        );
        _subscriptions[name.rawValue]!.add(subscription);
      } else {
        final controller = StreamController<T?>.broadcast();

        _controllers.putIfAbsent(
          name.rawValue,
          () => controller,
        );

        _subscriptions.putIfAbsent(
          name.rawValue,
          () => [],
        );

        final subscription = controller.stream.listen(
          callback,
          onError: onError,
        );
        _subscriptions[name.rawValue]!.add(subscription);
      }
    } catch (e) {
      log('Error: ${e.toString()}', name: "NotificationCenter");
    }
  }

  void removeObserver<T>(NotificationName name) {
    if (_subscriptions.keys.contains(name.rawValue)) {
      final subs = _subscriptions[name.rawValue]!;
      for (var s in subs) {
        s.cancel();
      }
      _subscriptions.remove(name.rawValue);
      _controllers.remove(name.rawValue);
    }
  }

  void postNotification<T>(NotificationName name, [T? data]) {
    if (_controllers.containsKey(name.rawValue)) {
      _controllers[name.rawValue]!.sink.add(data);
    }
  }
}
