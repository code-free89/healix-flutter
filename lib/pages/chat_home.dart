// ignore_for_file: prefer_const_constructors
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/HealthPermissionManager/HealthPermissionManager.dart';
import 'package:helix_ai/chat_component/chat_start.dart';
import 'package:helix_ai/chat_component/user_chat.dart';
import 'package:helix_ai/constants/colors.dart';
import 'package:helix_ai/images_path.dart';
import 'package:helix_ai/pages/user_profile.dart';
import 'package:helix_ai/provider/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:health/health.dart';

import '../util/ui_helper.dart';

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_DELETED,
  DATA_NOT_ADDED,
  DATA_NOT_DELETED,
  STEPS_READY,
  HEALTH_CONNECT_STATUS,
  PERMISSIONS_REVOKING,
  PERMISSIONS_REVOKED,
  PERMISSIONS_NOT_REVOKED,
}

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool _shouldAutoscroll = false;
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 0;

  // All types available depending on platform (iOS ot Android).
  // List<HealthDataType> get types => (Platform.isAndroid)
  //     ? dataTypesAndroid
  //     : (Platform.isIOS)
  //         ? dataTypesIOS
  //         : [];

  // // Or specify specific types
  static final types = [
    HealthDataType.WEIGHT,
    HealthDataType.STEPS,
    HealthDataType.HEIGHT,
    HealthDataType.WORKOUT,
    HealthDataType.WORKOUT,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.HEART_RATE,
    HealthDataType.BODY_MASS_INDEX

    // Uncomment this line on iOS - only available on iOS
    // HealthDataType.AUDIOGRAM
  ];
  // Or both READ and WRITE
  List<HealthDataAccess> get permissions => types
      .map((type) =>
          // can only request READ permissions to the following list of types on iOS
          [
            HealthDataType.WALKING_HEART_RATE,
            HealthDataType.ELECTROCARDIOGRAM,
            HealthDataType.HIGH_HEART_RATE_EVENT,
            HealthDataType.LOW_HEART_RATE_EVENT,
            HealthDataType.IRREGULAR_HEART_RATE_EVENT,
            HealthDataType.EXERCISE_TIME,
          ].contains(type)
              ? HealthDataAccess.READ
              : HealthDataAccess.READ_WRITE)
      .toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController(onAttach: (position) {
      var chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.scrollToBottom(scrollController);
    });
    Health().configure();
    // Authorize health permission and fetch data using the singleton
    HealthPermissionManager().authorizeHealthPermission().then((authorized) {
      if (authorized) {
        HealthPermissionManager().fetchHealthData();
      }
    });
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
