import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/api_constants.dart';
import '../model/ai_response.dart';

class ApiProvider {
  final Dio dio = Dio();
  final options = Options(contentType: Headers.formUrlEncodedContentType);

  Future<Options> constructRequestHeadersWithTokenForFormData() async {

    Map<String, String> headers = {
      "Content-Type":"application/json",
      "Authorization": "Bearer ${dotenv.env[apiKey]}",
    };
    return Options(
        headers: headers,
        validateStatus: (status) {
          return status! < 500;
        });
  }

  Future<AiResponse?> getAiAnswer(String question) async {

    AiResponse baseApiResponse=AiResponse();
    try {
      Response response = await dio.post(apiBaseUrl + endPointCompletions,
          data: {
            "model": "gpt-3.5-turbo-0613",
            "messages": [
              {
                "role": "assistant",
                "content": question
              }
            ],
             "max_tokens": 2048,
            "temperature": 0
          },
          options: await constructRequestHeadersWithTokenForFormData());
      baseApiResponse = AiResponse.fromJson(response.data);
      debugPrint('status code ${response.statusCode}');
      if (response.statusCode == 200) {
          return baseApiResponse;
      } else {
        return null;
      }
    } catch (exception, stack) {
      debugPrint("Exception --- $exception --- Stack --- $stack");
      return null;
    }
  }
}
