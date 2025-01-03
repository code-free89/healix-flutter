import 'package:flutter/foundation.dart';
import 'package:helix_ai/data/models/model/getCustomizedata.dart';
import 'package:isar/isar.dart';

import '../../main.dart';

class MessageRepository {
  Future<void> addMessage(CustomizedResponse response) async {
    try {
      await isar.writeTxn(() async {
        await isar.customizedResponses.put(response);
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error in adding message: $e");
      }
    }
  }

  Future<List<CustomizedResponse>> getAllMessages() async {
    try {
      return await isar.customizedResponses.where().findAll();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching messages: $e");
      }
      return [];
    }
  }

  Future<void> deleteAllMessages() async {
    try {
      await isar.writeTxn(() async {
        await isar.customizedResponses.clear();
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting messages: $e");
      }
    }
  }
}
