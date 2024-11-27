// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/colors.dart';

import '../../util/constants/constant.dart';

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
 final Color textColor;
 final String? initialText;
 final Color stockColor;
 final int? maxLength;

  const LabelTextField({super.key ,
    required this.textController ,
    required this.hintText ,
    required this.obsecureText ,
    required this.helperText ,
    required this.textInputType ,
    required this.labelText ,
    required this.filled,
    required this.validator,
    required this.textInputAction,
    required this.textColor,
    this.initialText, required this.stockColor, this.maxLength});


  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: height*0.008),
          child: Text(labelText, style: TextStyle(fontSize: height*0.015     , color: Color.fromRGBO(38, 37, 34, 1) )),
        ),
        TextFormField(
          initialValue: initialText,
          maxLength: maxLength==null?null:3,
          validator: validator,
          controller: textController,
          decoration: InputDecoration(
              counterText: "",
            errorMaxLines: 3,
              contentPadding: EdgeInsets.fromLTRB(14, 16, 16, 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(
                color: stockColor,
                width: 1,
              )),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(
                color: stockColor,
                width: 1,
              )),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 17
              ),
              errorStyle: TextStyle(
                overflow: TextOverflow.visible
              ),
              fillColor: textFieldColor,
              filled: filled,
              helperText: helperText,
              helperStyle: TextStyle(
                fontSize: 12,
                color: textColor,
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
