import 'package:flutter/foundation.dart';
import 'package:mobile_framework/packages/api/base/base_filter.dart';

abstract class ParametersBuildable {
  Map<String, dynamic> buildParams();
}

/// all params must be extended [BaseParams]
/// and override method [buildParams]
class BaseParams implements ParametersBuildable {
  @protected
  Map<String, dynamic> defaultParams = {};

  @override
  Map<String, dynamic> buildParams() {
    return defaultParams;
  }
}

extension ParamsBuildableExtension on BaseParams {
  BaseParams add(String key, dynamic value) {
    defaultParams[key] = value;
    return this;
  }

  BaseParams addIf(bool condition, String key, dynamic value) {
    if (condition) {
      defaultParams[key] = value;
    }
    return this;
  }

  BaseParams addIfNotNull(String key, dynamic value) {
    if (value != null) {
      defaultParams[key] = value;
    }
    return this;
  }

  BaseParams addIfNotEmpty(String key, dynamic value) {
    if (value != null && value.toString().isNotEmpty) {
      defaultParams[key] = value;
    }
    return this;
  }

  BaseParams addIfNotEmptyList(String key, List<dynamic> value) {
    if (value.isNotEmpty) {
      defaultParams[key] = value;
    }
    return this;
  }

  BaseParams addIfNotEmptyMap(String key, Map<String, dynamic> value) {
    if (value.isNotEmpty) {
      defaultParams[key] = value;
    }
    return this;
  }

  void addFilter(IFilter filter) {
    defaultParams.addAll(filter.buildFilterParams());
  }
}

class PageParams extends BaseParams {
  int page;
  int size;

  String sizeKey;

  PageParams.small({required this.page, this.sizeKey = "size"}) : size = 10;

  PageParams.medium({required this.page, this.sizeKey = "size"}) : size = 20;

  PageParams.large({required this.page, this.sizeKey = "size"}) : size = 50;

  PageParams.custom(
      {required this.page, required this.size, this.sizeKey = "size"});

  @override
  Map<String, dynamic> buildParams() {
    // TODO: implement buildParams
    return super.buildParams()
      ..addAll({
        "page": page,
        sizeKey: size,
      });
  }
}
