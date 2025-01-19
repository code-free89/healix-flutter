import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/controllers/provider_controllers/user_info_provider.dart';
import '../../../data/models/view_model/user_data_view_model.dart';
import '../../../util/constants/colors.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';
import 'favorites_food_screen.dart';

class HealthHistoryScreen extends StatelessWidget {
  final UserViewModel userData;
  const HealthHistoryScreen({super.key, required this.userData});

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
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.2241),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.04926),

                // Text and Input Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: WantText(
                    text: "Health History",
                    fontSize: size.width * 0.082,
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
                    text:
                        "Is there any medical conditions we should know about? (You can select multiple boxes)",
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.w500,
                    textColor: colorGreyText,
                    usePoppins: false,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                  height: size.height * 0.399,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: provider.healthOptions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => provider.toggleHealthCondition(index),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: Container(
                            height: size.height * 0.064,
                            decoration: BoxDecoration(
                                color: provider.selectedHealthConditions[index]
                                    ? greenThemeColor.withOpacity(0.2)
                                    : colorWhite,
                                border: Border.all(
                                  color:
                                      provider.selectedHealthConditions[index]
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
                            margin:
                                EdgeInsets.only(bottom: size.height * 0.0197),
                            child: Center(
                              child: WantText(
                                  text: provider.healthOptions[index],
                                  fontSize: size.width * 0.036,
                                  fontWeight: FontWeight.w500,
                                  textColor: colorBlack,
                                  usePoppins: false),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.0295),
                Center(
                  child: GeneralButton(
                    Width: size.width * 0.8,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoritesFoodScreen(
                            healthHistory:
                                provider.selectedHealthConditions.contains(true)
                                    ? provider.getSelectedHealthConditions()
                                    : ['None'],
                            userData: userData,
                          ),
                        ),
                      );
                    },
                    label: provider.selectedHealthConditions.contains(true)
                        ? "Next"
                        : "None",
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
                              builder: (context) => FavoritesFoodScreen(
                                healthHistory: [],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
