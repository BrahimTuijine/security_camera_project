import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/constants.dart';
import 'package:security_camera_project/core/widget/custom_app_bar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Temperature extends HookWidget {
  Temperature({Key? key}) : super(key: key);
  // final double _meterValue = 40;
  final double _temperatureValue = 37.5;

  final bool isWebOrDesktop = false;
  final bool isCardView = true;

  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('dht11');

  @override
  Widget build(BuildContext context) {
    return isWebOrDesktop
        ? Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width >= 1000 ? 550 : 440,
              height: 300,
              child: _buildThermometer(context),
            ))
        : _buildThermometer(context);
  }

  /// Returns the thermometer.
  Widget _buildThermometer(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Brightness brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const CustomAppBar(title: "Temperature"),
      body: Center(
          child: SizedBox(
        height: isCardView
            ? MediaQuery.of(context).size.height
            : orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height * 3 / 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 11),
            child: StreamBuilder(
                stream: dbRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('problem found'),
                    );
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.data!.snapshot.value as Map;
                    final meterValue = data['temperature'];
                    return SfLinearGauge(
                        minimum: -20,
                        maximum: 50,
                        interval: 10,
                        minorTicksPerInterval: 0,
                        axisTrackExtent: 23,
                        axisTrackStyle: const LinearAxisTrackStyle(
                            thickness: 12,
                            color: Colors.white,
                            borderWidth: 1,
                            edgeStyle: LinearEdgeStyle.bothCurve),
                        tickPosition: LinearElementPosition.outside,
                        labelPosition: LinearLabelPosition.outside,
                        orientation: LinearGaugeOrientation.vertical,
                        markerPointers: <LinearMarkerPointer>[
                          LinearWidgetPointer(
                              markerAlignment: LinearMarkerAlignment.end,
                              value: 50,
                              enableAnimation: false,
                              position: LinearElementPosition.outside,
                              offset: 8,
                              child: SizedBox(
                                height: 30,
                                child: Text(
                                  '°C',
                                  style: TextStyle(
                                      fontSize: isWebOrDesktop ? 14 : 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                          LinearShapePointer(
                            value: -20,
                            markerAlignment: LinearMarkerAlignment.start,
                            shapeType: LinearShapePointerType.circle,
                            borderWidth: 1,
                            borderColor: brightness == Brightness.dark
                                ? Colors.white30
                                : Colors.black26,
                            color: Colors.white,
                            position: LinearElementPosition.cross,
                            width: 24,
                            height: 24,
                          ),
                          LinearShapePointer(
                            value: -20,
                            markerAlignment: LinearMarkerAlignment.start,
                            shapeType: LinearShapePointerType.circle,
                            borderWidth: 6,
                            borderColor: Colors.transparent,
                            color: meterValue > _temperatureValue
                                ? const Color(0xffFF7B7B)
                                : const Color(0xff0074E3),
                            position: LinearElementPosition.cross,
                            width: 24,
                            height: 24,
                          ),
                          LinearWidgetPointer(
                              value: -20,
                              markerAlignment: LinearMarkerAlignment.start,
                              child: Container(
                                width: 10,
                                height: 3.4,
                                decoration: BoxDecoration(
                                  border: const Border(
                                    left: BorderSide(
                                        width: 2.0, color: Colors.white),
                                    right: BorderSide(
                                        width: 2.0, color: Colors.white),
                                  ),
                                  color: meterValue > _temperatureValue
                                      ? const Color(0xffFF7B7B)
                                      : const Color(0xff0074E3),
                                ),
                              )),
                          LinearWidgetPointer(
                            value: double.parse(meterValue.toString()),
                            enableAnimation: false,
                            position: LinearElementPosition.outside,
                            onChanged: (dynamic value) {},
                            child: Container(
                              width: 16,
                              height: 12,
                              transform: Matrix4.translationValues(4, 0, 0.0),
                              child: Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color: meterValue > _temperatureValue
                                    ? const Color(0xffFF7B7B)
                                    : const Color(0xff0074E3),
                              ),
                            ),
                          ),
                          LinearShapePointer(
                            value: double.parse(meterValue.toString()),
                            width: 20,
                            height: 20,
                            enableAnimation: false,
                            color: Colors.transparent,
                            position: LinearElementPosition.cross,
                            onChanged: (dynamic value) {},
                          )
                        ],
                        barPointers: <LinearBarPointer>[
                          LinearBarPointer(
                            value: double.parse(meterValue.toString()),
                            enableAnimation: false,
                            thickness: 6,
                            edgeStyle: LinearEdgeStyle.endCurve,
                            color: meterValue > _temperatureValue
                                ? const Color(0xffFF7B7B)
                                : const Color(0xff0074E3),
                          )
                        ]);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      )),
    );
  }
}
