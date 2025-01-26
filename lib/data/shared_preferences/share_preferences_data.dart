import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/getCustomizedata.dart';
import '../../models/user_profile_data.dart';

class SharePreferenceData {
  late SharedPreferences prefs;
  static const String keyIsFirstProfileShown = "is_first_profile_shown";
  late Isar isar;
  // Singleton instance
  static final SharePreferenceData _instance = SharePreferenceData._internal();
  String uid = '';

  factory SharePreferenceData() {
    return _instance;
  }

  SharePreferenceData._internal();

  Future<void> initSecureStorage() async {
    try {
      prefs = await SharedPreferences.getInstance();

      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        name: 'isar.db',
        [UserProfileDataSchema, CustomizedResponseSchema],
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

  Future<void> storeUserInfo(UserProfileData user) async {
    await isar.writeTxn(() => isar.userProfileDatas.put(user));
  }

  Future<UserProfileData?> retrieveUserInfo() async {
    UserProfileData? userProfileData =
        await isar.userProfileDatas.where().findFirst();
    uid = userProfileData?.id ?? '';
    return userProfileData;
  }

  Future<void> storeFirstProfileShownStatus(bool isShown) async {
    await prefs.setBool(keyIsFirstProfileShown, isShown);
  }

  Future<bool?> retrieveFirstProfileShownStatus() async {
    return prefs.getBool(keyIsFirstProfileShown);
  }
}
