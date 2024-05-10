import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helix_ai/constants/string_constants.dart';
import 'package:helix_ai/firebase_options.dart';
import 'package:helix_ai/pages/chat_home.dart';
import 'package:helix_ai/pages/first_profile.dart';
import 'package:helix_ai/pages/splash_screen.dart';
import 'package:helix_ai/pages/user_login.dart';
import 'package:helix_ai/pages/user_profile.dart';
import 'package:helix_ai/pages/user_signup.dart';
import 'package:helix_ai/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider.instance(),
        ),
        // Add other providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          // textTheme: GoogleFonts.ubuntu(Theme.of(context).textTheme),
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
        routes: {
          '/login': (context) => UserLogin(),
          '/sign_up': (context) => UserSignUp(),
          '/first_profile': (context) => FirstProfile(),
          '/chat_home': (context) => ChatHome(),
          '/user_profile': (context) => UserProfile(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthenticationProvider.instance(),
        child: Consumer<AuthenticationProvider>(builder: (context, authProvider, child) {
          switch (authProvider.status) {
            case Status.Uninitialized:
              return SplashScreen();
            case Status.Unauthenticated:
              return UserLogin();
            // case Status.Authenticating:
            //   return UserLogin();
            case Status.Authenticated:
              return ChatHome();
            case Status.FirstTimeAuthenticated:
              return FirstProfile();
          }
        })
    );
  }
}
