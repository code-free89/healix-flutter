import 'package:flutter/material.dart';

import '../../../util/constants/colors.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';
import 'dietary_preferences_screen.dart';

class FavoritesFoodScreen extends StatefulWidget {
  const FavoritesFoodScreen({super.key});

  @override
  State<FavoritesFoodScreen> createState() => _FavoritesFoodScreenState();
}

class _FavoritesFoodScreenState extends State<FavoritesFoodScreen> {
  final List<String> _options = [
    "American",
    "Chinese",
    "Mexican",
    "Thai",
    "Indian",
    "Italian",
  ];

  @override
  Widget build(BuildContext context) {
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
            child: Column(
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
                Container(height: size.height*0.5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: ReorderableListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) newIndex--;
                          final item = _options.removeAt(oldIndex);
                          _options.insert(newIndex, item);
                        });
                      },
                      itemCount: _options.length,
                      itemBuilder: (context, index) {
                        return Container(padding: EdgeInsets.symmetric(vertical: size.height*0.00985),
                          key: ValueKey(_options[index]),
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
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: colorBlack.withOpacity(0.15),
                              //     blurRadius: 10,
                              //     spreadRadius: 0.3,
                              //   ),
                              // ],
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
                                text: _options[index],
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
                          builder: (context) => DietaryPreferencesScreen(),
                        ),
                      );
                    },
                    label: "Surprise me",
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
                          // Handle Skip Action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DietaryPreferencesScreen(),
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
