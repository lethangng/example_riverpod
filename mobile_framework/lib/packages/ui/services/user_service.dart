import 'package:flutter/material.dart';

abstract class IUserService extends ChangeNotifier {
  Future<void> logOut();
  
  void logInFor<User>(User? user);
  void getUserProfile();
  void sendDeviceToken<DeviceToken>(DeviceToken token);
}
