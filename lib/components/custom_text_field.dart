// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helix_ai/constants/colors.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController textController;
  final TextInputType textInputType;
  final String hintText;
  final String? helperText;
  final bool obsecureText;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;

  const CustomTextField({super.key ,
    required this.textController ,
    required this.hintText ,
    required this.obsecureText ,
    required this.helperText ,
    required this.textInputType ,
    required this.validator,
    required this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       controller: textController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(14, 16, 16, 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(
          color: dividerColor,
          width: 1,
        )),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(
          color: dividerColor,
          width: 1,
        )),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 17
        ),
        fillColor: textFieldColor,
        filled: true,
        helperText: helperText,
        helperStyle: TextStyle(
          fontSize: 12,
          color: textFieldColor,
        )
      ),
      obscureText: obsecureText,
      keyboardType: textInputType,
      validator: validator,
      textInputAction: textInputAction,
    );
  }
}
