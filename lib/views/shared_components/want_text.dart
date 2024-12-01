import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WantText extends StatelessWidget { final String text;final double fontSize;final FontWeight fontWeight;final Color textColor;final TextAlign? textAlign;final TextOverflow textOverflow; final bool usePoppins;
WantText({
  required this.text,
  required this.fontSize,
  required this.fontWeight,
  required this.textColor,required this.usePoppins,

  this.textAlign, // O
  this.textOverflow=TextOverflow.ellipsis,// ptional parameter
});

@override
Widget build(BuildContext context) {
  return Text(overflow:textOverflow ,textAlign:textAlign?? TextAlign.start,
    text,
    style:usePoppins
        ? GoogleFonts.poppins(color: textColor,fontSize: fontSize,fontWeight:fontWeight,):GoogleFonts.roboto(color: textColor,fontSize: fontSize,fontWeight:fontWeight,), // Set default text color as white
  );
}
}