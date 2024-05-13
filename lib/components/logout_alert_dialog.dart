import 'package:flutter/material.dart';

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
