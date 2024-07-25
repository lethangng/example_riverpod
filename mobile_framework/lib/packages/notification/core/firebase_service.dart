abstract class IFirebaseService {
  Future<void> start();
  Future<void> close();

  Future<void> requestNotificationPermission();
  void registerDeviceToken({String? newToken});
}
