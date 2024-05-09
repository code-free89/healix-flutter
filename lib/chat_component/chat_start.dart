// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/components/chat_text.dart';
import 'package:helix_ai/images_path.dart';

class ChatStart extends StatelessWidget {
  const ChatStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(appLogo , height: 70, width: 30,),
            SizedBox(height: 25,),
            ChatText(text: "Gene Capabilities"),
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(12)
              ),
              width: double.infinity,
              child: Column(
                children: const [
                  ChatText(text : "Revolutionize your nutrition with Gene – "),
                  ChatText(text : "the ultimate solution for automating your "),
                  ChatText(text : "diet."),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(12)
              ),
              width: double.infinity,
              child: Column(
                children: const [
                  ChatText(text : "Prioritize your mental well-being with "),
                  ChatText(text : "Gene"),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(12)
              ),
              width: double.infinity,
              child: Column(
                children: const [
                  ChatText(text : "Effortlessly order and track essential tests"),
                  ChatText(text : "and other health metrics,"),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text("These are just examples what can I do." ,
              style: TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(130, 130, 130, 1)
              ),
            )
          ],
        ),
      ),
    );
  }
}
