import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/db/auth.dart';
import 'package:security_camera_project/core/db/save_user.dart';
import 'package:security_camera_project/core/widget/button.dart';
import 'package:security_camera_project/core/widget/default_btn.dart';
import 'package:security_camera_project/features/auth/login_page.dart';
import 'package:security_camera_project/features/notification/notification_screen.dart';
import 'package:security_camera_project/features/sensorsList/flame_detector.dart';
import 'package:security_camera_project/features/sensorsList/gas_sensor.dart';
import 'package:security_camera_project/features/sensorsList/humidity_sensor.dart';
import 'package:security_camera_project/features/sensorsList/mq7_sensor.dart';
import 'package:security_camera_project/features/sensorsList/temperature.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends HookWidget {
  HomePage({super.key});

  void navigateToChart(int currentIndex, BuildContext context) {
    switch (currentIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Temperature(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HumiditySensor(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GasValueChart(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MQ7Sensor(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FlameDetector(),
          ),
        );
        break;
      // case 5:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Camera(),
      //     ),
      //   );
      //   break;
      default:
        print("nothing for now");
    }
  }

  final formKey = GlobalKey<FormState>();

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
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          },
          icon: const Icon(
            Icons.notifications_on,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final localUser = await LocalUser.isUserFromLocalFound();
              if (localUser!.type == 0) {
                await Auth().signOut();
              }
              await LocalUser.deleteUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
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
            SizedBox(height: size.height * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  title: 'Camera',
                  icon: Icons.camera,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            DefaultButton(
              onTap: () async {
                if (selectedIndex.value == 5) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        String ip = '';
                        return Form(
                          key: formKey,
                          child: AlertDialog(
                            title: const Text('Camera Ip'),
                            content: TextFormField(
                              onSaved: (newValue) {
                                ip = newValue!;
                              },
                              validator: (value) {
                                if (value!.length < 5) {
                                  return 'Ip incorrect';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    final Uri url = Uri.parse('http://$ip');
                                    if (!await launchUrl(url,
                                        mode: LaunchMode.externalApplication)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  }
                                },
                                child: const Text(
                                  "launch",
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  navigateToChart(selectedIndex.value, context);
                }

                // Methods.openURL('http://172.20.10.3');
                // const String url = '192.168.1.112:80';
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
