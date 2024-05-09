// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserChatContainer extends StatelessWidget {

  final String message;
  const UserChatContainer({super.key , required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(51,0,7,22),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color.fromRGBO(28, 197, 116, 1),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(3),
          )
        ),
        child: Text(message ,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Urbanist',
          color: Colors.white
        ),
        ),
      ),
    );
  }
}
