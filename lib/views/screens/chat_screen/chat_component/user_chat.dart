import 'package:flutter/material.dart';
import 'package:helix_ai/controllers/provider_controllers/chat_provider.dart';
import 'package:helix_ai/model/getCustomizedata.dart';
import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_component/HealthBarChart.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_component/user_chat_container.dart';
import 'package:provider/provider.dart';

class UserChat extends StatefulWidget {
  final ScrollController scrollController;

  UserChat({super.key, required this.scrollController});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<ChatProvider>(builder: (_, chatProvider, __) {
        // Ensure that messages are not duplicated in the ListView
        List messages =
            chatProvider.messages.toSet().toList(); // Remove duplicates

        return ListView.builder(
          controller: widget.scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: messages.length,
          // Use the unique list
          itemBuilder: (context, index) {
            final message = messages[index];
            String question = message[questionTitle];
            String answer = message[answerTitle] ?? '';
            bool meal = message[isMeal] ?? false;
            MenuItem? menu = message[menuItem];

            // if (question.contains("graph") && !isFetching) {
            //   isFetching = true;
            //   return Container(
            //     padding: EdgeInsets.only(bottom: 20),
            //     height: 400.0,
            //     child: Healthbarchart(),
            //   );
            // } else {
            return UserChatContainer(
              question: question,
              answer: answer.isNotEmpty ? answer : 'Loading answer...',
              isMeal: meal,
              menuItem: menu,
              // isMeal: chatProvider.isMealOrder,
              // menuItem: chatProvider.menuItem,
            );
            //}
          },
        );
      }),
    );
  }
}
