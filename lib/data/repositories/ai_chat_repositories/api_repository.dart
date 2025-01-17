import 'package:flutter/material.dart';
import 'package:helix_ai/data/models/view_model/user_data_view_model.dart';

import '../../../../data/models/model/getCustomizedata.dart';
import '../../../../data/models/view_model/customized_fetch_data_request.dart';
import '../../../../data/models/view_model/customized_request.dart';
import '../../data_services/health_data_services.dart';
import '../../models/model/user_profile_data.dart';

class ApiRepository {
  final HealthDataServices healthDataController = HealthDataServices();

  // Passing context from the caller
  Future<CustomizedResponse> getCustomizedData(
      CustomizedRequest request, BuildContext context) {
    return healthDataController.getCustomizedData(request, context);
  }

  Future<void> addUserLocation(
      String userId, double latitude, double longitude) {
    return healthDataController.addUserLocation(userId, latitude, longitude);
  }

  Future<bool> getFinalQuoteData(
      CustomizedFetchDataRequest request, BuildContext context) {
    return healthDataController.getFinalQuoteData(request, context);
  }

  Future<bool> addUserProfile(BuildContext context, UserViewModel userData) {
    return healthDataController.addUserProfile(context, userData);
  }

  Future<UserProfileData> getUserProfileData(
    BuildContext context,
    String userId,
  ) {
    return healthDataController.getUserProfileData(
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
}
