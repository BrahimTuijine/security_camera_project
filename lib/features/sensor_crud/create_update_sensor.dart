import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/Model/sensors_model.dart';
import 'package:security_camera_project/core/db/sensors.dart';

import 'package:security_camera_project/core/extension/extensions.dart';

class CreateUpdateSensor extends HookWidget {
  final SensorModel? sensorToUpdate;

  CreateUpdateSensor({
    super.key,
    this.sensorToUpdate,
  });

  final formKey = GlobalKey<FormState>();

  final Map<String, String> sensorData = {
    "sensorType": "",
    "location": "",
    "isConnected": "",
    "sustainability": "",
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
        body: Padding(
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
                    child: Image.asset('assets/images/sensor.png'),
                  ),
                ),
                Text(
                  sensorToUpdate == null ? 'Create sensor' : 'Update sensor',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600),
                ),
                20.h.bh,
                TextFormField(
                  initialValue:
                      sensorToUpdate == null ? '' : sensorToUpdate!.sensorType,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.supervisor_account_sharp,
                      color: Colors.blue,
                    ),
                    hintText: 'Type de capteur',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none),
                    fillColor: Colors.blue.withOpacity(.3),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ne doit pas être vide';
                    }
                    return null;
                  },
                  onSaved: (sensorType) {
                    sensorData['sensorType'] = sensorType!;
                  },
                ),
                15.h.bh,
                TextFormField(
                  initialValue:
                      sensorToUpdate == null ? '' : sensorToUpdate!.location,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    hintText: 'Location',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none),
                    fillColor: Colors.blue.withOpacity(.3),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ne doit pas être vide';
                    }
                    return null;
                  },
                  onSaved: (refrences) {
                    sensorData['location'] = refrences!;
                  },
                ),
                15.h.bh,
                TextFormField(
                  initialValue:
                      sensorToUpdate == null ? '' : sensorToUpdate!.isConnected,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.blue,
                    ),
                    hintText: 'isConnected',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none),
                    fillColor: Colors.blue.withOpacity(.3),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ne doit pas être vide';
                    } else if (!['true', 'false', 'oui', 'non']
                        .contains(value.trim())) {
                      return "devrait être true ou false , oui ou non";
                    }
                    return null;
                  },
                  onSaved: (sustainability) {
                    sensorData['isConnected'] = sustainability!;
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
                          if (sensorToUpdate == null) {
                            SensorsCRUD().addSensor(sensorData);
                          } else {
                            SensorsCRUD().updateSensor(
                                docId: sensorToUpdate!.id!, sensor: sensorData);
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
                              debugPrint('Dialog Dissmiss from callback $type');
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
        ));
  }
}
