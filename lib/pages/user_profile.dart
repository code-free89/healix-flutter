// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/components/custom_button.dart';
import 'package:helix_ai/components/custom_text_fiels_with_label.dart';
import 'package:helix_ai/components/profile_generic_tile.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/chat_home.dart';
import 'package:helix_ai/pages/user_login.dart';
import 'package:provider/provider.dart';

import '../provider/authentication_provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final profileUpdateFormKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a age';
    }
    return null;
  }

  void validateAndSubmit() {
    if (profileUpdateFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Updated")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    // return Provider<AuthenticationProvider>(
    //     create: (_) => AuthenticationProvider.instance(),
    //     // we use `builder` to obtain a new `BuildContext` that has access to the provider
    //     builder: (context, child) {
    // No longer throws
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatHome()));
          },
          icon: Icon(
            Icons.chevron_left,
            size: 32,
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontFamily: 'Rubik', fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: profileUpdateFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "John Doe",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Ubuntu-Medium', fontSize: 28),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LabelTextField(
                            textController: usernameController,
                            hintText: "healthy_john",
                            obsecureText: false,
                            helperText: null,
                            textInputType: TextInputType.name,
                            labelText: "Username",
                            filled: false,
                            validator: validateUsername,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: LabelTextField(
                            textController: ageController,
                            hintText: "25",
                            obsecureText: false,
                            helperText: null,
                            textInputType: TextInputType.number,
                            labelText: "Age",
                            filled: false,
                            validator: validateAge,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LabelTextField(
                            textController: weightController,
                            hintText: "60",
                            obsecureText: false,
                            helperText: "Weight in LB",
                            textInputType: TextInputType.number,
                            labelText: "Weight",
                            filled: false,
                            validator: null,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: LabelTextField(
                            textController: heightController,
                            hintText: "170",
                            obsecureText: false,
                            helperText: "Height in CM",
                            textInputType: TextInputType.number,
                            labelText: "Height",
                            filled: false,
                            validator: null,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: CustomButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/first_profile');
                            validateAndSubmit();
                          },
                          buttonText: "Update"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 85,
              ),
              ProfileGenericTile(onPressed: () {}, assetName: textFile, text: "Terms of service"),
              ProfileGenericTile(onPressed: () {}, assetName: textFile, text: "Privacy Policy"),
              ProfileGenericTile(
                  onPressed: () async {
                    debugPrint("logout clicked");
                    await authProvider.signOut();
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (_) => UserLogin()), (route) => false);
                  },
                  assetName: logOut,
                  text: "Log out"),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: SvgPicture.asset(helixVersion),
              )
            ],
          ),
        ),
      ),
    );
    // });
  }
}
