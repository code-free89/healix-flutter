// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/util/ui_helper.dart';
import 'package:helix_ai/util/validator.dart';
import 'package:helix_ai/views/screens/auth_screens/user_info_screen.dart';
import 'package:helix_ai/views/screens/auth_screens/user_login.dart';
import 'package:helix_ai/views/shared_components/custom_button.dart';
import 'package:helix_ai/views/shared_components/custom_container.dart';
import 'package:helix_ai/views/shared_components/custom_divider.dart';
import 'package:helix_ai/views/shared_components/custom_text_field.dart';
import 'package:helix_ai/views/shared_components/social_login_buttons.dart';
import 'package:helix_ai/views/screens/profile_screens/first_profile.dart';
import 'package:provider/provider.dart';

import '../../../data/controllers/provider_controllers/authentication_provider.dart';
import '../../../util/constants/constant.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final signUpFormKey = GlobalKey<FormState>();

  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();

  bool isValidFirebaseUID(String uid) {
    final regex = RegExp(r'^[a-zA-Z0-9_-]{28,36}$');
    return regex.hasMatch(uid);
  }

  void validateAndSubmit(AuthenticationProvider authProvider) async {
    if (signUpFormKey.currentState!.validate()) {
      var res = await authProvider.signUp(
          signUpEmailController.text, signUpPasswordController.text);

      if (!(res is bool) && isValidFirebaseUID(res)) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserInfoScreen(
                    email: signUpEmailController.text,
                    id: res,
                  )),
        );
      } else {
        authProvider.setIsSignupLoading(false);
        UiHelper().showSnackBar(context, authProvider.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.06),
                          child: SizedBox(
                            height: height * 0.34,
                            child: SvgPicture.asset(lifeStyleImage,
                                fit: BoxFit.fill),
                          ),
                        ),
                        Expanded(
                          child: CustomContainer(
                            // height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(height * 0.04,
                                  height * 0.085, height * 0.04, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Welcome to Healix AI",
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu-Bold',
                                      fontSize: 20,
                                      // fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  CustomTextField(
                                    textController: signUpEmailController,
                                    hintText: "Email Address",
                                    obsecureText: false,
                                    helperText: null,
                                    textInputType: TextInputType.emailAddress,
                                    validator: Validator.validateEmail,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  CustomTextField(
                                    textController: signUpPasswordController,
                                    hintText: "Password",
                                    obsecureText: true,
                                    helperText: null,
                                    textInputType: TextInputType.text,
                                    validator: Validator.validatePassword,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: height * 0.07,
                                    child: CustomButton(
                                        onPressed: () {
                                          validateAndSubmit(authProvider);
                                        },
                                        showLoading:
                                            authProvider.isSignupLoading,
                                        buttonText: "Signup"),
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account?",
                                        style: TextStyle(
                                            color: textColor, fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UserLogin(),
                                              ));
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu-Medium',
                                            fontSize: 12,
                                            color: textColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  CustomDivider(),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: height * 0.02,
                                        right: height * 0.02,
                                        bottom: height * 0.02),
                                    child:
                                        SocialLoginButtons(text: "Signup with"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
