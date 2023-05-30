import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/db/auth.dart';
import 'package:security_camera_project/core/widget/button.dart';
import 'package:security_camera_project/core/widget/default_btn.dart';
import 'package:security_camera_project/features/auth/login_page.dart';
import 'package:security_camera_project/features/sensorsList/mq7.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      FirebaseMessaging.instance.getToken().then((value) {
        print(value);
      }).catchError((error) {
        print(error);
      });
      return null;
    }, const []);
    Size size = MediaQuery.of(context).size;

    final selectedIndex = useState<int>(0);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(height: size.height * 0.1),
            const Center(
              child: Text(
                'What do you think you\'ll\nmostly use?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            const Center(
              child: Text(
                'Tap on all that apply.This will help us\ncustomize your home page.',
                textAlign: TextAlign.center,
                style: TextStyle(color: kDarkGreyColor, fontSize: 18),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ControllButton(
                  size: size,
                  title: 'Maintenance\nRequests',
                  icon: Icons.settings_outlined,
                ),
                ControllButton(
                  size: size,
                  title: 'Integrations\n ',
                  icon: Icons.grain,
                ),
                ControllButton(
                  size: size,
                  title: 'Light\nControl',
                  icon: Icons.highlight,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ControllButton(
                  size: size,
                  title: 'Leak\nDetector',
                  icon: Icons.opacity,
                ),
                ControllButton(
                  size: size,
                  title: 'Temperature\nControl ',
                  icon: Icons.ac_unit,
                ),
                ControllButton(
                  size: size,
                  title: 'Guest\nAccess',
                  icon: Icons.vpn_key,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            DefaultButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GaugeTemperatureMonitorExample()),
                );
              },
              size: size,
              title: "Next",
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
