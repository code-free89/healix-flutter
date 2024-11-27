// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/util/constants/colors.dart';

import '../../util/constants/constant.dart';

class ProfileGenericTile extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetName;
  final String text;

  const ProfileGenericTile({super.key, required this.onPressed, required this.assetName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(assetName),
                    SizedBox(
                      width: height*0.02,
                    ),
                    Text(
                      text,
                      style: TextStyle(fontFamily: 'Rubik', fontSize: height*0.02, color: genericTileTextColor),
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: height*0.02,
                  width: height*0.02,
                  child: Icon(Icons.chevron_right),
                )
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
