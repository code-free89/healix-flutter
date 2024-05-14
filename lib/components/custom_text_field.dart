// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 17
        ),
        fillColor: Color.fromRGBO(242, 242, 242, 1),
        filled: true,
        helperText: helperText,
        helperStyle: TextStyle(
          fontSize: 12,
          color: Color.fromRGBO(242, 242, 242, 1),
        )
      ),
      obscureText: obsecureText,
      keyboardType: textInputType,
      validator: validator,
      textInputAction: textInputAction,
    );
  }
}
