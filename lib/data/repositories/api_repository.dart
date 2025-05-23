import 'package:flutter/material.dart';
import 'package:helix_ai/data/data_services/user_data_services.dart';
import 'package:helix_ai/data/data_services/message_data_services.dart';

import '../../models/billing_data_model.dart';
import '../../models/customized_fetch_data_request.dart';
import '../../models/customized_request.dart';
import '../../models/final_quote_data_model.dart';
import '../../models/getCustomizedata.dart';
import '../../models/user_data_view_model.dart';
import '../../models/user_profile_data.dart';
import '../data_services/health_data_services.dart';
import '../data_services/notification_data_service.dart';

class ApiRepository {
  final HealthDataServices healthDataController = HealthDataServices();

  // Passing context from the caller
  Future<CustomizedResponse> getCustomizedData(
    CustomizedRequest request,
  ) {
    return MessageDataServices().getCustomizedData(request);
  }

  Future<void> addUserLocation(
      String userId, double latitude, double longitude) {
    return UserDataServices().addUserLocation(userId, latitude, longitude);
  }

  Future<FinalQuoteDataModel> getFinalQuoteData(
    CustomizedFetchDataRequest request,
  ) {
    return MessageDataServices().getFinalQuoteData(request);
  }

  Future<bool> addUserProfile(UserViewModel userData) {
    return UserDataServices().addUserProfile(userData);
  }

  Future<bool> addUserBillingData(BillingDataModel billingData) {
    return UserDataServices().addUserBillingData(billingData);
  }

  Future<UserProfileData> getUserProfileData(
    String userId,
  ) {
    return UserDataServices().getUserProfileData(
      userId,
    );
  }

  Future setNotificationResponse(
    String userId,
    String query,
    String notificationResponse,
  ) {
    return NotificationDataServices().setNotificationResponse(
      userId,
      query,
      notificationResponse,
    );
  }

  Future getNotificationContent(
    String userId,
    String notificationTitle,
  ) {
    return NotificationDataServices().getNotificationContent(
      userId: userId,
      notificationTitle: notificationTitle,
    );
  }

  Future<bool> updateUserAddress(
      String uid, Map<String, dynamic> newAddress) async {
    return await UserDataServices().updateUserAddress(uid, newAddress);
  }
}
