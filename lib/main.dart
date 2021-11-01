import 'package:flutter/material.dart';

import 'numeric_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlabKapTask',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumericData(),
    );
  }
}
