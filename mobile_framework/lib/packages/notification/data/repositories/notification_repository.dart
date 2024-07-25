import 'package:mobile_framework/packages/api/api_version.dart';
import 'package:mobile_framework/packages/api/base/base_repository.dart';
import 'package:mobile_framework/packages/api/base/base_response.dart';
import 'package:mobile_framework/packages/api/base/result_plus.dart';
import 'package:mobile_framework/packages/api/builders/common_url_builder.dart';
import 'package:mobile_framework/packages/core/base/app_module.dart';
import 'package:mobile_framework/packages/notification/data/models/notfication_stat_model.dart';
import 'package:mobile_framework/packages/notification/domain/entities/notification_stat.dart';
import 'package:mobile_framework/packages/notification/domain/repositories/notification_repository.dart';

abstract class NotificationRepository extends BaseRepository
    implements INotificationRepository {
  NotificationRepository(Type moduleType)
      : super(
            urlBuilder: CommonURLBuilder(Module.findEnv(of: moduleType).baseUrl,
                StringAPIVersion("/v1")));

  @override
  ResultFuture<NotificationStat> getNotificationStat() {
    return make
        .request(path: "/notification/stats", decoder: NotificationStatModel())
        .get();
  }

  @override
  ResultFuture<EmptyResponse> readAllNotifications() {
    return make
        .request(path: "/notification/read_all", decoder: const EmptyResponse())
        .put();
  }

  @override
  ResultFuture<EmptyResponse> markAsRead(String id) {
    return make
        .request(
            path: "/notification",
            body: {
              "ids": [id]
            },
            decoder: const EmptyResponse())
        .put();
  }
}
