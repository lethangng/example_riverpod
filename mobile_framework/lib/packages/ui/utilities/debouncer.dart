import 'dart:async';

class Debouncer<T> {
  final Duration duration;
  final void Function(T value) onValue;

  late T _value;
  Timer? _timer;

  Debouncer(this.duration, this.onValue);

  factory Debouncer.miliseconds(
      {int value = 500, required void Function(T value) onValue}) {
    return Debouncer(Duration(milliseconds: value), onValue);
  }

  T get value => _value;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}

typedef StringDebouncer = Debouncer<String>;
typedef IntegerDebouncer = Debouncer<int>;
typedef DoubleDebouncer = Debouncer<double>;
