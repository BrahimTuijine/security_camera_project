import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/db/user.dart';
import 'package:security_camera_project/core/extension/extensions.dart';

class CreateUser extends HookWidget {
  CreateUser({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final Map<String, String> userData = {
    'nom': '',
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create user',
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
                hintText: 'Nom',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none),
                fillColor: Colors.blue.withOpacity(.3),
                filled: true,
              ),
              validator: (value) {
                return null;
              },
              onSaved: (nom) {
                userData['nom'] = nom!;
              },
            ),
            15.h.bh,
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
              validator: (value) {
                return null;
              },
              onSaved: (email) {
                userData['email'] = email!;
              },
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
              validator: (value) {
                return null;
              },
              onSaved: (passowrd) {
                userData['passowrd'] = passowrd!;
              },
            ),
            15.h.bh,
            Center(
              child: SizedBox(
                height: 50.h,
                width: 220.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      await UserCRUD.addUser(userData: userData);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "ENREGISTRER",
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
