// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/controllers/provider_controllers/authentication_provider.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/util/ui_helper.dart';
import 'package:helix_ai/util/validator.dart';
import 'package:helix_ai/views/shared_components/custom_button.dart';
import 'package:helix_ai/views/shared_components/custom_container.dart';
import 'package:helix_ai/views/shared_components/custom_divider.dart';
import 'package:helix_ai/views/shared_components/custom_text_field.dart';
import 'package:helix_ai/views/shared_components/social_login_buttons.dart';
import 'package:helix_ai/views/screens/profile_screens/first_profile.dart';
import 'package:provider/provider.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final signUpFormKey = GlobalKey<FormState>();

  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();

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
                          padding: const EdgeInsets.only(top: 50.0),
                          child: SvgPicture.asset(lifeStyleImage, fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: CustomContainer(
                            // height: MediaQuery.of(context).size.height,
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
                                    validator: Validator.validateEmail,
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
                                    validator: Validator.validatePassword,
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
                                        style: TextStyle(color: textColor, fontSize: 12),
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
                                            color: textColor,
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
