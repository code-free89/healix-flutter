import 'dart:async';

import 'package:flutter/material.dart';
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
    try {
      final existingUser = await isar.userProfileDatas
          .filter()
          .emailEqualTo(user.email)
          .findFirst(); // Check if user with the same email exists

      await isar.writeTxn(() async {
        if (existingUser != null) {
          user.id = existingUser.id; // Ensure update happens on the same record
        }
        await isar.userProfileDatas.put(user);
      });
    } catch (e) {
      debugPrint("Exception in storing UserInfo: $e");
    }
  }

  Future<UserProfileData?> retrieveUserInfo() async {
    try {
      UserProfileData? userProfileData =
          await isar.userProfileDatas.where().findFirst();
      uid = userProfileData?.id ?? '';
      return userProfileData;
    } catch (e) {
      debugPrint("Exception in retreiving UserInfo: $e");
    }
  }

  Future<void> storeFirstProfileShownStatus(bool isShown) async {
    await prefs.setBool(keyIsFirstProfileShown, isShown);
  }

  Future<bool?> retrieveFirstProfileShownStatus() async {
    return prefs.getBool(keyIsFirstProfileShown);
  }
}
