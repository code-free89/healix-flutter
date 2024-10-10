import 'package:flutter/material.dart';
import 'package:helix_ai/Controller/HealthDataController.dart';
import 'package:helix_ai/model/getCustomizedata.dart';

import '../model/ai_response.dart';
import 'api_provider.dart';

// class ApiRepository {
//   final ApiProvider _apiProvider = ApiProvider();

//   Future<AiResponse?> getAiAnswer(String question) async {
//     return await _apiProvider.getAiAnswer(question);
//   }
// }

class ApiRepository {
  final HealthDataController healthDataController = HealthDataController();

  // Passing context from the caller
  Future<CustomizedResponse> getCustomizedData(
      CustomizedRequest request, BuildContext context) {
    return healthDataController.getCustomizedData(request, context);
  }
}
