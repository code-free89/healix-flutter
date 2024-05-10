// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/components/custom_button.dart';
import 'package:helix_ai/components/custom_divider.dart';
import 'package:helix_ai/components/custom_text_field.dart';
import 'package:helix_ai/components/social_login_buttons.dart';
import 'package:helix_ai/pages/first_profile.dart';
import 'package:helix_ai/util/ui_helper.dart';
import 'package:provider/provider.dart';
import '../images_path.dart';
import '../provider/authentication_provider.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final signUpFormKey = GlobalKey<FormState>();

  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  void validateAndSubmit(AuthenticationProvider authProvider) async {
    if (signUpFormKey.currentState!.validate()) {
      if (await authProvider.signUp(signUpEmailController.text, signUpPasswordController.text)) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => FirstProfile()),
          (Route<dynamic> route) => false,
        );
      } else {
        authProvider.setIsSignupLoading(false);
        // authProvider.setStatus(Status.Unauthenticated);
        UiHelper().showSnackBar(context, authProvider.errorMessage);
      }
    }
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
                          padding: const EdgeInsets.only(top: 50.0),
                          child: SvgPicture.asset(lifeStyleImage, fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: Container(
                            // height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage(containerBackground), fit: BoxFit.fill)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(28, 75, 28, 0),
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
                                    height: 18,
                                  ),
                                  CustomTextField(
                                    textController: signUpEmailController,
                                    hintText: "Email Address",
                                    obsecureText: false,
                                    helperText: null,
                                    textInputType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    textController: signUpPasswordController,
                                    hintText: "Password",
                                    obsecureText: true,
                                    helperText: null,
                                    textInputType: TextInputType.text,
                                    validator: validatePassword,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: CustomButton(
                                        onPressed: () {
                                          validateAndSubmit(authProvider);
                                        },
                                        showLoading: authProvider.isSignupLoading,
                                        buttonText: "Signup"),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account?",
                                        style: TextStyle(color: Color.fromRGBO(44, 43, 38, 1), fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(context, '/login');
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            fontFamily: 'Ubuntu-Medium',
                                            fontSize: 12,
                                            color: Color.fromRGBO(44, 43, 38, 1),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  CustomDivider(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 40, bottom: 10),
                                    child: SocialLoginButtons(text: "Signup with"),
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
