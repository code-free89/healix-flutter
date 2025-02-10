// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/views/shared_components/chat_text.dart';
import 'package:helix_ai/views/shared_components/want_text.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/authentication_provider.dart';
import '../../../../util/constants/constant.dart';
import '../../../../util/constants/enums.dart';

class ChatStart extends StatelessWidget {
  final NeverScrollableScrollPhysics? scrollableScrollPhysics;
  ChatStart({super.key, this.scrollableScrollPhysics});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    final List<String> capability = [
      'Hi ${authProvider.userData?.name ?? ""}! Welcome to Healix! I am Gene. Go ahead and ask me anything about your health and diet',
      'Revolutionize your nutrition with Gene – the ultimate solution for automating your diet',
      'Manage your chronic condition with precision nutrition',
      'Effortlessly order and track essential tests and other health metrics',
    ];

    return Center(
      child: SingleChildScrollView(
        physics: scrollableScrollPhysics,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              appLogo,
              height: height * 0.1,
              width: height * 0.065,
            ),
            SizedBox(height: height * 0.03),
            WantText(
              text: "Gene Capabilities",
              fontSize: width * 0.061,
              fontWeight: FontWeight.w700,
              textColor: textColor,
              usePoppins: true,
            ),
            SizedBox(height: height * 0.03),
            ListView.builder(
              itemCount: capability.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(height * 0.0128),
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x124a5568),
                        blurRadius: 8,
                        spreadRadius: 3,
                      ),
                    ],
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(width * 0.030),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black, // Keep the default color
                            fontSize: 16, // Keep the default size
                          ),
                          children: _buildStyledText(capability[index]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Function to split the text and apply bold styling to "Gene"
  List<TextSpan> _buildStyledText(String text) {
    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'Gene');
    int lastMatchEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Add the text before "Gene"
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      // Add "Gene" in bold
      spans.add(const TextSpan(
        text: 'Gene',
        style: TextStyle(fontWeight: FontWeight.bold),
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
