import 'package:flutter/material.dart';
import '../api/api_repository.dart';
import '../constants/string_constants.dart';
import '../model/ai_response.dart';

class ChatProvider extends ChangeNotifier{
  ApiRepository apiRepository = ApiRepository();
  bool isAnswerLoading = false;
  List<Choices> answers = [];
  List<Map<String,dynamic>> messages = [];

  Future getChatAnswer(String question) async {
    isAnswerLoading = true;
    notifyListeners();
    var res =
    await apiRepository.getAiAnswer(question);
    if (res!=null) {
      answers = res.choices!;
      for (var element in answers) {
        messages[messages.length-1]={questionTitle:question,answerTitle:element.message?.content};
        debugPrint('chat is ${messages}');
      }
    } else {
      messages[messages.length-1]={questionTitle:question,answerTitle:'-'};
    }
    isAnswerLoading = false;
    notifyListeners();
  }

  void addQuestion(String question){
    messages.add({questionTitle:question,answerTitle:null});
    notifyListeners();
  }

  void scrollToBottom(ScrollController scrollController){
    if(scrollController.hasClients){
      for(int i=0;i<12;i++){
        Future.delayed(Duration(milliseconds: i*50),(){
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    }
  }
}