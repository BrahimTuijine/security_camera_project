import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/features/addUser/user_list.dart';
import 'package:security_camera_project/features/home/home.dart';
import 'package:security_camera_project/features/sensor_crud/sensors_list.dart';

class Dashboard extends HookWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
     HomePage(),
    const SensorList(),
    AddUser()
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _widgetOptions.elementAt(selectedIndex.value),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: GNav(
                gap: 8,
                activeColor: kDarkGreyColor,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: kOrangeColor.withOpacity(0.5),
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.sensors_sharp,
                    text: 'Sensors',
                  ),
                  GButton(
                    icon: LineIcons.userPlus,
                    text: 'Users',
                  ),
                ],
                selectedIndex: selectedIndex.value,
                onTabChange: (index) {
                  selectedIndex.value = index;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
