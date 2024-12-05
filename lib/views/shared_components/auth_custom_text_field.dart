import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants/colors.dart';

class AuthCustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode; // Added FocusNode parameter

  AuthCustomTextFormField({
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.focusNode, // Initialize FocusNode
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(color: colorBlack.withOpacity(0.15)),
        borderRadius: BorderRadius.all(
          Radius.circular(width * 0.03),
        ),
        boxShadow: [
          BoxShadow(
            color: colorBlack.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 0.3,
          ),
        ],
      ),
      height: height * 0.064,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode, // Attach FocusNode here
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        style: GoogleFonts.roboto(
          color: colorBlack,
          fontSize: width * 0.03733,
          fontWeight: FontWeight.w500,
        ),
        onChanged: onChanged,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.roboto(
            color: colorGreyText,
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
          ),
          hintText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(width * 0.03),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(width * 0.03),
            ),
            borderSide: BorderSide(color: colorGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(width * 0.03),
            ),
            borderSide: BorderSide(color: colorBlack),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
