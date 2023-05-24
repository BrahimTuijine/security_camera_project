import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/db/auth.dart';
import 'package:security_camera_project/core/extension/extensions.dart';
import 'package:security_camera_project/features/auth/login_page.dart';
import 'package:security_camera_project/features/sensorsList/sensors_list.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await Auth().signOut();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              } catch (e) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  headerAnimationLoop: false,
                  title: 'Error',
                  desc: "Veuillez réessayer plus tard",
                  btnOkOnPress: () {},
                  btnOkIcon: Icons.cancel,
                  btnOkColor: Colors.red,
                ).show();
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SensorsList()),
                );
              },
              child: const Text(
                "afficher liste des capteurs",
              ),
            ),
            20.h.bh,
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Gestion des capteurs",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
