/// Flutter package imports
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';

/// Gauge imports

import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Locals imports

/// Renders the gauge temperature monitor sample.
class HumiditySensor extends HookWidget {
  const HumiditySensor({super.key});

  /// Creates the gauge temperature monitor sample.

  @override
  Widget build(BuildContext context) {
    // change axis interval based on orientation for the UI that looks good.
    final double interval =
        MediaQuery.of(context).orientation == Orientation.portrait ? 10 : 20;

    final isCardView = useState<bool>(false);
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('dht11');

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const CustomAppBar(title: "humidity"),
      body: StreamBuilder(
          stream: dbRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              final data = snapshot.data!.snapshot.value as Map;

              print(data);

              return SfRadialGauge(
                animationDuration: 3500,
                enableLoadingAnimation: true,
                axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      interval: interval,
                      minorTicksPerInterval: 9,
                      showAxisLine: false,
                      radiusFactor: 0.9,
                      labelOffset: 8,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 25,
                          startWidth: 0.265,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.265,
                          color: const Color.fromRGBO(34, 144, 199, 0.75),
                        ),
                        GaugeRange(
                            startValue: 25,
                            endValue: 50,
                            startWidth: 0.265,
                            sizeUnit: GaugeSizeUnit.factor,
                            endWidth: 0.265,
                            color: const Color.fromRGBO(34, 144, 199, 0.75)),
                        GaugeRange(
                            startValue: 50,
                            endValue: 75,
                            startWidth: 0.265,
                            sizeUnit: GaugeSizeUnit.factor,
                            endWidth: 0.265,
                            color: const Color.fromRGBO(34, 144, 199, 0.75)),
                        GaugeRange(
                          startValue: 75,
                          endValue: 100,
                          startWidth: 0.265,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.265,
                          color: const Color.fromRGBO(34, 144, 199, 0.75),
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        const GaugeAnnotation(
                            angle: 90,
                            positionFactor: 0.35,
                            widget: Text('humidity%',
                                style: TextStyle(
                                    color: kOrangeColor, fontSize: 16))),
                        GaugeAnnotation(
                          angle: 90,
                          positionFactor: 0.8,
                          widget: Text(
                            data["humidity"] == null
                                ? '...'
                                : '${(snapshot.data!.snapshot.value as Map)["humidity"].toString()}%',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ) // snapshot.data!..value != null ? '${snapshot.data!.snapshot.value} °C' : "",
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: double.parse(data['humidity'].toString()),
                          needleStartWidth: isCardView.value ? 0 : 1,
                          needleEndWidth: isCardView.value ? 5 : 8,
                          animationType: AnimationType.easeOutBack,
                          enableAnimation: true,
                          animationDuration: 1200,
                          knobStyle: KnobStyle(
                              knobRadius: isCardView.value ? 0.06 : 0.09,
                              borderColor: kOrangeColor,
                              color: Colors.white,
                              borderWidth: isCardView.value ? 0.035 : 0.05),
                          tailStyle: TailStyle(
                              color: const Color(0xFFF8B195),
                              width: isCardView.value ? 4 : 8,
                              length: isCardView.value ? 0.15 : 0.2),
                          needleColor: kOrangeColor,
                        )
                      ],
                      axisLabelStyle:
                          GaugeTextStyle(fontSize: isCardView.value ? 10 : 12),
                      majorTickStyle: const MajorTickStyle(
                          length: 0.25, lengthUnit: GaugeSizeUnit.factor),
                      minorTickStyle: const MinorTickStyle(
                          length: 0.13,
                          lengthUnit: GaugeSizeUnit.factor,
                          thickness: 1))
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
