import 'package:flutter/material.dart';
import 'package:helix_ai/chat_component/response_chat_container.dart';
import 'package:helix_ai/chat_component/user_chat_container.dart';

class UserChat extends StatefulWidget {

  final List messages;
  UserChat({super.key , required this.messages});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       reverse: true,
        itemCount: widget.messages.length,
        itemBuilder: (context,index){
          final reversedIndex = widget.messages.length - 1 - index;
          if(!reversedIndex.isEven){
            return ResponseChatContainer(
              message: widget.messages[reversedIndex]);
          }else{
            return UserChatContainer(
                message: widget.messages[reversedIndex]);
          }
        });
  }
}
