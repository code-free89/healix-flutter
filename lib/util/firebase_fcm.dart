import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_provider.dart';

import 'backend_services/firestore/firestore.dart';

class FirebaseFCMService {
  static final FirebaseFCMService _firebaseFCMService =
      FirebaseFCMService._internal();
  FirebaseFCMService._internal();
  factory FirebaseFCMService() => _firebaseFCMService;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool initialized = false;

  init() async {
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
      FirestoreService().saveFcmToken(SharePreferenceProvider().uid, fcmToken);
      _firebaseMessaging.onTokenRefresh.listen((token) {
        print('FCM Token: $token');
        FirestoreService().saveFcmToken(SharePreferenceProvider().uid, token);
      });
    }
  }

  updateToken() async {
    if (!initialized) {
      await init();
    }
    final token = await _firebaseMessaging.getToken();
    if (token == null) return;
    FirestoreService().saveFcmToken(SharePreferenceProvider().uid, token);
  }

  Future<String?> getToken() async {
    if (!initialized) {
      await init();
    }
    return await _firebaseMessaging.getToken();
  }
}
