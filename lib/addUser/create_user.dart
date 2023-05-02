// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:security_camera_project/core/db/bloc/users_bloc.dart';
import 'package:security_camera_project/core/extension/extensions.dart';

class CreateUpdateUser extends HookWidget {
  final Map<String, dynamic>? userToUpdate;

  CreateUpdateUser({
    super.key,
    this.userToUpdate,
  });

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
              userToUpdate == null ? 'Create user' : 'Update user',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600),
            ),
            20.h.bh,
            TextFormField(
              initialValue: userToUpdate?['nom'] ?? '',
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
              initialValue: userToUpdate?['email'] ?? '',
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email,
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
              initialValue: userToUpdate?['password'] ?? '',
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
                userData['password'] = passowrd!;
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
                      BlocProvider.of<UsersBloc>(context)
                          .add(AddUser(newUser: userData));
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
