import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.teal[800]),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Word pair generator'),
          ),
          body: Center(
            child: Text('Hello World'),
          ),
        ));
  }
}
