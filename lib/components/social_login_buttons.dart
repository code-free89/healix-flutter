// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/images_path.dart';

class SocialLoginButtons extends StatelessWidget {

  final String text;
  const SocialLoginButtons({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(text ,
            style: TextStyle(
              fontFamily: 'Ubuntu-Medium',
              fontSize: 20,
              color: Color.fromRGBO(51, 51, 51, 1)
            ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: SvgPicture.asset(googleLogin , fit: BoxFit.none,),
            ),
            SizedBox(width: 20,),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: SvgPicture.asset(appleLogin , fit: BoxFit.none,),
            )
          ],
        )
      ],
    );
  }
}
