import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/constant.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_home.dart';
import 'package:provider/provider.dart';

import '../../../controllers/authentication_provider.dart';
import '../../../controllers/user_info_provider.dart';
import '../../../models/user_data_view_model.dart';
import '../../../util/constants/colors.dart';
import '../../../util/shared_preferences/share_preference_provider.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';

class AllergiesSelectionScreen extends StatelessWidget {
  final List<String> dietPref;
  final List<String> favoriteFood;
  final List<String> healthHistory;
  final UserViewModel userData;

  const AllergiesSelectionScreen({
    super.key,
    required this.dietPref,
    required this.favoriteFood,
    required this.healthHistory,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final userInfoProvider = Provider.of<UserInfoProvider>(context);

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
          padding: EdgeInsets.only(top: size.height * 0.45),
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
                  SizedBox(height: size.height * 0.02),

                  // Text and Input Section
                  WantText(
                    text: "Lastly",
                    fontSize: size.width * 0.082,
                    fontWeight: FontWeight.bold,
                    textColor: colorBlack,
                    usePoppins: true,
                  ),
                  SizedBox(height: size.height * 0.001),
                  WantText(
                      text: "Do you have any allergies we should know\nabout?",
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w500,
                      textColor: colorGreyText,
                      usePoppins: false),
                  SizedBox(height: size.height * 0.015),

                  // Allergy Selection Section
                  Wrap(
                    spacing: size.width * 0.02,
                    runSpacing: size.width * 0.02,
                    children: userInfoProvider.allergies.map((allergy) {
                      final isSelected =
                          userInfoProvider.selectedAllergies.contains(allergy);
                      return GestureDetector(
                        onTap: () => userInfoProvider.toggleAllergy(allergy),
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

                  // Next Button
                  Center(
                    child: GeneralButton(
                      Width: size.width * 0.8,
                      onTap: () {
                        authProvider
                            .addUserProfile(
                          userData
                            ..allergies = userInfoProvider
                                    .selectedAllergies.isEmpty
                                ? ["No allergy"]
                                : userInfoProvider.selectedAllergies.toList()
                            ..dietPreference = dietPref.toList()
                            ..cuisinePreference = favoriteFood.toList()
                            ..healthHistory = healthHistory.toList(),
                          context,
                        )
                            .whenComplete(() async {
                          Provider.of<AuthenticationProvider>(context,
                                  listen: false)
                              .getUserProfileData(
                            context,
                            SharePreferenceProvider().uid,
                          );
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatHome(
                              userFromLogin: false,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      label: userInfoProvider.selectedAllergies.isEmpty
                          ? "No allergy"
                          : "Next",
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Skip Button (if needed)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.001,
                      ),
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
                          authProvider.addUserProfile(
                            userData
                              ..allergies = []
                              ..dietPreference = dietPref.toList()
                              ..cuisinePreference = favoriteFood.toList()
                              ..healthHistory = healthHistory.toList(),
                            context,
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatHome(
                                userFromLogin: false,
                              ),
                            ),
                            (route) => false,
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
  }
}
