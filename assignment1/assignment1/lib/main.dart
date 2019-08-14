import 'package:flutter/material.dart';

import './text_control.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Assignment1'),
          ),
          body: Center(
            child: TextControl(),
          )),
    );
  }
}
