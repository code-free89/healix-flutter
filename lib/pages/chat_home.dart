// ignore_for_file: prefer_const_constructors
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/chat_component/chat_start.dart';
import 'package:helix_ai/chat_component/user_chat.dart';
import 'package:helix_ai/constants/colors.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/user_profile.dart';
import 'package:helix_ai/provider/chat_provider.dart';
import 'package:provider/provider.dart';

import '../util/ui_helper.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  // bool isChatVisible = false;
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  // List initialMessages = [
  //   "Hello there",
  //   "Hello! How may I assist you today!",
  //   "Show me what you can do?",
  //   "Of course! I can help you to start and maintain a healthy Healix lifestyle, with everything you need to know at your fingertips.  Let me know your questions."
  // ];

  // List messages = [
  //   "Hello there",
  //   "Hello! How may I assist you today!",
  //   "Show me what you can do?",
  //   "Of course! I can help you to start and maintain a healthy Healix lifestyle, with everything you need to know at your fingertips.  Let me know your questions."
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var chatProvider = Provider.of<ChatProvider>(context,listen: false);
    chatProvider.scrollToBottom(scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gene',
          style: TextStyle(fontSize: 15),
        ),
        leading: SvgPicture.asset(
          appLogo,
          fit: BoxFit.none,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: SvgPicture.asset(userCircle)),
          )
        ],
      ),
      body: Consumer<ChatProvider>(builder: (_, chatProvider, __) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 18.0, right: 18, bottom: 36, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: chatProvider.messages.isNotEmpty
                      ? UserChat(
                          scrollController: scrollController,
                        )
                      : ChatStart()),
              SizedBox(
                height: 22,
              ),
              AbsorbPointer(
                absorbing: chatProvider.isAnswerLoading,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTap: () {
                          // if (!isChatVisible) {
                          //   setState(() {
                          //     isChatVisible = true;
                          //   });
                          // }
                          chatProvider.scrollToBottom(scrollController);
                        },
                        controller: chatController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: greenThemeColor,
                                width: 1,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: greenThemeColor,
                                width: 1,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: greenThemeColor,
                                width: 1,
                              )),
                          hintText: "Ask me anything...",
                          hintStyle: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 17,
                              color: Color.fromRGBO(166, 163, 157, 1)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (chatController.text.isNotEmpty) {
                          final connectionStatus =
                              await Connectivity().checkConnectivity();
                          if (connectionStatus == ConnectivityResult.none) {
                            UiHelper().showSnackBar(
                                context, 'Please enable internet connection');
                            return;
                          }
                          if (chatController.text != "") {
                            FocusManager.instance.primaryFocus?.unfocus();
                            chatProvider.addQuestion(chatController.text);
                            String? question = chatController.text;
                            chatController.clear();
                            chatProvider.scrollToBottom(scrollController);
                            await chatProvider.getChatAnswer(question);
                            chatProvider.scrollToBottom(scrollController);
                          }
                          return;
                        }
                        FocusScope.of(context).unfocus();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: greenThemeColor),
                          child: SvgPicture.asset(
                            buttonArrow,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
