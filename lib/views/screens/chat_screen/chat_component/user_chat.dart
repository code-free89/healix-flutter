import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_component/HealthBarChart.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_component/user_chat_container.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/chat_provider.dart';
import '/models/getCustomizedata.dart';

class UserChat extends StatefulWidget {
  final ScrollController scrollController;

  UserChat({super.key, required this.scrollController});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  bool isFetching = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Add a listener to monitor changes in the messages list
    Provider.of<ChatProvider>(context, listen: false)
        .addListener(_scrollToBottom);
  }

  @override
  @override
  void dispose() {
    if (mounted) {
      Provider.of<ChatProvider>(context, listen: false)
          .removeListener(_scrollToBottom);
    }
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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

            return UserChatContainer(
              question: question,
              answer: answer.isNotEmpty ? answer : 'Loading answer...',
              isMeal: meal,
              menuItem: menu,
              isNotification: chatProvider.isNotification,

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
