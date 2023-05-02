import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:security_camera_project/core/db/bloc/users_bloc.dart';
import 'package:security_camera_project/dashboard/dashboard.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => BlocProvider(
        create: (context) => UsersBloc(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Dashboard(),
        ),
      ),
    );
  }
}
