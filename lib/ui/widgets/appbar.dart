import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appbar extends StatelessWidget {
  void removeSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userID');
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('PhoneBook'),
      backgroundColor: Colors.blueAccent,
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String choice) {
            if (choice == 'Logout') {
              removeSharedPrefs();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'login', (Route<dynamic> route) => false);
              // Navigator.of(context).pushNamed('login');
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Logout'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
