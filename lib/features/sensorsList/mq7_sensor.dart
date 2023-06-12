import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MQ7Sensor extends HookWidget {
  final bool isCardView = true;
  final bool isWebFullView = true;

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('mq7');

  MQ7Sensor({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const CustomAppBar(title: "MQ7 Sensor"),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('problem found'),
            );
          }
          if (snapshot.hasData) {
            final mq7Sensor = snapshot.data!.snapshot.value;
            return SfRadialGauge(
              animationDuration: 3500,
              enableLoadingAnimation: true,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 500,
                  interval: isCardView ? 20 : 10,
                  minorTicksPerInterval: 9,
                  showAxisLine: false,
                  radiusFactor: isWebFullView ? 0.8 : 0.9,
                  labelOffset: 8,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 0,
                        startWidth: 0.265,
                        sizeUnit: GaugeSizeUnit.factor,
                        endWidth: 0.265,
                        color: const Color.fromRGBO(34, 144, 199, 0.75)),
                    GaugeRange(
                        startValue: 0,
                        endValue: 100,
                        startWidth: 0.265,
                        sizeUnit: GaugeSizeUnit.factor,
                        endWidth: 0.265,
                        color: const Color.fromRGBO(34, 195, 199, 0.75)),
                    GaugeRange(
                        startValue: 100,
                        endValue: 200,
                        startWidth: 0.265,
                        sizeUnit: GaugeSizeUnit.factor,
                        endWidth: 0.265,
                        color: const Color.fromRGBO(123, 199, 34, 0.75)),
                    GaugeRange(
                        startValue: 200,
                        endValue: 300,
                        startWidth: 0.265,
                        sizeUnit: GaugeSizeUnit.factor,
                        endWidth: 0.265,
                        color: const Color.fromRGBO(238, 193, 34, 0.75)),
                    GaugeRange(
                        startValue: 300,
                        endValue: 500,
                        startWidth: 0.265,
                        sizeUnit: GaugeSizeUnit.factor,
                        endWidth: 0.265,
                        color: const Color.fromRGBO(238, 79, 34, 0.65)),
                  ],
                  annotations: <GaugeAnnotation>[
                    const GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.35,
                      widget: Text(
                        '',
                        style:
                            TextStyle(color: Color(0xFFF8B195), fontSize: 16),
                      ),
                    ),
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.8,
                      widget: Text(
                        mq7Sensor.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: double.parse(mq7Sensor.toString()),
                      needleStartWidth: isCardView ? 0 : 1,
                      needleEndWidth: isCardView ? 5 : 8,
                      animationType: AnimationType.easeOutBack,
                      enableAnimation: true,
                      animationDuration: 1200,
                      knobStyle: KnobStyle(
                          knobRadius: isCardView ? 0.06 : 0.09,
                          borderColor: const Color(0xFFF8B195),
                          color: Colors.white,
                          borderWidth: isCardView ? 0.035 : 0.05),
                      tailStyle: TailStyle(
                          color: const Color(0xFFF8B195),
                          width: isCardView ? 4 : 8,
                          length: isCardView ? 0.15 : 0.2),
                      needleColor: const Color(0xFFF8B195),
                    )
                  ],
                  axisLabelStyle:
                      GaugeTextStyle(fontSize: isCardView ? 10 : 12),
                  majorTickStyle: const MajorTickStyle(
                      length: 0.25, lengthUnit: GaugeSizeUnit.factor),
                  minorTickStyle: const MinorTickStyle(
                      length: 0.13,
                      lengthUnit: GaugeSizeUnit.factor,
                      thickness: 1),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
