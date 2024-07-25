// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

const firebaseServiceLogName = "FirebaseNotificationService";

// @pragma('vm:entry-point')
// Future<void> _onBackgroundNotification(RemoteMessage message) async {
//   FirebaseNotificationService()
//       .notificationHandler
//       ?.didReceiveNotificationFromBackgroundState(message);
// }

class FirebaseNotificationService extends NotificationService {
  FirebaseNotificationService._();

  RemoteMessage? _initialMessage;

  static FirebaseNotificationService? instance;
  static const String notificationChannelKey = "global_channel_key";
  static const String notificationGroupKey = "global_channel_group";
  static const String notificationChannelName = "global_channel";

  factory FirebaseNotificationService() {
    instance ??= FirebaseNotificationService._();

    return instance!;
  }

  String? androidDefaultIcon;

  StreamSubscription? onMessageSubscription;
  StreamSubscription? onBackgroundMessageSubscription;

  NotificationHandler? notificationHandler;

  @override
  Future<void> close() async {
    await FirebaseMessaging.instance.deleteToken();
    onMessageSubscription?.cancel();
    onBackgroundMessageSubscription?.cancel();
  }

  @override
  void getDeviceToken() async {
    var isTokenAvailable = true;

    if (Platform.isIOS) {
      var apnsToken = await FirebaseMessaging.instance.getAPNSToken();

      isTokenAvailable = apnsToken != null;
    }

    if (!isTokenAvailable) {
      return;
    }

    String? firebaseMessagingToken =
        await FirebaseMessaging.instance.getToken();
    if (firebaseMessagingToken != null) {
      registerDeviceToken(firebaseMessagingToken);
    }
  }

  @override
  void registerDeviceToken(String? deviceToken) {
    notificationHandler?.onRegisterNotificationDeviceToken(deviceToken);
  }

  @override
  Future<void> requestNotificationPermission() {
    return FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true)
        .then((settings) {
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          log("Notification is authorized", name: firebaseServiceLogName);
          break;
        case AuthorizationStatus.denied:
          log("Notification is denied", name: firebaseServiceLogName);
          break;
        case AuthorizationStatus.notDetermined:
          log("Notification is not determined", name: firebaseServiceLogName);
          break;
        case AuthorizationStatus.provisional:
          log("Notification is provisional [iOS]",
              name: firebaseServiceLogName);
          break;
      }
    });
  }

  @override
  Future<void> start() async {
    try {
      await Firebase.initializeApp();

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: false, // Required to display a heads up notification
        badge: false,
        sound: false,
      );
      await requestNotificationPermission();

      initializeIncomingNotifications();
      initializeLocalForegroundMessage();
      registerDependency();
    } catch (e) {
      log(e.toString(), name: "Firebase Start");
    }
  }

  void initializeIncomingNotifications() {
    onMessageSubscription = FirebaseMessaging.onMessage.listen((message) {
      notificationHandler?.didReceiveNotificationFromForegroundState(message);
    });
    onBackgroundMessageSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
      notificationHandler?.didReceiveNotificationFromBackgroundState(message);
    });
  }

  void onInitializeNotificationFromTerminateState() async {
    try {
      if (Firebase.apps.isEmpty) {
        await start();
      }

      if (_initialMessage != null) {
        notificationHandler
            ?.didReceiveNotificationFromTerminatedState(_initialMessage);
      }
    } catch (e) {
      log(e.toString(), name: "onInitializeNotificationFromTerminateState");
    }
  }

  @override
  void initializeLocalForegroundMessage() async {}

  @override
  NotificationService handleNotificationBy(NotificationHandler handler) {
    notificationHandler = handler;
    return this;
  }

  @override
  void deleteRegisteredDeviceToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  @override
  void registerDependency() {
    get.registerSingleton<NotificationService>(this);
  }

  @override
  Future<void> initializeTerminatedNotification() async {
    _initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  }
}

mixin FirebaseNotificationGetMessageFromTerminatedStateMixin<
    T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    FirebaseNotificationService().onInitializeNotificationFromTerminateState();
  }
}

mixin RegisterUpdateUnreadNotificationMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  @override
  void initState() {
    super.initState();

    NotificationCenter().addObserver(
      updateUnreadNumberNotificationName,
      callback: (_) {
        ref.invalidate(unreadNotificationNumberProvider);
      },
    );
  }
}

mixin RegisterMarkUnreadAsReadNotificationMixin<
    T extends ConsumerStatefulWidget> on ConsumerState<T> {
  @override
  void initState() {
    super.initState();

    NotificationCenter().addObserver<String>(
      markUnreadNotificationAsRead,
      callback: (notificationId) {
        ref.read(markNotificationAsReadUCProvider)(params: notificationId);
      },
    );
  }
}
