import 'package:flutter/material.dart';
import 'package:helix_ai/data/data_services/user_data_services.dart';
import 'package:helix_ai/data/repositories/message_repository.dart';

import '../../models/customized_fetch_data_request.dart';
import '../../models/customized_request.dart';
import '../../models/getCustomizedata.dart';
import '../../models/user_data_view_model.dart';
import '../../models/user_profile_data.dart';
import '../data_services/health_data_services.dart';

class ApiRepository {
  final HealthDataServices healthDataController = HealthDataServices();

  // Passing context from the caller
  Future<CustomizedResponse> getCustomizedData(
      CustomizedRequest request, BuildContext context) {
    return MessageRepository().getCustomizedData(request, context);
  }

  Future<void> addUserLocation(
      String userId, double latitude, double longitude) {
    return UserDataServices().addUserLocation(userId, latitude, longitude);
  }

  Future<bool> getFinalQuoteData(
      CustomizedFetchDataRequest request, BuildContext context) {
    return MessageRepository().getFinalQuoteData(request, context);
  }

  Future<bool> addUserProfile(BuildContext context, UserViewModel userData) {
    return UserDataServices().addUserProfile(context, userData);
  }

  Future<UserProfileData> getUserProfileData(
    BuildContext context,
    String userId,
  ) {
    return UserDataServices().getUserProfileData(
      context,
      userId,
    );
  }

  Future setNotificationResponse(
    BuildContext context,
    String userId,
    String query,
    String notificationResponse,
  ) {
    return healthDataController.setNotificationResponse(
      context,
      userId,
      query,
      notificationResponse,
    );
  }

  Future getNotificationContent(
    String userId,
    String notificationTitle,
  ) {
    return healthDataController.getNotificationContent(
      userId: userId,
      notificationTitle: notificationTitle,
    );
  }
}
