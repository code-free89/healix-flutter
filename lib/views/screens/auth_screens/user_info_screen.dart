import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../util/constants/colors.dart';
import '../../shared_components/auth_custom_text_field.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/want_text.dart';
import 'health_history_screen.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final TextEditingController weightController = TextEditingController();

  String selectedGender = "";
  String selectedHeightUnit = "CM"; // Default for height
  String selectedWeightUnit = "KG";

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(1900),  // Earliest date
      lastDate: DateTime.now(),  // Latest date
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // Format the date
      setState(() {
        dobController.text = formattedDate; // Update the controller
      });
    }
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
          padding: EdgeInsets.only(top: size.height * 0.192),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.035),

                    // Text and Input Section
                    WantText(
                      text: "Hi",
                      fontSize: size.width * 0.082,
                      fontWeight: FontWeight.bold,
                      textColor: colorBlack,
                      usePoppins: true,
                    ),

                    SizedBox(height: size.height * 0.0098),
                    WantText(
                        text: "Tell us more about yourself",
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w500,
                        textColor: colorGreyText,
                        usePoppins: false),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.51,
                          child: AuthCustomTextFormField(
                              labelText: "Name", controller: nameController),
                        ),
                        SizedBox(
                          width: size.width * 0.25,
                          child: AuthCustomTextFormField(
                            labelText: "Birth Date",
                            controller: dobController,
                            readOnly: true, // Ensure the field is read-only
                            onTap: () => _selectDate(context), // Open the date picker on tap
                          ),

                        )
                      ],
                    ),

                    SizedBox(height: size.height * 0.02),
                    AuthCustomTextFormField(
                        labelText: "Phone Number", controller: phoneController),

                    SizedBox(height: size.height * 0.0197),
                    // Gender Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GenderSelection(
                          images: "assets/images/male.png",
                          label: "Male",
                          size: size,
                          isSelected: selectedGender == "Male",
                          onSelect: () {
                            setState(() {
                              selectedGender = "Male";
                            });
                          },
                        ),
                        GenderSelection(
                          images: "assets/images/female.png",
                          label: "Female",
                          size: size,
                          isSelected: selectedGender == "Female",
                          onSelect: () {
                            setState(() {
                              selectedGender = "Female";
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.0197),
                    // Height and Weight
                    AuthCustomTextFormField(
                      labelText: "Height",
                      controller: heightController,
                      suffixIcon: SizedBox(
                        width: size.width * 0.2256,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildToggleOption(
                              "CM",
                              size.width,
                              isSelected: selectedHeightUnit == "CM",
                              onTap: () {
                                setState(() {
                                  selectedHeightUnit = "CM";
                                });
                              },
                            ),
                            buildToggleOption(
                              "FT",
                              size.width,
                              isSelected: selectedHeightUnit == "FT",
                              onTap: () {
                                setState(() {
                                  selectedHeightUnit = "FT";
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.0197),
                    AuthCustomTextFormField(
                      labelText: "Weight",
                      controller: weightController,
                      suffixIcon: SizedBox(
                        width: size.width * 0.2256,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildToggleOption(
                              "KG",
                              size.width,
                              isSelected: selectedWeightUnit == "KG",
                              onTap: () {
                                setState(() {
                                  selectedWeightUnit = "KG";
                                });
                              },
                            ),
                            buildToggleOption(
                              "LB",
                              size.width,
                              isSelected: selectedWeightUnit == "LB",
                              onTap: () {
                                setState(() {
                                  selectedWeightUnit = "LB";
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.0297),
                    GeneralButton(
                        Width: size.width,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HealthHistoryScreen(),
                              ));
                        },
                        label: "Next"),

                    SizedBox(height: size.height * 0.04),

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
                                color: index == 0
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
                                  builder: (context) => HealthHistoryScreen(),
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
      ),
    );
  }

  Widget buildToggleOption(
    String label,
    double width, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: width * 0.033, horizontal: width * 0.02),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(width * 0.015),
        ),
        child: WantText(
            text: label,
            fontSize: width * 0.036,
            fontWeight: FontWeight.bold,
            textColor: isSelected ? colorWhite : colorBlack,
            usePoppins: false),
      ),
    );
  }
}

class GenderSelection extends StatelessWidget {
  final String images;
  final String label;
  final Size size;
  final bool isSelected;
  final VoidCallback onSelect;

  GenderSelection({
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
