import 'package:flutter/material.dart';
import 'package:security_camera_project/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: kBlueColor,
      ),
      backgroundColor: kBgColor,
      title: Text(
        title,
        style: const TextStyle(
          color: kOrangeColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
