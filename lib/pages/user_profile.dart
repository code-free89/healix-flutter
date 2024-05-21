// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/components/custom_button.dart';
import 'package:helix_ai/components/custom_text_fiels_with_label.dart';
import 'package:helix_ai/components/logout_alert_dialog.dart';
import 'package:helix_ai/components/profile_generic_tile.dart';
import 'package:helix_ai/constants/colors.dart';
import 'package:helix_ai/firestore/firestore.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/chat_home.dart';
import 'package:helix_ai/pages/user_login.dart';
import 'package:helix_ai/util/validator.dart';
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

  FirestoreService firestoreService = FirestoreService();

  bool isLoading = false;

  void validateAndSubmit() async {
    bool status = false;
    if (profileUpdateFormKey.currentState!.validate()) {
      bool hasFilledField = usernameController.text.isNotEmpty ||
          ageController.text.isNotEmpty ||
          weightController.text.isNotEmpty ||
          heightController.text.isNotEmpty;

      String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

      if(uid != null){
        setState(() {
          isLoading = true;
        });

        String username = usernameController.text.toString();
        int? age = ageController.text.isNotEmpty ? int.parse(ageController.text) : null;
        double? height = heightController.text.isNotEmpty ? double.parse(heightController.text) : null;
        double? weight = weightController.text.isNotEmpty ? double.parse(weightController.text) : null;

       status = await firestoreService.updateUserDetails(uid, username, age, height, weight);
        debugPrint('update user');

        setState(() {
          isLoading = false;
        });
      }

      if (hasFilledField&&status) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile Updated"),
          ),
        );
      } else if (!status){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Enable to update please check your internet"),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please enter some details"),
          ),
        );
      }
    }
  }

  Future<void> fetchUserDetails() async{
    String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

    if(uid != null){
      Map<String,dynamic>? userDetails = await firestoreService.showUserDetails(uid);
      setState(() {
        usernameController.text = userDetails?['username'] ?? '' ;
        ageController.text = (userDetails?['age'] ?? '').toString() ;
        heightController.text = (userDetails?['height'] ?? '').toString() ;
        weightController.text = (userDetails?['weight']?? '').toString() ;
      });
    }
  }

  @override
  void initState() {
    fetchUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
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
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChatHome()),(Route<dynamic> route) => false);
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
                      height: 51,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LabelTextField(
                            stockColor: greyStockColor,
                            textController: usernameController,
                            hintText: "healthy_john",
                            obsecureText: false,
                            helperText: null,
                            textInputType: TextInputType.name,
                            labelText: "Username",
                            filled: false,
                            validator: null,
                            textInputAction: TextInputAction.next,
                            textColor: textColor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: LabelTextField(
                            stockColor: greyStockColor,
                            textController: ageController,
                            hintText: "25",
                            obsecureText: false,
                            helperText: null,
                            textInputType: TextInputType.number,
                            labelText: "Age",
                            filled: false,
                            validator: Validator.validateAge,
                            textInputAction: TextInputAction.next,
                            textColor: textColor,
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
                            maxLength: 3,
                            stockColor: greyStockColor,
                            textController: weightController,
                            hintText: "60",
                            obsecureText: false,
                            helperText: "Weight in KG",
                            textInputType: TextInputType.number,
                            labelText: "Weight",
                            filled: false,
                            validator: Validator.validateWeight,
                            textInputAction: TextInputAction.next,
                            textColor: textColor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: LabelTextField(
                            maxLength: 3,
                            stockColor: greyStockColor,
                            textController: heightController,
                            hintText: "170",
                            obsecureText: false,
                            helperText: "Height in CM",
                            textInputType: TextInputType.number,
                            labelText: "Height",
                            filled: false,
                            validator: Validator.validateHeight,
                            textInputAction: TextInputAction.done,
                            textColor: textColor,
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
                          buttonText: "Update",
                          showLoading: isLoading,),
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return LogOutAlertDialog(
                            onLogout: () async{
                              debugPrint("logout clicked");
                              await authProvider.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (_) => UserLogin()), (route) => false);
                            },
                          );
                        });
                  },
                  assetName: logOut,
                  text: "Log out"),
              SizedBox(
                height: 45,
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
