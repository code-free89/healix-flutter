import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/constants/colors.dart';
import '../../shared_components/want_text.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController emailController =
      TextEditingController(text: "john.doe@email.com");
  final TextEditingController passwordController =
      TextEditingController(text: "*******");
  final TextEditingController addressController =
      TextEditingController(text: "Street Number 123");
  final TextEditingController phoneController =
      TextEditingController(text: "+123 456 789");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.061),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.055,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: size.width * 0.05,
                    ),
                    onTap: () {
                      Navigator.pop(context); // Back navigation
                    },
                  ),
                  WantText(
                      text: 'Profile',
                      fontSize: size.width * 0.036,
                      fontWeight: FontWeight.w500,
                      textColor: colorBlack.withOpacity(0.7),
                      usePoppins: false),
                  SizedBox()
                ],
              ),
              Center(
                child: WantText(
                    text: 'John Doe',
                    fontSize: size.width * 0.082,
                    fontWeight: FontWeight.bold,
                    textColor: textColor,
                    usePoppins: true),
              ),
              SizedBox(height: size.height * 0.035),
              buildEditableField("Full Name", nameController),
              buildEditableField("E-Mail", emailController),
              buildEditableField("Password", passwordController,
                  isObscure: true),
              buildEditableField("Address", addressController),
              buildEditableField("Phone Number", phoneController),
              SizedBox(height: size.height * 0.01),
              ListTile(
                leading: Icon(Icons.description_outlined),
                title:WantText(text: 'Terms of Service', fontSize: size.width*0.0435, fontWeight: FontWeight.w500, textColor: textColor, usePoppins: false) ,
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to Terms of Service screen
                },
              ),Container(height: 1.5,width: size.width,color: colorGrey,),
              ListTile(
                leading: Icon(Icons.privacy_tip_outlined),
                title:WantText(text:'Privacy Policy', fontSize: size.width*0.0435, fontWeight: FontWeight.w500, textColor: textColor, usePoppins: false) ,
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to Privacy Policy screen
                },
              ),Container(height: 1.5,width: size.width,color: colorGrey,),
              ListTile(
                leading: Icon(Icons.logout),
                title:WantText(text:'Log out', fontSize: size.width*0.0435, fontWeight: FontWeight.w500, textColor: textColor, usePoppins: false) ,
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Log out functionality
                },
              ),Container(height: 1.5,width: size.width,color: colorGrey,),
              SizedBox(height: size.height * 0.035),
              Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height:size.height*0.061 ,child: Image.asset("assets/images/logo.png")),
                   SizedBox(width: size.width*0.061),WantText(text: 'Healix AI\nV 1.0.0', fontSize: size.width*0.0435, fontWeight: FontWeight.w500, textColor: colorGreyText, usePoppins: false)
                  ,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller,
      {bool isObscure = false}) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.041),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WantText(
                    text: label,
                    fontSize: MediaQuery.of(context).size.height * 0.017,
                    fontWeight: FontWeight.w400,
                    textColor: colorBlack.withOpacity(0.7),
                    usePoppins: false),
                TextField(
                  controller: controller,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter $label",
                    isDense: true,
                  ),
                  style: GoogleFonts.roboto(
                    color: textColor,
                    fontSize: MediaQuery.of(context).size.width * 0.051,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Icon(Icons.edit, size: 20),
            onTap: () {
              // Trigger editing functionality
            },
          ),
        ],
      ),
    );
  }
}
