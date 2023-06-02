import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_camera_project/core/extension/extensions.dart';
import 'package:security_camera_project/features/sensorsList/humidity_sensor.dart';

class SensorsList extends HookWidget {
  const SensorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('liste des capteurs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HumiditySensor()),
                );
              },
              child: const Text(
                "MQ7",
              ),
            ),
            20.h.bh,
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "MQ2",
              ),
            ),
            20.h.bh,
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "DHT11",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
