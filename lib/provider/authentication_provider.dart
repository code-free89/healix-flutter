import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helix_ai/shared_preferences/share_preference_repository.dart';

enum Status { Uninitialized, Authenticated, Unauthenticated, FirstTimeAuthenticated }

class AuthenticationProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User? _user;
  Status _status = Status.Uninitialized;
  String _errorMessage = "";
  SharedPreferenceRepository _sharedPreferenceRepository = SharedPreferenceRepository();

  AuthenticationProvider.instance()
      : _auth = FirebaseAuth.instance,
        _user = FirebaseAuth.instance.currentUser {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;

  String get errorMessage => _errorMessage;

  User? get user => _user;

  Future<bool> signUp(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      notifyListeners();
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _sharedPreferenceRepository.storeUserInfo(uid: userCredential.user!.uid, email: userCredential.user!.email);
      return true;
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

  Future<bool> signIn(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
      if (await _sharedPreferenceRepository.retrieveFirstProfileShownStatus() ?? false) {
        _status = Status.FirstTimeAuthenticated;
        await _sharedPreferenceRepository.storeFirstProfileShownStatus(true);
      } else {
        _status = Status.Authenticated;
      }
    }
    notifyListeners();
  }
}
