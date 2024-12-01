import 'package:flutter/material.dart';
import 'package:helix_ai/views/screens/auth_screens/profile_screen.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_home.dart';

import '../../../util/constants/colors.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';

class AllergiesSelectionScreen extends StatefulWidget {
  const AllergiesSelectionScreen({super.key});

  @override
  State<AllergiesSelectionScreen> createState() =>
      _AllergiesSelectionScreenState();
}

class _AllergiesSelectionScreenState extends State<AllergiesSelectionScreen> {
  final List<String> allergies = [
    "Milk",
    "Egg",
    "Fish",
    "Wheat",
    "Shellfish",
    "Soy beans",
    "Gluten",
    "Peanuts",
    "Tree nuts",
    "Sesame"
  ];
  final Set<String> selectedAllergies = {};

  void toggleSelection(String allergy) {
    setState(() {
      if (selectedAllergies.contains(allergy)) {
        selectedAllergies.remove(allergy);
      } else {
        selectedAllergies.add(allergy);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/auth.png"))),
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.45
          ),
          child: Container(
            decoration: BoxDecoration(
                color: colorWhite,
                border: Border.all(color: colorGrey),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.1),
                    topRight: Radius.circular(size.width * 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: colorBlack.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 6,
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.03),

                  // Text and Input Section
                  WantText(
                    text: "Lastly",
                    fontSize: size.width * 0.082,
                    fontWeight: FontWeight.bold,
                    textColor: colorBlack,
                    usePoppins: true,
                  ),

                  SizedBox(height: size.height * 0.009),
                  WantText(
                      text: "Do you have any allergies we should know\nabout?",
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w500,
                      textColor: colorGreyText,
                      usePoppins: false),
                  SizedBox(height: size.height * 0.03),
                  Wrap(
                    spacing: size.width * 0.02,
                    runSpacing: size.width * 0.02,
                    children: allergies.map((allergy) {
                      final isSelected = selectedAllergies.contains(allergy);
                      return GestureDetector(
                        onTap: () => toggleSelection(allergy),
                        child: Container(
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? greenThemeColor.withOpacity(0.2)
                                  : colorWhite,
                              border: Border.all(
                                  color: isSelected
                                      ? colorBlack
                                      : colorBlack.withOpacity(0.15)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(size.width * 0.03),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorBlack.withOpacity(0.15),
                                  blurRadius: 10,
                                  spreadRadius: 0.3,
                                ),
                              ]),
                          height: size.height * 0.044,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.width * 0.01),
                          child: WantText(
                              text: allergy,
                              fontSize: size.height * 0.0197,
                              fontWeight: FontWeight.w500,
                              textColor: colorBlack.withOpacity(0.7),
                              usePoppins: false),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Center(
                    child: GeneralButton(
                      Width: size.width * 0.8,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatHome(),
                            ));
                      },
                      label: selectedAllergies.isEmpty ? "No allergy" : "Next",
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),

                  // Skip Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: size.width * 0.0154,
                            width: size.width * 0.0154,
                            decoration: BoxDecoration(
                              color: index == 4
                                  ? colorBlack
                                  : colorGreyText.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          );
                        }),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle Skip Action
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ));
                        },
                        child: WantText(
                            text: "Skip",
                            fontSize: size.width * 0.036,
                            fontWeight: FontWeight.w500,
                            textColor: colorBlack,
                            usePoppins: false),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
