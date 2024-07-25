abstract class RawRepresentable<T> {
  final T rawValue;

  RawRepresentable(this.rawValue);
}

typedef StringRawRepresentable = RawRepresentable<String>;
typedef IntegerRawRepresentable = RawRepresentable<int>;
typedef DoubleRawRepresentable = RawRepresentable<double>;