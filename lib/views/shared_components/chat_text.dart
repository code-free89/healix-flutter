import 'package:flutter/material.dart';

import '../../util/constants/constant.dart';

class ChatText extends StatelessWidget {

  final String text;

  const ChatText({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style:  TextStyle(
        color: Color.fromRGBO(51, 51, 51, 1),
        fontSize: height * 0.02
      ),
    );
  }
}
