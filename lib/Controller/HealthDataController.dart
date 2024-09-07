import 'dart:convert';
import 'package:helix_ai/model/gethealthdata.dart';
import 'package:helix_ai/model/puthealthdata.dart';
import 'package:http/http.dart' as http;

class HealthDataController {
  final String putHealthDataapiUrl =
      'https://puthealthdata-5auw6dnapq-uc.a.run.app';
  final String getHealthDataapiUrl =
      'https://gethealthdata-5auw6dnapq-uc.a.run.app';

  //MARK: - Function For Put Health Data
  Future<void> postHealthData(HealthDataRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(getHealthDataapiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        print('Data posted successfully Post.');
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while posting data: $e');
    }
  }

  //MARK: - Function for Get Health Data
  Future<gethealthdataResponse> fetchHealthData(
      gethealthdataRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(getHealthDataapiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        // Parse the response body as JSON
        final responseJson = jsonDecode(response.body);

        // Convert the JSON to a `gethealthdataResponse` object
        return gethealthdataResponse.fromJson(responseJson);
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
        // Handle the error case by returning an empty or default response
        throw Exception('Failed to Get/Fetch data');
      }
    } catch (e) {
      print('Error occurred while posting data: $e');
      // Handle the error by throwing an exception or returning a default value
      throw Exception('Error occurred while getting data: $e');
    }
  }
}
