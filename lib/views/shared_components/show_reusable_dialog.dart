import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/views/shared_components/want_text.dart';

// Function to show permission dialog
void showReusableDialog(
  BuildContext context,
  String title,
  String message,
  String OKText,
) {
  final size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Rounded corners
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Stack(
          clipBehavior: Clip.none, // To allow the close button to overlap
          children: [
            // Dialog content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Makes the dialog only as big as its content
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorGreyText,
                    ),
                  ),
                  SizedBox(height: 24),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: WantText(
                      text: OKText,
                      fontSize: size.width * 0.036,
                      fontWeight: FontWeight.bold,
                      textColor: whiteColor,
                      usePoppins: false,
                    ),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(size.width * 0.8, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      backgroundColor: Colors.black,
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            // Close button on the top right corner
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close, color: colorBlack),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog when pressed
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
