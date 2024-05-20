import '../model/ai_response.dart';
import 'api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<AiResponse?> getAiAnswer(String question) async {
    return await _apiProvider.getAiAnswer(question);
  }
}
