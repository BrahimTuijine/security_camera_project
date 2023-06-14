import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/Model/saved_user.dart';
import 'package:security_camera_project/core/db/auth.dart';
import 'package:security_camera_project/core/db/save_user.dart';
import 'package:security_camera_project/core/db/user.dart';
import 'package:security_camera_project/core/extension/extensions.dart';
import 'package:security_camera_project/features/dashboard/dashboard.dart';
import 'package:security_camera_project/features/home/home.dart';

class LoginPage extends HookWidget {
  LoginPage({Key? key}) : super(key: key);

  static final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final isAdmin = useState<int>(0);
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                height: 140.h,
                color: kOrangeColor,
              ),
            ),
            // 40.h.bh,
            // Image.asset('assets/images/camera.jpg'),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Column(
                  children: [
                    60.h.bh,
                    Text(
                      'CONNECTION',
                      style: TextStyle(
                          color: kBlueColor,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    20.h.bh,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ne doit pas être vide';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        email = newValue!;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.supervisor_account_sharp,
                          color: kOrangeColor,
                        ),
                        hintText: 'E-mail',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none),
                        fillColor: kOrangeColor.withOpacity(.3),
                        filled: true,
                      ),
                    ),
                    15.h.bh,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ne doit pas être vide';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue!;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: kOrangeColor,
                        ),
                        hintText: 'Mot de passe',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none),
                        fillColor: kOrangeColor.withOpacity(.3),
                        filled: true,
                      ),
                    ),
                    15.h.bh,
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          // width: MediaQuery.of(context).size.width / 2.56,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('admin'),
                            leading: Radio<int>(
                              activeColor: kOrangeColor,
                              value: 0,
                              groupValue: isAdmin.value,
                              onChanged: (int? value) {
                                isAdmin.value = 0;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          // width: MediaQuery.of(context).size.width / 2,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('utilisateur'),
                            leading: Radio<int>(
                              activeColor: kOrangeColor,
                              value: 1,
                              groupValue: isAdmin.value,
                              onChanged: (int? value) {
                                isAdmin.value = 1;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    15.h.bh,
                    HookBuilder(builder: (context) {
                      final isLoading = useState<bool>(false);
                      return isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kOrangeColor,
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                height: 50.h,
                                width: 220.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kOrangeColor,
                                      shape: const StadiumBorder()),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();

                                      isLoading.value = true;

                                      if (isAdmin.value == 0) {
                                        final auth =
                                            await Auth.signInWithEmailAndPass(
                                                email: email.trim(),
                                                password: password.trim());

                                        if (auth == null) {
                                          if (context.mounted) {
                                            isLoading.value = false;
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              headerAnimationLoop: false,
                                              title: 'Error',
                                              desc:
                                                  "email d'admin ou mot de passe erroné",
                                              btnOkOnPress: () {},
                                              btnOkIcon: Icons.cancel,
                                              btnOkColor: Colors.red,
                                            ).show();
                                          }
                                        } else {
                                          //! save user data
                                          await LocalUser.saveUserInLoacal(
                                              SavedUser.fromJson({
                                            "email": email.trim(),
                                            "password": password.trim(),
                                            "type": isAdmin.value
                                          }));
                                          if (context.mounted) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Dashboard()),
                                            );
                                          }
                                        }
                                      } else {
                                        if (await UserCRUD().isThisUserFound(
                                            email: email.trim(),
                                            passowrd: password.trim())) {
                                          //! save user data
                                          await LocalUser.saveUserInLoacal(
                                              SavedUser.fromJson({
                                            "email": email.trim(),
                                            "password": password.trim(),
                                            "type": isAdmin.value
                                          }));
                                          // if (context.mounted) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                          );
                                          // }
                                        } else {
                                          // if (context.mounted) {
                                          isLoading.value = false;
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.rightSlide,
                                            headerAnimationLoop: false,
                                            title: 'Error',
                                            desc:
                                                "email d'utilisateur ou mot de passe erroné",
                                            btnOkOnPress: () {},
                                            btnOkIcon: Icons.cancel,
                                            btnOkColor: Colors.red,
                                          ).show();
                                          // }
                                        }
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "SE CONNECTER",
                                  ),
                                ),
                              ),
                            );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
