import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/db/auth.dart';
import 'package:security_camera_project/core/widget/button.dart';
import 'package:security_camera_project/core/widget/default_btn.dart';
import 'package:security_camera_project/features/auth/login_page.dart';
import 'package:security_camera_project/features/sensorsList/gas_sensor.dart';
import 'package:security_camera_project/features/sensorsList/mq7.dart';

class HomePage extends HookWidget {
  void navigateToChart(int currentIndex, BuildContext context) {
    switch (currentIndex) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GaugeTemperatureMonitorExample(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GasValueChart(),
          ),
        );
        break;
      default:
        print("nothing for now");
    }
  }

  const HomePage({Key? key}) : super(key: key);

  

  

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      FirebaseMessaging.instance.getToken().then((value) {
        print('*' * 100);
        print("token $value");
      }).catchError((error) {
        print(error);
      });
      //! execute when app opened
      FirebaseMessaging.onMessage.listen((message) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: message.notification!.title,
          desc: message.notification!.body,
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: kOrangeColor,
        ).show();
      });

     

      //! execute when app is terminated
      FirebaseMessaging.onMessageOpenedApp.listen((event) {});

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
                  onTap: () {
                    selectedIndex.value = 0;
                  },
                  selected: selectedIndex.value == 0,
                  size: size,
                  title: 'Temperature',
                  icon: Icons.ac_unit,
                ),
                ControllButton(
                  onTap: () {
                    selectedIndex.value = 1;
                  },
                  selected: selectedIndex.value == 1,
                  size: size,
                  title: 'humidity',
                  icon: Icons.grain,
                ),
                ControllButton(
                  onTap: () {
                    selectedIndex.value = 2;
                  },
                  selected: selectedIndex.value == 2,
                  size: size,
                  title: 'Gas Value',
                  icon: Icons.gas_meter_outlined,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ControllButton(
                  onTap: () {
                    selectedIndex.value = 3;
                  },
                  selected: selectedIndex.value == 3,
                  size: size,
                  title: 'MQ7',
                  icon: Icons.gas_meter,
                ),
                ControllButton(
                  onTap: () {
                    selectedIndex.value = 4;
                  },
                  selected: selectedIndex.value == 4,
                  size: size,
                  title: 'Capteur Flamme ',
                  icon: Icons.grass,
                ),
                ControllButton(
                  onTap: () {
                    selectedIndex.value = 5;
                  },
                  selected: selectedIndex.value == 5,
                  size: size,
                  title: 'Camera Access',
                  icon: Icons.camera,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            DefaultButton(
              onTap: () {
                navigateToChart(selectedIndex.value, context);
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
