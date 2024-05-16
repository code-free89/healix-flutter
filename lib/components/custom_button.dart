// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  bool showLoading = false;

  CustomButton({super.key, required this.onPressed, required this.buttonText, this.showLoading = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Color.fromRGBO(16, 15, 13, 1),
      onPressed: onPressed,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      child: showLoading
          ? CircularProgressIndicator(color: Colors.white,)
          : Text(
              buttonText,
              style: TextStyle(fontFamily: 'Ubuntu-Medium', fontSize: 20, color: Color.fromRGBO(255, 251, 242, 1)),
            ),
    );
  }
}