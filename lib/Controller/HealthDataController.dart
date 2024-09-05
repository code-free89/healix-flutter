import 'dart:convert';
import 'package:helix_ai/model/puthealthdata.dart';
import 'package:http/http.dart' as http;

class HealthDataController {
  final String apiUrl = 'https://puthealthdata-5auw6dnapq-uc.a.run.app';

  Future<void> postHealthData(HealthDataRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        print('Data posted successfully.');
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while posting data: $e');
    }
  }
}
