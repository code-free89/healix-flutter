// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helix_ai/controllers/provider_controllers/authentication_provider.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/ui_helper.dart';
import 'package:helix_ai/util/validator.dart';
import 'package:helix_ai/views/shared_components/custom_button.dart';
import 'package:helix_ai/views/shared_components/custom_container.dart';
import 'package:helix_ai/views/shared_components/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../util/constants/constant.dart';

class UserForgotPassword extends StatefulWidget {
  const UserForgotPassword({super.key});

  @override
  State<UserForgotPassword> createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
  final forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();

  // TextEditingController loginPasswordController = TextEditingController();
  //
  // void validateAndSubmit(AuthenticationProvider authProvider) async {
  //   if (forgotPasswordFormKey.currentState!.validate()) {
  //     if (await authProvider.signIn(loginEmailController.text, loginPasswordController.text)) {
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => ChatHome()),
  //         (Route<dynamic> route) => false,
  //       );
  //     } else {
  //       authProvider.setIsLoginLoading(false);
  //       UiHelper().showSnackBar(context, authProvider.errorMessage);
  //     }
  //   }
  // }

  @override
  void dispose() {
    loginEmailController.dispose();
    // loginPasswordController.dispose();
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
                    key: forgotPasswordFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: height*0.06),
                          child: SvgPicture.asset(lifeStyleImage, fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: CustomContainer(
                            // height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(height*0.05, height*0.085, height*0.05, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Forgot Password?",
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
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: height*0.07,
                                    child: CustomButton(
                                        onPressed: () async {
                                          if (!forgotPasswordFormKey.currentState!.validate()) return;

                                          if (await authProvider.sendPasswordResetEmail(loginEmailController.text)) {
                                            UiHelper().showSnackBar(context, "Password reset link sent to your email");
                                          } else {
                                            UiHelper().showSnackBar(context, "Unable to send password reset link");
                                          }
                                        },
                                        showLoading: authProvider.isSendingPasswordResentLinkLoading,
                                        buttonText: "Get password reset link"),
                                  ),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
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
