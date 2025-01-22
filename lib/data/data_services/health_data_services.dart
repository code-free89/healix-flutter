import 'dart:convert';
import 'dart:async'; // For timeout exceptions
import 'package:flutter/material.dart';

import '../../models/gethealthdata.dart';
import '../../models/notification_content.dart';
import '../../models/puthealthdata.dart';
import '../../util/constants/api_constants.dart';
import '../../util/constants/constant.dart';
import '../../util/internet_connetion.dart';
import '../../views/shared_components/show_permission_dialog.dart';
import '../backend_services/backend_call.dart';

class HealthDataServices {
  // MARK: - Function For Put Health Data
  Future<void> postHealthData(HealthDataRequest request) async {
    try {
      final response = await BackendCall().postRequest(
          endpoint: putHealthDataApiUrl, jsonBody: request.toJson());
    } catch (e) {
      print('Error occurred while posting data: $e');
      throw Exception('Error occurred while posting data: $e');
    }
  }

  // MARK: - Function for Get Health Data
  Future<gethealthdataResponse> fetchHealthDataForGraph(
      gethealthdataRequest request) async {
    try {
      print("Sending request to $getHealthDataApiUrl");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await BackendCall().postRequest(
          endpoint: getHealthDataApiUrl, jsonBody: request.toJson());
      return gethealthdataResponse.fromJson(response);
    } catch (e) {
      print('Error occurred while fetching data: $e');

      throw Exception('Error occurred while getting data: $e');
    }
  }
}
