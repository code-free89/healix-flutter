import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/Controller/HealthDataController.dart';
import 'package:helix_ai/HealthPermissionManager/HealthPermissionManager.dart';
import 'package:helix_ai/chat_component/chat_start.dart';
import 'package:helix_ai/chat_component/user_chat.dart';
import 'package:helix_ai/constants/colors.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/model/gethealthdata.dart';
import 'package:helix_ai/pages/user_profile.dart';
import 'package:helix_ai/provider/chat_provider.dart';
import 'package:helix_ai/shared_preferences/share_preference_provider.dart';
import 'package:provider/provider.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';

import '../util/ui_helper.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Timer? _fetchHealthDataTimer;
  late Future<void> futureHealthData;
  final sharePreferenceProvider = SharePreferenceProvider();
  HealthDataController controller = HealthDataController();
  bool isFetching = false; // Flag to prevent multiple API calls

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(onAttach: (position) {
      var chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.scrollToBottom(scrollController);
    });
    Health().configure();

    // Initial call to authorize health permission and fetch data
    _fetchHealthData();

    // Set up the periodic timer to call the fetch function every 4 hours
    _fetchHealthDataTimer = Timer.periodic(Duration(hours: 1), (Timer timer) {
      _fetchHealthData();
    });
  }

  // Function to authorize and fetch health data
  void _fetchHealthData() async {
    bool authorized =
        await HealthPermissionManager().authorizeHealthPermission(context);
    if (authorized) {
      await HealthPermissionManager().fetchHealthData(context);
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _fetchHealthDataTimer?.cancel();
    scrollController.dispose();
    chatController.dispose();
    super.dispose();
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
              child: SvgPicture.asset(userCircle),
            ),
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
                absorbing: chatProvider.isAnswerLoading || isFetching,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTap: () {
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
                        if (chatController.text.isNotEmpty && !isFetching) {
                          final connectionStatus =
                              await Connectivity().checkConnectivity();
                          if (connectionStatus == ConnectivityResult.none) {
                            UiHelper().showSnackBar(
                                context, 'Please enable internet connection');
                            return;
                          }

                          String question = chatController.text;
                          FocusManager.instance.primaryFocus?.unfocus();

                          // Add question to chat provider
                          chatProvider.getChatAnswer(question, context);
                          chatController.clear();
                          chatProvider.scrollToBottom(scrollController);

                          // Set the fetching flag
                          isFetching = true;

                          // Fetch GPT answer for the question
                          await chatProvider.getChatAnswer(question, context);
                          chatProvider.scrollToBottom(scrollController);

                          // Reset the fetching flag after API call
                          isFetching = false;

                          // Fetch Health Data
                          String? userUid =
                              await sharePreferenceProvider.retrieveUserUid();
                          DateTime now = DateTime.now();
                          String today = DateFormat('yyyy-MM-dd').format(now);

                          gethealthdataRequest request = gethealthdataRequest(
                            id: userUid ?? "",
                            items: ["STEPS", "ACTIVE_ENERGY_BURNED"],
                            startDate: today,
                            endDate: today,
                          );

                          futureHealthData = controller.fetchHealthDataForGraph(
                              request, context);
                          futureHealthData.then((response) {
                            print("Get Health Data Response");
                          });
                        }
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
