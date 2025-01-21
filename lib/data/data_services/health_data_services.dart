import 'dart:convert';
import 'dart:async'; // For timeout exceptions
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../models/gethealthdata.dart';
import '../../models/notification_content.dart';
import '../../models/puthealthdata.dart';
import '../../util/constants/api_constants.dart';
import '../../util/constants/constant.dart';
import '../../util/internet_connetion.dart';
import '../../views/shared_components/show_permission_dialog.dart';

class HealthDataServices {
  Dio dio = Dio();

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
}
