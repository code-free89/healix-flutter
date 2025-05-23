import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/shared_preferences/share_preferences_data.dart';
import '../models/final_quote_data_model.dart';
import '../views/shared_components/show_permission_dialog.dart';
import '/models/notification_content.dart' as notification;
import 'package:helix_ai/data/data_services/message_data_services.dart';

import 'package:helix_ai/util/constants/string_constants.dart';
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
  bool isOrderButtonClicked = false;
  List<notification.Choices> answers = [];
  notification.Choices? choice;
  List<Map<String, dynamic>> messages = [];
  late MessageDataServices messagesDataservices;

  ChatProvider() {
    initializeMessages();
  }

  Future<void> initializeMessages() async {
    messagesDataservices = MessageDataServices();
    List<CustomizedResponse> savedMessages =
        await messagesDataservices.getAllMessages();

    var oldMessages = savedMessages.map<Map<String, dynamic>>((e) {
      // Parse menuItemString into a MenuItem object
      MenuItem? menuItem;
      if (e.menuItemString != null) {
        menuItem = IsarHelper.parseMenuItem(e.menuItemString!); // Parse it
      }

      return {
        questionTitle: e.searchText,
        answerTitle: e.gptResponse,
        isMeal: e.intent == 'MEAL_ORDER',
        // menuItem: menuItem, // Use parsed MenuItem object
      };
    }).toList();

    messages.addAll(oldMessages); // Add parsed messages to the list
    notifyListeners();
  }

  Future<void> setUserLocationData() async {
    String? userUid = SharePreferenceData().uid;
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

    String? userUid = SharePreferenceData().uid;

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
      CustomizedResponse res = await apiRepository.getCustomizedData(request);

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
        isOrderButtonClicked = false;
      }
      messagesDataservices.addMessage(res);
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
    isOrderButtonClicked = true;
    notifyListeners();
    // Add a placeholder message to the list
    messages.add({
      questionTitle: question,
      answerTitle: null, // Placeholder for the answer
    });
    notifyListeners(); // Notify UI about the change

    int currentMessageIndex =
        messages.length - 1; // Get index of the placeholder
    String? userUid = SharePreferenceData().uid;

    // Prepare the request
    CustomizedFetchDataRequest request = CustomizedFetchDataRequest(
      id: userUid ?? "",
      menuItem: menuItemView,
    );

    try {
      // Fetch data
      FinalQuoteDataModel finalQuoteData =
          await apiRepository.getFinalQuoteData(request);

      if (finalQuoteData.message != null) {
        // Replace the placeholder with the final success message
        messages[currentMessageIndex] = {
          questionTitle: question,
          answerTitle: finalQuoteData.message,
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
    if (scrollController.hasClients &&
        scrollController.position.hasViewportDimension) {
      for (int i = 0; i < 12; i++) {
        Future.delayed(Duration(milliseconds: i * 50), () {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }
    }
  }

  void resetChat() {
    messages.clear();
    notifyListeners();
    messagesDataservices.deleteAllMessages();
  }

  void updateAnswerWithNotification(notificationQuestion) {
    for (var i = 0; i < messages.length; i++) {
      if (messages[i]['question'] == '' ||
          messages[i]['question'] == 'Annotation') {
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

  void notificationOptionSelected(bool isAnswerSelected) {
    isNotificationClicked = true;
    if (isAnswerSelected) {
      messages.add({
        questionTitle: 'Annotation',
        // Empty Answer since it's just a Notification Annotation
        answerTitle: 'Thanks for your input',
      });
    }
    notifyListeners();
  }

  void OrderButtonOptionSelected() {
    isOrderButtonClicked = true;
    notifyListeners();
  }

  Future<bool> setNotificationResponse(
      BuildContext context, String query, String notificationResponse) async {
    try {
      await apiRepository.setNotificationResponse(
          FirebaseAuth.instance.currentUser!.uid, query, notificationResponse);
      return true;
    } catch (e) {
      showErrorDialog(context, "Error",
          "An error occurred while fetching user profile response: $e");
      print("Error updating response: $e");
      return false;
    }
  }

  Future getNotificationContent(
    String notificationTitle,
  ) async {
    try {
      String? userUid = await SharePreferenceData().uid;
      return await apiRepository.getNotificationContent(
          userUid, notificationTitle);
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
