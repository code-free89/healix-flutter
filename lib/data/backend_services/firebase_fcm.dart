import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:helix_ai/data/data_services/notification_data_service.dart';

import '../shared_preferences/share_preferences_data.dart';
import 'firestore/firestore.dart';

class FirebaseFCMService {
  static final FirebaseFCMService _firebaseFCMService =
      FirebaseFCMService._internal();
  FirebaseFCMService._internal();
  factory FirebaseFCMService() => _firebaseFCMService;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool initialized = false;

  init() async {
    try {
      if (Platform.isAndroid) {
        await _firebaseMessaging.requestPermission();
        initialized = true;
      } else if (Platform.isIOS) {
        final apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          await _firebaseMessaging.requestPermission();
          initialized = true;
        }
      }
      print('FCM initialized: $initialized');
      if (initialized) {
        String fcmToken = await _firebaseMessaging.getToken() ?? '';
        print('FCM Token: $fcmToken');
        NotificationDataServices()
            .saveFcmToken(SharePreferenceData().uid, fcmToken);
        _firebaseMessaging.onTokenRefresh.listen((token) {
          print('FCM Token: $token');
          NotificationDataServices()
              .saveFcmToken(SharePreferenceData().uid, token);
        });
      }
    } catch (e) {
      print('FCM initialization error: $e');
    }
  }

  updateToken() async {
    if (!initialized) {
      await init();
    }
    final token = await _firebaseMessaging.getToken();
    if (token == null) return;
    NotificationDataServices().saveFcmToken(SharePreferenceData().uid, token);
  }

  Future<String?> getToken() async {
    if (!initialized) {
      await init();
    }
    return await _firebaseMessaging.getToken();
  }
}
