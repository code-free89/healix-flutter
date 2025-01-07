import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helix_ai/main.dart';
import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:helix_ai/data/controllers/provider_controllers/chat_provider.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Handling a background message ${message.messageId}');
  log("title: ${message.notification?.title}");
  log("body: ${message.notification?.body}");
  log("data: ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel", // Channel ID
    "High Importance Notifications", // Channel name
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log('Handling a background message ${message.messageId}');
    log("title: ${message.notification?.title}");
    log("body: ${message.notification?.body}");
    log("data: ${message.data}");
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    final context = navigatorKey.currentContext!;

    if (context != null) {
      isNotification = true;
      Provider.of<ChatProvider>(context, listen: false)
          .updateAnswerWithNotification();
    }
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      final message = RemoteMessage.fromMap(
        jsonDecode(response.payload!),
      );

      handleMessage(message);
    });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_launcher',
            )),
        payload: jsonEncode(message.toMap()),
      );

      handleMessage(message);
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    initPushNotifications();
    initLocalNotifications();
  }
}
