import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GasValueChart extends HookWidget {
  const GasValueChart({Key? key}) : super(key: key);
  @override
  final systemOverlayStyle = Brightness.light;

  @override
  Widget build(BuildContext context) {
    final value = useState<double>(189);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gas Value'),
      backgroundColor: kBgColor,
      body: SfLinearGauge(
        interval: 20,
        animateAxis: true,
        animateRange: true,
        labelPosition: LinearLabelPosition.outside,
        tickPosition: LinearElementPosition.outside,
        onGenerateLabels: () {
          return List.generate(
            11,
            (index) => LinearAxisLabel(text: '${index * 10}', value: 400),
          ).toList();
        },
        axisTrackStyle: const LinearAxisTrackStyle(
            thickness: 16, color: Colors.transparent),
        markerPointers: <LinearMarkerPointer>[
          LinearShapePointer(
              value: value.value,
              onChanged: (dynamic value) {
                value = value as double;
              },
              color: systemOverlayStyle == Brightness.light
                  ? const Color(0xff06589C)
                  : const Color(0xffFFFFFF),
              width: 24,
              position: LinearElementPosition.cross,
              shapeType: LinearShapePointerType.triangle,
              height: 16),
        ],
        ranges: const <LinearGaugeRange>[
          LinearGaugeRange(
            midValue: 0,
            endValue: 80,
            startWidth: 16,
            midWidth: 16,
            endWidth: 16,
            position: LinearElementPosition.cross,
            color: Color(0xff0DC9AB),
          ),
          LinearGaugeRange(
            startValue: 80.0,
            midValue: 0,
            startWidth: 16,
            midWidth: 16,
            endWidth: 16,
            position: LinearElementPosition.cross,
            color: Color(0xffF45656),
          )
        ],
      ),
    );
  }
}
