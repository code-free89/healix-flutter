import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/model/user_profile_data.dart';

class SharePreferenceProvider {
  late Isar isar;

  late SharedPreferences prefs;
  static const String keyIsFirstProfileShown = "is_first_profile_shown";
  // Singleton instance
  static final SharePreferenceProvider _instance =
      SharePreferenceProvider._internal();

  factory SharePreferenceProvider() {
    return _instance;
  }

  SharePreferenceProvider._internal();

  Future<void> initSecureStorage() async {
    try {
      prefs = await SharedPreferences.getInstance();

      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [UserProfileDataSchema],
        directory: dir.path,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearSharePreference() async {
    await prefs.clear();
    await isar.writeTxn(() => isar.userProfileDatas.clear());
  }

  Future<void> storeUserInfo(
      {String? uid,
      String? email,
      String? displayName,
      bool? firstTime}) async {
    var userProfileData =
        UserProfileData(id: uid, email: email, name: displayName);
    await isar.writeTxn(() => isar.userProfileDatas.put(userProfileData));
  }

  Future<UserProfileData?> retrieveUserInfo() async {
    UserProfileData? userProfileData =
        await isar.userProfileDatas.where().findFirst();
    return userProfileData;
  }

  Future<void> storeFirstProfileShownStatus(bool isShown) async {
    await prefs.setBool(keyIsFirstProfileShown, isShown);
  }

  Future<bool?> retrieveFirstProfileShownStatus() async {
    return prefs.getBool(keyIsFirstProfileShown);
  }
}
