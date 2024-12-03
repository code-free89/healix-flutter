import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/controllers/provider_controllers/user_info_provider.dart';
import '../../../data/models/view_model/user_data_view_model.dart';
import '../../../util/constants/colors.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';
import 'dietary_preferences_screen.dart' ;

class FavoritesFoodScreen extends StatelessWidget {
  final List<String> healthHistory;
  final UserViewModel userData;


  FavoritesFoodScreen({
    super.key,
    required this.healthHistory,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorWhite,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/auth.png")),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.0766),
          child: Container(
            decoration: BoxDecoration(
              color: colorWhite,
              border: Border.all(color: colorGrey),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * 0.1),
                topRight: Radius.circular(size.width * 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorBlack.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: Consumer<UserInfoProvider>(
              builder: (context, provider, child) {
                return FavoritesFoodContent(
                  size: size,
                  healthHistory: healthHistory,
                  userInfoProvider: provider,
                  userData: userData,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FavoritesFoodContent extends StatelessWidget {
  final Size size;
  final List<String> healthHistory;
  final UserInfoProvider userInfoProvider;
  final UserViewModel userData;


  const FavoritesFoodContent({
    required this.size,
    required this.healthHistory,
    required this.userInfoProvider,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.02926),

        // Text and Input Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: WantText(
            text: "Pick your\nfavorites",
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
            "We want to know your cuisine preferences,\norder them by dragging from most to least\nfavorite.",
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w500,
            textColor: colorGreyText,
            usePoppins: false,
          ),
        ),
        SizedBox(height: size.height * 0.0197),

        // Draggable Options Section
        Container(
          height: size.height * 0.5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: ReorderableListView.builder(
              physics: NeverScrollableScrollPhysics(),
              onReorder: (int oldIndex, int newIndex) {
                userInfoProvider.updateFoodOrder(oldIndex, newIndex);
              },
              itemCount: userInfoProvider.foodOptions.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.00985),
                  key: ValueKey(userInfoProvider.foodOptions[index]),
                  child: Container(
                    height: size.height * 0.064,
                    decoration: BoxDecoration(
                      color: colorWhite,
                      border: Border.all(
                        color: colorBlack.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(size.width * 0.03),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.0197),
                        child: Image.asset(
                          "assets/images/food.png",
                          scale: 3,
                        ),
                      ),
                      title: WantText(
                        text: userInfoProvider.foodOptions[index],
                        fontSize: size.width * 0.036,
                        fontWeight: FontWeight.w500,
                        textColor: colorBlack,
                        usePoppins: false,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: size.height * 0.0197),

        // Bottom Button
        Center(
          child: GeneralButton(
            Width: size.width * 0.8,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DietaryPreferencesScreen(
                    favoriteFood: userInfoProvider.foodOptions,
                    healthHistory: healthHistory,
                    userData: userData,
                  ),
                ),
              );
            },
            label: userInfoProvider.isReordering ? "Next" : "Surprise me",
          ),
        ),

        SizedBox(height: size.height * 0.04),

        // Pagination and Skip Section
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
                      color: index == 2
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
                      builder: (context) => DietaryPreferencesScreen(
                        favoriteFood: userInfoProvider.foodOptions,
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
        ),
      ],
    );
  }
}
