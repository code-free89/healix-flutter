import 'package:flutter/material.dart';
import 'package:helix_ai/views/screens/auth_screens/health_history_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/controllers/provider_controllers/user_info_provider.dart';
import '../../../data/models/view_model/user_data_view_model.dart';
import '../../../util/constants/colors.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';

class WellnessGoalScreen extends StatelessWidget {
  final UserViewModel userData;
  const WellnessGoalScreen({Key? key, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserInfoProvider>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorWhite,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/auth.png"))),
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.24),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.04926),

              // Text and Input Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: WantText(
                  text: "Your Goals, Your Way to Wellness",
                  // textAlign: TextAlign.center,
                  fontSize: size.width * 0.08,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                  textColor: colorBlack,
                  usePoppins: true,
                ),
              ),
              SizedBox(height: size.height * 0.0098),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: WantText(
                  textOverflow: TextOverflow.fade,
                  text: "Select your goals (You can select multiple options)",
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.w500,
                  textColor: colorGreyText,
                  usePoppins: false,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: provider.wellnessGoalOptions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => provider.toggleWellnessGoal(index),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: Container(
                        height: size.height * 0.064,
                        decoration: BoxDecoration(
                            color: provider.selectedWellnessGoals[index]
                                ? greenThemeColor.withOpacity(0.2)
                                : colorWhite,
                            border: Border.all(
                              color: provider.selectedWellnessGoals[index]
                                  ? colorBlack
                                  : colorBlack.withOpacity(0.15),
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
                            ]),
                        margin: EdgeInsets.only(bottom: size.height * 0.0197),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: WantText(
                              text: provider.wellnessGoalOptions[index],
                              fontSize: size.width * 0.036,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              textColor: colorBlack,
                              usePoppins: false),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.02),
              Center(
                child: GeneralButton(
                  Width: size.width * 0.8,
                  onTap: () {
                    userData.wellnessGoals =
                        provider.getSelectedWellnessGoals();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HealthHistoryScreen(
                          userData: userData,
                        ),
                      ),
                    );
                  },
                  label: "Next",
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Row(
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
                            color: index == 1
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
                            builder: (context) => HealthHistoryScreen(
                              userData: userData,
                            ),
                          ),
                        );
                      },
                      child: WantText(
                        text: "Skip",
                        decoration: TextDecoration.underline,
                        fontSize: size.width * 0.036,
                        fontWeight: FontWeight.w500,
                        textColor: colorBlack,
                        usePoppins: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
