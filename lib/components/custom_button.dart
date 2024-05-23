// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helix_ai/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  bool showLoading = false;

  CustomButton({super.key, required this.onPressed, required this.buttonText, this.showLoading = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonBackgroundColor,
      onPressed: onPressed,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      child: showLoading
          ? CircularProgressIndicator(color: Colors.white,)
          : Text(
              buttonText,
              style: TextStyle(fontFamily: 'Ubuntu-Medium', fontSize: 20, color: buttonTextColor),
            ),
    );
  }
}