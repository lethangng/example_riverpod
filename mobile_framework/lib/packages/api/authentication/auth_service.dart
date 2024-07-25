import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

abstract class RetryRequestErrorHandler extends GetxService {
  void onRetryError({Response? response});
  void onRefreshTokenError({Response? response});
}
