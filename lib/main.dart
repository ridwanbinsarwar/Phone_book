import 'package:flutter_demo/routes/RouteBuilder.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/ui/views/home_view.dart';
import 'package:flutter_demo/ui/views/login_view.dart';
import 'package:flutter_demo/ui/views/registration_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //setup locator
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> checkIfPresentInSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userID');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: checkIfPresentInSharedPrefs(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return snapshot.data ? HomeView() : LoginView();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      onGenerateRoute: RouteBuilder.generateRoute,
    );
  }
}
