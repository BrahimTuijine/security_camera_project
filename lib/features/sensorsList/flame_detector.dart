import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';

class FlameDetector extends HookWidget {
  const FlameDetector({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('capteur_flamme');
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const CustomAppBar(title: "Flame Sensor"),
      body: StreamBuilder(
          stream: dbRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('problem found'),
              );
            }
            if (snapshot.hasData) {
              final flameValue = snapshot.data!.snapshot.value as bool;
              return flameValue
                  ? Center(
                      child: Lottie.asset(
                      height: MediaQuery.of(context).size.height * .7,
                      fit: BoxFit.fill,
                      'assets/images/flame.json',
                      reverse: true,
                    ))
                  : Image.asset('assets/images/fire.png');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
