import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:helix_ai/data/models/view_model/user_data_view_model.dart';

import '../../../controllers/provider_controllers/user_info_provider.dart';
import '../../../util/constants/colors.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';
import 'allergies_selection_screen.dart';

class DietaryPreferencesScreen extends StatelessWidget {
  final List<String> favoriteFood;
  final List<String> healthHistory;
  final UserViewModel userData;

  const DietaryPreferencesScreen({
    super.key,
    required this.favoriteFood,
    required this.healthHistory,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<UserInfoProvider>(
      create: (_) => UserInfoProvider(),
      builder: (context, _) {
        return Scaffold(
          backgroundColor: colorWhite,
          body: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/auth.png"))),
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
                        usePoppins: false,
                      ),
                      SizedBox(height: size.height * 0.03),

                      // Food Selection Rows
                      FoodSelectionRow(
                        size: size,
                        options: const ["Vegetarian", "White meat"],
                      ),
                      SizedBox(height: size.height * 0.0197),
                      FoodSelectionRow(
                        size: size,
                        options: const ["Red meat", "Sea food"],
                      ),
                      SizedBox(height: size.height * 0.0295),

                      // Next Button
                      Center(
                        child: Consumer<UserInfoProvider>(
                          builder: (context, provider, child) {
                            return GeneralButton(
                              Width: size.width * 0.8,
                              onTap: () {
                                if (provider.selectedDietary.isEmpty) {
                                  provider.selectAllDietaryOptions();
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AllergiesSelectionScreen(
                                      dietPref: provider.selectedDietary,
                                      favoriteFood: favoriteFood,
                                      healthHistory: healthHistory,
                                      userData: userData,
                                    ),
                                  ),
                                );
                              },
                              label: provider.selectedDietary.isEmpty
                                  ? "I eat everything"
                                  : "Next",
                            );
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),

                      // Skip Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AllergiesSelectionScreen(
                                    dietPref: [],
                                    favoriteFood: favoriteFood,
                                    healthHistory: healthHistory,
                                    userData: userData,
                                  ),
                                ),
                              );
                            },
                            child: WantText(
                              text: "Skip",
                              fontSize: size.width * 0.036,
                              fontWeight: FontWeight.w500,
                              textColor: colorBlack,
                              usePoppins: false,
                            ),
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
      },
    );
  }
}

class FoodSelectionRow extends StatelessWidget {
  final List<String> options;
  final Size size;

  const FoodSelectionRow(
      {super.key, required this.options, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.map((option) {
        return Consumer<UserInfoProvider>(
          builder: (context, provider, child) {
            return FoodSelection(
              images: "assets/images/food-${options.indexOf(option) + 1}.png",
              label: option,
              size: size,
              isSelected: provider.selectedDietary.contains(option),
              onSelect: () {
                provider.toggleDietary(option);
              },
            );
          },
        );
      }).toList(),
    );
  }
}

class FoodSelection extends StatelessWidget {
  final String images;
  final String label;
  final Size size;
  final bool isSelected;
  final VoidCallback onSelect;

  const FoodSelection({
    Key? key,
    required this.images,
    required this.label,
    required this.size,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? greenThemeColor.withOpacity(0.2) : colorWhite,
          border: Border.all(
            color: isSelected ? colorBlack : colorBlack.withOpacity(0.15),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(size.width * 0.03),
          ),
          boxShadow: [
            BoxShadow(
              color: colorBlack.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 0.3,
            ),
          ],
        ),
        height: size.height * 0.1182,
        width: size.width * 0.3769,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: size.width * 0.12,
              child: Image.asset(
                images,
              ),
            ),
            WantText(
              text: label,
              fontSize: size.width * 0.036,
              fontWeight: FontWeight.w500,
              textColor: isSelected ? colorBlack : colorBlack.withOpacity(0.7),
              usePoppins: false,
            ),
          ],
        ),
      ),
    );
  }
}
