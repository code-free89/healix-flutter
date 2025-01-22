import 'package:flutter/material.dart';

import '../../models/notification_content.dart';
import '../../util/constants/api_constants.dart';
import '../../util/internet_connetion.dart';
import '../../views/shared_components/show_permission_dialog.dart';
import '../backend_services/backend_call.dart';

class NotificationDataServices {
  Future setNotificationResponse(
    String userId,
    String query,
    String notificationResponse,
  ) async {
    bool isConnected = await InternetConnection.checkInternet();
    if (!isConnected) {
      return;
    }
    try {
      var headers = {'Content-Type': 'application/json'};
      final response = await BackendCall()
          .postRequest(endpoint: setNotificationResponseUrl, jsonBody: {
        "id": userId,
        "query": query,
        "response": notificationResponse,
      });
    } catch (e) {
      print('Error occurred while fetching user profile response: $e');
      throw Exception(
          'Error occurred while fetching user profile response: $e');
    }
  }

  Future getNotificationContent({
    required String userId,
    required String notificationTitle,
  }) async {
    bool isConnected = await InternetConnection.checkInternet();
    if (!isConnected) {
      return;
    }
    try {
      print("Sending request to $getNotificationContentUrl");
      print("User Id: $userId");

      var headers = {'Content-Type': 'application/json'};
      final response = await BackendCall()
          .postRequest(endpoint: getNotificationContentUrl, jsonBody: {
        "id": userId,
        "notification_title": notificationTitle,
      });

      NotificationContent? notificationContent;
      notificationContent = NotificationContent.fromJson(response);
      return notificationContent;
    } catch (e) {
      print('Error occurred while fetching user profile response: $e');
      // showPermissionDialog(context, "Error",
      //     "An error occurred while fetching user profile response: $e");
      throw Exception(
          'Error occurred while fetching user profile response: $e');
    }
  }

  Future<bool> saveFcmToken(String id, String fcmToken) async {
    try {
      final response =
          await BackendCall().postRequest(endpoint: saveFcmTokenUrl, jsonBody: {
        "id": id,
        "fcmToken": fcmToken,
      });
      return true;
    } catch (error) {
      print('Error saving FCM token: $error');
      return false;
    }
  }
}
