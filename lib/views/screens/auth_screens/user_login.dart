// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helix_ai/util/constants/constant.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/util/ui_helper.dart';
import 'package:helix_ai/util/validator.dart';
import 'package:helix_ai/views/screens/auth_screens/user_forgot_password.dart';
import 'package:helix_ai/views/screens/auth_screens/user_signup.dart';
import 'package:helix_ai/views/shared_components/custom_button.dart';
import 'package:helix_ai/views/shared_components/custom_container.dart';
import 'package:helix_ai/views/shared_components/custom_divider.dart';
import 'package:helix_ai/views/shared_components/custom_text_field.dart';
import 'package:helix_ai/views/shared_components/social_login_buttons.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_home.dart';
import 'package:provider/provider.dart';

import '../../../data/controllers/provider_controllers/authentication_provider.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  void validateAndSubmit(AuthenticationProvider authProvider) async {
    if (loginFormKey.currentState!.validate()) {
      if (await authProvider.signIn(
          loginEmailController.text, loginPasswordController.text)) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ChatHome(userFromLogin: true,)),
          (Route<dynamic> route) => false,
        );
      } else {
        authProvider.setIsLoginLoading(false);
        UiHelper().showSnackBar(context, authProvider.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
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
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: height*0.06),
                          child: SizedBox(height: height*0.34,
                            child: SvgPicture.asset(lifeStyleImage,
                                fit: BoxFit.fill),
                          ),
                        ),
                        Expanded(
                          child: CustomContainer(
                            // height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding:  EdgeInsets.fromLTRB(height*0.04, height*0.085, height*0.04, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Welcome to Healix AI",
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu-Bold',
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
                                  CustomTextField(
                                    textController: loginEmailController,
                                    hintText: "Email Address",
                                    obsecureText: false,
                                    helperText: null,
                                    textInputType: TextInputType.emailAddress,
                                    validator: Validator.validateEmail,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
                                  CustomTextField(
                                    textController: loginPasswordController,
                                    hintText: "Password",
                                    obsecureText: true,
                                    helperText: null,
                                    textInputType: TextInputType.text,
                                    validator: Validator.validatePassword,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: height*0.07,
                                    child: CustomButton(
                                        onPressed: () {
                                          validateAndSubmit(authProvider);
                                        },
                                        showLoading:
                                            authProvider.isLoginLoading,
                                        buttonText: "Login"),
                                  ),
                                  SizedBox(
                                    height: height*0.015,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            child: Text(
                                              "Forgot Password",
                                              style: TextStyle(
                                                fontSize: height*0.016,
                                                color: textColor,
                                              ),
                                            ),
                                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => UserForgotPassword(),));

                                            },
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            "Don't have an account? ",
                                            style: TextStyle(
                                              fontSize: height*0.016,
                                              color: textColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserSignUp(),));
                                            },
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu-Medium',
                                                fontSize: height*0.016,
                                                color: textColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
                                  CustomDivider(),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(
                                        left: height*0.02, right: height*0.02, bottom: height*0.02),
                                    child:
                                        SocialLoginButtons(text: "Login with"),
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
