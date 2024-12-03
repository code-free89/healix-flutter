import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helix_ai/util/backend_services/firestore/firestore.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_repository.dart';

import '../../models/view_model/user_data_view_model.dart';
import '../../repositories/ai_chat_repositories/api_repository.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Unauthenticated,
  FirstTimeAuthenticated
}

class AuthenticationProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User? _user;
  Status _status = Status.Uninitialized;
  String _errorMessage = "";
  ApiRepository apiRepository = ApiRepository();

  SharedPreferenceRepository _sharedPreferenceRepository =
      SharedPreferenceRepository();
  bool isSignupLoading = false;
  bool isLoginLoading = false;
  bool isSendingPasswordResentLinkLoading = false;
  FirestoreService firestoreService = FirestoreService();

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
      User? user = userCredential.user;
      if (user != null) {
        await firestoreService.addUserDocument(
          user.uid,
          email,
        );
      }
      await _sharedPreferenceRepository.storeUserInfo(
          uid: userCredential.user!.uid, email: userCredential.user!.email);
      print("Get User ID");
      print(userCredential.user!.uid);
      _status = Status.FirstTimeAuthenticated;
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
      notifyListeners();
      return false;
    }
  }

  Future<bool> addUserProfile(
      UserViewModel userData, BuildContext context) async {
    try {
      setIsSignupLoading(true);
      var res = await apiRepository.addUserProfile(context, userData);
      if (res) {
        setIsSignupLoading(false);
        notifyListeners();
      }
      return res;
    } catch (e) {
      _status = Status.Unauthenticated;
      _errorMessage = "Unable to signup. Please try again later.";
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      setIsLoginLoading(true);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _sharedPreferenceRepository.storeUserInfo(
          uid: userCredential.user!.uid, email: userCredential.user!.email);
      print("Get User ID");
      print(userCredential.user!.uid);
      setIsLoginLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _errorMessage = 'Wrong password provided for that user.';
      } else {
        _errorMessage = "Unable to login";
      }
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      if (await _sharedPreferenceRepository.retrieveFirstProfileShownStatus() ??
          false) {
        _status = Status.FirstTimeAuthenticated;
        await _sharedPreferenceRepository.storeFirstProfileShownStatus(true);
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
}
