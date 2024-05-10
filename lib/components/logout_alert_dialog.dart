import 'package:flutter/material.dart';
import 'package:helix_ai/pages/user_login.dart';
import 'package:helix_ai/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

class LogOutAlertDialog extends StatelessWidget {

  final VoidCallback onLogout;
  const LogOutAlertDialog({super.key , required this.onLogout});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Logout"),
      content:Text("Are you sure you want to logout ? "),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        TextButton(
            onPressed: (){
              onLogout();
            },
            child: Text("Logout")),
      ],
    );
  }
}
