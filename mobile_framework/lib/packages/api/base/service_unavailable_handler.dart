import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/api/base/dio_base.dart';
import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/alert_notification_name.dart';

mixin ServiceUnavailableHandler {
  bool isServiceUnavailable = false;
  RequestOptions? options;

  /// Should be called when user presses reload button on service unavailable page
  Future<bool> retryRequest() async {
    if (this.options == null) return false;

    var options = this.options!;

    NotificationCenter().postNotification(AlertNotificationName.showLoading);
    return await DioBase.instance
        .request(
      options.baseUrl + options.path,
      cancelToken: options.cancelToken,
      data: options.data,
      onReceiveProgress: options.onReceiveProgress,
      onSendProgress: options.onSendProgress,
      queryParameters: options.queryParameters,
      options: Options(
        method: options.method,
        headers: options.headers,
        contentType: options.contentType,
      ),
    )
        .then((value) {
      NotificationCenter().postNotification(AlertNotificationName.hideLoading);
      return true;
    }).catchError((e) {
      NotificationCenter().postNotification(AlertNotificationName.hideLoading);
      return false;
    });
  }

  void _onServiceUnavailable(RequestOptions? options) {
    if (options != null && isServiceUnavailable) {
      this.options = options;
      onShowServiceUnavailablePage();
    }
  }

  onShowServiceUnavailablePage();
}

class ServiceUnavailableInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    get<ServiceUnavailableHandler>().isServiceUnavailable = false;
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 503) {
      get<ServiceUnavailableHandler>().isServiceUnavailable = true;
      get<ServiceUnavailableHandler>()
          ._onServiceUnavailable(err.response?.requestOptions);
    }

    super.onError(err, handler);
  }
}
