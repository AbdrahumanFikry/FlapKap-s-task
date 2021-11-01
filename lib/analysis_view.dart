import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'data.dart';

class AnalysisView extends StatefulWidget {
  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  List<SalesData> chartData = [];
  int maximumRange = 2;
  bool loading = false;
  int dateInterval = 1;
  int orderInterval = 1;

  void initGraphData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    for (final order in data) {
      final orderTime = DateTime.parse(order['registered']);
      if (chartData.any(
          (element) => element.dateTime.difference(orderTime).inDays == 0)) {
        final index = chartData.indexWhere(
            (element) => element.dateTime.difference(orderTime).inDays == 0);
        chartData[index].orderCount += 1;
        if (chartData[index].orderCount > maximumRange) {
          maximumRange = chartData[index].orderCount;
        }
      } else {
        chartData.add(SalesData(orderTime, 1));
      }
    }
    chartData.sort((x, y) => x.dateTime.difference(y.dateTime).inDays);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initGraphData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Numeric Data Analysis',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          interval: dateInterval.toDouble(),
                          isVisible: true,
                          title: AxisTitle(
                            text: 'Time',
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          isVisible: true,
                          minimum: 0,
                          interval: orderInterval.toDouble(),
                          title: AxisTitle(
                            text: 'Orders',
                          ),
                        ),
                        plotAreaBorderColor: Colors.transparent,
                        enableAxisAnimation: true,
                        plotAreaBackgroundColor: Colors.transparent,
                        series: <ChartSeries>[
                          SplineSeries<SalesData, DateTime>(
                            // markerSettings: MarkerSettings(isVisible: true),
                            color: Colors.blue,
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) =>
                                sales.dateTime,
                            yValueMapper: (SalesData sales, _) =>
                                sales.orderCount,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SalesData {
  SalesData(this.dateTime, this.orderCount);

  DateTime dateTime;
  int orderCount;
}
