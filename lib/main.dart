import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/ui/views/registration_view.dart';
import 'package:flutter/material.dart';

void main() {
  //setup locator
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationView(),
    );
  }
}
