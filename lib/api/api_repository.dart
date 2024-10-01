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

  Future<CustomizedResponse> getCustomizedData(CustomizedRequest request) {
    return healthDataController.getCustomizedData(request);
  }
}
