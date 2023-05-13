// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/db/user.dart';

import 'package:security_camera_project/core/extension/extensions.dart';

class CreateUpdateUser extends HookWidget {
  final String? userToUpdate;
  final String? docId;

  CreateUpdateUser({
    super.key,
    this.userToUpdate,
    this.docId,
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
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: Container(
            margin: EdgeInsets.only(left: 20.w),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 40.h.bh,
                  Center(
                    child: SizedBox(
                      height: 200.h,
                      width: 200.w,
                      child: Image.asset('assets/images/user.png'),
                    ),
                  ),
                  Text(
                    userToUpdate == null ? 'Create user' : 'Update user',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  20.h.bh,
                  TextFormField(
                    initialValue: userToUpdate == null
                        ? ''
                        : json.decode(userToUpdate!)['nom'],
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
                    initialValue: userToUpdate == null
                        ? ''
                        : json.decode(userToUpdate!)['email'],
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
                    initialValue: userToUpdate == null
                        ? ''
                        : json.decode(userToUpdate!)['password'],
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
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (userToUpdate == null) {
                             UserCRUD().addUser(userData);
                            } else {
                              UserCRUD().updateUser(docId: docId!, newUser : userData);
                              // BlocProvider.of<UsersBloc>(context).add(
                              //     UpdateUser(
                              //         updatedUser: userData, index: index!));
                            }
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              headerAnimationLoop: false,
                              dialogType: DialogType.success,
                              showCloseIcon: true,
                              title: 'Succes',
                              desc: '',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkIcon: Icons.check_circle,
                              onDismissCallback: (type) {
                                debugPrint(
                                    'Dialog Dissmiss from callback $type');
                              },
                            ).show();
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
          ),
        ));
  }
}
