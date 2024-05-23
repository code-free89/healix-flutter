import 'package:flutter/material.dart';
import 'package:helix_ai/chat_component/response_chat_container.dart';
import 'package:helix_ai/chat_component/user_chat_container.dart';
import 'package:helix_ai/provider/chat_provider.dart';
import 'package:provider/provider.dart';

import '../constants/string_constants.dart';

class UserChat extends StatefulWidget {

  final ScrollController scrollController;
  UserChat({super.key , required this.scrollController});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<ChatProvider>(
        builder: (_,chatProvider,__) {
          return ListView.builder(
            controller: widget.scrollController,
            shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: chatProvider.messages.length,
              itemBuilder: (context,index){
                return UserChatContainer(
                   question: chatProvider.messages[index][questionTitle]!,answer: chatProvider.messages[index][answerTitle],);
              }
              );
        }
      ),
    );
  }
}
