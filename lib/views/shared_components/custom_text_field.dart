// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/colors.dart';

import '../../util/constants/constant.dart';

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
          contentPadding: EdgeInsets.fromLTRB(height*0.015, height*0.02, height*0.02, height*0.015),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(height*0.015))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(height*0.015)), borderSide: BorderSide(
          color: dividerColor,
          width: 1,
        )),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(height*0.015)), borderSide: BorderSide(
          color: dividerColor,
          width: 1,
        )),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: height*0.02
        ),
        fillColor: textFieldColor,
        filled: true,
        helperText: helperText,
        helperStyle: TextStyle(
          fontSize: height*0.02,
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
