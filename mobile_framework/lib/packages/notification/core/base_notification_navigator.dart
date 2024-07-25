// ignore_for_file: public_member_api_docs, sort_constructors_first

@Deprecated("Use NotificationTypeMixin instead")

/// Usually an enum will implement this
abstract interface class NotificationDestination {}

@Deprecated("Use NotificationTypeMixin instead")
class NotificationNavigatorData {
  NotificationDestination destination;
  dynamic data;

  NotificationNavigatorData({
    required this.destination,
    required this.data,
  });
}

@Deprecated("Use NotificationTypeMixin instead")
abstract class NotificationNavigable {
  bool canNavigateWith(NotificationNavigatorData data);
  navigateToTargetWith<T>(NotificationNavigatorData data);

  void onTapNotification(NotificationNavigatorData data) {
    if (canNavigateWith(data)) {
      navigateToTargetWith(data);
    }
  }
}
