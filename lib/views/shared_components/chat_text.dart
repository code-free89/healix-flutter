import 'package:flutter/material.dart';
import 'package:helix_ai/views/shared_components/want_text.dart';

import '../../util/constants/constant.dart';

class ChatText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;

  const ChatText({super.key, required this.text,this.textAlign, this.color});

  @override
  Widget build(BuildContext context) {
    return WantText(
      text: text,
      fontSize: width * 0.043,
      fontWeight: FontWeight.w400,
      textColor: color??Color(0xff333333),
      usePoppins: false,
      textAlign: textAlign?? TextAlign.start,
      textOverflow: TextOverflow.fade,
    );

  }
}