import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helix_ai/util/constants/constant.dart';
import 'package:provider/provider.dart';
import '../../../data/controllers/provider_controllers/user_info_provider.dart';
import '../../../data/models/view_model/user_data_view_model.dart';
import '../../../util/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared_components/auth_custom_text_field.dart';
import '../../shared_components/general_button.dart';
import '../../shared_components/show_toast.dart';
import '../../shared_components/want_text.dart';
import 'health_history_screen.dart';
import 'package:intl/intl.dart';

class UserInfoScreen extends StatelessWidget {
  final String id;
  final String email;

  UserInfoScreen({required this.id, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserInfoProvider(),
      child: _UserInfoScreenContent(id: id, email: email),
    );
  }
}

class _UserInfoScreenContent extends StatelessWidget {
  final String id;
  final String email;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController heightFtController = TextEditingController();
  final TextEditingController heightInchController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  _UserInfoScreenContent({required this.id, required this.email});

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      context.read<UserInfoProvider>().updateDob(formattedDate);
      dobController.text = formattedDate;
    }
  }

  bool isButtonEnabled(BuildContext context) {
    final provider = context.watch<UserInfoProvider>();
    return nameController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        provider.selectedGender.isNotEmpty &&
        heightFtController.text.isNotEmpty &&
        heightInchController.text.isNotEmpty &&
        weightController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = context.watch<UserInfoProvider>();

    return Scaffold(
      backgroundColor: colorWhite,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/auth.png")),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.192),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.035),
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
                      usePoppins: false,
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.49,
                          child: AuthCustomTextFormField(
                            labelText: "Name",
                            controller: nameController,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: size.width * 0.29,
                          child: AuthCustomTextFormField(
                            labelText: "Birth Date",
                            controller: dobController,
                            readOnly: true,
                            onTap: () => _selectDate(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.064,
                          width: width * 0.28,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(width * 0.028)),
                            border: Border.all(color: colorGrey),

                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorWhite,
                              border: Border.all(
                                  color: colorBlack.withOpacity(0.15)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(width * 0.03),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorBlack.withOpacity(0.15),
                                  blurRadius: 10,
                                  spreadRadius: 0.3,
                                ),
                              ],
                            ),
                           child:  CountryCodePicker(
                             padding: EdgeInsets.all(0),
                             boxDecoration: BoxDecoration(
                               color: Color.fromRGBO(235, 225, 230, 1),
                               borderRadius: BorderRadius.all(
                                   Radius.circular(width * 0.05)),
                             ),
                             onChanged: (countryCode) {
                               // setState(() {
                               //   this.countryCode =
                               //       countryCode.dialCode ?? '+1';
                               // });
                             },
                             initialSelection: 'US',
                             favorite: ['+1', 'US'],
                             showCountryOnly: false,
                             showOnlyCountryWhenClosed: false,                             // optional. aligns the flag and the Text left
                             alignLeft: false,
                             dialogSize: Size(width * 0.8, height * 0.4),
                             textStyle: GoogleFonts.roboto(
                               textStyle: TextStyle(
                                 fontSize: width * 0.04,
                                 color: colorBlack,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ),

                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: AuthCustomTextFormField(
                            labelText: "Phone Number",
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            focusNode: phoneFocusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                              _PhoneNumberFormatter(onComplete: () {
                                phoneFocusNode
                                    .unfocus(); // Unfocus the field when 10 digits are complete
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.0197),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GenderSelection(
                          images: "assets/images/male.png",
                          label: "Male",
                          size: size,
                          isSelected: provider.selectedGender == "Male",
                          onSelect: () => provider.selectGender("Male"),
                        ),
                        GenderSelection(
                          images: "assets/images/female.png",
                          label: "Female",
                          size: size,
                          isSelected: provider.selectedGender == "Female",
                          onSelect: () => provider.selectGender("Female"),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.0197),
                    Row(
                      children: [
                        Expanded(
                          child: AuthCustomTextFormField(
                            keyboardType: provider.selectedHeightUnit == "CM"
                                ? TextInputType.number
                                : TextInputType.text,
                            labelText: "Height",
                            controller: heightFtController,
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: width * 0.015,
                                  horizontal: width * 0.015),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorGreyText.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.circular(width * 0.015),
                                ),
                                width: width * 0.1,
                                child: Center(
                                  child: WantText(
                                      text: "Ft",
                                      fontSize: width * 0.036,
                                      fontWeight: FontWeight.bold,
                                      textColor: colorBlack,
                                      usePoppins: false),
                                ),
                              ),
                            ),
                            // suffixIcon: SizedBox(
                            //   width: size.width * 0.2256,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       buildToggleOption(
                            //         "CM",
                            //         size.width,
                            //         isSelected: provider.selectedHeightUnit == "CM",
                            //         onTap: () => provider.toggleHeightUnit("CM"),
                            //       ),
                            //       buildToggleOption(
                            //         "FT",
                            //         size.width,
                            //         isSelected: provider.selectedHeightUnit == "FT",
                            //         onTap: () => provider.toggleHeightUnit("FT"),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Expanded(
                          child: AuthCustomTextFormField(
                            keyboardType: provider.selectedHeightUnit == "CM"
                                ? TextInputType.number
                                : TextInputType.text,
                            labelText: "Height",
                            controller: heightInchController,
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: width * 0.015,
                                  horizontal: width * 0.015),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorGreyText.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.circular(width * 0.015),
                                ),
                                width: width * 0.1,
                                child: Center(
                                  child: WantText(
                                      text: "In",
                                      fontSize: width * 0.036,
                                      fontWeight: FontWeight.bold,
                                      textColor: colorBlack,
                                      usePoppins: false),
                                ),
                              ),
                            ),
                            // suffixIcon: SizedBox(
                            //   width: size.width * 0.2256,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       buildToggleOption(
                            //         "CM",
                            //         size.width,
                            //         isSelected: provider.selectedHeightUnit == "CM",
                            //         onTap: () => provider.toggleHeightUnit("CM"),
                            //       ),
                            //       buildToggleOption(
                            //         "FT",
                            //         size.width,
                            //         isSelected: provider.selectedHeightUnit == "FT",
                            //         onTap: () => provider.toggleHeightUnit("FT"),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.0197),
                    AuthCustomTextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d{0,9}(\.\d{0,1})?$')),
                        ],
                        labelText: "Weight",
                        controller: weightController,
                        suffixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: width * 0.015,
                              horizontal: width * 0.015),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorGreyText.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(width * 0.015),
                            ),
                            width: width * 0.1,
                            child: Center(
                              child: WantText(
                                  text: "LB",
                                  fontSize: width * 0.036,
                                  fontWeight: FontWeight.bold,
                                  textColor: colorBlack,
                                  usePoppins: false),
                            ),
                          ),
                        )
                        // suffixIcon: SizedBox(
                        //   width: size.width * 0.2256,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       buildToggleOption(
                        //         "KG",
                        //         size.width,
                        //         isSelected: provider.selectedWeightUnit == "KG",
                        //         onTap: () => provider.toggleWeightUnit("KG"),
                        //       ),
                        //       buildToggleOption(
                        //         "LB",
                        //         size.width,
                        //         isSelected: provider.selectedWeightUnit == "LB",
                        //         onTap: () => provider.toggleWeightUnit("LB"),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        ),
                    SizedBox(height: size.height * 0.0297),
                    SizedBox(
                      height: height * 0.064,
                      width: width,
                      child: ElevatedButton(
                        onPressed: isButtonEnabled(context)
                            ? () {
                                String rawPhoneNumber = phoneController.text
                                    .replaceAll(RegExp(r'\D'), '')
                                    .trim();

                                print("Raw phone number: $rawPhoneNumber");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HealthHistoryScreen(
                                      userData: UserViewModel(
                                        id: id,
                                        email: email,
                                        name: nameController.text,
                                        phone: rawPhoneNumber.trim(),
                                        gender: provider.selectedGender,
                                        dateOfBirth: dobController.text,
                                        height: heightFtController.text +
                                            '\'' +
                                            heightInchController.text +
                                            '\"',
                                        weight: weightController.text,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled(context)
                              ? greenThemeColor
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
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

class PhoneNumberField extends StatefulWidget {
  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      focusNode: phoneFocusNode,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        _PhoneNumberFormatter(onComplete: () {
          phoneFocusNode
              .unfocus(); // Unfocus the field when 10 digits are complete
        })
      ],
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "999-999-9999",
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  final VoidCallback onComplete;

  _PhoneNumberFormatter({required this.onComplete});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    final buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      if (i == 3 || i == 6)
        buffer.write('-'); // Add hyphen after 3rd and 6th digits
      buffer.write(newText[i]);
    }

    final formattedText = buffer.toString();

    // Trigger the onComplete callback when 10 digits are entered
    if (newText.length == 10) {
      onComplete();
    }

    final newSelectionIndex =
        newValue.selection.baseOffset + (formattedText.length - newText.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: newSelectionIndex > formattedText.length
            ? formattedText.length
            : newSelectionIndex,
      ),
    );
  }
}
