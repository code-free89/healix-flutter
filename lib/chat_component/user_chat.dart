import 'package:flutter/material.dart';
import 'package:helix_ai/chat_component/HealthBarChart.dart';
import 'package:helix_ai/chat_component/user_chat_container.dart';
import 'package:helix_ai/provider/chat_provider.dart';
import 'package:provider/provider.dart';

import '../constants/string_constants.dart';

class UserChat extends StatefulWidget {
  final ScrollController scrollController;
  UserChat({super.key, required this.scrollController});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<ChatProvider>(builder: (_, chatProvider, __) {
        return ListView.builder(
          controller: widget.scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: chatProvider.messages.length,
          itemBuilder: (context, index) {
            final message = chatProvider.messages[index];
            String question = message[questionTitle];
            final answer = message[answerTitle];
            if (question.contains("steps")) {
              return Container(
                padding: EdgeInsets.only(bottom: 20),
                height:
                400.0, // Set a fixed height or use constraints that fit your design
                child: Healthbarchart(),
              );
            } else {
              // Handle other questions and answers
              return UserChatContainer(
                question: question ?? 'No question',
                answer: answer ?? 'No answer',
              );
            }
          },
        );
      }),
    );
  }
}
