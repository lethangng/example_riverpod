/// A method returns a human readable string representing a file _size
String filesize(dynamic size, [int round = 2]) {
  /** 
   * [size] can be passed as number or as string
   *
   * the optional parameter [round] specifies the number 
   * of digits after comma/point (default is 2)
   */
  var divider = 1024;
  int size0;
  try {
    size0 = int.parse(size.toString());
  } catch (e) {
    throw ArgumentError('Can not parse the size parameter: $e');
  }

  if (size0 < divider) {
    return '$size0 B';
  }

  if (size0 < divider * divider && size0 % divider == 0) {
    return '${(size0 / divider).toStringAsFixed(0)} KB';
  }

  if (size0 < divider * divider) {
    return '${(size0 / divider).toStringAsFixed(round)} KB';
  }

  if (size0 < divider * divider * divider && size0 % divider == 0) {
    return '${(size0 / (divider * divider)).toStringAsFixed(0)} MB';
  }

  if (size0 < divider * divider * divider) {
    return '${(size0 / divider / divider).toStringAsFixed(round)} MB';
  }

  if (size0 < divider * divider * divider * divider && size0 % divider == 0) {
    return '${(size0 / (divider * divider * divider)).toStringAsFixed(0)} GB';
  }

  if (size0 < divider * divider * divider * divider) {
    return '${(size0 / divider / divider / divider).toStringAsFixed(round)} GB';
  }

  if (size0 < divider * divider * divider * divider * divider &&
      size0 % divider == 0) {
    num r = size0 / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} TB';
  }

  if (size0 < divider * divider * divider * divider * divider) {
    num r = size0 / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} TB';
  }

  if (size0 < divider * divider * divider * divider * divider * divider &&
      size0 % divider == 0) {
    num r = size0 / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} PB';
  } else {
    num r = size0 / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} PB';
  }
}
