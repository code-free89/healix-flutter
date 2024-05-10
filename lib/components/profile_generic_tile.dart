// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                      width: 12,
                    ),
                    Text(
                      text,
                      style: TextStyle(fontFamily: 'Rubik', fontSize: 17, color: Color.fromRGBO(64, 62, 57, 1)),
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 24,
                  width: 24,
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
