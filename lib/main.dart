import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/features/dashboard/dashboard.dart';
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
          primaryColor: kOrangeColor,
        ),
        builder: (context, child) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child,
        ),
        debugShowCheckedModeBanner: false,
        // home: const OnboardingScreen(),
        home: const Dashboard(),
      ),
    );
  }
}
