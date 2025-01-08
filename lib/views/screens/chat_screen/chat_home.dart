import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_ai/data/models/model/user_profile_data.dart';
import 'package:helix_ai/util/constants/api_constants.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/health_permission_manager/health_permission_manager.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_provider.dart';
import 'package:helix_ai/util/ui_helper.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_component/chat_start.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_component/user_chat.dart';
import 'package:helix_ai/views/screens/profile_screens/user_profile.dart';
import 'package:helix_ai/views/shared_components/want_text.dart';
import 'package:provider/provider.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';

import '../../../data/controllers/provider_controllers/authentication_provider.dart';
import '../../../data/controllers/provider_controllers/chat_provider.dart';
import '../../../data/data_services/health_data_services.dart';
import '../../../data/models/model/gethealthdata.dart';
import '../../../util/background_services.dart';
import '../../../util/constants/constant.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../auth_screens/profile_screen.dart';

class ChatHome extends StatefulWidget {
  bool userFromLogin;

  ChatHome({super.key, required this.userFromLogin});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> with WidgetsBindingObserver {
  final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];

  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Timer? _fetchHealthDataTimer;
  late Future<void> futureHealthData;
  final sharePreferenceProvider = SharePreferenceProvider();
  HealthDataServices controller = HealthDataServices();
  bool isFetching = false; // Flag to prevent multiple API calls
  int _lastFetchTime = 0; // Store the last fetch time in milliseconds
  bool _isFirstInstall = false; // Flag to check first install

  void getUserData() async {
    String? userUid = await SharePreferenceProvider().retrieveUserInfo().then(
          (value) => value?.id,
        );
    Provider.of<AuthenticationProvider>(context, listen: false)
        .getUserProfileData(
      context,
      userUid ?? '',
    );
  }

  @override
  void initState() {
    super.initState();

    Provider.of<ChatProvider>(context, listen: false).setUserLocationData();
    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      _stateHistoryList.add(WidgetsBinding.instance.lifecycleState!);
    }
    scrollController = ScrollController(onAttach: (position) {
      var chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.scrollToBottom(scrollController);
    });
    Health().configure();

    // Check if it's the first install
    _checkFirstInstall();

    /// Initialize the background service
    checkBackgroundService();
    if (widget.userFromLogin) {
      getUserData();
    }
  }

  // Function to check if the app is being launched for the first time
  Future<void> _checkFirstInstall() async {
    _isFirstInstall =
        await sharePreferenceProvider.retrieveFirstProfileShownStatus() ?? true;
    if (_isFirstInstall) {
      sharePreferenceProvider.storeFirstProfileShownStatus(false);
    } else {
      _loadLastFetchTime();
    }
  }

  // Function to load the last fetch time from SharedPreferences
  Future<void> _loadLastFetchTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastFetchTime =
        prefs.getInt('lastFetchTime') ?? 0; // Default to 0 if not set
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Check the app lifecycle state

    if (state == AppLifecycleState.resumed) {
      FlutterBackgroundService().invoke("setAsForeground");
      if (mounted) {
        Provider.of<ChatProvider>(context, listen: false).setUserLocationData();
      }
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
          "Gene",
          style: TextStyle(
              fontSize: width * 0.038,
              fontWeight: FontWeight.w400,
              color: Color(0xff262522),
              fontFamily: 'Ubuntu'),
        ),
        leading: SvgPicture.asset(
          appLogo,
          fit: BoxFit.none,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: height * 0.025),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: SvgPicture.asset(userCircle),
            ),
          )
        ],
      ),
      body: Consumer<ChatProvider>(builder: (_, chatProvider, __) {
        return Padding(
          padding: EdgeInsets.only(
              left: height * 0.022,
              right: height * 0.022,
              bottom: height * 0.04,
              top: height * 0.02),
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
                height: height * 0.018,
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
                          contentPadding: EdgeInsets.fromLTRB(height * 0.02,
                              height * 0.016, height * 0.02, height * 0.016),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(width * 0.030),
                              borderSide: BorderSide(
                                color: greenBorderColor,
                                width: 1,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(width * 0.030),
                              borderSide: BorderSide(
                                color: greenBorderColor,
                                width: 1,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(width * 0.030),
                              borderSide: BorderSide(
                                color: greenBorderColor,
                                width: 1,
                              )),
                          hintText: "Ask me anything...",
                          hintStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: width * 0.035,
                              color: Color(0xff767676)),
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
                          String? userUid = await sharePreferenceProvider
                              .retrieveUserInfo()
                              .then(
                                (value) => value?.id,
                              );
                          DateTime now = DateTime.now();
                          String today = DateFormat('yyyy-MM-dd').format(now);

                          gethealthdataRequest request = gethealthdataRequest(
                            id: userUid ?? "",
                            items: ["STEPS", "ACTIVE_ENERGY_BURNED"],
                            startDate: today,
                            endDate: today,
                          );

                          /*futureHealthData = controller.fetchHealthDataForGraph(
                              request, context);
                          futureHealthData.then((response) {
                            print("Get Health Data Response");
                          });*/
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: height * 0.01),
                        child: Container(
                          height: height * 0.065,
                          width: height * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: greenBorderColor),
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

  Future<void> checkBackgroundService() async {
    UserProfileData? user = await sharePreferenceProvider.retrieveUserInfo();
    String? userUid = user?.id;

    /// Call and post health data when app is opened
    HealthPermissionManager().fetchHealthData(userUid ?? "");
    final service = FlutterBackgroundService();

    var isRunning = await service.isRunning();
    if (!isRunning) {
      await initializeService();
    }
    service.invoke('dataReceived', {'uid': userUid});
  }
}
