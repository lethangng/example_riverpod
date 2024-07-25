import 'package:flutter/cupertino.dart';
import 'package:mobile_framework/mobile_framework.dart';

class ResponsiveValueBuilder<ValueType> {
  final BuildContext context;

  final ValueType? _mobileValue;
  final ValueType? _tabletValue;

  ResponsiveValueBuilder(this.context, this._mobileValue, this._tabletValue);

  T build<T extends ValueType>() {
    assert(_mobileValue != null,
        "Missing mobile value for responsive value builder");
    assert(_tabletValue != null,
        "Missing tablet value for responsive value builder");

    assert(_mobileValue.runtimeType == _tabletValue.runtimeType,
        "Mobile value and tablet value must be the same type");

    return responsiveValue(context,
        mobile: _mobileValue as T, tablet: _tabletValue as T);
  }
}

extension ResponsiveValueBuilderExt on BuildContext {
  T value<T>({required T mobile, required T tablet}) {
    return ResponsiveValueBuilder<T>(this, mobile, tablet).build();
  }
}
