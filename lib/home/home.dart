import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:security_camera_project/auth/login_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomePage extends HookWidget {
  HomePage({Key? key}) : super(key: key);

  final List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(children: [
        //Initialize the chart widget
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //Initialize the spark charts widget
            child: SfSparkLineChart.custom(
              //Enable the trackball
              trackball: const SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap),
              //Enable marker
              marker: const SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all),
              //Enable data label
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => data[index].year,
              yValueMapper: (int index) => data[index].sales,
              dataCount: 5,
            ),
          ),
        )
      ]),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
