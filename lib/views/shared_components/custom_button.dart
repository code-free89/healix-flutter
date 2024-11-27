// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/colors.dart';

import '../../util/constants/constant.dart';

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
              style: TextStyle(fontFamily: 'Ubuntu-Medium', fontSize: height * 0.021, color: buttonTextColor),
            ),
    );
  }
}