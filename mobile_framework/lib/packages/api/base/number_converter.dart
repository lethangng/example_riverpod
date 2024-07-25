abstract class NumberConverter<FromType> {
  dynamic data;

  NumberConverter(this.data);

  FromType? convert();
}

class IntegerConverter extends NumberConverter<int> {
  IntegerConverter(super.data);

  @override
  int? convert() {
    if (data is int) {
      return data;
    }

    if (data is double) {
      return (data as double).toInt();
    }

    return null;
  }
}

class DoubleConverter extends NumberConverter<double> {
  DoubleConverter(super.data);

  @override
  double? convert() {
    if (data is int) {
      return (data as int).toDouble();
    }

    if (data is double) {
      return data;
    }

    return null;
  }
}
