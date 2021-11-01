import 'package:flap_kap_task/data.dart';
import 'package:flutter/material.dart';

class NumericData extends StatefulWidget {
  @override
  _NumericDataState createState() => _NumericDataState();
}

class _NumericDataState extends State<NumericData> {
  int totalCount = 0;
  double avgPrice = 0.0;
  int numOfReturns = 0;

  void initData() {
    totalCount = data.length;
    double totalPrices = 0.0;
    for (final order in data) {
      final price = (order['price'] ?? '0.0').toString().replaceAll(',', '');
      totalPrices += double.tryParse(price)!;
      if (order['status'] == 'RETURNED') {
        numOfReturns += 1;
      }
    }
    avgPrice = (totalPrices / totalCount).roundToDouble();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Numeric Data view',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total orders count : $totalCount',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Average price : $avgPrice',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Total returned orders : $numOfReturns',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'To graph',
        child: Icon(Icons.auto_graph_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
