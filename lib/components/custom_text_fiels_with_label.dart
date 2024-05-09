// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {

 final TextEditingController textController;
 final TextInputType textInputType;
 final String labelText;
 final String hintText;
 final String? helperText;
 final bool obsecureText;
 final bool filled;
 final FormFieldValidator<String>? validator;
 final TextInputAction textInputAction;

  const LabelTextField({super.key ,
    required this.textController ,
    required this.hintText ,
    required this.obsecureText ,
    required this.helperText ,
    required this.textInputType ,
    required this.labelText ,
    required this.filled,
    required this.validator,
    required this.textInputAction});


  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(labelText, style: TextStyle(fontSize: 13 , color: Color.fromRGBO(38, 37, 34, 1) )),
        ),
        TextFormField(
          validator: validator,
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
              filled: filled,
              helperText: helperText,
              helperStyle: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(242, 242, 242, 1),
              )
          ),
          obscureText: obsecureText,
          keyboardType: textInputType,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
