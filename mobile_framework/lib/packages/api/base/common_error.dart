import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/packages/global/define.dart';

abstract interface class CommonErrorTransformable {
  CommonError transform(CommonError error);
}

class CommonError implements Exception {
  String? message;
  int? errorCode;
  dynamic errorData;

  CommonError({this.message, this.errorCode, this.errorData});

  factory CommonError.message(String? message) => CommonError(message: message);

  factory CommonError.fromDioError(DioException error, {Ref? ref}) {
    if (get.isRegistered<CommonErrorTransformable>()) {
      return get<CommonErrorTransformable>().transform(CommonError(
          message: error.message,
          errorCode: error.response?.statusCode,
          errorData: error.response?.data));
    }

    if ((error.response?.statusCode ?? 0) >= 400) {
      return CommonError(
          message: "Có lỗi xảy ra, vui lòng thử lại sau",
          errorCode: error.response?.statusCode,
          errorData: error.response?.data);
    }

    return CommonError(
        message: error.message,
        errorCode: error.response?.statusCode,
        errorData: error.response?.data);
  }
}
