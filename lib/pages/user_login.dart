// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helix_ai/components/custom_button.dart';
import 'package:helix_ai/components/custom_container.dart';
import 'package:helix_ai/components/custom_divider.dart';
import 'package:helix_ai/components/custom_text_field.dart';
import 'package:helix_ai/components/social_login_buttons.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/chat_home.dart';
import 'package:helix_ai/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../util/ui_helper.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

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
    if (loginFormKey.currentState!.validate()) {
      if (await authProvider.signIn(loginEmailController.text, loginPasswordController.text)) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChatHome()),(Route<dynamic> route) => false,);
      } else {
        authProvider.setIsLoginLoading(false);
        UiHelper().showSnackBar(context , authProvider.errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body:LayoutBuilder(
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
                          padding: const EdgeInsets.only(top: 50.0),
                          child: SvgPicture.asset(lifeStyleImage ,
                              fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: CustomContainer(
                            // height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(28,75,28,0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Welcome to Healix AI" ,
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu-Bold',
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 18,),
                                  CustomTextField(
                                    textController: loginEmailController,
                                    hintText: "Email Address",
                                    obsecureText: false,
                                    helperText: null,
                                    textInputType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                    textInputAction: TextInputAction.next,),
                                  SizedBox(height: 15,),
                                  CustomTextField(
                                    textController: loginPasswordController,
                                    hintText: "Password",
                                    obsecureText: true,
                                    helperText: null,
                                    textInputType: TextInputType.text,
                                    validator: validatePassword,
                                    textInputAction: TextInputAction.done,),
                                  SizedBox(height: 16,),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: CustomButton(
                                        onPressed: (){
                                          validateAndSubmit(authProvider);
                                        },
                                        showLoading: authProvider.isLoginLoading,
                                        buttonText: "Login"),
                                  ),
                                  SizedBox(height: 12,),
                                  Row(
                                    children: [
                                      Row(
                                        children: const [
                                          Text("Forgot Password" ,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(44, 43, 38, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text("Don't have an account?",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(44, 43, 38, 1),
                                            ),
                                          ),
                                          SizedBox(width: 3,),
                                          InkWell(
                                            onTap: (){
                                              Navigator.pushReplacementNamed(context,'/sign_up');
                                            },
                                            child: Text("Sign Up" ,
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu-Medium',
                                                fontSize: 12,
                                                color: Color.fromRGBO(44, 43, 38, 1),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  CustomDivider(),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0 , right: 40 , bottom: 41),
                                    child: SocialLoginButtons(text: "Login with"),
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
        )
    );
  }
}
