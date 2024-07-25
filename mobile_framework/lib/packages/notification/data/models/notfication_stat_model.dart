import 'package:mobile_framework/packages/api/base/json_codable.dart';
import 'package:mobile_framework/packages/notification/domain/entities/notification_stat.dart';

class NotificationStatModel extends NotificationStat implements Decodable {
  @override
  void decode(json) {
    total = json['total'];
    unread = json['unRead'];
    read = json['read'];
  }
}
