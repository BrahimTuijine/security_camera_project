import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/features/auth/login_page.dart';
import 'package:security_camera_project/core/db/bloc/users_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => BlocProvider(
        create: (context) => UsersBloc(),
        child: MaterialApp(
          builder: (context, child) => GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child,
          ),
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        ),
      ),
    );
  }
}
