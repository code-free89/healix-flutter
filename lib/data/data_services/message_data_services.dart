import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helix_ai/util/backend_services/backend_call.dart';
import 'package:isar/isar.dart';

import '../../models/customized_fetch_data_request.dart';
import '../../models/customized_request.dart';
import '../../models/getCustomizedata.dart';
import '../../util/constants/api_constants.dart';

class MessageRepository {
  // MARK: - Function for Get Customized Response
  Future<CustomizedResponse> getCustomizedData(
      CustomizedRequest request, BuildContext context) async {
    try {
      var response = await BackendCall()
          .postRequest(endpoint: getCustomizedUrl, jsonBody: request.toJson());
      return CustomizedResponse.fromJson(response);
    } catch (e) {
      throw Exception('Error occurred while fetching customized response: $e');
    }
  }

  Future<bool> getFinalQuoteData(
      CustomizedFetchDataRequest request, BuildContext context) async {
    try {
      final response = await BackendCall()
          .postRequest(endpoint: getQuoteData, jsonBody: request.toJson());
      return true;
    } catch (e) {
      throw Exception('Error occurred while fetching final quote data: $e');
    }
  }

  Future<void> addMessage(CustomizedResponse response) async {
    try {
      var isar = Isar.getInstance('isar.db');
      await isar?.writeTxn(() async {
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
      var isar = Isar.getInstance('isar.db');
      return await isar?.customizedResponses.where().findAll() ?? [];
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching messages: $e");
      }
      return [];
    }
  }

  Future<void> deleteAllMessages() async {
    try {
      var isar = Isar.getInstance('isar.db');
      await isar?.writeTxn(() async {
        await isar.customizedResponses.clear();
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting messages: $e");
      }
    }
  }
}
