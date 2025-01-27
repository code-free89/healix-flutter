import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helix_ai/data/shared_preferences/share_preferences_data.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/backend_services/firebase_fcm.dart';
import '../views/shared_components/show_permission_dialog.dart';
import '/models/user_profile_data.dart';
import '/models/user_data_view_model.dart';
import '../data/repositories/api_repository.dart';
import '../util/constants/enums.dart';

class AuthenticationProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User? _user;
  Status _status = Status.Uninitialized;
  String _errorMessage = "";
  ApiRepository apiRepository = ApiRepository();

  UserProfileData? userData;
  bool isSignupLoading = false;
  bool isLoginLoading = false;
  bool isSendingPasswordResentLinkLoading = false;

  AuthenticationProvider.instance()
      : _auth = FirebaseAuth.instance,
        _user = FirebaseAuth.instance.currentUser {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;

  String get errorMessage => _errorMessage;

  User? get user => _user;

  Future signUp(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      setIsSignupLoading(true);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      SharePreferenceData().uid = userCredential.user!.uid;
      await FirebaseFCMService().init();

      _status = Status.FirstTimeAuthenticated;
      SharePreferenceData().storeUserInfo(UserProfileData(
        id: userCredential.user!.uid,
        email: email,
      ));
      setIsSignupLoading(false);
      notifyListeners();
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        _errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _errorMessage = 'The account already exists for that email.';
      } else {
        _errorMessage = "Unable to signup. Please try again later.";
      }
      setIsSignupLoading(false);

      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      setIsLoginLoading(true);

      // Sign in using Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFCMService().init();

      setIsLoginLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      setIsLoginLoading(false);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _errorMessage = 'Wrong password provided for that user.';
      } else {
        _errorMessage = "Unable to login.";
      }
      notifyListeners();
      return false;
    }
  }

  Future<bool> addUserProfile(
      UserViewModel userviewData, BuildContext context) async {
    try {
      setIsSignupLoading(true);
      var res = await apiRepository.addUserProfile(userviewData);
      if (res) {
        setIsSignupLoading(false);
        userData = UserProfileData(
          id: SharePreferenceData().uid,
          email: userviewData.email,
          name: userviewData.name,
          phone: userviewData.phone,
          address: userviewData.address,
          allergies: userviewData.allergies,
          dietPreference: userviewData.dietPreference,
          // : userviewData.favoriteFood,
          healthHistory: userviewData.healthHistory,
        );
        notifyListeners();
      }
      SharePreferenceData().storeUserInfo(userData!);
      return res;
    } catch (e) {
      _status = Status.Unauthenticated;
      _errorMessage = "Unable to signup. Please try again later.";
      notifyListeners();
      return false;
    }
  }

  signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    await SharePreferenceData().clearSharePreference();
    userData = UserProfileData();
    notifyListeners();
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      SharePreferenceData().uid = firebaseUser.uid;
      if (await SharePreferenceData().retrieveFirstProfileShownStatus() ??
          false) {
        _status = Status.FirstTimeAuthenticated;
        await SharePreferenceData().storeFirstProfileShownStatus(true);
      } else {
        _status = Status.Authenticated;
      }
    }
    notifyListeners();
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    setIsResettingPasswordLoading(true);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      setIsResettingPasswordLoading(false);
      return true;
    } catch (exception) {
      debugPrint("Exception while sending password reset link: $exception");
      setIsResettingPasswordLoading(false);
      return false;
    }
  }

  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  void setIsSignupLoading(bool value) {
    isSignupLoading = value;
    notifyListeners();
  }

  void setIsLoginLoading(bool value) {
    isLoginLoading = value;
    notifyListeners();
  }

  void setIsResettingPasswordLoading(bool value) {
    isSendingPasswordResentLinkLoading = value;
    notifyListeners();
  }

  Future<void> getUserProfileData(BuildContext context) async {
    try {
      var res =
          await apiRepository.getUserProfileData(SharePreferenceData().uid);
      await SharePreferenceData().storeUserInfo(res);
      userData = res;
    } catch (e) {
      _status = Status.Unauthenticated;
      showErrorDialog(context, "Error",
          "An error occurred while fetching user profile response: $e");
      _errorMessage = "Unable to fetch data. Please try again later.";
    }
    notifyListeners();
  }
}
