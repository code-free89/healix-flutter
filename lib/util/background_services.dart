import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'health_permission_manager/health_permission_manager.dart';

late String uid;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  // Use a health-specific channel ID and name
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'health_foreground_service', // id
    'Health Monitoring Service', // title
    description: 'Background service for health data monitoring', // description
    importance: Importance.low, // Changed to high for health data
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'health_foreground_service',
        initialNotificationTitle: 'Healix AI Health Monitor',
        initialNotificationContent: 'Monitoring health data...',
        foregroundServiceNotificationId: 888,
        foregroundServiceTypes: [
          AndroidForegroundType.health,
          AndroidForegroundType.dataSync
        ]),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    uid = preferences.getString('uid') ?? '';
    if (uid.isNotEmpty) {
      await HealthPermissionManager().fetchHealthDataFromDevice(uid);
    }
    return true;
  } catch (e) {
    debugPrint('iOS background service error: $e');
    return false;
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();

  if (service is AndroidServiceInstance) {
    try {
      service.setAsForegroundService();
    } catch (e) {
      debugPrint('Error setting foreground service: $e');
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }

  // Handle UID updates
  service.on('dataReceived').listen((event) {
    if (event != null && event['uid'] != null) {
      uid = event['uid'];
      debugPrint('Received UID: $uid');
      preferences.setString('uid', uid);
    }
  });

  // Set up periodic health data sync
  Timer.periodic(const Duration(minutes: 10), (timer) async {
    if (service is AndroidServiceInstance) {
      try {
        if (await service.isForegroundService()) {
          await service.setForegroundNotificationInfo(
            title: 'Healix AI Health Monitor',
            content: 'Syncing health data...',
          );
        }
      } catch (e) {
        debugPrint('Error updating notification: $e');
      }
    }

    try {
      debugPrint('Starting health data sync at: ${DateTime.now()}');
      if (uid.isNotEmpty) {
        await HealthPermissionManager().fetchHealthDataFromDevice(uid);
        debugPrint('Health data sync completed successfully');
      } else {
        debugPrint('UID is missing. Skipping health data fetch.');
      }
    } catch (e) {
      debugPrint('Error during health data sync: $e');
    }
  });
}
