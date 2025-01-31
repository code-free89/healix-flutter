import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helix_ai/models/billing_data_model.dart';
import 'package:helix_ai/util/constants/api_constants.dart';

import '../../models/user_data_view_model.dart';
import '../../models/user_profile_data.dart';
import '../../views/shared_components/show_permission_dialog.dart';
import '../backend_services/backend_call.dart';

class UserDataServices {
  Future<void> addUserLocation(
      String userId, double latitude, double longitude) async {
    try {
      var data = {"id": userId, "latitude": latitude, "longitude": longitude};
      final response = await BackendCall()
          .postRequest(endpoint: addUserLocationData, jsonBody: data);
    } catch (e) {
      print('Error occurred while sending location data: $e');
      throw Exception('Error occurred while sending location data: $e');
    }
  }

  Future<bool> addUserProfile(UserViewModel userData) async {
    try {
      print("Sending request to $addUserData");
      final response = BackendCall().postRequest(
        endpoint: addUserData,
        jsonBody: userData.toJson(),
      );
      return true;
    } catch (e) {
      print('Error occurred while fetching customized response: $e');
      throw Exception('Error occurred while fetching customized response: $e');
    }
  }

  Future<UserProfileData> getUserProfileData(
    String userId,
  ) async {
    try {
      debugPrint("Sending request to $getUserData");
      final response =
          await BackendCall().postRequest(endpoint: getUserData, jsonBody: {
        "id": userId,
      });
      debugPrint("response from get_user_profile $response");

      return UserProfileData.fromJson(response);
    } catch (e) {
      print('Error occurred while fetching user profile response: $e');
      throw Exception(
          'Error occurred while fetching user profile response: $e');
    }
  }

  Future<bool> updateUserAddress(
      String uid, Map<String, dynamic> addressBlock) async {
    try {
      // Construct the request body
      var data = {"id": uid, "address": addressBlock};
      // Send the request
      final response = await BackendCall()
          .postRequest(endpoint: addUserData, jsonBody: data);
      return true;
    } catch (e) {
      print('Error occurred while updating address: $e');
      return false;
    }
  }

  Future<bool> addUserBillingData(BillingDataModel billingData) async {
    try {
      print("Sending request to $addBillingDataUrl");
      print("body sent to $addBillingDataUrl :::  ${billingData.toJson()}");

      final response = await BackendCall().postRequest(
        endpoint: addBillingDataUrl,
        jsonBody: billingData.toJson(),
      );

      print("response from $addBillingDataUrl :::  $response");

      if (response['error'] != null && response['error'] != '') {
        Fluttertoast.showToast(
          msg: response['status'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
      return true;
    } catch (e) {
      print('Error occurred while adding user billing response: ${e}');
      throw Exception('Error occurred while adding billing response: $e');
    }
  }
}
