import 'package:flutter/material.dart';
import '../../util/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';



class GeneralButton extends StatelessWidget {
  const GeneralButton(
      {Key? key,
        required this.Width,
        required this.onTap,
        this.isSelected = false,this.buttonClick=false,this.isBoarderRadiusLess=false,
        required this.label})
      : super(key: key);

  final double Width;
  final Function()? onTap;
  final String label;
  final bool isSelected;
  final bool buttonClick;final bool isBoarderRadiusLess;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.064,
        width: Width,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: isSelected ? Colors.grey.withOpacity(0.4) : greenThemeColor),
            color: isSelected ? Colors.grey.withOpacity(0.4) :buttonClick?colorWhite: greenThemeColor,
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: width * 0.042,
                  color:buttonClick?colorBlack: colorWhite,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}