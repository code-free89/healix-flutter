import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helix_ai/main.dart';
import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:provider/provider.dart';

import '../../../controllers/chat_provider.dart';
import '../../../models/notification_content.dart';
import '../../firebase_fcm.dart';

// Background message handler
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Handling a background message: ${message.messageId}');
  log("Title: ${message.notification?.title}");
  log("Body: ${message.notification?.body}");
  log("Data: ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Notification channel for Android
  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel", // Channel ID
    "High Importance Notifications", // Channel name
    description: "This channel is used for important notifications",
    importance: Importance.high,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    final context = navigatorKey.currentContext;

    if (context != null) {
      var response = await Provider.of<ChatProvider>(context, listen: false)
          .getNotificationContent(message.notification!.title!);
      log('notification Message  ::: ${message.notification!.title!}');
      log('notification res ${response}');

      if (response is NotificationContent) {
        isNotification = true;
        Provider.of<ChatProvider>(context, listen: false)
            .updateAnswerWithNotification(response.query);
        Provider.of<ChatProvider>(context, listen: false)
            .updateNotificationOptions(response.choices);
      }
    }
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(android: android, iOS: iOS);

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

  Future<void> initPushNotifications() async {
    // Request permissions
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log('Push notifications permission denied');
      return;
    }

    // Set foreground notification presentation options for iOS
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle app opened from a notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Background and foreground notification handling
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );

      handleMessage(message);
    });
  }

  Future<void> initNotifications() async {
    await initLocalNotifications();
    await initPushNotifications();
  }
}
