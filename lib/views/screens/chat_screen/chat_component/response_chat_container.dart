// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/colors.dart';

class ResponseChatContainer extends StatelessWidget {
  final String message;

  const ResponseChatContainer({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 55, 22),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: gray5Color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(12),
            )),
        child: Text(
          message,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'Urbanist',
              color: Color.fromRGBO(51, 51, 51, 1)),
        ),
      ),
    );
  }
}
