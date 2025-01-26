import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/data/shared_preferences/share_preferences_data.dart';
import 'package:helix_ai/util/constants/constant.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/views/screens/auth_screens/user_login.dart';
import 'package:provider/provider.dart';

import '../../../controllers/authentication_provider.dart';
import '../../../util/constants/enums.dart';
import '../chat_screen/chat_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuthStatus();
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  Future<void> checkAuthStatus() async {
    final authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    await Future.delayed(Duration(seconds: 2));

    switch (authProvider.status) {
      case Status.Uninitialized:
        break;
      case Status.Unauthenticated:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserLogin(),
            ));

        break;
      case Status.Authenticated:
        authProvider.userData = await SharePreferenceData().retrieveUserInfo();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatHome(
                userFromLogin: true,
              ),
            ));

        break;
      case Status.FirstTimeAuthenticated:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SvgPicture.asset(
        splashImage,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
