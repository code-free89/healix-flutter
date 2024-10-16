import 'package:flutter/material.dart';
import 'package:helix_ai/controllers/data_controller/health_data_controller.dart';
import 'package:helix_ai/model/ai_response.dart';
import 'package:helix_ai/model/getCustomizedata.dart';
import 'package:helix_ai/util/backend_services/repositories/ai_chat_repositories/api_repository.dart';
import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_provider.dart';


class ChatProvider extends ChangeNotifier {
  ApiRepository apiRepository = ApiRepository();
  bool isAnswerLoading = false;
  List<Choices> answers = [];
  List<Map<String, dynamic>> messages = [];

  Future<void> getChatAnswer(String question, BuildContext context) async {
    if (isAnswerLoading) return; // Prevent duplicate calls

    isAnswerLoading = true;
    notifyListeners();

    String? userUid = await SharePreferenceProvider().retrieveUserUid();

    // Create a CustomizedRequest object
    CustomizedRequest request = CustomizedRequest(
      id: userUid ?? "", // replace with actual user ID if necessary
      searchText: question,
    );

    // Add the question to the list with a loading placeholder
    messages.add({
      questionTitle: question,
      answerTitle: null, // Placeholder for the answer
    });
    notifyListeners(); // Notify listeners after adding the question

    try {
      // Call your API to get the customized response
      CustomizedResponse res =
          await apiRepository.getCustomizedData(request, context);

      // Assuming your API response has a field 'gpt_response'
      String gptResponse =
          res.gptResponse; // or whatever field contains the response

      // Update the answer for the question in the messages list
      messages.last = {
        questionTitle: question,
        answerTitle: gptResponse,
      };
    } catch (error) {
      // Update the question with an error message if the API call fails
      messages.last = {
        questionTitle: question,
        answerTitle: 'Error fetching response',
      };
      print('Error: $error');
    }

    isAnswerLoading = false;
    notifyListeners(); // Notify listeners after updating the answer
  }

  void scrollToBottom(ScrollController scrollController) {
    if (scrollController.hasClients) {
      for (int i = 0; i < 12; i++) {
        Future.delayed(Duration(milliseconds: i * 50), () {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    }
  }
}
