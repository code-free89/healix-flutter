// Function for showing dialog to get input from the user
import 'package:flutter/material.dart';

import '../../data/models/view_model/customized_request.dart';

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