import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helix_ai/data/repositories/message_repository.dart';

import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_provider.dart';

import '../../models/model/ai_response.dart';
import '../../models/model/getCustomizedata.dart';
import '../../models/view_model/customized_fetch_data_request.dart';
import '../../models/view_model/customized_request.dart';
import '../../repositories/ai_chat_repositories/api_repository.dart';
import 'package:geolocator/geolocator.dart';

class ChatProvider extends ChangeNotifier {
  ApiRepository apiRepository = ApiRepository();
  bool isAnswerLoading = false;
  bool isMealFinalQuoteLoaded = false;
  bool isNotification = false;
  bool isNotificationShowed = false;
  List<Choices> answers = [];
  List<Map<String, dynamic>> messages = [];
  late MessageRepository messageRepository;

  ChatProvider() {
    initializeMessages();
  }

  Future<void> initializeMessages() async {
    messageRepository = MessageRepository();
    List<CustomizedResponse> savedMessages =
        await messageRepository.getAllMessages();

    var oldMessages = savedMessages
        .map((e) => {
              questionTitle: e.searchText,
              answerTitle: e.gptResponse,
              isMeal: e.intent == 'MEAL_ORDER',
              menuItem: e.menuItem
            })
        .toList();
    messages.addAll(oldMessages);
    notifyListeners();
  }

  Future<void> setUserLocationData() async {
    String? userUid = await SharePreferenceProvider()
        .retrieveUserInfo()
        .then((value) => value?.id);
    LocationPermission permission;
    // Call your API to set user location data
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      apiRepository.addUserLocation(
          userUid ?? '', position.latitude, position.longitude);
    }
  }

  Future<void> getChatAnswer(String question, BuildContext context) async {
    if (isAnswerLoading) return; // Prevent duplicate calls

    isAnswerLoading = true;
    notifyListeners();

    String? userUid = await SharePreferenceProvider()
        .retrieveUserInfo()
        .then((value) => value?.id);

    // Create a CustomizedRequest object
    CustomizedRequest request = CustomizedRequest(
      // id: '345', // replace with actual user ID if necessary
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

      if (res.intent == 'MEAL_ORDER') {
        messages.last = {
          questionTitle: question,
          answerTitle: gptResponse,
          isMeal: true,
          menuItem: res.menuItem,
        };
      }
      messageRepository.addMessage(res);
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

  Future<void> getFinalQuote(
      String question, BuildContext context, MenuItem menuItemView) async {
    // Add a placeholder message to the list
    messages.add({
      questionTitle: question,
      answerTitle: null, // Placeholder for the answer
    });
    notifyListeners(); // Notify UI about the change

    int currentMessageIndex =
        messages.length - 1; // Get index of the placeholder
    String? userUid = await SharePreferenceProvider()
        .retrieveUserInfo()
        .then((value) => value?.id);

    // Prepare the request
    CustomizedFetchDataRequest request = CustomizedFetchDataRequest(
      // id: '345', // replace with actual user ID if necessary
      id: userUid ?? "", // replace with actual user ID if necessary
      menuItem: menuItemView,
    );

    try {
      // Fetch data
      bool success = await apiRepository.getFinalQuoteData(request, context);

      if (success) {
        // Replace the placeholder with the final success message
        messages[currentMessageIndex] = {
          questionTitle: question,
          answerTitle: 'Order confirmed!',
        };
      } else {
        // Replace the placeholder with an error message
        messages[currentMessageIndex] = {
          questionTitle: question,
          answerTitle: 'Error fetching response',
        };
      }
    } catch (error) {
      // Handle any exceptions and update the placeholder with an error message
      messages[currentMessageIndex] = {
        questionTitle: question,
        answerTitle: 'Error: Something went wrong!',
      };
    }

    notifyListeners(); // Notify UI about the updated message
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

  void resetChat() {
    messages.clear();
    notifyListeners();
    messageRepository.deleteAllMessages();
  }

  void updateAnswerWithNotification() {
    for (var i = 0; i < messages.length; i++) {
      if (messages[i]['question'] == '') {
        messages.removeAt(i);
        notifyListeners();
      }
    }

    // Add a new message with the desired string
    messages.add({
      questionTitle: '',
      // Empty question since it's just a notification
      answerTitle: 'What is your Blood glucose level in mg/dl?',
    });
    isNotification = true;
    isNotificationShowed = false;
    notifyListeners();
  }

  void notificationOptionSelected() {
    isNotificationShowed = true;
    notifyListeners();
  }
}
