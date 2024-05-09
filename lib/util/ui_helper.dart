import 'package:flutter/material.dart';

class UiHelper {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String message) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }
}
