import 'dart:convert';
import 'package:helix_ai/model/gethealthdata.dart';
import 'package:helix_ai/model/puthealthdata.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; // For timeout exceptions

class HealthDataController {
  final String putHealthDataapiUrl =
      'https://us-central1-smarte-cloudservice-846b2.cloudfunctions.net/save_health_data';
  final String getHealthDataapiUrl =
      'https://us-central1-smarte-cloudservice-846b2.cloudfunctions.net/get_health_data';

  //MARK: - Function For Put Health Data
  Future<void> postHealthData(HealthDataRequest request) async {
    try {
      print("Sending request to $putHealthDataapiUrl");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await http
          .post(
        Uri.parse(putHealthDataapiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(Duration(seconds: 15), onTimeout: () {
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

  //MARK: - Function for Get Health Data
  Future<gethealthdataResponse> fetchHealthData(
      gethealthdataRequest request) async {
    try {
      print("Sending request to $getHealthDataapiUrl");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await http
          .post(
        Uri.parse(getHealthDataapiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(Duration(seconds: 15), onTimeout: () {
        print('Request timed out');
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

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
