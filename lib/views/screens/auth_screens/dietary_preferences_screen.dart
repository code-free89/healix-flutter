import 'package:flutter/material.dart';

import '../../../util/constants/colors.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';
import 'allergies_selection_screen.dart';

class DietaryPreferencesScreen extends StatefulWidget {
  const DietaryPreferencesScreen({super.key});

  @override
  State<DietaryPreferencesScreen> createState() =>
      _DietaryPreferencesScreenState();
}

class _DietaryPreferencesScreenState extends State<DietaryPreferencesScreen> {
  String selectedFoodOrder = "";
  List<String> selectedDietary = [];

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
          padding: EdgeInsets.only(top: size.height * 0.411),
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
                  SizedBox(height: size.height * 0.03926),

                  // Text and Input Section
                  WantText(
                    text: "Almost there",
                    fontSize: size.width * 0.082,
                    fontWeight: FontWeight.bold,
                    textColor: colorBlack,
                    usePoppins: true,
                  ),

                  SizedBox(height: size.height * 0.0098),
                  WantText(
                      text: "Do you have any dietary preferences?",
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w500,
                      textColor: colorGreyText,
                      usePoppins: false),
                  SizedBox(height: size.height * 0.03),

                  // Food order Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FoodSelection(
                        images: "assets/images/food-1.png",
                        label: "Vegetarian",
                        size: size,
                        isSelected: selectedDietary.contains("Vegetarian"),
                        onSelect: () {
                          setState(() {
                            toggleDietary("Vegetarian");
                          });
                        },
                      ),
                      FoodSelection(
                        images: "assets/images/food-2.png",
                        label: "White meat",
                        size: size,
                        isSelected: selectedDietary.contains("White meat"),
                        onSelect: () {
                          setState(() {
                            toggleDietary("White meat");
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.0197),
                  // Food order Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FoodSelection(
                        images: "assets/images/food-3.png",
                        label: "Red meat",
                        size: size,
                        isSelected: selectedDietary.contains("Red meat"),
                        onSelect: () {
                          setState(() {
                            toggleDietary("Red meat");
                          });
                        },
                      ),
                      FoodSelection(
                        images: "assets/images/food-4.png",
                        label: "Sea food",
                        size: size,
                        isSelected: selectedDietary.contains("Sea food"),
                        onSelect: () {
                          setState(() {
                            toggleDietary("Sea food");
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.0295),
                  Center(
                    child: GeneralButton(
                      Width: size.width * 0.8,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllergiesSelectionScreen(),
                            ));
                      },
                      label: selectedFoodOrder.isEmpty
                          ? "I eat everything"
                          : "Next",
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),

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
                              color: index == 3
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
                                builder: (context) =>
                                    AllergiesSelectionScreen(),
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

  void toggleDietary(String diet) async {
    setState(() {
      if (selectedDietary.contains(diet)) {
        selectedDietary.remove(diet);
      } else {
        selectedDietary.add(diet);
      }
    });
  }
}

class FoodSelection extends StatelessWidget {
  final String images;
  final String label;
  final Size size;
  final bool isSelected;
  final VoidCallback onSelect;

  FoodSelection({
    required this.images,
    required this.label,
    required this.size,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? greenThemeColor.withOpacity(0.2) : colorWhite,
            border: Border.all(
                color: isSelected ? colorBlack : colorBlack.withOpacity(0.15)),
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
        height: size.height * 0.1182,
        width: size.width * 0.3769,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: size.width * 0.12,
                child: Image.asset(
                  images,
                )),
            WantText(
                text: label,
                fontSize: size.width * 0.036,
                fontWeight: FontWeight.w500,
                textColor:
                    isSelected ? colorBlack : colorBlack.withOpacity(0.7),
                usePoppins: false),
          ],
        ),
      ),
    );
  }
}
