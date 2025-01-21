import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/models/notification_content.dart' as notification;
import 'package:helix_ai/data/repositories/message_repository.dart';

import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_provider.dart';

import 'package:geolocator/geolocator.dart';

import '/models/getCustomizedata.dart';
import '/models/customized_fetch_data_request.dart';
import '/models/customized_request.dart';
import '../../data/repositories/api_repository.dart';

class ChatProvider extends ChangeNotifier {
  ApiRepository apiRepository = ApiRepository();
  bool isAnswerLoading = false;
  bool isMealFinalQuoteLoaded = false;
  bool isNotification = false;
  bool isNotificationClicked = false;
  List<notification.Choices> answers = [];
  notification.Choices? choice;
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
      id: userUid ?? "",
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

  void updateAnswerWithNotification(notificationQuestion) {
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
      answerTitle: notificationQuestion,
    });
    isNotification = true;
    isNotificationClicked = false;
    notifyListeners();
  }

  void notificationOptionSelected() {
    isNotificationClicked = true;
    notifyListeners();
  }

  Future<bool> setNotificationResponse(
      BuildContext context, String query, String notificationResponse) async {
    try {
      await apiRepository.setNotificationResponse(context,
          FirebaseAuth.instance.currentUser!.uid, query, notificationResponse);
      return true;
    } catch (e) {
      print("Error updating response: $e");
      return false;
    }
  }

  Future getNotificationContent(
    String notificationTitle,
  ) async {
    try {
      String? userUid = await SharePreferenceProvider().retrieveUserInfo().then(
            (value) => value?.id,
          );
      return await apiRepository.getNotificationContent(
          userUid!, notificationTitle);
    } catch (e) {
      print("Error updating address: $e");
      return false;
    }
  }

  void updateNotificationOptions(notification.Choices? choices) {
    choice = choices;
    notifyListeners();
  }
}
