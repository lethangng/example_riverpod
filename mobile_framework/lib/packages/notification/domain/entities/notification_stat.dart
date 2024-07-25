import 'package:mobile_framework/packages/clean_architecture/core/domain/entity/domain_entity.dart';

class NotificationStat extends StandardEntity {
  int? read;
  int? unread;
  int? total;
}
