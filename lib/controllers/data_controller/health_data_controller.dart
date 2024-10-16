import 'dart:convert';
import 'dart:async'; // For timeout exceptions
import 'package:flutter/material.dart';
import 'package:helix_ai/model/getCustomizedata.dart';
import 'package:helix_ai/model/gethealthdata.dart';
import 'package:helix_ai/model/puthealthdata.dart';
import 'package:http/http.dart' as http;

class CustomizedRequest {
  final String id;
  final String searchText;

  CustomizedRequest({required this.id, required this.searchText});

  Map<String, dynamic> toJson() => {
        'id': id,
        'search_text': searchText,
      };
}

class HealthDataController {
  final String putHealthDataapiUrl =
      'https://us-central1-smarte-cloudservice-846b2.cloudfunctions.net/save_health_data';
  final String getHealthDataapiUrl =
      'https://us-central1-smarte-cloudservice-846b2.cloudfunctions.net/get_health_data';
  final String getcustomizedUrl =
      'https://us-central1-smarte-cloudservice-846b2.cloudfunctions.net/get_customized_response';

  // Function to show permission dialog
  void showPermissionDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function for showing dialog to get input from the user
  Future<CustomizedRequest?> showCustomizedRequestDialog(
      BuildContext context) async {
    final idController = TextEditingController();
    final searchTextController = TextEditingController();

    return showDialog<CustomizedRequest>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Customized Request Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: 'ID'),
              ),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(labelText: 'Search Text'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without sending the request
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (idController.text.isNotEmpty &&
                    searchTextController.text.isNotEmpty) {
                  // Create a CustomizedRequest object and return it
                  final request = CustomizedRequest(
                    id: idController.text,
                    searchText: searchTextController.text,
                  );
                  Navigator.of(context).pop(request); // Return the request
                } else {
                  // Show error or warning if fields are empty
                  print("Fields cannot be empty");
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // MARK: - Function For Put Health Data
  Future<void> postHealthData(
      HealthDataRequest request, BuildContext context) async
  {
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
        showPermissionDialog(context, "Error",
            "The connection has timed out, please try again later.");
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      if (response.statusCode == 200) {
        print('Data posted successfully.');
        showPermissionDialog(context, "Success", "Data posted successfully.");
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        showPermissionDialog(context, "Error",
            "Failed to post data. Status code: ${response.statusCode}");
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error occurred while posting data: $e');
      showPermissionDialog(
          context, "Error", "An error occurred while posting data: $e");
      throw Exception('Error occurred while posting data: $e');
    }
  }

  // MARK: - Function for Get Health Data
  Future<gethealthdataResponse> fetchHealthDataForGraph(
      gethealthdataRequest request, BuildContext context) async {
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
        showPermissionDialog(context, "Error",
            "The connection has timed out, please try again later.");
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseJson = jsonDecode(response.body);
          return gethealthdataResponse.fromJson(responseJson);
        } else {
          showPermissionDialog(context, "Error", "Empty response body");
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
      print("Sending request to $getcustomizedUrl");
      print("Request body: ${jsonEncode(request.toJson())}");

      final response = await http
          .post(
        Uri.parse(getcustomizedUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      )
          .timeout(Duration(seconds: 15), onTimeout: () {
        print('Request timed out');
        showPermissionDialog(context, "Error",
            "The connection has timed out, please try again later.");
        throw TimeoutException(
            'The connection has timed out, please try again later.');
      });

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseJson = jsonDecode(response.body);
          return CustomizedResponse.fromJson(responseJson);
        } else {
          showPermissionDialog(context, "Error", "Empty response body");
          throw Exception('Empty response body');
        }
      } else {
        print(
            'Failed to fetch customized response. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        showPermissionDialog(context, "Error",
            "Failed to fetch customized response. Status code: ${response.statusCode}");
        throw Exception('Failed to fetch customized response');
      }
    } catch (e) {
      print('Error occurred while fetching customized response: $e');
      showPermissionDialog(context, "Error",
          "An error occurred while fetching customized response: $e");
      throw Exception('Error occurred while fetching customized response: $e');
    }
  }
}
