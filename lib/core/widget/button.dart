import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';

class ControllButton extends HookWidget {
  ControllButton({
    Key? key,
    required this.onTap,
    required this.selected,
    required this.size,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final String title;
  void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: size.height * 0.105,
            width: size.width * 0.21,
            decoration: BoxDecoration(
              color: selected ? kOrangeColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: selected
                      ? kOrangeColor.withOpacity(0.5)
                      : Colors.grey.shade200,
                  blurRadius: 30,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: selected ? Colors.white : kDarkGreyColor.withOpacity(0.6),
              size: 45,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.005),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kDarkGreyColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
