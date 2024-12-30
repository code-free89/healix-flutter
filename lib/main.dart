import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health/health.dart';

import 'package:helix_ai/firebase_options.dart';
import 'package:helix_ai/util/constants/images_path.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/util/constants/string_constants.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_provider.dart';
import 'package:helix_ai/views/screens/chat_screen/chat_home.dart';
import 'package:helix_ai/views/screens/profile_screens/first_profile.dart';
import 'package:helix_ai/views/screens/splash_screen/splash_screen.dart';
import 'package:helix_ai/views/screens/auth_screens/user_forgot_password.dart';
import 'package:helix_ai/views/screens/auth_screens/user_login.dart';
import 'package:helix_ai/views/screens/profile_screens/user_profile.dart';
import 'package:helix_ai/views/screens/auth_screens/user_signup.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'data/controllers/provider_controllers/authentication_provider.dart';
import 'data/controllers/provider_controllers/chat_provider.dart';
import 'data/controllers/provider_controllers/user_info_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharePreferenceProvider().initSecureStorage();
  // await dotenv.load(fileName: ".env");
  await preCacheInitialAssets();
  Health().configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider.instance(),
        ),
        ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
        ChangeNotifierProvider<UserInfoProvider>(
            create: (_) => UserInfoProvider())
        // Add other providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          // textTheme: GoogleFonts.ubuntu(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
            color: whiteColor,
            scrolledUnderElevation: 0.0,
            elevation: 0,
          ),
          scaffoldBackgroundColor: whiteColor,
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSeed(seedColor: greenThemeColor),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

preCacheInitialAssets() async {
  await Future.wait([preCachePicture(lifeStyleImage)]);
}

Future preCachePicture(String path) async {
  final loader = SvgAssetLoader(path);
  await svg.cache
      .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
}
