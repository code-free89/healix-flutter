import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceProvider {
  late SharedPreferences prefs;
  static const String keyUserUid = "current_user_uid";
  static const String keyUserEmail = "current_user_email";
  static const String keyIsFirstProfileShown = "is_first_profile_shown";

  Future _initSecureStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> clearSharePreference() async {
    await _initSecureStorage();
    await prefs.remove(keyUserUid);
    await prefs.remove(keyUserEmail);
  }

  Future<void> storeUserInfo(
      {String? uid,
      String? email}) async {
    await _initSecureStorage();
    await prefs.setString(keyUserUid, uid ?? '');
    await prefs.setString(keyUserEmail, email ?? '');
  }

  Future<String?> retrieveUserEmail() async {
    await _initSecureStorage();
    return prefs.getString(keyUserEmail);
  }

  Future<String?> retrieveUserUid() async {
    await _initSecureStorage();
    return prefs.getString(keyUserUid);
  }

  Future<void> storeFirstProfileShownStatus(bool isShown) async {
    await _initSecureStorage();
    await prefs.setBool(keyIsFirstProfileShown, isShown);
  }

  Future<bool?> retrieveFirstProfileShownStatus() async {
    await _initSecureStorage();
    return prefs.getBool(keyIsFirstProfileShown);
  }
}
