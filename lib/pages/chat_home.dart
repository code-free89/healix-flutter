// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/chat_component/chat_start.dart';
import 'package:helix_ai/chat_component/user_chat.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/user_profile.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool isChatVisible = false;
  TextEditingController chatController = TextEditingController();

  List initialMessages = [
    "Hello there",
    "Hello! How may I assist you today!",
    "Show me what you can do?",
    "Of course! I can help you to start and maintain a healthy Healix lifestyle, with everything you need to know at your fingertips.  Let me know your questions."
  ];

  List messages = [
    "Hello there",
    "Hello! How may I assist you today!",
    "Show me what you can do?",
    "Of course! I can help you to start and maintain a healthy Healix lifestyle, with everything you need to know at your fingertips.  Let me know your questions."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gene',
          style: TextStyle(fontSize: 15),
        ),
        leading: InkWell(
            onTap: () {
              setState(() {
                isChatVisible = false;
                messages = initialMessages;
              });
            },
            child: SvgPicture.asset(
              appLogo,
              fit: BoxFit.none,
            )),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: SvgPicture.asset(userCircle)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 36, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: isChatVisible ? UserChat(messages: messages) : ChatStart()),
            SizedBox(height: 22,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: () {
                      if (!isChatVisible) {
                        setState(() {
                          isChatVisible = true;
                        });
                      }
                    },
                    controller: chatController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(28, 197, 116, 1),
                            width: 1,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(28, 197, 116, 1),
                            width: 1,
                          )
                      ),
                      hintText: "Ask me anything...",
                      hintStyle: TextStyle(fontFamily: 'Rubik', fontSize: 17, color: Color.fromRGBO(166, 163, 157, 1)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (chatController.text.isNotEmpty) {
                      setState(() {
                        messages.add(chatController.text.toString());
                      });
                    }
                    chatController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: Color.fromRGBO(28, 197, 116, 1)),
                      child: SvgPicture.asset(
                        buttonArrow,
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
