import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/db/auth.dart';
import 'package:security_camera_project/core/db/user.dart';
import 'package:security_camera_project/core/extension/extensions.dart';
import 'package:security_camera_project/features/dashboard/dashboard.dart';
import 'package:security_camera_project/features/userDashboard/user_dashboard.dart';

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
                    Center(
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

                              if (isAdmin.value == 0) {
                                try {
                                  Auth().signInWithEmailAndPassword(
                                      email: email.trim(),
                                      password: password.trim());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Dashboard()),
                                  );
                                } catch (e) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: 'Error',
                                    desc:
                                        "nom d'utilisateur ou mot de passe erroné",
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: Colors.red,
                                  ).show();
                                }
                              } else {
                                if (await UserCRUD().isThisUserFound(
                                    email: email, passowrd: password)) {
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UserDashboard()),
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      headerAnimationLoop: false,
                                      title: 'Error',
                                      desc:
                                          "nom d'utilisateur ou mot de passe erroné",
                                      btnOkOnPress: () {},
                                      btnOkIcon: Icons.cancel,
                                      btnOkColor: Colors.red,
                                    ).show();
                                  }
                                }
                              }
                            }
                          },
                          child: const Text(
                            "SE CONNECTER",
                          ),
                        ),
                      ),
                    ),
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
