// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/chat_home.dart';
import 'package:helix_ai/shared_preferences/share_preference_repository.dart';

class SocialLoginButtons extends StatelessWidget {
  final String text;
  SocialLoginButtons({super.key, required this.text});
  SharedPreferenceRepository _sharedPreferenceRepository =
      SharedPreferenceRepository();
  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Method to handle Facebook Login
  Future<void> _loginWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;

        if (accessToken != null) {
          final OAuthCredential credential =
              FacebookAuthProvider.credential(accessToken.tokenString);

          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          final User? user = userCredential.user;
          if (user != null) {
            print('Facebook Firebase Login Success: ${user.uid}');
            await _sharedPreferenceRepository.storeUserInfo(
                uid: userCredential.user!.uid,
                email: userCredential.user!.email);
            // Navigate to ChatHome after successful login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ChatHome()),
            );
          }
        }
      } else {
        print('Facebook Login Failed: ${result.status}');
        print('Error Message: ${result.message}');
      }
    } catch (e) {
      print('Error during Facebook Login: $e');
    }
  }

  // Method to handle Google Login
  Future<void> _loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final User? user = userCredential.user;
        if (user != null) {
          print('Google Firebase Login Success: ${user.uid}');

          await _sharedPreferenceRepository.storeUserInfo(
              uid: userCredential.user!.uid, email: userCredential.user!.email);
          // Navigate to ChatHome after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChatHome()),
          );
        }
      }
    } catch (e) {
      print('Error during Google Login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Ubuntu-Medium',
                  fontSize: 20,
                  color: Color.fromRGBO(51, 51, 51, 1)),
            )
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () => _loginWithGoogle(context), // Google Login Tap
              child: Container(
                height: 59,
                width: 59,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: SvgPicture.asset(
                  googleLogin,
                  fit: BoxFit.none,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () => _loginWithFacebook(context), // Facebook Login Tap
              child: Container(
                height: 59,
                width: 59,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: SvgPicture.asset(
                  appleLogin, // You can still use the Apple icon here, but it will trigger Facebook login
                  fit: BoxFit.none,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
