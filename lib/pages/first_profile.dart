// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/components/custom_button.dart';
import 'package:helix_ai/components/custom_text_fiels_with_label.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/chat_home.dart';

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

  String? validateUsername(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? validateAge(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter a age';
    }
    return null;
  }

  void validateAndSubmit(){
    if(profileFormKey.currentState!.validate()){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatHome()));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
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
              Container(
                height: MediaQuery.of(context).size.height-358,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(containerBackground),
                        fit: BoxFit.fill
                    )
                ),
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
                                hintText: "healthy_john",
                                obsecureText: false,
                                helperText: null,
                                textInputType: TextInputType.name,
                                labelText: "Username",
                              filled: true,
                              validator: validateUsername,
                              textInputAction: TextInputAction.next,),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: LabelTextField(
                                textController:ageController,
                                hintText: "25",
                                obsecureText: false,
                                helperText: null,
                                textInputType: TextInputType.number,
                                labelText: "Age",
                              filled: true,
                              validator: validateAge,
                              textInputAction: TextInputAction.next,),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: LabelTextField(
                                textController:weightController,
                                hintText: "60",
                                obsecureText: false,
                                helperText: "Weight in LB",
                                textInputType: TextInputType.number,
                                labelText: "Weight",
                              filled: true,
                              validator: null,
                              textInputAction: TextInputAction.next,),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: LabelTextField(
                                textController:heightController,
                                hintText: "170",
                                obsecureText: false,
                                helperText: "Height in CM",
                                textInputType: TextInputType.number,
                                labelText: "Height",
                                filled: true,
                                validator: null,
                                textInputAction: TextInputAction.done,),
                          ),
                        ],
                      ),
                      SizedBox(height: 50,),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: CustomButton(
                            onPressed: (){
                              validateAndSubmit();
                            },
                            buttonText: "Submit"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
