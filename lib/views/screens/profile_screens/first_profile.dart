// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/backend_services/firestore/firestore.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/util/validator.dart';
import 'package:helix_ai/views/shared_components/custom_button.dart';
import 'package:helix_ai/views/shared_components/custom_container.dart';
import 'package:helix_ai/views/shared_components/custom_text_fiels_with_label.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_home.dart';

class FirstProfile extends StatefulWidget {
  const FirstProfile({super.key});

  @override
  State<FirstProfile> createState() => _FirstProfileState();
}

class _FirstProfileState extends State<FirstProfile> {

  final profileFormKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  FirestoreService firestoreService = FirestoreService();
  bool hasFilledField = false;
  bool isLoading = false;

  void filledField(){
    setState(() {
      hasFilledField =  usernameController.text.isNotEmpty ||
          ageController.text.isNotEmpty ||
          weightController.text.isNotEmpty ||
          heightController.text.isNotEmpty;
    });
  }

  Widget updateButton(){
    if(hasFilledField){
      return
        SizedBox(
          width: double.infinity,
          height: 60,
          child:CustomButton(
              onPressed: (){
                validateAndSubmit();
              },
              buttonText: "Submit",
              showLoading: isLoading,)
      );
    }else{
      return SizedBox(
          width: double.infinity,
          height: 60,
          child:CustomButton(
              onPressed: (){
                skip();
              },
              buttonText: "Skip")
      );
    }
  }

  void validateAndSubmit() async{
    bool status = false;
    if(profileFormKey.currentState!.validate()){

      String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

      if(uid != null){

        setState(() {
          isLoading = true;
        });

        String username = usernameController.text.toString();
        int? age = ageController.text.isNotEmpty ? int.parse(ageController.text) : null;
        double? height = heightController.text.isNotEmpty ? double.parse(heightController.text) : null;
        double? weight = weightController.text.isNotEmpty ? double.parse(weightController.text) : null;

        status =  await firestoreService.getUserDetails(uid, username, age, height, weight);
        debugPrint('status is get user ${status}');
        setState(() {
          isLoading = false;
        });

        if(status){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChatHome()) ,(Route<dynamic> route) => false,);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Unable to submit check your internet"),
            ),
          );
        }
      }
    }
  }

  void skip(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ChatHome()) ,(Route<dynamic> route) => false,);
  }

  String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
  @override
  void initState() {
    super.initState();
    usernameController.addListener(filledField);
    ageController.addListener(filledField);
    weightController.addListener(filledField);
    heightController.addListener(filledField);
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
    return Scaffold(
      backgroundColor: Colors.black,
      body:LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: profileFormKey,
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
                            padding: const EdgeInsets.fromLTRB(28,85,28,0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Vital Statistics" ,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Text("Accurate data will help us to " , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w500),),
                                Text("provide you a right guidance. " , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w500),),
                                SizedBox(height:50),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LabelTextField(
                                        textController:usernameController,
                                        stockColor: dividerColor,
                                        hintText: "healthy_john",
                                        obsecureText: false,
                                        helperText: null,
                                        textInputType: TextInputType.name,
                                        labelText: "Username",
                                        filled: true,
                                        validator: null,
                                        textInputAction: TextInputAction.next,
                                        textColor: textFieldColor),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: LabelTextField(
                                        stockColor: dividerColor,
                                        textController:ageController,
                                        hintText: "25",
                                        obsecureText: false,
                                        helperText: null,
                                        textInputType: TextInputType.number,
                                        labelText: "Age",
                                        filled: true,
                                        validator: Validator.validateAge,
                                        textInputAction: TextInputAction.next,
                                        textColor: textFieldColor,),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LabelTextField(
                                        maxLength: 3,
                                        stockColor: dividerColor,
                                        textController:weightController,
                                        hintText: "60",
                                        obsecureText: false,
                                        helperText: "Weight in KG",
                                        textInputType: TextInputType.number,
                                        labelText: "Weight",
                                        filled: true,
                                        validator: Validator.validateWeight,
                                        textInputAction: TextInputAction.next,
                                        textColor: textFieldColor,),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: LabelTextField(
                                        maxLength: 3,
                                        stockColor: dividerColor,
                                        textController:heightController,
                                        hintText: "170",
                                        obsecureText: false,
                                        helperText: "Height in CM",
                                        textInputType: TextInputType.number,
                                        labelText: "Height",
                                        filled: true,
                                        validator: Validator.validateHeight,
                                        textInputAction: TextInputAction.done,
                                        textColor: textFieldColor,),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50,),
                                updateButton(),
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