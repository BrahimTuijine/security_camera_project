import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/extension/extensions.dart';

class LoginPage extends HookWidget {
  LoginPage({Key? key}) : super(key: key);

  final GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CONNECTION',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600),
            ),
            20.h.bh,
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.supervisor_account_sharp,
                  color: Colors.blue,
                ),
                hintText: 'E-mail',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none),
                fillColor: Colors.blue.withOpacity(.3),
                filled: true,
              ),
            ),
            15.h.bh,
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Colors.blue,
                ),
                hintText: 'Mot de passe',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none),
                fillColor: Colors.blue.withOpacity(.3),
                filled: true,
              ),
            ),
            15.h.bh,
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('admin'),
                    leading: Radio<int>(
                      value: 1,
                      groupValue: 1,
                      onChanged: (int? value) {},
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('utilisateur'),
                    leading: Radio<int>(
                      value: 1,
                      groupValue: 1,
                      onChanged: (int? value) {},
                    ),
                  ),
                ),
              ],
            ),
            15.h.bh,
            Center(
              child: SizedBox(
                height: 50,
                width: 220.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {},
                  child: const Text(
                    "SE CONNECTER",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
