import 'dart:convert';
import 'dart:async'; // For timeout exceptions
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helix_ai/data/models/model/user_profile_data.dart';
import 'package:helix_ai/data/models/view_model/user_data_view_model.dart';

import 'package:http/http.dart' as http;

import '../../data/models/model/getCustomizedata.dart';
import '../../data/models/model/gethealthdata.dart';
import '../../data/models/model/puthealthdata.dart';
import '../../data/models/view_model/customized_fetch_data_request.dart';
import '../../data/models/view_model/customized_request.dart';
import '../../util/constants/api_constants.dart';
import '../../util/constants/constant.dart';
import '../../views/shared_components/show_permission_dialog.dart';

class HealthDataServices {
  Dio dio = Dio();

  final String putHealthDataApiUrl = '$BASEURL/save_health_data';
  final String getHealthDataApiUrl = '$BASEURL/get_health_data';
  final String getCustomizedUrl = '$BASEURL/get_customized_response';
  final String getQuoteData = '$BASEURL/get_final_quote';
  final String addUserData = '$BASEURL/add_user_profile';
  final String getUserData = '$BASEURL/get_user_profile';
  final String addUserLocationData = '$BASEURL/save_location';
  final String saveFcmTokenUrl = '$BASEURL/save_fcm_token';

  // MARK: - Function For Put Health Data
  Future<void> postHealthData(HealthDataRequest request) async {
    try {
      print("Sending request to $putHealthDataApiUrl");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await http
          .post(
        Uri.parse(putHealthDataApiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(Duration(seconds: TIME_OUT_SECONDS), onTimeout: () {
        print('Request timed out');
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      if (response.statusCode == 200) {
        print('Data posted successfully.');
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error occurred while posting data: $e');
      throw Exception('Error occurred while posting data: $e');
    }
  }

  // MARK: - Function for Get Health Data
  Future<gethealthdataResponse> fetchHealthDataForGraph(
      gethealthdataRequest request, BuildContext context) async {
    try {
      print("Sending request to $getHealthDataApiUrl");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await http
          .post(
        Uri.parse(getHealthDataApiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(Duration(seconds: TIME_OUT_SECONDS), onTimeout: () {
        print('Request timed out');
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });
      print("response from getHealthDataapiUrl: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseJson = jsonDecode(response.body);
          return gethealthdataResponse.fromJson(responseJson);
        } else {
          throw Exception('Empty response body');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error occurred while fetching data: $e');

      throw Exception('Error occurred while getting data: $e');
    }
  }

  // MARK: - Function for Get Customized Response
  Future<CustomizedResponse> getCustomizedData(
      CustomizedRequest request, BuildContext context) async {
    try {
      print("Sending request to $getCustomizedUrl");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await http
          .post(
        Uri.parse(getCustomizedUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(Duration(seconds: TIME_OUT_SECONDS), onTimeout: () {
        print('Request timed out');
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseJson = jsonDecode(response.body);
          return CustomizedResponse.fromJson(responseJson);
        } else {
          throw Exception('Empty response body');
        }
      } else {
        print(
            'Failed to fetch customized response. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch customized response');
      }
    } catch (e) {
      print('Error occurred while fetching customized response: $e');
      throw Exception('Error occurred while fetching customized response: $e');
    }
  }

  Future<bool> getFinalQuoteData(
      CustomizedFetchDataRequest request, BuildContext context) async {
    try {
      print("Sending request to $getQuoteData");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await http
          .post(
        Uri.parse(getQuoteData),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(Duration(seconds: TIME_OUT_SECONDS), onTimeout: () {
        print('Request timed out');
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      if (response.statusCode == 200 || response.statusCode == 202) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error occurred while fetching customized response: $e');
      throw Exception('Error occurred while fetching customized response: $e');
    }
  }

  Future<void> addUserLocation(
      String userId, double latitude, double longitude) async {
    try {
      print("Sending request to $addUserLocationData");
      var headers = {'Content-Type': 'application/json'};
      var data = {"id": userId, "latitude": latitude, "longitude": longitude};
      final response = await dio
          .post(
        addUserLocationData,
        data: data,
        options: Options(
          headers: headers,
        ),
      )
          .timeout(Duration(seconds: TIME_OUT_SECONDS), onTimeout: () {
        print('Request timed out');

        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      print(" addUserLocation response status code ${response.statusCode}");
      print(" addUserLocation response data ${response.data}");
    } catch (e) {
      print('Error occurred while sending location data: $e');

      throw Exception('Error occurred while sending location data: $e');
    }
  }

  Future<bool> addUserProfile(
      BuildContext context, UserViewModel userData) async {
    try {
      print("Sending request to $addUserData");
      var headers = {'Content-Type': 'application/json'};
      final response = await dio
          .post(
        addUserData,
        data: userData.toJson(),
        options: Options(
          headers: headers,
        ),
      )
          .timeout(Duration(seconds: TIME_OUT_SECONDS), onTimeout: () {
        print('Request timed out');
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      print(" add_user_profile response status code ${response.statusCode}");
      print(" add_user_profile response body ${userData.toJson()}");
      print(" add_user_profile response data ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 202) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error occurred while fetching customized response: $e');
      throw Exception('Error occurred while fetching customized response: $e');
    }
  }

  Future<UserProfileData> getUserProfileData(
    BuildContext context,
    String userId,
  ) async {
    try {
      print("Sending request to $getUserData");
      var headers = {'Content-Type': 'application/json'};
      final response = await dio
          .post(
        getUserData,
        data: {
          "id": userId,
        },
        options: Options(
          headers: headers,
        ),
      )
          .timeout(Duration(seconds: TIME_OUT_SECONDS), onTimeout: () {
        print('Request timed out');
        showPermissionDialog(context, "Error",
            "The connection has timed out, please try again later.");
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      print(" get_user_profile response status code ${response.statusCode}");

      print(" get_user_profile response data ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 202) {
        UserProfileData userProfileData =
            await UserProfileData.fromJson(response.data);
        return userProfileData;
      } else {
        throw Exception('Failed to fetch user profile data');
      }
    } catch (e) {
      print('Error occurred while fetching user profile response: $e');
      showPermissionDialog(context, "Error",
          "An error occurred while fetching user profile response: $e");
      throw Exception(
          'Error occurred while fetching user profile response: $e');
    }
  }

  Future<bool> saveFcmToken(String id, String fcmToken) async {
    try {
      final response = await dio.post(
        saveFcmTokenUrl,
        data: {
          "id": id,
          "fcmToken": fcmToken,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.data}');
        return true;
      } else {
        print('Failed to save FCM token. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error saving FCM token: $error');
      return false;
    }
  }
}
