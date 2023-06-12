import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/Model/saved_user.dart';
import 'package:security_camera_project/core/db/save_user.dart';
import 'package:security_camera_project/features/dashboard/dashboard.dart';
import 'package:security_camera_project/features/home/home.dart';
import 'package:security_camera_project/features/onboarding/onboarding.dart';
import 'package:security_camera_project/firebase_options.dart';

//! execute when app on background
Future<void> onBackgroundMessage(RemoteMessage message) async {
  print(message.notification?.title.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //! execute when app on background
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: kOrangeColor,
          ),
          primaryColor: kOrangeColor,
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: kOrangeColor),
        ),
        builder: (context, child) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<SavedUser?>(
          future: LocalUser.isUserFromLocalFound(),
          builder: (BuildContext context, AsyncSnapshot<SavedUser?> snapshot) {
            if (snapshot.data == null) {
              return const OnboardingScreen();
            } else {
              if (snapshot.data!.type == 0) {
                return const Dashboard();
              } else {
                return HomePage();
              }
            }
          },
        ),
        // home: const Dashboard(),
      ),
    );
  }
}
