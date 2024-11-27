// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/colors.dart';

import '../../util/constants/constant.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Container(
          height: 2,
          color: dividerColor,
        )
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0 , left: 5),
          child: Text("OR" ,
          style: TextStyle(
            fontSize: height * 0.015,
            color: dividerColor,
          ),
          ),
        ),
        Expanded(child: Container(
          height: 2,
          color: dividerColor,
        )
        ),
      ],
    );
  }
}
