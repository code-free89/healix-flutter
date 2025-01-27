import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WantText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign? textAlign;
  final TextOverflow textOverflow;
  final bool usePoppins;
  final int? maxLines;
  final TextDecoration? decoration;

  WantText({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    required this.usePoppins,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.textOverflow = TextOverflow.ellipsis, // ptional parameter
  });


    @override
    Widget build(BuildContext context) {
      final RegExp urlRegExp = RegExp(
        r'(https?:\/\/[^\s]+)',
        caseSensitive: false,
      );

      final List<TextSpan> textSpans = [];
      text.splitMapJoin(
        urlRegExp,
        onMatch: (Match match) {
          textSpans.add(
            TextSpan(
              text: match.group(0),
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(Uri.parse(match.group(0)!));
                },
            ),
          );
          return '';
        },
        onNonMatch: (String nonMatch) {
          textSpans.add(TextSpan(text: nonMatch));
          return '';
        },
      );

      return RichText(
        text: TextSpan(
          style: usePoppins
              ? GoogleFonts.poppins(
            color: textColor,
            decoration: decoration,
            fontSize: fontSize,
            fontWeight: fontWeight,
          )
              : GoogleFonts.roboto(
            color: textColor,
            fontSize: fontSize,
            decoration: decoration,
            fontWeight: fontWeight,
          ),
          children: textSpans,
        ),
      );
    }
  }

