import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/button.dart';
import 'package:security_camera_project/core/widget/default_btn.dart';
import 'package:security_camera_project/features/addUser/user_list.dart';
import 'package:security_camera_project/features/home/home.dart';

class Dashboard extends HookWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Center(
      child: Text(
        'Camera',
        style: optionStyle,
      ),
    ),
    AddUser()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final selectedIndex = useState<int>(0);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: size.height * 0.1),
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
              press: () {},
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
