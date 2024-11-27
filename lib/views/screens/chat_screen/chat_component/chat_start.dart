// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/views/shared_components/chat_text.dart';

import '../../../../util/constants/constant.dart';

class ChatStart extends StatelessWidget {
  ChatStart({super.key});

  final List<String> capability = [
    'Revolutionize your nutrition with Gene – the ultimate solution for automating your diet.',
    'Prioritize your mental well-being with Gene',
    'Effortlessly order and track essential tests and other health metrics,'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              appLogo,
              height: height * 0.1,
              width: height * 0.065,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            ChatText(text: "Gene Capabilities"),
            SizedBox(
              height: height * 0.03,
            ),
            ListView.builder(
              itemCount: capability.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(height * 0.0128),
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  decoration: BoxDecoration(
                      color: f5f5feColor,
                      borderRadius: BorderRadius.circular(height * 0.02)),
                  width: double.infinity,
                  child: Column(
                    children: [
                      ChatText(text: capability[index]),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: height * 0.02),
            Text(
              "These are just examples what can I do.",
              style: TextStyle(
                fontSize: height * 0.021,
                color: gray1Color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
