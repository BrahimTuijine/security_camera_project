import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GasValueChart extends HookWidget {
  GasValueChart({Key? key}) : super(key: key);

  final bool isCardView = true;
  final bool isWebFullView = true;

  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('gasValue');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const CustomAppBar(title: "Gas Value"),
      body: StreamBuilder(
          stream: dbRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('problem found'),
              );
            }
            if (snapshot.hasData) {
              final gasValue = snapshot.data!.snapshot.value;
              return SfRadialGauge(
                enableLoadingAnimation: true,
                key: isWebFullView ? UniqueKey() : null,
                animationDuration: 2500,
                axes: <RadialAxis>[
                  RadialAxis(
                      axisLineStyle: const AxisLineStyle(
                          thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
                      radiusFactor: isWebFullView ? 0.8 : 0.9,
                      showTicks: false,
                      showLastLabel: true,
                      maximum: 200,
                      axisLabelStyle: const GaugeTextStyle(),
                      // Added custom axis renderer that extended from RadialAxisRenderer
                      // onCreateAxisRenderer: handleCreateAxisRenderer,
                      pointers: <GaugePointer>[
                        NeedlePointer(
                            enableAnimation: true,
                            gradient: const LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(203, 126, 223, 0),
                                  Color(0xFFCB7EDF)
                                ],
                                stops: <double>[
                                  0.25,
                                  0.75
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                            animationType: AnimationType.easeOutBack,
                            value: double.parse(gasValue.toString()),
                            animationDuration: 1300,
                            needleStartWidth: isCardView ? 3 : 4,
                            needleEndWidth: isCardView ? 6 : 8,
                            needleLength: 0.8,
                            knobStyle: const KnobStyle(
                              knobRadius: 0,
                            )),
                        RangePointer(
                            value: double.parse(gasValue.toString()),
                            width: 0.15,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: Colors.pink,
                            animationDuration: 1300,
                            animationType: AnimationType.easeOutBack,
                            gradient: const SweepGradient(colors: <Color>[
                              Color(0xFF9E40DC),
                              Color(0xFFE63B86)
                            ], stops: <double>[
                              0.25,
                              0.75
                            ]),
                            enableAnimation: true)
                      ])
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
